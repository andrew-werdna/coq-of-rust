(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

(* StructTuple
  {
    name := "Empty";
    const_params := [];
    ty_params := [];
    fields := [];
  } *)

(* StructTuple
  {
    name := "Null";
    const_params := [];
    ty_params := [];
    fields := [];
  } *)

(* Trait *)
(* Empty module 'DoubleDrop' *)

Module Impl_generics_traits_DoubleDrop_T_for_U.
  Definition Self (T U : Ty.t) : Ty.t := U.
  
  Parameter double_drop : forall (T U : Ty.t), (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Axiom Implements :
    forall (T U : Ty.t),
    M.IsTraitInstance
      "generics_traits::DoubleDrop"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) [ T ]
      (Self T U)
      (* Instance *) [ ("double_drop", InstanceField.Method (double_drop T U)) ].
End Impl_generics_traits_DoubleDrop_T_for_U.

Parameter main : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.

Global Instance Instance_IsFunction_main : M.IsFunction.C "generics_traits::main" main.
Admitted.
