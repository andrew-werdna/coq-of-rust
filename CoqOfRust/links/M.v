Require Import CoqOfRust.CoqOfRust.

Import List.ListNotations.

Local Open Scope list.

Class Link (A : Set) : Set := {
  Φ : Ty.t;
  φ : A -> Value.t;
}.
(* We make explicit the argument [A]. *)
Arguments Φ _ {_}.

Global Opaque φ.

Global Instance BoolIsLink : Link bool := {
  Φ := Ty.path "bool";
  φ b := Value.Bool b;
}.

Module Integer.
  (** We distinguish the various forms of integers at this level. We will use plain [Z] integers in
      the simulations. *)
  Record t {kind : IntegerKind.t} : Set := {
    value : Z;
  }.
  Arguments t : clear implicits.

  Definition to_ty_path (kind : IntegerKind.t) : string :=
    match kind with
    | IntegerKind.I8 => "i8"
    | IntegerKind.I16 => "i16"
    | IntegerKind.I32 => "i32"
    | IntegerKind.I64 => "i64"
    | IntegerKind.I128 => "i128"
    | IntegerKind.Isize => "isize"
    | IntegerKind.U8 => "u8"
    | IntegerKind.U16 => "u16"
    | IntegerKind.U32 => "u32"
    | IntegerKind.U64 => "u64"
    | IntegerKind.U128 => "u128"
    | IntegerKind.Usize => "usize"
    end.

  Global Instance IsLink {kind : IntegerKind.t} : Link (t kind) := {
    Φ := Ty.path (to_ty_path kind);
    φ '{| value := value |} := Value.Integer kind value;
  }.
End Integer.

(** ** Integer kinds for better readability *)
Module U8.
  Definition t : Set := Integer.t IntegerKind.U8.
End U8.

Module U16.
  Definition t : Set := Integer.t IntegerKind.U16.
End U16.

Module U32.
  Definition t : Set := Integer.t IntegerKind.U32.
End U32.

Module U64.
  Definition t : Set := Integer.t IntegerKind.U64.
End U64.

Module U128.
  Definition t : Set := Integer.t IntegerKind.U128.
End U128.

Module Usize.
  Definition t : Set := Integer.t IntegerKind.Usize.
End Usize.

Module I8.
  Definition t : Set := Integer.t IntegerKind.I8.
End I8.

Module I16.
  Definition t : Set := Integer.t IntegerKind.I16.
End I16.

Module I32.
  Definition t : Set := Integer.t IntegerKind.I32.
End I32.

Module I64.
  Definition t : Set := Integer.t IntegerKind.I64.
End I64.

Module I128.
  Definition t : Set := Integer.t IntegerKind.I128.
End I128.

Module Isize.
  Definition t : Set := Integer.t IntegerKind.Isize.
End Isize.

Module Char.
  Inductive t : Set :=
  | Make (c : Z).

  Global Instance IsLink : Link t := {
    Φ := Ty.path "char";
    φ '(Make c) := Value.UnicodeChar c;
  }.
End Char.

Module OneElementTuple.
  (** There are no tuples of one element in Coq so we have to create it. This is different than the
      type itself in the sense that the [Link] instance should not be the same and use Rust tuples
      of one element instead. *)
  Record t {A : Set} `{Link A} : Set := {
    value : A;
  }.
  Arguments t _ {_}.

  Global Instance IsLink {A : Set} `{Link A} : Link (t A) := {
    Φ := Ty.tuple [Φ A];
    φ '{| value := value |} := Value.Tuple [φ value];
  }.
End OneElementTuple.

