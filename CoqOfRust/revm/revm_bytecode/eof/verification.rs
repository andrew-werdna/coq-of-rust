use crate::{
    eof::{Eof, EofDecodeError, TypesSection},
    opcode::OPCODE_INFO,
};
use primitives::Bytes;
use specification::constants::MAX_INITCODE_SIZE;

use core::{convert::identity, mem};
use std::{borrow::Cow, fmt, vec, vec::Vec};

/// Decodes `raw` into an [`Eof`] container and validates it.
pub fn validate_raw_eof(raw: Bytes) -> Result<Eof, EofError> {
    validate_raw_eof_inner(raw, Some(CodeType::ReturnContract))
}

/// Decodes `raw` into an [`Eof`] container and validates it.
#[inline]
pub fn validate_raw_eof_inner(
    raw: Bytes,
    first_code_type: Option<CodeType>,
) -> Result<Eof, EofError> {
    if raw.len() > MAX_INITCODE_SIZE {
        return Err(EofError::Decode(EofDecodeError::InvalidEOFSize));
    }
    let eof = Eof::decode(raw)?;
    validate_eof_inner(&eof, first_code_type)?;
    Ok(eof)
}

/// Fully validates an [`Eof`] container.
///
/// Only place where validation happen is in Creating Transaction.
///
/// Because of that we are assuming [CodeType] is [ReturnContract][CodeType::ReturnContract].
///
/// Note: If needed we can make a flag that would assume [ReturnContract][CodeType::ReturnContract]..
pub fn validate_eof(eof: &Eof) -> Result<(), EofError> {
    validate_eof_inner(eof, Some(CodeType::ReturnContract))
}

#[inline]
pub fn validate_eof_inner(eof: &Eof, first_code_type: Option<CodeType>) -> Result<(), EofError> {
    // Data needs to be filled first first container.
    if !eof.body.is_data_filled {
        return Err(EofError::Validation(EofValidationError::DataNotFilled));
    }
    if eof.body.container_section.is_empty() {
        validate_eof_codes(eof, first_code_type)?;
        return Ok(());
    }

    let mut stack = Vec::with_capacity(4);
    stack.push((Cow::Borrowed(eof), first_code_type));

    while let Some((eof, code_type)) = stack.pop() {
        // Validate the current container.
        let tracker_containers = validate_eof_codes(&eof, code_type)?;
        // Decode subcontainers and push them to the stack.
        for (container, code_type) in eof
            .body
            .container_section
            .iter()
            .zip(tracker_containers.into_iter())
        {
            stack.push((Cow::Owned(Eof::decode(container.clone())?), Some(code_type)));
        }
    }

    Ok(())
}

/// Validates an [`Eof`] structure, without recursing into containers.
///
/// Returns a list of all sub containers that are accessed.
#[inline]
pub fn validate_eof_codes(
    eof: &Eof,
    this_code_type: Option<CodeType>,
) -> Result<Vec<CodeType>, EofValidationError> {
    if eof.body.code_section.len() != eof.body.types_section.len() {
        return Err(EofValidationError::InvalidTypesSection);
    }

    if eof.body.code_section.is_empty() {
        // No code sections. This should be already checked in decode.
        return Err(EofValidationError::NoCodeSections);
    }

    // The first code section must have a type signature
    // (0, 0x80, max_stack_height) (0 inputs non-returning function)
    let first_types = &eof.body.types_section[0];
    if first_types.inputs != 0 || !first_types.is_non_returning() {
        return Err(EofValidationError::InvalidTypesSection);
    }

    // Tracking access of code and sub containers.
    let mut tracker: AccessTracker = AccessTracker::new(
        this_code_type,
        eof.body.code_section.len(),
        eof.body.container_section.len(),
    );

    while let Some(index) = tracker.processing_stack.pop() {
        // Assume `index` is correct.
        let code = eof.body.code(index).unwrap();
        validate_eof_code(
            &code,
            eof.header.data_size as usize,
            index,
            eof.body.container_section.len(),
            &eof.body.types_section,
            &mut tracker,
        )?;
    }

    // Iterate over accessed codes and check if all are accessed.
    if !tracker.codes.into_iter().all(identity) {
        return Err(EofValidationError::CodeSectionNotAccessed);
    }
    // Iterate over all accessed subcontainers and check if all are accessed.
    if !tracker.subcontainers.iter().all(|i| i.is_some()) {
        return Err(EofValidationError::SubContainerNotAccessed);
    }

    if tracker.this_container_code_type == Some(CodeType::ReturnContract)
        && !eof.body.is_data_filled
    {
        return Err(EofValidationError::DataNotFilled);
    }

    Ok(tracker
        .subcontainers
        .into_iter()
        .map(|i| i.unwrap())
        .collect())
}

