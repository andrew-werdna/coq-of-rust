Require Import CoqOfRust.CoqOfRust.
Require Import links.M.
Require Import alloc.links.alloc.
Require Import alloc.vec.links.mod.
Require core.links.clone.
Require core.links.default.
Require Import core.links.option.
Require Import revm.links.dependencies.
Require Export revm.revm_bytecode.eof.links.body_EofBody.
Require Export revm.revm_bytecode.eof.links.header.
Require Import revm.revm_bytecode.eof.links.types_section.
Require Import revm_bytecode.eof.body.
Require Import core.slice.mod.

Import Run.

Module EofBody.
  Record t : Set := {
    types_section: Vec.t revm_bytecode.eof.links.types_section.TypesSection.t Global.t;
    code_section: Vec.t Usize.t Global.t;
    code: alloy_primitives.links.bytes_.Bytes.t;
    container_section: Vec.t alloy_primitives.links.bytes_.Bytes.t Global.t;
    data_section: alloy_primitives.links.bytes_.Bytes.t;
    is_data_filled: bool;
  }.

  Global Instance IsLink : Link t := {
    Φ := Ty.path "revm_bytecode::eof::body::EofBody";
    φ '(Build_t types_section code_section code container_section data_section is_data_filled) :=
      Value.StructRecord "revm_bytecode::eof::body::EofBody" [
        ("types_section", φ types_section);
        ("code_section", φ code_section);
        ("code", φ code);
        ("container_section", φ container_section);
        ("data_section", φ data_section);
        ("is_data_filled", φ is_data_filled)
      ]
  }.

  Definition of_ty : OfTy.t (Ty.path "revm_bytecode::eof::body::EofBody").
  Proof. eapply OfTy.Make with (A := t); reflexivity. Defined.
  Smpl Add apply of_ty : of_ty.

  Lemma of_value_with
      (types_section : Vec.t revm_bytecode.eof.links.types_section.TypesSection.t Global.t) types_section'
      (code_section : Vec.t Usize.t Global.t) code_section'
      (code : alloy_primitives.links.bytes_.Bytes.t) code'
      (container_section : Vec.t alloy_primitives.links.bytes_.Bytes.t Global.t) container_section'
      (data_section : alloy_primitives.links.bytes_.Bytes.t) data_section'
      (is_data_filled : bool) is_data_filled' :
    types_section' = φ types_section ->
    code_section' = φ code_section ->
    code' = φ code ->
    container_section' = φ container_section ->
    data_section' = φ data_section ->
    is_data_filled' = φ is_data_filled ->
    Value.StructRecord "revm_bytecode::eof::body::EofBody" [
      ("types_section", types_section');
      ("code_section", code_section');
      ("code", code');
      ("container_section", container_section');
      ("data_section", data_section');
      ("is_data_filled", is_data_filled')
    ] = φ (Build_t types_section code_section code container_section data_section is_data_filled).
  Proof. now intros; subst. Qed.
  Smpl Add apply of_value_with : of_value.

  Definition of_value
      (types_section : Vec.t revm_bytecode.eof.links.types_section.TypesSection.t Global.t)
      (code_section : Vec.t Usize.t Global.t)
      (code : alloy_primitives.links.bytes_.Bytes.t)
      (container_section : Vec.t alloy_primitives.links.bytes_.Bytes.t Global.t)
      (data_section : alloy_primitives.links.bytes_.Bytes.t)
      (is_data_filled : bool) :
    OfValue.t (
      Value.StructRecord "revm_bytecode::eof::body::EofBody" [
        ("types_section", φ types_section);
        ("code_section", φ code_section);
        ("code", φ code);
        ("container_section", φ container_section);
        ("data_section", φ data_section);
        ("is_data_filled", φ is_data_filled)
      ]
    ).
  Proof. econstructor; apply of_value_with; reflexivity. Defined.
  Smpl Add apply of_value : of_value.

  Module SubPointer.
    Definition get_types_section : SubPointer.Runner.t t
      (Pointer.Index.StructRecord "revm_bytecode::eof::body::EofBody" "types_section") :=
    {|
      SubPointer.Runner.projection x := Some x.(types_section);
      SubPointer.Runner.injection x y := Some (x <| types_section := y |>);
    |}.

    Lemma get_types_section_is_valid :
      SubPointer.Runner.Valid.t get_types_section.
    Proof.
      now constructor.
    Qed.
    Smpl Add apply get_types_section_is_valid : run_sub_pointer.

    Definition get_code_section : SubPointer.Runner.t t
      (Pointer.Index.StructRecord "revm_bytecode::eof::body::EofBody" "code_section") :=
    {|
      SubPointer.Runner.projection x := Some x.(code_section);
      SubPointer.Runner.injection x y := Some (x <| code_section := y |>);
    |}.

    Lemma get_code_section_is_valid :
      SubPointer.Runner.Valid.t get_code_section.
    Proof.
      now constructor.
    Qed.
    Smpl Add apply get_code_section_is_valid : run_sub_pointer.

    Definition get_code : SubPointer.Runner.t t
      (Pointer.Index.StructRecord "revm_bytecode::eof::body::EofBody" "code") :=
    {|
      SubPointer.Runner.projection x := Some x.(code);
      SubPointer.Runner.injection x y := Some (x <| code := y |>);
    |}.

    Lemma get_code_is_valid :
      SubPointer.Runner.Valid.t get_code.
    Proof.
      now constructor.
    Qed.
    Smpl Add apply get_code_is_valid : run_sub_pointer.

    Definition get_container_section : SubPointer.Runner.t t
      (Pointer.Index.StructRecord "revm_bytecode::eof::body::EofBody" "container_section") :=
    {|
      SubPointer.Runner.projection x := Some x.(container_section);
      SubPointer.Runner.injection x y := Some (x <| container_section := y |>);
    |}.

    Lemma get_container_section_is_valid :
      SubPointer.Runner.Valid.t get_container_section.
    Proof.
      now constructor.
    Qed.
    Smpl Add apply get_container_section_is_valid : run_sub_pointer.

    Definition get_data_section : SubPointer.Runner.t t
      (Pointer.Index.StructRecord "revm_bytecode::eof::body::EofBody" "data_section") :=
    {|
      SubPointer.Runner.projection x := Some x.(data_section);
      SubPointer.Runner.injection x y := Some (x <| data_section := y |>);
    |}.

    Lemma get_data_section_is_valid :
      SubPointer.Runner.Valid.t get_data_section.
    Proof.
      now constructor.
    Qed.
    Smpl Add apply get_data_section_is_valid : run_sub_pointer.

    Definition get_is_data_filled : SubPointer.Runner.t t
      (Pointer.Index.StructRecord "revm_bytecode::eof::body::EofBody" "is_data_filled") :=
    {|
      SubPointer.Runner.projection x := Some x.(is_data_filled);
      SubPointer.Runner.injection x y := Some (x <| is_data_filled := y |>);
    |}.

    Lemma get_is_data_filled_is_valid :
      SubPointer.Runner.Valid.t get_is_data_filled.
    Proof.
      now constructor.
    Qed.
    Smpl Add apply get_is_data_filled_is_valid : run_sub_pointer.
  End SubPointer.
End EofBody.

Module Impl_Clone_for_EofBody.
  Definition run_clone : clone.Clone.Run_clone EofBody.t.
  Proof.
    eexists; split.
    { eapply IsTraitMethod.Defined.
      { apply body.eof.body.Impl_core_clone_Clone_for_revm_bytecode_eof_body_EofBody.Implements. }
      { reflexivity. }
    }
    { intros.
      destruct (vec.links.mod.Impl_Clone_for_Vec.run (T := TypesSection.t) (A := Global.t)).
      destruct clone.
      destruct (vec.links.mod.Impl_Clone_for_Vec.run (T := Usize.t) (A := Global.t)).
      destruct clone.
      destruct alloy_primitives.links.bytes_.Impl_Clone_for_Bytes.run.
      destruct clone.
      destruct (vec.links.mod.Impl_Clone_for_Vec.run (T := alloy_primitives.links.bytes_.Bytes.t) (A := Global.t)).
      destruct clone.
      destruct clone.Impl_Clone_for_bool.run.
      destruct clone.
      run_symbolic.
    }
  Defined.

  Definition run : clone.Clone.Run EofBody.t.
  Proof.
    constructor.
    { (* clone *)
      exact run_clone.
    }
  Defined.
End Impl_Clone_for_EofBody.

Module Impl_Default_for_EofBody.
  Definition run_default : default.Default.Run_default EofBody.t.
  Proof.
    eexists; split.
    { eapply IsTraitMethod.Defined.
      { apply body.eof.body.Impl_core_default_Default_for_revm_bytecode_eof_body_EofBody.Implements. }
      { reflexivity. }
    }
    { intros.
      destruct (vec.links.mod.Impl_Default_for_Vec.run (T := TypesSection.t) (A := Global.t)).
      destruct default.
      destruct (vec.links.mod.Impl_Default_for_Vec.run (T := Usize.t) (A := Global.t)).
      destruct default.
      destruct alloy_primitives.links.bytes_.Impl_Default_for_Bytes.run.
      destruct default.
      destruct (vec.links.mod.Impl_Default_for_Vec.run (T := alloy_primitives.links.bytes_.Bytes.t) (A := Global.t)).
      destruct default.
      destruct default.Impl_Default_for_bool.run.
      destruct default.
      run_symbolic.
      run_symbolic_closure.
      intros []; run_symbolic.
      run_symbolic_closure.
      intros []; run_symbolic.
      run_symbolic_closure.
      intros []; run_symbolic.
      run_symbolic_closure.
      intros []; run_symbolic.
      run_symbolic_closure.
      intros []; run_symbolic.
      run_symbolic_closure.
      intros []; run_symbolic.
    }
  Defined.
End Impl_Default_for_EofBody.

Module Impl_EofBody.
  Definition Self : Set := EofBody.t.

  (*
      pub fn code(&self, index: usize) -> Option<Bytes> {
        if index == 0 {
            // There should be at least one code section.
            return Some(self.code.slice(..self.code_section[0]));
        }
        self.code_section
            .get(index)
            .map(|end| self.code.slice(self.code_section[index - 1]..*end))
      }
  *)
  Definition run_code (self : Ref.t Pointer.Kind.Ref Self) (index : Usize.t) :
    {{ body.eof.body.Impl_revm_bytecode_eof_body_EofBody.code [] [] [φ self; φ index] 🔽 option alloy_primitives.links.bytes_.Bytes.t }}.
  Proof.
    run_symbolic.
    run_symbolic_let. {
      run_symbolic.
      run_symbolic_are_equal_integer; run_symbolic.
      { run_symbolic_are_equal_bool; run_symbolic; admit. }
      { run_symbolic_are_equal_bool; run_symbolic; admit. }
    }
    intros [|[]]; run_symbolic.
    destruct (vec.links.mod.Impl_Deref_for_Vec.run (T := Usize.t) (A := Global.t)).
    destruct deref as [deref [H_deref run_deref]].
    run_symbolic.
    run_symbolic_closure. {
      pose proof (Impl_Slice.run_get
        Usize.t
        (I := Usize.t)
        (Output := Ref.t Pointer.Kind.Ref Usize.t)
      ).
      apply H.
      pose proof (Impl_SliceIndex_for_Usize.run Usize.t).
      cbn.
      Print Impl_Slice.Self.
      unfold Impl_Slice.Self.
      cbn.
  Admitted.

  (*
  pub fn into_eof(self) -> Eof {
        // TODO : Add bounds checks.
        let mut prev_value = 0;
        let header = EofHeader {
            types_size: self.types_section.len() as u16 * 4,
            code_sizes: self
                .code_section
                .iter()
                .map(|x| {
                    let ret = (x - prev_value) as u16;
                    prev_value = *x;
                    ret
                })
                .collect(),
            container_sizes: self
                .container_section
                .iter()
                .map(|x| x.len() as u16)
                .collect(),
            data_size: self.data_section.len() as u16,
            sum_code_sizes: self.code.len(),
            sum_container_sizes: self.container_section.iter().map(|x| x.len()).sum(),
        };
        let mut buffer = Vec::new();
        header.encode(&mut buffer);
        self.encode(&mut buffer);
        Eof {
            header,
            body: self,
            raw: buffer.into(),
        }
    }
  *)
  Definition run_into_eof (self : Self) :
    {{ body.eof.body.Impl_revm_bytecode_eof_body_EofBody.into_eof [] [] [φ self] 🔽 Eof.t }}.
  Proof.
    run_symbolic.
    run_symbolic_let. { 
      run_symbolic.
      run_symbolic_closure. {
        apply Impl_alloc_vec_Vec_T_A.run_len.
      }
      intros []; run_symbolic.
  Admitted.

  (*
    pub fn eof_code_section_start(&self, idx: usize) -> Option<usize> {
      // Starting code section start with 0.
      let code_offset = self.code_offset;
      if idx == 0 {
          return Some(code_offset);
      }
      self.code_section.get(idx - 1).map(|i| i + code_offset)
    }
  *)
  Definition run_eof_code_section_start (self : Ref.t Pointer.Kind.Ref Self) (idx : Usize.t) :
    {{ body.eof.body.Impl_revm_bytecode_eof_body_EofBody.eof_code_section_start [] [] [φ self; φ idx] 🔽 option Usize.t }}.
  Proof.
    run_symbolic.
    run_symbolic_let. {
      run_symbolic.
      run_symbolic_are_equal_integer; run_symbolic; run_symbolic_are_equal_bool; run_symbolic.
    }
    intros []; run_symbolic. {
      destruct (vec.links.mod.Impl_Deref_for_Vec.run (T := Usize.t) (A := Global.t)).
      destruct deref.
      run_symbolic.
      run_symbolic_closure.
      intros []; run_symbolic.
      run_symbolic_closure.
  Admitted.

  (*
    pub fn encode(&self, buffer: &mut Vec<u8>) {
      for code_info in &self.code_info {
          code_info.encode(buffer);
      }

      buffer.extend_from_slice(&self.code);

      for container_section in &self.container_section {
          buffer.extend_from_slice(container_section);
      }

      buffer.extend_from_slice(&self.data_section);
    }
  *)
  Definition run_encode (self : Ref.t Pointer.Kind.Ref Self) (buffer : Ref.t Pointer.Kind.MutPointer (Vec.t U8.t Global.t)) :
    {{ body.eof.body.Impl_revm_bytecode_eof_body_EofBody.encode [] [] [φ self; φ buffer] 🔽 unit }}.
  Proof.
    run_symbolic.
    run_symbolic_let. {
      run_symbolic.
Admitted.

  (*
    pub fn decode(input: &Bytes, header: &EofHeader) -> Result<Self, EofDecodeError> {
      let header_len = header.size();
      let partial_body_len =
          header.sum_code_sizes + header.sum_container_sizes + header.types_size as usize;
      let full_body_len = partial_body_len + header.data_size as usize;

      if input.len() < header_len + partial_body_len {
          return Err(EofDecodeError::MissingBodyWithoutData);
      }

      if input.len() > header_len + full_body_len {
          return Err(EofDecodeError::DanglingData);
      }

      let mut body = EofBody::default();

      let mut types_input = &input[header_len..];
      for _ in 0..header.types_count() {
          let (code_info, local_input) = CodeInfo::decode(types_input)?;
          types_input = local_input;
          body.code_info.push(code_info);
      }

      // Extract code section
      let start = header_len + header.types_size as usize;
      body.code_offset = start;
      let mut code_end = 0;
      for size in header.code_sizes.iter().map(|x| *x as usize) {
          code_end += size;
          body.code_section.push(code_end);
      }
      body.code = input.slice(start..start + header.sum_code_sizes);

      // Extract container section
      let mut start = start + header.sum_code_sizes;
      for size in header.container_sizes.iter().map(|x| *x as usize) {
          body.container_section
              .push(input.slice(start..start + size));
          start += size;
      }

      body.data_section = input.slice(start..);
      body.is_data_filled = body.data_section.len() == header.data_size as usize;

      Ok(body)
    }
  *)

End Impl_EofBody.