Module TupleIsLink.
  Global Instance I0 : Link unit := {
    Φ := Ty.tuple [];
    φ _ := Value.Tuple [];
  }.

  Global Instance I2 (A1 A2 : Set)
      (_ : Link A1)
      (_ : Link A2) :
      Link (A1 * A2) := {
    Φ := Ty.tuple [Φ A1; Φ A2];
    φ '(a1, a2) := Value.Tuple [φ a1; φ a2];
  }.

  Global Instance I3 (A1 A2 A3 : Set)
      (_ : Link A1)
      (_ : Link A2)
      (_ : Link A3) :
      Link (A1 * A2 * A3) := {
    Φ := Ty.tuple [Φ A1; Φ A2; Φ A3];
    φ '(a1, a2, a3) := Value.Tuple [φ a1; φ a2; φ a3];
  }.

  Global Instance I4 (A1 A2 A3 A4 : Set)
      (_ : Link A1)
      (_ : Link A2)
      (_ : Link A3)
      (_ : Link A4) :
      Link (A1 * A2 * A3 * A4) := {
    Φ := Ty.tuple [Φ A1; Φ A2; Φ A3; Φ A4];
    φ '(a1, a2, a3, a4) :=
      Value.Tuple [φ a1; φ a2; φ a3; φ a4];
  }.

  Global Instance I5 (A1 A2 A3 A4 A5 : Set)
      (_ : Link A1)
      (_ : Link A2)
      (_ : Link A3)
      (_ : Link A4)
      (_ : Link A5) :
      Link (A1 * A2 * A3 * A4 * A5) := {
    Φ := Ty.tuple [Φ A1; Φ A2; Φ A3; Φ A4; Φ A5];
    φ '(a1, a2, a3, a4, a5) :=
      Value.Tuple [φ a1; φ a2; φ a3; φ a4; φ a5];
  }.

  Global Instance I6 (A1 A2 A3 A4 A5 A6 : Set)
      (_ : Link A1)
      (_ : Link A2)
      (_ : Link A3)
      (_ : Link A4)
      (_ : Link A5)
      (_ : Link A6) :
      Link (A1 * A2 * A3 * A4 * A5 * A6) := {
    Φ := Ty.tuple [Φ A1; Φ A2; Φ A3; Φ A4; Φ A5; Φ A6];
    φ '(a1, a2, a3, a4, a5, a6) :=
      Value.Tuple [φ a1; φ a2; φ a3; φ a4; φ a5; φ a6];
  }.

  Global Instance I7 (A1 A2 A3 A4 A5 A6 A7 : Set)
      (_ : Link A1)
      (_ : Link A2)
      (_ : Link A3)
      (_ : Link A4)
      (_ : Link A5)
      (_ : Link A6)
      (_ : Link A7) :
      Link (A1 * A2 * A3 * A4 * A5 * A6 * A7) := {
    Φ := Ty.tuple [Φ A1; Φ A2; Φ A3; Φ A4; Φ A5; Φ A6; Φ A7];
    φ '(a1, a2, a3, a4, a5, a6, a7) :=
      Value.Tuple [
        φ a1; φ a2; φ a3; φ a4; φ a5; φ a6; φ a7
      ];
  }.

  Global Instance I8 (A1 A2 A3 A4 A5 A6 A7 A8 : Set)
      (_ : Link A1)
      (_ : Link A2)
      (_ : Link A3)
      (_ : Link A4)
      (_ : Link A5)
      (_ : Link A6)
      (_ : Link A7)
      (_ : Link A8) :
      Link (A1 * A2 * A3 * A4 * A5 * A6 * A7 * A8) := {
    Φ := Ty.tuple [
      Φ A1; Φ A2; Φ A3; Φ A4; Φ A5; Φ A6; Φ A7; Φ A8
    ];
    φ '(a1, a2, a3, a4, a5, a6, a7, a8) :=
      Value.Tuple [
        φ a1;
        φ a2;
        φ a3;
        φ a4;
        φ a5;
        φ a6;
        φ a7;
        φ a8
      ];
  }.
End TupleIsLink.

(** A general type for references. Can be used for mutable or non-mutable references, as well as
    for unsafe pointers (we assume that the `unsafe` code is safe). *)