/// EOF Error
#[derive(Debug, Hash, PartialEq, Eq, PartialOrd, Ord, Clone, Copy)]
pub enum EofError {
    Decode(EofDecodeError),
    Validation(EofValidationError),
}

impl From<EofDecodeError> for EofError {
    fn from(err: EofDecodeError) -> Self {
        EofError::Decode(err)
    }
}

impl From<EofValidationError> for EofError {
    fn from(err: EofValidationError) -> Self {
        EofError::Validation(err)
    }
}

impl fmt::Display for EofError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            EofError::Decode(e) => write!(f, "Bytecode decode error: {}", e),
            EofError::Validation(e) => write!(f, "Bytecode validation error: {}", e),
        }
    }
}

impl core::error::Error for EofError {}

/// EOF Validation Error
#[derive(Debug, Hash, PartialEq, Eq, PartialOrd, Ord, Clone, Copy)]
pub enum EofValidationError {
    FalsePositive,
    /// Opcode is not known. It is not defined in the opcode table.
    UnknownOpcode,
    /// Opcode is disabled in EOF. For example JUMP, JUMPI, etc
    OpcodeDisabled,
    /// Every instruction inside bytecode should be forward accessed
    ///
    /// Forward access can be a jump or sequential opcode.
    ///
    /// In case after terminal opcode there should be a forward jump.
    InstructionNotForwardAccessed,
    /// Bytecode is too small and is missing immediate bytes for instruction
    MissingImmediateBytes,
    /// Bytecode is too small and is missing immediate bytes for instruction
    ///
    /// Similar to [`MissingImmediateBytes`][EofValidationError::MissingImmediateBytes] but for special case of RJUMPV immediate bytes.
    MissingRJUMPVImmediateBytes,
    /// Invalid jump into immediate bytes
    JumpToImmediateBytes,
    /// Invalid jump into immediate bytes
    BackwardJumpToImmediateBytes,
    /// MaxIndex in RJUMPV can't be zero. Zero max index makes it RJUMPI
    RJUMPVZeroMaxIndex,
    /// Jump with zero offset would make a jump to next opcode, it does not make sense
    JumpZeroOffset,
    /// EOFCREATE points to container out of bounds
    EOFCREATEInvalidIndex,
    /// CALLF section out of bounds
    CodeSectionOutOfBounds,
    /// CALLF to non returning function is not allowed
    CALLFNonReturningFunction,
    /// CALLF stack overflow
    StackOverflow,
    /// JUMPF needs to have enough outputs
    JUMPFEnoughOutputs,
    /// JUMPF Stack
    JUMPFStackHigherThanOutputs,
    /// DATA load out of bounds
    DataLoadOutOfBounds,
    /// RETF biggest stack num more then outputs
    RETFBiggestStackNumMoreThenOutputs,
    /// Stack requirement is more than smallest stack items
    StackUnderflow,
    /// Smallest stack items is more than types output
    TypesStackUnderflow,
    /// Jump out of bounds
    JumpUnderflow,
    /// Jump to out of bounds
    JumpOverflow,
    /// Backward jump should have same smallest and biggest stack items
    BackwardJumpBiggestNumMismatch,
    /// Backward jump should have same smallest and biggest stack items
    BackwardJumpSmallestNumMismatch,
    /// Last instruction should be terminating
    LastInstructionNotTerminating,
    /// Code section not accessed
    CodeSectionNotAccessed,
    /// Types section invalid
    InvalidTypesSection,
    /// First types section is invalid
    /// It should have inputs 0 and outputs `0x80`
    InvalidFirstTypesSection,
    /// Max stack element mismatch
    MaxStackMismatch,
    /// No code sections present
    NoCodeSections,
    /// Sub container called in two different modes
    ///
    /// Check [`CodeType`] for more information.
    SubContainerCalledInTwoModes,
    /// Sub container not accessed
    SubContainerNotAccessed,
    /// Data size needs to be filled for [ReturnContract][CodeType::ReturnContract] type
    DataNotFilled,
    /// Section is marked as non-returning but has either RETF or
    /// JUMPF to returning section opcodes
    NonReturningSectionIsReturning,
}

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct AccessTracker {
    /// This code type
    pub this_container_code_type: Option<CodeType>,
    /// Vector of accessed codes.
    pub codes: Vec<bool>,
    /// Stack of codes section that needs to be processed.
    pub processing_stack: Vec<usize>,
    /// Code accessed by subcontainer and expected subcontainer first code type.
    /// EOF code can be invoked in EOFCREATE mode or used in RETURNCONTRACT opcode.
    /// if SubContainer is called from EOFCREATE it needs to be ReturnContract type.
    /// If SubContainer is called from RETURNCONTRACT it needs to be ReturnOrStop type.
    ///
    /// None means it is not accessed.
    pub subcontainers: Vec<Option<CodeType>>,
}

