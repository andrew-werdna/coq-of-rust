Require Import CoqOfRust.CoqOfRust.
Require Import CoqOfRust.simulations.M.

(*
pub enum StatusCode {
    // The status of a transaction as determined by the prologue.
    // Validation Errors: 0-999
    // We don't want the default value to be valid
    UNKNOWN_VALIDATION_STATUS = 0,
    // The transaction has a bad signature
    INVALID_SIGNATURE = 1,
    // Bad account authentication key
    INVALID_AUTH_KEY = 2,
    // Sequence number is too old
    SEQUENCE_NUMBER_TOO_OLD = 3,
    // Sequence number is too new
    SEQUENCE_NUMBER_TOO_NEW = 4,
    // Insufficient balance to pay minimum transaction fee
    INSUFFICIENT_BALANCE_FOR_TRANSACTION_FEE = 5,
    // The transaction has expired
    TRANSACTION_EXPIRED = 6,
    // The sending account does not exist
    SENDING_ACCOUNT_DOES_NOT_EXIST = 7,
    // This write set transaction was rejected because it did not meet the
    // requirements for one.
    REJECTED_WRITE_SET = 8,
    // This write set transaction cannot be applied to the current state.
    INVALID_WRITE_SET = 9,
    // Length of program field in raw transaction exceeded max length
    EXCEEDED_MAX_TRANSACTION_SIZE = 10,
    // This script is not in our allowlist of scripts.
    UNKNOWN_SCRIPT = 11,
    // Transaction is trying to publish a new module.
    UNKNOWN_MODULE = 12,
    // Max gas units submitted with transaction exceeds max gas units bound
    // in VM
    MAX_GAS_UNITS_EXCEEDS_MAX_GAS_UNITS_BOUND = 13,
    // Max gas units submitted with transaction not enough to cover the
    // intrinsic cost of the transaction.
    MAX_GAS_UNITS_BELOW_MIN_TRANSACTION_GAS_UNITS = 14,
    // Gas unit price submitted with transaction is below minimum gas price
    // set in the VM.
    GAS_UNIT_PRICE_BELOW_MIN_BOUND = 15,
    // Gas unit price submitted with the transaction is above the maximum
    // gas price set in the VM.
    GAS_UNIT_PRICE_ABOVE_MAX_BOUND = 16,
    // Gas specifier submitted is either malformed (not a valid identifier),
    // or does not refer to an accepted gas specifier
    INVALID_GAS_SPECIFIER = 17,
    // The sending account is frozen
    SENDING_ACCOUNT_FROZEN = 18,
    // Unable to deserialize the account blob
    UNABLE_TO_DESERIALIZE_ACCOUNT = 19,
    // The currency info was unable to be found
    CURRENCY_INFO_DOES_NOT_EXIST = 20,
    // The account sender doesn't have permissions to publish modules
    INVALID_MODULE_PUBLISHER = 21,
    // The sending account has no role
    NO_ACCOUNT_ROLE = 22,
    // The transaction's chain_id does not match the one published on-chain
    BAD_CHAIN_ID = 23,
    // The sequence number is too large and would overflow if the transaction were executed
    SEQUENCE_NUMBER_TOO_BIG = 24,
    // The gas currency is not registered as a TransactionFee currency
    BAD_TRANSACTION_FEE_CURRENCY = 25,
    // The feature requested is intended for a future Diem version instead of the current one
    FEATURE_UNDER_GATING = 26,
    // The number of secondary signer addresses is different from the number of secondary
    // public keys provided.
    SECONDARY_KEYS_ADDRESSES_COUNT_MISMATCH = 27,
    // There are duplicates among signers, including the sender and all the secondary signers
    SIGNERS_CONTAIN_DUPLICATES = 28,
    // The sequence nonce in the transaction is invalid (too new, too old, or already used).
    SEQUENCE_NONCE_INVALID = 29,
    // There was an error when accessing chain-specific account information
    CHAIN_ACCOUNT_INFO_DOES_NOT_EXIST = 30,

    // When a code module/script is published it is verified. These are the
    // possible errors that can arise from the verification process.
    // Verification Errors: 1000-1999
    UNKNOWN_VERIFICATION_ERROR = 1000,
    INDEX_OUT_OF_BOUNDS = 1001,
    INVALID_SIGNATURE_TOKEN = 1003,
    RECURSIVE_STRUCT_DEFINITION = 1005,
    FIELD_MISSING_TYPE_ABILITY = 1006,
    INVALID_FALL_THROUGH = 1007,
    NEGATIVE_STACK_SIZE_WITHIN_BLOCK = 1009,
    INVALID_MAIN_FUNCTION_SIGNATURE = 1011,
    DUPLICATE_ELEMENT = 1012,
    INVALID_MODULE_HANDLE = 1013,
    UNIMPLEMENTED_HANDLE = 1014,
    LOOKUP_FAILED = 1017,
    TYPE_MISMATCH = 1020,
    MISSING_DEPENDENCY = 1021,
    POP_WITHOUT_DROP_ABILITY = 1023,
    BR_TYPE_MISMATCH_ERROR = 1025,
    ABORT_TYPE_MISMATCH_ERROR = 1026,
    STLOC_TYPE_MISMATCH_ERROR = 1027,
    STLOC_UNSAFE_TO_DESTROY_ERROR = 1028,
    UNSAFE_RET_LOCAL_OR_RESOURCE_STILL_BORROWED = 1029,
    RET_TYPE_MISMATCH_ERROR = 1030,
    RET_BORROWED_MUTABLE_REFERENCE_ERROR = 1031,
    FREEZEREF_TYPE_MISMATCH_ERROR = 1032,
    FREEZEREF_EXISTS_MUTABLE_BORROW_ERROR = 1033,
    BORROWFIELD_TYPE_MISMATCH_ERROR = 1034,
    BORROWFIELD_BAD_FIELD_ERROR = 1035,
    BORROWFIELD_EXISTS_MUTABLE_BORROW_ERROR = 1036,
    COPYLOC_UNAVAILABLE_ERROR = 1037,
    COPYLOC_WITHOUT_COPY_ABILITY = 1038,
    COPYLOC_EXISTS_BORROW_ERROR = 1039,
    MOVELOC_UNAVAILABLE_ERROR = 1040,
    MOVELOC_EXISTS_BORROW_ERROR = 1041,
    BORROWLOC_REFERENCE_ERROR = 1042,
    BORROWLOC_UNAVAILABLE_ERROR = 1043,
    BORROWLOC_EXISTS_BORROW_ERROR = 1044,
    CALL_TYPE_MISMATCH_ERROR = 1045,
    CALL_BORROWED_MUTABLE_REFERENCE_ERROR = 1046,
    PACK_TYPE_MISMATCH_ERROR = 1047,
    UNPACK_TYPE_MISMATCH_ERROR = 1048,
    READREF_TYPE_MISMATCH_ERROR = 1049,
    READREF_WITHOUT_COPY_ABILITY = 1050,
    READREF_EXISTS_MUTABLE_BORROW_ERROR = 1051,
    WRITEREF_TYPE_MISMATCH_ERROR = 1052,
    WRITEREF_WITHOUT_DROP_ABILITY = 1053,
    WRITEREF_EXISTS_BORROW_ERROR = 1054,
    WRITEREF_NO_MUTABLE_REFERENCE_ERROR = 1055,
    INTEGER_OP_TYPE_MISMATCH_ERROR = 1056,
    BOOLEAN_OP_TYPE_MISMATCH_ERROR = 1057,
    EQUALITY_OP_TYPE_MISMATCH_ERROR = 1058,
    EXISTS_WITHOUT_KEY_ABILITY_OR_BAD_ARGUMENT = 1059,
    BORROWGLOBAL_TYPE_MISMATCH_ERROR = 1060,
    BORROWGLOBAL_WITHOUT_KEY_ABILITY= 1061,
    MOVEFROM_TYPE_MISMATCH_ERROR = 1062,
    MOVEFROM_WITHOUT_KEY_ABILITY = 1063,
    MOVETO_TYPE_MISMATCH_ERROR = 1064,
    MOVETO_WITHOUT_KEY_ABILITY= 1065,
    // The self address of a module the transaction is publishing is not the sender address
    MODULE_ADDRESS_DOES_NOT_MATCH_SENDER = 1067,
    // The module does not have any module handles. Each module or script must have at least one
    // module handle.
    NO_MODULE_HANDLES = 1068,
    POSITIVE_STACK_SIZE_AT_BLOCK_END = 1069,
    MISSING_ACQUIRES_ANNOTATION = 1070,
    EXTRANEOUS_ACQUIRES_ANNOTATION = 1071,
    DUPLICATE_ACQUIRES_ANNOTATION = 1072,
    INVALID_ACQUIRES_ANNOTATION = 1073,
    GLOBAL_REFERENCE_ERROR = 1074,
    CONSTRAINT_NOT_SATISFIED = 1075,
    NUMBER_OF_TYPE_ARGUMENTS_MISMATCH = 1076,
    LOOP_IN_INSTANTIATION_GRAPH = 1077,
    // Reported when a struct has zero fields
    ZERO_SIZED_STRUCT = 1080,
    LINKER_ERROR = 1081,
    INVALID_CONSTANT_TYPE = 1082,
    MALFORMED_CONSTANT_DATA = 1083,
    EMPTY_CODE_UNIT = 1084,
    INVALID_LOOP_SPLIT = 1085,
    INVALID_LOOP_BREAK = 1086,
    INVALID_LOOP_CONTINUE = 1087,
    UNSAFE_RET_UNUSED_VALUES_WITHOUT_DROP = 1088,
    TOO_MANY_LOCALS = 1089,
    GENERIC_MEMBER_OPCODE_MISMATCH = 1090,
    FUNCTION_RESOLUTION_FAILURE = 1091,
    INVALID_OPERATION_IN_SCRIPT = 1094,
    // The sender is trying to publish two modules with the same name in one transaction
    DUPLICATE_MODULE_NAME = 1095,
    // The sender is trying to publish a module that breaks the compatibility checks
    BACKWARD_INCOMPATIBLE_MODULE_UPDATE = 1096,
    // The updated module introduces a cyclic dependency (i.e., A uses B and B also uses A)
    CYCLIC_MODULE_DEPENDENCY = 1097,
    NUMBER_OF_ARGUMENTS_MISMATCH = 1098,
    INVALID_PARAM_TYPE_FOR_DESERIALIZATION = 1099,
    FAILED_TO_DESERIALIZE_ARGUMENT = 1100,
    NUMBER_OF_SIGNER_ARGUMENTS_MISMATCH = 1101,
    CALLED_SCRIPT_VISIBLE_FROM_NON_SCRIPT_VISIBLE = 1102,
    EXECUTE_ENTRY_FUNCTION_CALLED_ON_NON_ENTRY_FUNCTION = 1103,
    // Cannot mark the module itself as a friend
    INVALID_FRIEND_DECL_WITH_SELF = 1104,
    // Cannot declare modules outside of account address as friends
    INVALID_FRIEND_DECL_WITH_MODULES_OUTSIDE_ACCOUNT_ADDRESS = 1105,
    // Cannot declare modules that this module depends on as friends
    INVALID_FRIEND_DECL_WITH_MODULES_IN_DEPENDENCIES = 1106,
    // The updated module introduces a cyclic friendship (i.e., A friends B and B also friends A)
    CYCLIC_MODULE_FRIENDSHIP = 1107,
    // A phantom type parameter was used in a non-phantom position.
    INVALID_PHANTOM_TYPE_PARAM_POSITION = 1108,
    VEC_UPDATE_EXISTS_MUTABLE_BORROW_ERROR = 1109,
    VEC_BORROW_ELEMENT_EXISTS_MUTABLE_BORROW_ERROR = 1110,
    // Loops are too deeply nested.
    LOOP_MAX_DEPTH_REACHED = 1111,
    TOO_MANY_TYPE_PARAMETERS = 1112,
    TOO_MANY_PARAMETERS = 1113,
    TOO_MANY_BASIC_BLOCKS = 1114,
    VALUE_STACK_OVERFLOW = 1115,
    TOO_MANY_TYPE_NODES = 1116,
    VALUE_STACK_PUSH_OVERFLOW = 1117,
    MAX_DEPENDENCY_DEPTH_REACHED = 1118,
    MAX_FUNCTION_DEFINITIONS_REACHED = 1119,
    MAX_STRUCT_DEFINITIONS_REACHED = 1120,
    MAX_FIELD_DEFINITIONS_REACHED = 1121,
    // Reserved error code for future use
    TOO_MANY_BACK_EDGES = 1122,
    RESERVED_VERIFICATION_ERROR_1 = 1123,
    RESERVED_VERIFICATION_ERROR_2 = 1124,
    RESERVED_VERIFICATION_ERROR_3 = 1125,
    RESERVED_VERIFICATION_ERROR_4 = 1126,
    RESERVED_VERIFICATION_ERROR_5 = 1127,

    TOO_MANY_VECTOR_ELEMENTS = 1128,
    IDENTIFIER_TOO_LONG = 1129,

    // Bytecode verifier determined code to complex
    // or took too long to run based on metering policies
    PROGRAM_TOO_COMPLEX = 1130,

    // These are errors that the VM might raise if a violation of internal
    // invariants takes place.
    // Invariant Violation Errors: 2000-2999
    UNKNOWN_INVARIANT_VIOLATION_ERROR = 2000,
    EMPTY_VALUE_STACK = 2003,
    PC_OVERFLOW = 2005,
    VERIFICATION_ERROR = 2006,
    STORAGE_ERROR = 2008,
    INTERNAL_TYPE_ERROR = 2009,
    EVENT_KEY_MISMATCH = 2010,
    UNREACHABLE = 2011,
    VM_STARTUP_FAILURE = 2012,
    UNEXPECTED_ERROR_FROM_KNOWN_MOVE_FUNCTION = 2015,
    VERIFIER_INVARIANT_VIOLATION = 2016,
    UNEXPECTED_VERIFIER_ERROR = 2017,
    UNEXPECTED_DESERIALIZATION_ERROR = 2018,
    FAILED_TO_SERIALIZE_WRITE_SET_CHANGES = 2019,
    FAILED_TO_DESERIALIZE_RESOURCE = 2020,
    // Failed to resolve type due to linking being broken after verification
    TYPE_RESOLUTION_FAILURE = 2021,
    DUPLICATE_NATIVE_FUNCTION = 2022,
    ARITHMETIC_OVERFLOW = 2023,

    // Errors that can arise from binary decoding (deserialization)
    // Deserializtion Errors: 3000-3999
    UNKNOWN_BINARY_ERROR = 3000,
    MALFORMED = 3001,
    BAD_MAGIC = 3002,
    UNKNOWN_VERSION = 3003,
    UNKNOWN_TABLE_TYPE = 3004,
    UNKNOWN_SIGNATURE_TYPE = 3005,
    UNKNOWN_SERIALIZED_TYPE = 3006,
    UNKNOWN_OPCODE = 3007,
    BAD_HEADER_TABLE = 3008,
    UNEXPECTED_SIGNATURE_TYPE = 3009,
    DUPLICATE_TABLE = 3010,
    UNKNOWN_ABILITY = 3013,
    UNKNOWN_NATIVE_STRUCT_FLAG = 3014,
    BAD_U16 = 3017,
    BAD_U32 = 3018,
    BAD_U64 = 3019,
    BAD_U128 = 3020,
    BAD_U256 = 3021,
    VALUE_SERIALIZATION_ERROR = 3022,
    VALUE_DESERIALIZATION_ERROR = 3023,
    CODE_DESERIALIZATION_ERROR = 3024,
    INVALID_FLAG_BITS = 3025,
    TRAILING_BYTES = 3026,

    // Errors that can arise at runtime
    // Runtime Errors: 4000-4999
    UNKNOWN_RUNTIME_STATUS = 4000,
    EXECUTED = 4001,
    OUT_OF_GAS = 4002,
    // We tried to access a resource that does not exist under the account.
    RESOURCE_DOES_NOT_EXIST = 4003,
    // We tried to create a resource under an account where that resource
    // already exists.
    RESOURCE_ALREADY_EXISTS = 4004,
    MISSING_DATA = 4008,
    DATA_FORMAT_ERROR = 4009,
    ABORTED = 4016,
    ARITHMETIC_ERROR = 4017,
    VECTOR_OPERATION_ERROR = 4018,
    EXECUTION_STACK_OVERFLOW = 4020,
    CALL_STACK_OVERFLOW = 4021,
    VM_MAX_TYPE_DEPTH_REACHED = 4024,
    VM_MAX_VALUE_DEPTH_REACHED = 4025,
    VM_EXTENSION_ERROR = 4026,
    STORAGE_WRITE_LIMIT_REACHED = 4027,
    MEMORY_LIMIT_EXCEEDED = 4028,
    VM_MAX_TYPE_NODES_REACHED = 4029,

    // A reserved status to represent an unknown vm status.
    // this is std::u64::MAX, but we can't pattern match on that, so put the hardcoded value in
    UNKNOWN_STATUS = 18446744073709551615,
}
*)
(* NOTE: We might want to implement a function to translate the StatusCode to its corresponded integer in the future *)
Module StatusCode.
  Inductive t : Set :=
  | UNKNOWN_VALIDATION_STATUS
  | INVALID_SIGNATURE
  | INVALID_AUTH_KEY
  | SEQUENCE_NUMBER_TOO_OLD
  | SEQUENCE_NUMBER_TOO_NEW
  | INSUFFICIENT_BALANCE_FOR_TRANSACTION_FEE
  | TRANSACTION_EXPIRED
  | SENDING_ACCOUNT_DOES_NOT_EXIST
  | REJECTED_WRITE_SET
  | INVALID_WRITE_SET
  | EXCEEDED_MAX_TRANSACTION_SIZE
  | UNKNOWN_SCRIPT
  | UNKNOWN_MODULE
  | MAX_GAS_UNITS_EXCEEDS_MAX_GAS_UNITS_BOUND
  | MAX_GAS_UNITS_BELOW_MIN_TRANSACTION_GAS_UNITS
  | GAS_UNIT_PRICE_BELOW_MIN_BOUND
  | GAS_UNIT_PRICE_ABOVE_MAX_BOUND
  | INVALID_GAS_SPECIFIER
  | SENDING_ACCOUNT_FROZEN
  | UNABLE_TO_DESERIALIZE_ACCOUNT
  | CURRENCY_INFO_DOES_NOT_EXIST
  | INVALID_MODULE_PUBLISHER
  | NO_ACCOUNT_ROLE
  | BAD_CHAIN_ID
  | SEQUENCE_NUMBER_TOO_BIG
  | BAD_TRANSACTION_FEE_CURRENCY
  | FEATURE_UNDER_GATING
  | SECONDARY_KEYS_ADDRESSES_COUNT_MISMATCH
  | SIGNERS_CONTAIN_DUPLICATES
  | SEQUENCE_NONCE_INVALID
  | CHAIN_ACCOUNT_INFO_DOES_NOT_EXIST
  | UNKNOWN_VERIFICATION_ERROR
  | INDEX_OUT_OF_BOUNDS
  | INVALID_SIGNATURE_TOKEN
  | RECURSIVE_STRUCT_DEFINITION
  | FIELD_MISSING_TYPE_ABILITY
  | INVALID_FALL_THROUGH
  | NEGATIVE_STACK_SIZE_WITHIN_BLOCK
  | INVALID_MAIN_FUNCTION_SIGNATURE
  | DUPLICATE_ELEMENT
  | INVALID_MODULE_HANDLE
  | UNIMPLEMENTED_HANDLE
  | LOOKUP_FAILED
  | TYPE_MISMATCH
  | MISSING_DEPENDENCY
  | POP_WITHOUT_DROP_ABILITY
  | BR_TYPE_MISMATCH_ERROR
  | ABORT_TYPE_MISMATCH_ERROR
  | STLOC_TYPE_MISMATCH_ERROR
  | STLOC_UNSAFE_TO_DESTROY_ERROR
  | UNSAFE_RET_LOCAL_OR_RESOURCE_STILL_BORROWED
  | RET_TYPE_MISMATCH_ERROR
  | RET_BORROWED_MUTABLE_REFERENCE_ERROR
  | FREEZEREF_TYPE_MISMATCH_ERROR
  | FREEZEREF_EXISTS_MUTABLE_BORROW_ERROR
  | BORROWFIELD_TYPE_MISMATCH_ERROR
  | BORROWFIELD_BAD_FIELD_ERROR
  | BORROWFIELD_EXISTS_MUTABLE_BORROW_ERROR
  | COPYLOC_UNAVAILABLE_ERROR
  | COPYLOC_WITHOUT_COPY_ABILITY
  | COPYLOC_EXISTS_BORROW_ERROR
  | MOVELOC_UNAVAILABLE_ERROR
  | MOVELOC_EXISTS_BORROW_ERROR
  | BORROWLOC_REFERENCE_ERROR
  | BORROWLOC_UNAVAILABLE_ERROR
  | BORROWLOC_EXISTS_BORROW_ERROR
  | CALL_TYPE_MISMATCH_ERROR
  | CALL_BORROWED_MUTABLE_REFERENCE_ERROR
  | PACK_TYPE_MISMATCH_ERROR
  | UNPACK_TYPE_MISMATCH_ERROR
  | READREF_TYPE_MISMATCH_ERROR
  | READREF_WITHOUT_COPY_ABILITY
  | READREF_EXISTS_MUTABLE_BORROW_ERROR
  | WRITEREF_TYPE_MISMATCH_ERROR
  | WRITEREF_WITHOUT_DROP_ABILITY
  | WRITEREF_EXISTS_BORROW_ERROR
  | WRITEREF_NO_MUTABLE_REFERENCE_ERROR
  | INTEGER_OP_TYPE_MISMATCH_ERROR
  | BOOLEAN_OP_TYPE_MISMATCH_ERROR
  | EQUALITY_OP_TYPE_MISMATCH_ERROR
  | EXISTS_WITHOUT_KEY_ABILITY_OR_BAD_ARGUMENT
  | BORROWGLOBAL_TYPE_MISMATCH_ERROR
  | BORROWGLOBAL_WITHOUT_KEY_ABILITY
  | MOVEFROM_TYPE_MISMATCH_ERROR
  | MOVEFROM_WITHOUT_KEY_ABILITY
  | MOVETO_TYPE_MISMATCH_ERROR
  | MOVETO_WITHOUT_KEY_ABILITY
  | MODULE_ADDRESS_DOES_NOT_MATCH_SENDER
  | NO_MODULE_HANDLES
  | POSITIVE_STACK_SIZE_AT_BLOCK_END
  | MISSING_ACQUIRES_ANNOTATION
  | EXTRANEOUS_ACQUIRES_ANNOTATION
  | DUPLICATE_ACQUIRES_ANNOTATION
  | INVALID_ACQUIRES_ANNOTATION
  | GLOBAL_REFERENCE_ERROR
  | CONSTRAINT_NOT_SATISFIED
  | NUMBER_OF_TYPE_ARGUMENTS_MISMATCH
  | LOOP_IN_INSTANTIATION_GRAPH
  | ZERO_SIZED_STRUCT
  | LINKER_ERROR
  | INVALID_CONSTANT_TYPE
  | MALFORMED_CONSTANT_DATA
  | EMPTY_CODE_UNIT
  | INVALID_LOOP_SPLIT
  | INVALID_LOOP_BREAK
  | INVALID_LOOP_CONTINUE
  | UNSAFE_RET_UNUSED_VALUES_WITHOUT_DROP
  | TOO_MANY_LOCALS
  | GENERIC_MEMBER_OPCODE_MISMATCH
  | FUNCTION_RESOLUTION_FAILURE
  | INVALID_OPERATION_IN_SCRIPT
  | DUPLICATE_MODULE_NAME
  | BACKWARD_INCOMPATIBLE_MODULE_UPDATE
  | CYCLIC_MODULE_DEPENDENCY
  | NUMBER_OF_ARGUMENTS_MISMATCH
  | INVALID_PARAM_TYPE_FOR_DESERIALIZATION
  | FAILED_TO_DESERIALIZE_ARGUMENT
  | NUMBER_OF_SIGNER_ARGUMENTS_MISMATCH
  | CALLED_SCRIPT_VISIBLE_FROM_NON_SCRIPT_VISIBLE
  | EXECUTE_ENTRY_FUNCTION_CALLED_ON_NON_ENTRY_FUNCTION
  | INVALID_FRIEND_DECL_WITH_SELF
  | INVALID_FRIEND_DECL_WITH_MODULES_OUTSIDE_ACCOUNT_ADDRESS
  | INVALID_FRIEND_DECL_WITH_MODULES_IN_DEPENDENCIES
  | CYCLIC_MODULE_FRIENDSHIP
  | INVALID_PHANTOM_TYPE_PARAM_POSITION
  | VEC_UPDATE_EXISTS_MUTABLE_BORROW_ERROR
  | VEC_BORROW_ELEMENT_EXISTS_MUTABLE_BORROW_ERROR
  | LOOP_MAX_DEPTH_REACHED
  | TOO_MANY_TYPE_PARAMETERS
  | TOO_MANY_PARAMETERS
  | TOO_MANY_BASIC_BLOCKS
  | VALUE_STACK_OVERFLOW
  | TOO_MANY_TYPE_NODES
  | VALUE_STACK_PUSH_OVERFLOW
  | MAX_DEPENDENCY_DEPTH_REACHED
  | MAX_FUNCTION_DEFINITIONS_REACHED
  | MAX_STRUCT_DEFINITIONS_REACHED
  | MAX_FIELD_DEFINITIONS_REACHED
  | TOO_MANY_BACK_EDGES
  | RESERVED_VERIFICATION_ERROR_1
  | RESERVED_VERIFICATION_ERROR_2
  | RESERVED_VERIFICATION_ERROR_3
  | RESERVED_VERIFICATION_ERROR_4
  | RESERVED_VERIFICATION_ERROR_5
  | TOO_MANY_VECTOR_ELEMENTS
  | IDENTIFIER_TOO_LONG
  | PROGRAM_TOO_COMPLEX
  | UNKNOWN_INVARIANT_VIOLATION_ERROR
  | EMPTY_VALUE_STACK
  | PC_OVERFLOW
  | VERIFICATION_ERROR
  | STORAGE_ERROR
  | INTERNAL_TYPE_ERROR
  | EVENT_KEY_MISMATCH
  | UNREACHABLE
  | VM_STARTUP_FAILURE
  | UNEXPECTED_ERROR_FROM_KNOWN_MOVE_FUNCTION
  | VERIFIER_INVARIANT_VIOLATION
  | UNEXPECTED_VERIFIER_ERROR
  | UNEXPECTED_DESERIALIZATION_ERROR
  | FAILED_TO_SERIALIZE_WRITE_SET_CHANGES
  | FAILED_TO_DESERIALIZE_RESOURCE
  | TYPE_RESOLUTION_FAILURE
  | DUPLICATE_NATIVE_FUNCTION
  | ARITHMETIC_OVERFLOW
  | UNKNOWN_BINARY_ERROR
  | MALFORMED
  | BAD_MAGIC
  | UNKNOWN_VERSION
  | UNKNOWN_TABLE_TYPE
  | UNKNOWN_SIGNATURE_TYPE
  | UNKNOWN_SERIALIZED_TYPE
  | UNKNOWN_OPCODE
  | BAD_HEADER_TABLE
  | UNEXPECTED_SIGNATURE_TYPE
  | DUPLICATE_TABLE
  | UNKNOWN_ABILITY
  | UNKNOWN_NATIVE_STRUCT_FLAG
  | BAD_U16
  | BAD_U32
  | BAD_U64
  | BAD_U128
  | BAD_U256
  | VALUE_SERIALIZATION_ERROR
  | VALUE_DESERIALIZATION_ERROR
  | CODE_DESERIALIZATION_ERROR
  | INVALID_FLAG_BITS
  | TRAILING_BYTES
  | UNKNOWN_RUNTIME_STATUS
  | EXECUTED
  | OUT_OF_GAS
  | RESOURCE_DOES_NOT_EXIST
  | RESOURCE_ALREADY_EXISTS
  | MISSING_DATA
  | DATA_FORMAT_ERROR
  | ABORTED
  | ARITHMETIC_ERROR
  | VECTOR_OPERATION_ERROR
  | EXECUTION_STACK_OVERFLOW
  | CALL_STACK_OVERFLOW
  | VM_MAX_TYPE_DEPTH_REACHED
  | VM_MAX_VALUE_DEPTH_REACHED
  | VM_EXTENSION_ERROR
  | STORAGE_WRITE_LIMIT_REACHED
  | MEMORY_LIMIT_EXCEEDED
  | VM_MAX_TYPE_NODES_REACHED
  | UNKNOWN_STATUS
  .
End StatusCode.