Module Ref.
  Module Core.
    Inductive t (A : Set) `{Link A} : Set :=
    | Immediate (value : A)
    | Mutable {Address Big_A : Set}
      (address : Address)
      (path : Pointer.Path.t)
      (big_to_value : Big_A -> Value.t)
      (projection : Big_A -> option A)
      (injection : Big_A -> A -> option Big_A).
    Arguments Immediate {_ _}.
    Arguments Mutable {_ _ _ _}.

    Definition to_core {A : Set} `{Link A} (ref : t A) :
        Pointer.Core.t Value.t A :=
      match ref with
      | Immediate value =>
        Pointer.Core.Immediate (φ value)
      | Mutable address path big_to_value projection injection =>
        Pointer.Core.Mutable (Pointer.Mutable.Make
          address path big_to_value projection injection
        )
      end.
  End Core.

  Record t {kind : Pointer.Kind.t} {A : Set} `{Link A} : Set := {
    core : Core.t A;
  }.
  Arguments t _ _ {_}.

  Definition to_core {kind : Pointer.Kind.t} {A : Set} `{Link A} (ref : t kind A) :
      Pointer.Core.t Value.t A :=
    Core.to_core ref.(core).

  Definition to_pointer {kind : Pointer.Kind.t} {A : Set} `{Link A} (ref : t kind A) :
      Pointer.t Value.t :=
    Pointer.Make kind (Φ A) φ (to_core ref).

  Global Instance IsLink {kind : Pointer.Kind.t} {A : Set} `{Link A} : Link (t kind A) := {
    Φ := Ty.apply (Ty.path (Pointer.Kind.to_ty_path kind)) [] [Φ A];
    φ ref := Value.Pointer (to_pointer ref);
  }.

  Definition immediate {kind : Pointer.Kind.t} {A : Set} `{Link A} (value : A) : t kind A :=
    {| core := Core.Immediate value |}.

  Definition deref {kind : Pointer.Kind.t} {A : Set} `{Link A} (ref : t kind A) :
      t Pointer.Kind.Raw A :=
    {| core := ref.(core) |}.

  Lemma deref_eq {kind : Pointer.Kind.t} {A : Set} `{Link A} (ref : t kind A) :
    M.deref (φ ref) = M.pure (φ (deref ref)).
  Proof.
    reflexivity.
  Qed.
End Ref.

Module SubPointer.
  Module Runner.
    (** We group in a single data structure how we can access to the address of a field of a value
        pointed by a pointer. The field is given by [index]. The functions [projection]
        and [injection] are to read or update values at this [index], once we have a typed
        representation. These operations can fail if the field is from an enum case that is not the
        one currently selected. *)
    Record t (A Sub_A : Set) {H_A : Link A} {H_Sub_A : Link Sub_A} : Set := {
      index : Pointer.Index.t;
      projection : A -> option Sub_A;
      injection : A -> Sub_A -> option A;
    }.
    Arguments index {_ _ _ _}.
    Arguments projection {_ _ _ _}.
    Arguments injection {_ _ _ _}.

    Module Valid.
      (** What does it mean for a [runner] to be well formed. *)
      Record t {A Sub_A : Set} `{Link A} `{Link Sub_A} (runner : Runner.t A Sub_A) : Prop := {
        read_commutativity (a : A) :
          Option.map (runner.(projection) a) φ =
          Value.read_index (φ a) runner.(index);
        write_commutativity (a : A) (sub_a : Sub_A) :
          Option.map (runner.(injection) a sub_a) φ =
          Value.write_index (φ a) runner.(index) (φ sub_a);
      }.
    End Valid.
  End Runner.
End SubPointer.

Module IsSubPointer.
  (** If a pointer (the sub-pointer) targets the field given by a [runner] of another value
      targeted by a pointer. We only consider the core part of a pointer. *)
  Inductive t {A Sub_A : Set} `{Link A} `{Link Sub_A}
      (runner : SubPointer.Runner.t A Sub_A) : Ref.Core.t A -> Ref.Core.t Sub_A -> Set :=
  | Immediate (value : A) (sub_value : Sub_A) :
    runner.(SubPointer.Runner.projection) value = Some sub_value ->
    t runner
      (Ref.Core.Immediate value)
      (Ref.Core.Immediate sub_value)
  | Mutable {Address Big_A : Set}
      (address : Address)
      (path : Pointer.Path.t)
      (big_to_value : Big_A -> Value.t)
      (projection : Big_A -> option A)
      (injection : Big_A -> A -> option Big_A) :
    let ref : Ref.Core.t A :=
      Ref.Core.Mutable address path big_to_value projection injection in
    let sub_ref : Ref.Core.t Sub_A :=
      Ref.Core.Mutable
        address
        (path ++ [runner.(SubPointer.Runner.index)])
        big_to_value
        (fun (big_a : Big_A) =>
          match projection big_a with
          | Some a => runner.(SubPointer.Runner.projection) a
          | None => None
          end : option Sub_A
        )
        (fun (big_a : Big_A) (new_sub_a : Sub_A) =>
          match projection big_a with
          | Some a =>
            match runner.(SubPointer.Runner.injection) a new_sub_a with
            | Some new_a => injection big_a new_a
            | None => None
            end
          | None => None
          end : option Big_A
        ) in
    t runner ref sub_ref.
End IsSubPointer.

(** Some convenient `output_to_value` functions. *)

Definition output_pure (Output : Set) `{Link Output} (output : Output) : Value.t + Exception.t :=
  inl (φ output).