impl AccessTracker {
    /// Returns a new instance of `CodeSubContainerAccess`.
    ///
    /// Mark first code section as accessed and push first it to the stack.
    ///
    /// # Panics
    ///
    /// Panics if `codes_size` is zero.
    pub fn new(
        this_container_code_type: Option<CodeType>,
        codes_size: usize,
        subcontainers_size: usize,
    ) -> Self {
        if codes_size == 0 {
            panic!("There should be at least one code section");
        }
        let mut this = Self {
            this_container_code_type,
            codes: vec![false; codes_size],
            processing_stack: Vec::with_capacity(4),
            subcontainers: vec![None; subcontainers_size],
        };
        this.codes[0] = true;
        this.processing_stack.push(0);
        this
    }

    /// Mark code as accessed.
    ///
    /// If code was not accessed before, it will be added to the processing stack.
    ///
    /// Assumes that index is valid.
    pub fn access_code(&mut self, index: usize) {
        let was_accessed = mem::replace(&mut self.codes[index], true);
        if !was_accessed {
            self.processing_stack.push(index);
        }
    }

    pub fn set_subcontainer_type(
        &mut self,
        index: usize,
        new_code_type: CodeType,
    ) -> Result<(), EofValidationError> {
        let Some(container) = self.subcontainers.get_mut(index) else {
            panic!("It should not be possible")
        };

        let Some(code_type) = container else {
            *container = Some(new_code_type);
            return Ok(());
        };

        if *code_type != new_code_type {
            return Err(EofValidationError::SubContainerCalledInTwoModes);
        }
        Ok(())
    }
}

/// Types of code sections
///
/// It is a error if container to contain
/// both RETURNCONTRACT and either of RETURN or STOP.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum CodeType {
    /// Return contract code
    ReturnContract,
    /// Return or Stop opcodes
    ReturnOrStop,
}

impl CodeType {
    /// Returns `true` of the code is initcode.
    pub fn is_initcode(&self) -> bool {
        matches!(self, CodeType::ReturnContract)
    }
}

impl fmt::Display for EofValidationError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let s = match self {
            Self::FalsePositive => "False positive",
            Self::UnknownOpcode => "Opcode is not known",
            Self::OpcodeDisabled => "Opcode is disabled",
            Self::InstructionNotForwardAccessed => "Should have forward jump",
            Self::MissingImmediateBytes => "Bytecode is missing bytes",
            Self::MissingRJUMPVImmediateBytes => "Bytecode is missing bytes after RJUMPV opcode",
            Self::JumpToImmediateBytes => "Invalid jump",
            Self::BackwardJumpToImmediateBytes => "Invalid backward jump",
            Self::RJUMPVZeroMaxIndex => "Used RJUMPV with zero as MaxIndex",
            Self::JumpZeroOffset => "Used JUMP with zero as offset",
            Self::EOFCREATEInvalidIndex => "EOFCREATE points to out of bound index",
            Self::CodeSectionOutOfBounds => "CALLF index is out of bounds",
            Self::CALLFNonReturningFunction => "CALLF was used on non-returning function",
            Self::StackOverflow => "CALLF stack overflow",
            Self::JUMPFEnoughOutputs => "JUMPF needs more outputs",
            Self::JUMPFStackHigherThanOutputs => "JUMPF stack is too high for outputs",
            Self::DataLoadOutOfBounds => "DATALOAD is out of bounds",
            Self::RETFBiggestStackNumMoreThenOutputs => {
                "RETF biggest stack num is more than outputs"
            }
            Self::StackUnderflow => "Stack requirement is above smallest stack items",
            Self::TypesStackUnderflow => "Smallest stack items is more than output type",
            Self::JumpUnderflow => "Jump destination is too low",
            Self::JumpOverflow => "Jump destination is too high",
            Self::BackwardJumpBiggestNumMismatch => {
                "Backward jump has different biggest stack item"
            }
            Self::BackwardJumpSmallestNumMismatch => {
                "Backward jump has different smallest stack item"
            }
            Self::LastInstructionNotTerminating => {
                "Last instruction of bytecode is not terminating"
            }
            Self::CodeSectionNotAccessed => "Code section was not accessed",
            Self::InvalidTypesSection => "Invalid types section",
            Self::InvalidFirstTypesSection => "Invalid first types section",
            Self::MaxStackMismatch => "Max stack element mismatches",
            Self::NoCodeSections => "No code sections",
            Self::SubContainerCalledInTwoModes => "Sub container called in two modes",
            Self::SubContainerNotAccessed => "Sub container not accessed",
            Self::DataNotFilled => "Data not filled",
            Self::NonReturningSectionIsReturning => "Non returning section is returning",
        };
        f.write_str(s)
    }
}

impl core::error::Error for EofValidationError {}