Module Output.
  Inductive t (Output : Set) `{Link Output} : Set :=
  | Success (output : Output) : t Output
  | Panic (panic : Panic.t) : t Output.
  Arguments Success {_ _}.
  Arguments Panic {_ _}.
End Output.

Definition output_with_panic (Output : Set) `{Link Output} (output : Output.t Output) :
    Value.t + Exception.t :=
  match output with
  | Output.Success output => inl (φ output)
  | Output.Panic panic => inr (Exception.Panic panic)
  end.

Definition output_with_exception (Output : Set) `{Link Output} (output : Output + Exception.t) :
    Value.t + Exception.t :=
  match output with
  | inl output => inl (φ output)
  | inr exception => inr exception
  end.

Module Run.
  Reserved Notation "{{ e ⇓ output_to_value }}" (no associativity).

  (** The [Run.t] predicate to show that there exists a trace of execution for an expression [e]
      if we choose the right types/`φ` functions and make a valid names and traits
      resolution.

      The function [output_to_value] is used to convert the output of the expression [e] to
      a [Value.t] or an [Exception.t] at the end. It gives a constraint on what kinds of results
      the expression [e] can produce.
  *)
  Inductive t {Output : Set} (output_to_value : Output -> Value.t + Exception.t) : M -> Set :=
  | Pure
      (output : Output)
      (output' : Value.t + Exception.t) :
    output' = output_to_value output ->
    {{ LowM.Pure output' ⇓ output_to_value }}
  | CallPrimitiveStateAlloc {A : Set} `{Link A}
      (value : A) (value' : Value.t)
      (k : Value.t -> M) :
    value' = φ value ->
    (forall (ref : Ref.t Pointer.Kind.Raw A),
      {{ k (φ ref) ⇓ output_to_value }}
     ) ->
    {{ LowM.CallPrimitive (Primitive.StateAlloc value') k ⇓ output_to_value }}
  | CallPrimitiveStateAllocImmediate {A : Set} `{Link A}
      (value : A) (value' : Value.t)
      (k : Value.t -> M) :
    value' = φ value ->
    {{
      k (φ ({| Ref.core := Ref.Core.Immediate value |} : Ref.t Pointer.Kind.Raw A)) ⇓
      output_to_value
    }} ->
    {{ LowM.CallPrimitive (Primitive.StateAlloc value') k ⇓ output_to_value }}
  | CallPrimitiveStateRead {A : Set} `{Link A}
      (ref_core : Ref.Core.t A)
      (k : Value.t -> M) :
    let ref : Ref.t Pointer.Kind.Raw A := {| Ref.core := ref_core |} in
    (forall (value : A),
      {{ k (φ value) ⇓ output_to_value }}
    ) ->
    (* We can expect the pointers to always be the image of [φ] as they cannot be manually
       created. This is the same for the other primitives expecting a pointer. *)
    {{ LowM.CallPrimitive (Primitive.StateRead (φ ref)) k ⇓ output_to_value }}
  | CallPrimitiveStateReadImmediate {A : Set} `{Link A}
      (value : A)
      (k : Value.t -> M) :
    let ref := Ref.immediate (kind := Pointer.Kind.Raw) value in
    {{ k (φ value) ⇓ output_to_value }} ->
    {{ LowM.CallPrimitive (Primitive.StateRead (φ ref)) k ⇓ output_to_value }}
  | CallPrimitiveStateWrite {A : Set} `{Link A}
      (ref_core : Ref.Core.t A)
      (value : A) (value' : Value.t)
      (k : Value.t -> M) :
    let ref : Ref.t Pointer.Kind.Raw A := {| Ref.core := ref_core |} in
    value' = φ value ->
    {{ k (φ tt) ⇓ output_to_value }} ->
    {{ LowM.CallPrimitive (Primitive.StateWrite (φ ref) value') k ⇓ output_to_value }}
  | CallPrimitiveGetSubPointer {A Sub_A : Set} `{Link A} `{Link Sub_A}
      (ref_core : Ref.Core.t A)
      (runner : SubPointer.Runner.t A Sub_A)
      (k : Value.t -> M) :
    let ref : Ref.t Pointer.Kind.Raw A := {| Ref.core := ref_core |} in
    SubPointer.Runner.Valid.t runner ->
    (forall (sub_ref : Ref.t Pointer.Kind.Raw Sub_A),
      {{ k (φ sub_ref) ⇓ output_to_value }}
    ) ->
    {{
      LowM.CallPrimitive (Primitive.GetSubPointer (φ ref) runner.(SubPointer.Runner.index)) k ⇓
      output_to_value
    }}
  | CallPrimitiveAreEqual {A : Set} `{Link A}
      (x y : A) (x' y' : Value.t)
      (k : Value.t -> M) :
    x' = φ x ->
    y' = φ y ->
    (forall (b : bool),
      {{ k (φ b) ⇓ output_to_value }}
    ) ->
    {{
      LowM.CallPrimitive (Primitive.AreEqual x' y') k ⇓
        output_to_value
    }}
  | CallPrimitiveGetFunction
      (name : string) (generic_consts : list Value.t) (generic_tys : list Ty.t)
      (function : PolymorphicFunction.t)
      (k : Value.t -> M) :
    let closure := Value.Closure (existS (_, _) (function generic_consts generic_tys)) in
    M.IsFunction name function ->
    {{ k closure ⇓ output_to_value }} ->
    {{
      LowM.CallPrimitive (Primitive.GetFunction name generic_consts generic_tys) k ⇓
      output_to_value
    }}
  | CallPrimitiveGetAssociatedFunction
      (ty : Ty.t) (name : string) (generic_consts : list Value.t) (generic_tys : list Ty.t)
      (associated_function : PolymorphicFunction.t)
      (k : Value.t -> M) :
    let closure := Value.Closure (existS (_, _) (associated_function generic_consts generic_tys)) in
    M.IsAssociatedFunction ty name associated_function ->
    {{ k closure ⇓ output_to_value }} ->
    {{ LowM.CallPrimitive
        (Primitive.GetAssociatedFunction ty name generic_consts generic_tys) k ⇓
        output_to_value
    }}
  | CallPrimitiveGetTraitMethod
      (trait_name : string) (self_ty : Ty.t) (trait_consts : list Value.t) (trait_tys : list Ty.t)
      (method_name : string) (generic_consts : list Value.t) (generic_tys : list Ty.t)
      (method : PolymorphicFunction.t)
      (k : Value.t -> M) :
    let closure := Value.Closure (existS (_, _) (method generic_consts generic_tys)) in
    IsTraitMethod.t trait_name self_ty trait_tys method_name method ->
    {{ k closure ⇓ output_to_value }} ->
    {{ LowM.CallPrimitive
        (Primitive.GetTraitMethod
          trait_name
          self_ty
          trait_consts
          trait_tys
          method_name
          generic_consts
          generic_tys
        )
        k ⇓
        output_to_value
    }}
  | CallClosure {Output' : Set}
      (output_to_value' : Output' -> Value.t + Exception.t)
      (f : list Value.t -> M) (args : list Value.t)
      (k : Value.t + Exception.t -> M) :
    let closure := Value.Closure (existS (_, _) f) in
    {{ f args ⇓ output_to_value' }} ->
    (forall (value_inter : Output'),
      {{ k (output_to_value' value_inter) ⇓ output_to_value }}
    ) ->
    {{ LowM.CallClosure closure args k ⇓ output_to_value }}
  | Let {Output' : Set}
      (output_to_value' : Output' -> Value.t + Exception.t)
      (e : M) (k : Value.t + Exception.t -> M) :
    {{ e ⇓ output_to_value' }} ->
    (forall (value_inter : Output'),
      {{ k (output_to_value' value_inter) ⇓ output_to_value }}
    ) ->
    {{ LowM.Let e k ⇓ output_to_value }}
  (** This primitive is useful to avoid blocking the reduction of this inductive with a [rewrite]
      that is hard to eliminate. *)
  | Rewrite (e e' : M) :
    e = e' ->
    {{ e' ⇓ output_to_value }} ->
    {{ e ⇓ output_to_value }}

  where "{{ e ⇓ output_to_value }}" :=
    (t output_to_value e).

  Notation "{{ e 🔽 Output }}" := {{ e ⇓ output_with_panic Output }}.
End Run.

Import Run.

(*
(** This lemma is convenient to handle the case of sub-pointers. We also have a dedicated tactic
    using it (defined below). Using the tactic is the recommended way. *)
Definition run_sub_pointer {Output A Sub_A : Set}
    {IsLinkA : Link A} {IsLinkSub_A : Link Sub_A}
    {runner : SubPointer.Runner.t A Sub_A}
    (H_runner : SubPointer.Runner.Valid.t runner)
    (ref_core : Ref.Core.t A)
    (pointer_core : Pointer.Core.t Value.t A)
    (k : Value.t -> M)
    (output_to_value : Output -> Value.t + Exception.t)
    (H_pointer_core : pointer_core = Ref.Core.to_core ref_core)
    (H_k : forall (sub_ref : Ref.t Pointer.Kind.Raw Sub_A),
      {{ k (φ sub_ref) ⇓ output_to_value }}
    ) :
  let pointer := Pointer.Make Pointer.Kind.Raw (Φ A) φ pointer_core in
  {{
    LowM.CallPrimitive (Primitive.GetSubPointer pointer runner.(SubPointer.Runner.index)) k ⇓
    output_to_value
  }}.
Proof.
  intros.
  eapply Run.CallPrimitiveGetSubPointer;
    try apply H_pointer_core;
    try apply H_runner;
    try apply H_k.
Defined.
*)

Module Primitive.
  (** These primitives are equivalent to the ones in the generated code, except that we are now
      with types. We have also removed the primitives related to name/trait resolution, as this is
      now done. *)
  Inductive t : Set -> Set :=
  | StateAlloc {A : Set} `{Link A} (value : A) : t (Ref.Core.t A)
  | StateRead {A : Set} `{Link A} (ref_core : Ref.Core.t A) : t A
  | StateWrite {A : Set} `{Link A} (ref_core : Ref.Core.t A) (value : A) : t unit
  | GetSubPointer {A Sub_A : Set} `{Link A} `{Link Sub_A}
    (ref_core : Ref.Core.t A) (runner : SubPointer.Runner.t A Sub_A) :
    t (Ref.Core.t Sub_A)
  | AreEqual {A : Set} `{Link A} (x y : A) : t bool.
End Primitive.

Module LowM.
  (** The typed version of the [LowM.t] monad used in the generated code. We might need to use a
      co-inductive definition instead at some point. *)
  Inductive t (Output : Set) : Set :=
  | Pure (value : Output)
  | CallPrimitive {A : Set} (primitive : Primitive.t A) (k : A -> t Output)
  | Let {A : Set} (e : t A) (k : A -> t Output)
  | Call {A : Set} (e : t A) (k : A -> t Output)
  | Loop {A : Set} (body : t A) (k : A -> t Output).
  Arguments Pure {_}.
  Arguments CallPrimitive {_ _}.
  Arguments Let {_ _}.
  Arguments Call {_ _}.
  Arguments Loop {_ _}.
End LowM.

(* We do not define an equivalent of [M] as the resulting term is generated, so we are not
   interested into having syntactic sugar for the error monad. *)

(** With this function we generate an expression in [LowM.t Output] that is equivalent to the
    input [e] expression, following the proof of equivalence provided in [run]. *)
Fixpoint evaluate {Output : Set}
  {e : M} {output_to_value : Output -> Value.t + Exception.t}
  (run : {{ e ⇓ output_to_value }}) :
  LowM.t Output.
Proof.
  destruct run.
  { (* Pure *)
    exact (LowM.Pure output).
  }
  { (* Alloc *)
    apply (LowM.CallPrimitive (Primitive.StateAlloc value)).
    intros ref_core.
    eapply evaluate.
    match goal with
    | H : forall _, _ |- _ => apply (H {| Ref.core := ref_core |})
    end.
  }
  { (* AllocImmediate *)
    exact (evaluate _ _ _ run).
  }
  { (* Read *)
    apply (LowM.CallPrimitive (Primitive.StateRead ref_core)).
    intros value.
    eapply evaluate.
    match goal with
    | H : forall _, _ |- _ => apply (H value)
    end.
  }
  { (* ReadImmediate *)
    exact (evaluate _ _ _ run).
  }
  { (* Write *)
    apply (LowM.CallPrimitive (Primitive.StateWrite ref_core value)).
    intros _.
    exact (evaluate _ _ _ run).
  }
  { (* SubPointer *)
    apply (LowM.CallPrimitive (Primitive.GetSubPointer ref_core runner)).
    intros sub_ref_core.
    eapply evaluate.
    match goal with
    | H : forall _, _ |- _ => apply (H {| Ref.core := sub_ref_core |})
    end.
  }
  { (* AreEqual *)
    apply (LowM.CallPrimitive (Primitive.AreEqual x y)).
    intros b.
    eapply evaluate.
    match goal with
    | H : forall _, _ |- _ => apply (H b)
    end.

  }
  { (* CallPrimitiveGetFunction *)
    exact (evaluate _ _ _ run).
  }
  { (* CallPrimitiveGetAssociatedFunction *)
    exact (evaluate _ _ _ run).
  }
  { (* CallPrimitiveGetTraitMethod *)
    exact (evaluate _ _ _ run).
  }
  { (* CallClosure *)
    eapply LowM.Call. {
      exact (evaluate _ _ _ run).
    }
    intros output'; eapply evaluate.
    match goal with
    | H : forall _ : Output', _ |- _ => apply (H output')
    end.
  }
  { (* Let *)
    eapply LowM.Let. {
      exact (evaluate _ _ _ run).
    }
    intros output'; eapply evaluate.
    match goal with
    | H : forall _ : Output', _ |- _ => apply (H output')
    end.
  }
  { (* Rewrite *)
    exact (evaluate _ _ _ run).
  }
Defined.

Ltac run_symbolic_state_alloc :=
  (
    (* We hope the allocated value to be in a form that is already the image of a [φ] conversion. *)
    with_strategy opaque [φ] cbn;
    match goal with
    | |-
      {{
        CoqOfRust.M.LowM.CallPrimitive
          (CoqOfRust.M.Primitive.StateAlloc (φ (A := ?B) _)) _ ⇓
        _
      }} =>
        eapply Run.CallPrimitiveStateAlloc with (A := B);
        [try reflexivity |];
        intros
    end
  ) || (
    (* An important case is the allocation of the unit value *)
    eapply Run.CallPrimitiveStateAlloc with (value := tt); [reflexivity |];
    intros
  ).

Ltac run_symbolic_state_alloc_immediate :=
  (
    (* We hope the allocated value to be in a form that is already the image of a [φ] conversion. *)
    with_strategy opaque [φ] cbn;
    match goal with
    | |-
      {{
        CoqOfRust.M.LowM.CallPrimitive
          (CoqOfRust.M.Primitive.StateAlloc (φ (A := ?B) _)) _ ⇓
        _
      }} =>
        eapply Run.CallPrimitiveStateAllocImmediate with (A := B);
        try reflexivity
    end
  ) || (
    (* An important case is the allocation of the unit value *)
    eapply Run.CallPrimitiveStateAllocImmediate with (value := tt);
    try reflexivity
  ).

Ltac run_symbolic_state_read :=
  cbn;
  eapply Run.CallPrimitiveStateRead;
  intros.

Ltac run_symbolic_state_read_immediate :=
  cbn;
  apply Run.CallPrimitiveStateReadImmediate.

Ltac run_symbolic_state_write :=
  cbn;
  eapply Run.CallPrimitiveStateWrite; [reflexivity | reflexivity |];
  intros.

Ltac run_rewrite_deref :=
  eapply Run.Rewrite; [
    rewrite Ref.deref_eq;
    reflexivity
  |].

Ltac run_symbolic_one_step :=
  match goal with
  | |- {{ _ ⇓ _ }} =>
    (eapply Run.Pure; try reflexivity) ||
    run_symbolic_state_alloc ||
    run_symbolic_state_read_immediate ||
    run_symbolic_state_read ||
    run_symbolic_state_write ||
    run_rewrite_deref
  end.

Ltac run_symbolic_one_step_immediate :=
  match goal with
  | |- {{ _ ⇓ _ }} =>
    (eapply Run.Pure; try reflexivity) ||
    run_symbolic_state_alloc_immediate ||
    run_symbolic_state_read_immediate ||
    run_symbolic_state_read ||
    run_symbolic_state_write ||
    run_rewrite_deref
  end.

(** We should use this tactic instead of the ones above, as this one calls all the others. *)
Ltac run_symbolic :=
  (* Ideally, we should have the information about which kind of pointer to use. TODO: add it! *)
  unshelve (repeat run_symbolic_one_step_immediate).

Ltac run_symbolic_mutable :=
  (* Ideally, we should have the information about which kind of pointer to use. TODO: add it! *)
  unshelve (repeat run_symbolic_one_step).

Ltac run_panic :=
  run_symbolic; try apply Output.Panic; try reflexivity.

(** For the specific case of sub-pointers, we still do it by hand by providing the corresponding
    validity statement for the index that we access. *)
Ltac run_sub_pointer sub_pointer_is_valid :=
  cbn; apply (Run.CallPrimitiveGetSubPointer _ _ _ _ sub_pointer_is_valid); intros.

Module Function.
  Record t (Args Output : Set)
      (args_to_value : Args -> list Value.t)
      (output_to_value : Output -> Value.t + Exception.t) :
      Set := {
    f : list Value.t -> M;
    run : forall (args : Args),
      {{ f (args_to_value args) ⇓ output_to_value }};
  }.
End Function.

Module Function2.
  Record t {A1 A2 Output : Set} `{Link A1} `{Link A2} `{Link Output} : Set := {
    f : list Value.t -> M;
    run : forall (a1 : A1) (a2 : A2),
      {{ f [ φ a1; φ a2 ] 🔽 Output }};
  }.
  Arguments t _ _ _ {_ _ _}.

  Global Instance IsLink (A1 A2 Output : Set) `{Link A1} `{Link A2} `{Link Output} :
      Link (t A1 A2 Output) := {
    Φ := Ty.function [Φ A1; Φ A2] (Φ Output);
    φ x := Value.Closure (existS (_, _) x.(f));
  }.
End Function2.