/// Validates that:
/// * All instructions are valid.
/// * It ends with a terminating instruction or RJUMP.
/// * All instructions are accessed by forward jumps or .
///
/// Validate stack requirements and if all codes sections are used.
pub fn validate_eof_code(
    code: &[u8],
    _data_size: usize,
    this_types_index: usize,
    _num_of_containers: usize,
    types: &[TypesSection],
    _tracker: &mut AccessTracker,
) -> Result<(), EofValidationError> {
    let this_types = &types[this_types_index];

    #[derive(Debug, Copy, Clone)]
    struct InstructionInfo {
        /// Is immediate byte, jumps can't happen on this part of code.
        is_immediate: bool,
        /// Have forward jump to this opcode. Used to check if opcode
        /// after termination is accessed.
        is_jumpdest: bool,
        /// Smallest number of stack items accessed by jumps or sequential opcodes.
        smallest: i32,
        /// Biggest number of stack items accessed by jumps or sequential opcodes.
        biggest: i32,
    }

    impl InstructionInfo {
        #[inline]
        fn mark_as_immediate(&mut self) -> Result<(), EofValidationError> {
            if self.is_jumpdest {
                // Jump to immediate bytes.
                return Err(EofValidationError::JumpToImmediateBytes);
            }
            self.is_immediate = true;
            Ok(())
        }
    }

    impl Default for InstructionInfo {
        fn default() -> Self {
            Self {
                is_immediate: false,
                is_jumpdest: false,
                smallest: i32::MAX,
                biggest: i32::MIN,
            }
        }
    }

    // All bytes that are intermediate.
    let mut jumps = vec![InstructionInfo::default(); code.len()];
    let mut is_after_termination = false;

    let mut next_smallest = this_types.inputs as i32;
    let mut next_biggest = this_types.inputs as i32;

    let is_returning = false;

    let mut i = 0;
    // We can check validity and jump destinations in one pass.
    while i < code.len() {
        let op = code[i];
        let opcode = &OPCODE_INFO[op as usize];

        let Some(opcode) = opcode else {
            // Err unknown opcode.
            return Err(EofValidationError::UnknownOpcode);
        };

        if opcode.is_disabled_in_eof() {
            // Opcode is disabled in EOF
            return Err(EofValidationError::OpcodeDisabled);
        }

        let this_instruction = &mut jumps[i];

        // Update biggest/smallest values for next instruction only if it is not after termination.
        if !is_after_termination {
            this_instruction.smallest = core::cmp::min(this_instruction.smallest, next_smallest);
            this_instruction.biggest = core::cmp::max(this_instruction.biggest, next_biggest);
        }

        let this_instruction = *this_instruction;

        // Opcodes after termination should be accessed by forward jumps.
        if is_after_termination && !this_instruction.is_jumpdest {
            // Opcode after termination was not accessed.
            return Err(EofValidationError::InstructionNotForwardAccessed);
        }
        is_after_termination = opcode.is_terminating();

        // Mark immediate as non-jumpable. RJUMPV is special case covered later.
        if opcode.immediate_size() != 0 {
            // Check if the opcode immediate are within the bounds of the code
            if i + opcode.immediate_size() as usize >= code.len() {
                // Malfunctional code
                return Err(EofValidationError::MissingImmediateBytes);
            }

            // Mark immediate bytes as non-jumpable.
            for imm in 1..opcode.immediate_size() as usize + 1 {
                // SAFETY: Immediate size is checked above.
                jumps[i + imm].mark_as_immediate()?;
            }
        }
        // IO diff used to generate next instruction smallest/biggest value.
        let stack_io_diff = opcode.io_diff() as i32;
        // How many stack items are required for this opcode.
        let stack_requirement = opcode.inputs() as i32;
        // Additional immediate bytes for RJUMPV, it has dynamic vtable.
        let rjumpv_additional_immediates = 0;
        // If opcodes is RJUMP, RJUMPI or RJUMPV then this will have absolute jumpdest.
        let absolute_jumpdest: Vec<isize> = vec![];
        // Check if stack requirement is more than smallest stack items.
        if stack_requirement > this_instruction.smallest {
            // Opcode requirement is more than smallest stack items.
            return Err(EofValidationError::StackUnderflow);
        }

        next_smallest = this_instruction.smallest + stack_io_diff;
        next_biggest = this_instruction.biggest + stack_io_diff;

        // Check if jumpdest are correct and mark forward jumps.
        for absolute_jump in absolute_jumpdest {
            if absolute_jump < 0 {
                // Jump out of bounds.
                return Err(EofValidationError::JumpUnderflow);
            }
            if absolute_jump >= code.len() as isize {
                // Jump to out of bounds
                return Err(EofValidationError::JumpOverflow);
            }
            // Fine to cast as bounds are checked.
            let absolute_jump = absolute_jump as usize;

            let target_jump = &mut jumps[absolute_jump];
            if target_jump.is_immediate {
                // Jump target is immediate byte.
                return Err(EofValidationError::BackwardJumpToImmediateBytes);
            }

            // Needed to mark forward jumps. It does not do anything for backward jumps.
            target_jump.is_jumpdest = true;

            if absolute_jump <= i {
                // Backward jumps should have same smallest and biggest stack items.
                if target_jump.biggest != next_biggest {
                    // Wrong jumpdest.
                    return Err(EofValidationError::BackwardJumpBiggestNumMismatch);
                }
                if target_jump.smallest != next_smallest {
                    // Wrong jumpdest.
                    return Err(EofValidationError::BackwardJumpSmallestNumMismatch);
                }
            } else {
                // Forward jumps can make min even smallest size
                // While biggest num is needed to check stack overflow
                target_jump.smallest = core::cmp::min(target_jump.smallest, next_smallest);
                target_jump.biggest = core::cmp::max(target_jump.biggest, next_biggest);
            }
        }

        // Additional immediate are from RJUMPV vtable.
        i += 1 + opcode.immediate_size() as usize + rjumpv_additional_immediates;
    }

    // Error if section is returning but marked as non-returning.
    if is_returning == this_types.is_non_returning() {
        // Wrong termination.
        return Err(EofValidationError::NonReturningSectionIsReturning);
    }

    // Last opcode should be terminating
    if !is_after_termination {
        // Wrong termination.
        return Err(EofValidationError::LastInstructionNotTerminating);
    }
    // TODO : Integrate max so we dont need to iterate again
    let mut max_stack_requirement = 0;
    for opcode in jumps {
        max_stack_requirement = core::cmp::max(opcode.biggest, max_stack_requirement);
    }

    if max_stack_requirement != types[this_types_index].max_stack_size as i32 {
        // Stack overflow
        return Err(EofValidationError::MaxStackMismatch);
    }

    Ok(())
}

#[cfg(test)]
mod test {
    use super::*;
    use primitives::hex;

    #[test]
    fn test1() {
        // result:Result { result: false, exception: Some("EOF_ConflictingStackHeight") }
        let err =
            validate_raw_eof(hex!("ef0001010004020001000704000000008000016000e200fffc00").into());
        assert!(err.is_err(), "{err:#?}");
    }

    #[test]
    fn test2() {
        // result:Result { result: false, exception: Some("EOF_InvalidNumberOfOutputs") }
        let err =
            validate_raw_eof_inner(hex!("ef000101000c02000300040004000204000000008000020002000100010001e30001005fe500025fe4").into(),None);
        assert!(err.is_ok(), "{err:#?}");
    }

    #[test]
    fn test3() {
        // result:Result { result: false, exception: Some("EOF_InvalidNumberOfOutputs") }
        let err =
            validate_raw_eof_inner(hex!("ef000101000c02000300040008000304000000008000020002000503010003e30001005f5f5f5f5fe500025050e4").into(),None);
        assert_eq!(
            err,
            Err(EofError::Validation(
                EofValidationError::JUMPFStackHigherThanOutputs
            ))
        );
    }

    #[test]
    fn test4() {
        //0xef0001010004020001000e04000000008000045f6000e100025f5f6000e1fffd00
        // result:Result { result: false, exception: Some("EOF_InvalidNumberOfOutputs") }
        let err = validate_raw_eof(
            hex!("ef0001010004020001000e04000000008000045f6000e100025f5f6000e1fffd00").into(),
        );
        assert_eq!(
            err,
            Err(EofError::Validation(
                EofValidationError::BackwardJumpBiggestNumMismatch
            ))
        );
    }

    #[test]
    fn test5() {
        let err = validate_raw_eof(hex!("ef000101000402000100030400000000800000e5ffff").into());
        assert_eq!(
            err,
            Err(EofError::Validation(
                EofValidationError::CodeSectionOutOfBounds
            ))
        );
    }

    #[test]
    fn size_limit() {
        let eof = validate_raw_eof_inner(
            hex!("ef00010100040200010003040001000080000130500000").into(),
            Some(CodeType::ReturnOrStop),
        );
        assert!(eof.is_ok());
    }

    #[test]
    fn test() {
        let eof = validate_raw_eof_inner(
            hex!("ef0001010004020001000504ff0300008000023a60cbee1800").into(),
            None,
        );
        assert_eq!(
            eof,
            Err(EofError::Validation(EofValidationError::DataNotFilled))
        );
    }

    #[test]
    fn unreachable_code_section() {
        let eof = validate_raw_eof_inner(
            hex!("ef000101000c02000300030001000304000000008000000080000000800000e50001fee50002")
                .into(),
            None,
        );
        assert_eq!(
            eof,
            Err(EofError::Validation(
                EofValidationError::CodeSectionNotAccessed
            ))
        );
    }

    #[test]
    fn non_returning_sections() {
        let eof = validate_raw_eof_inner(
            hex!("ef000101000c02000300040001000304000000008000000080000000000000e300020000e50001")
                .into(),
            Some(CodeType::ReturnOrStop),
        );
        assert_eq!(
            eof,
            Err(EofError::Validation(
                EofValidationError::NonReturningSectionIsReturning
            ))
        );
    }

    #[test]
    fn incompatible_container_kind() {
        let eof = validate_raw_eof_inner(
            hex!("ef000101000402000100060300010014040000000080000260006000ee00ef00010100040200010001040000000080000000")
                .into(),
            Some(CodeType::ReturnOrStop),
        );
        assert_eq!(
            eof,
            Err(EofError::Validation(
                EofValidationError::SubContainerCalledInTwoModes
            ))
        );
    }
}
