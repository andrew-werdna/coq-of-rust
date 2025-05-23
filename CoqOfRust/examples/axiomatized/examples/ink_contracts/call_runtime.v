(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

(* StructTuple
  {
    name := "AccountId";
    const_params := [];
    ty_params := [];
    fields := [ Ty.path "u128" ];
  } *)

Module Impl_core_default_Default_for_call_runtime_AccountId.
  Definition Self : Ty.t := Ty.path "call_runtime::AccountId".
  
  Parameter default : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Axiom Implements :
    M.IsTraitInstance
      "core::default::Default"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) []
      Self
      (* Instance *) [ ("default", InstanceField.Method default) ].
End Impl_core_default_Default_for_call_runtime_AccountId.

Module Impl_core_clone_Clone_for_call_runtime_AccountId.
  Definition Self : Ty.t := Ty.path "call_runtime::AccountId".
  
  Parameter clone : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Axiom Implements :
    M.IsTraitInstance
      "core::clone::Clone"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) []
      Self
      (* Instance *) [ ("clone", InstanceField.Method clone) ].
End Impl_core_clone_Clone_for_call_runtime_AccountId.

Module Impl_core_marker_Copy_for_call_runtime_AccountId.
  Definition Self : Ty.t := Ty.path "call_runtime::AccountId".
  
  Axiom Implements :
    M.IsTraitInstance
      "core::marker::Copy"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) []
      Self
      (* Instance *) [].
End Impl_core_marker_Copy_for_call_runtime_AccountId.

Axiom Balance : (Ty.path "call_runtime::Balance") = (Ty.path "u128").

(* StructRecord
  {
    name := "Env";
    const_params := [];
    ty_params := [];
    fields := [ ("caller", Ty.path "call_runtime::AccountId") ];
  } *)

(*
Enum MultiAddress
{
  const_params := [];
  ty_params := [ "AccountId"; "AccountIndex" ];
  variants := [];
}
*)


Module Impl_core_convert_From_call_runtime_AccountId_for_call_runtime_MultiAddress_call_runtime_AccountId_Tuple_.
  Definition Self : Ty.t :=
    Ty.apply
      (Ty.path "call_runtime::MultiAddress")
      []
      [ Ty.path "call_runtime::AccountId"; Ty.tuple [] ].
  
  Parameter from : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Axiom Implements :
    M.IsTraitInstance
      "core::convert::From"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) [ Ty.path "call_runtime::AccountId" ]
      Self
      (* Instance *) [ ("from", InstanceField.Method from) ].
End Impl_core_convert_From_call_runtime_AccountId_for_call_runtime_MultiAddress_call_runtime_AccountId_Tuple_.

(*
Enum BalancesCall
{
  const_params := [];
  ty_params := [];
  variants :=
    [
      {
        name := "Transfer";
        item :=
          StructRecord
            [
              ("dest",
                Ty.apply
                  (Ty.path "call_runtime::MultiAddress")
                  []
                  [ Ty.path "call_runtime::AccountId"; Ty.tuple [] ]);
              ("value", Ty.path "u128")
            ];
      }
    ];
}
*)

Axiom IsDiscriminant_BalancesCall_Transfer :
  M.IsDiscriminant "call_runtime::BalancesCall::Transfer" 0.

(*
Enum RuntimeCall
{
  const_params := [];
  ty_params := [];
  variants :=
    [
      {
        name := "Balances";
        item := StructTuple [ Ty.path "call_runtime::BalancesCall" ];
      }
    ];
}
*)

Axiom IsDiscriminant_RuntimeCall_Balances :
  M.IsDiscriminant "call_runtime::RuntimeCall::Balances" 0.

(* StructTuple
  {
    name := "RuntimeCaller";
    const_params := [];
    ty_params := [];
    fields := [];
  } *)

Module Impl_core_default_Default_for_call_runtime_RuntimeCaller.
  Definition Self : Ty.t := Ty.path "call_runtime::RuntimeCaller".
  
  Parameter default : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Axiom Implements :
    M.IsTraitInstance
      "core::default::Default"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) []
      Self
      (* Instance *) [ ("default", InstanceField.Method default) ].
End Impl_core_default_Default_for_call_runtime_RuntimeCaller.

(*
Enum RuntimeError
{
  const_params := [];
  ty_params := [];
  variants :=
    [
      {
        name := "CallRuntimeFailed";
        item := StructTuple [];
      }
    ];
}
*)

Axiom IsDiscriminant_RuntimeError_CallRuntimeFailed :
  M.IsDiscriminant "call_runtime::RuntimeError::CallRuntimeFailed" 0.

Module Impl_core_fmt_Debug_for_call_runtime_RuntimeError.
  Definition Self : Ty.t := Ty.path "call_runtime::RuntimeError".
  
  Parameter fmt : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Axiom Implements :
    M.IsTraitInstance
      "core::fmt::Debug"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) []
      Self
      (* Instance *) [ ("fmt", InstanceField.Method fmt) ].
End Impl_core_fmt_Debug_for_call_runtime_RuntimeError.

Module Impl_core_marker_StructuralPartialEq_for_call_runtime_RuntimeError.
  Definition Self : Ty.t := Ty.path "call_runtime::RuntimeError".
  
  Axiom Implements :
    M.IsTraitInstance
      "core::marker::StructuralPartialEq"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) []
      Self
      (* Instance *) [].
End Impl_core_marker_StructuralPartialEq_for_call_runtime_RuntimeError.

Module Impl_core_cmp_PartialEq_call_runtime_RuntimeError_for_call_runtime_RuntimeError.
  Definition Self : Ty.t := Ty.path "call_runtime::RuntimeError".
  
  Parameter eq : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Axiom Implements :
    M.IsTraitInstance
      "core::cmp::PartialEq"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) [ Ty.path "call_runtime::RuntimeError" ]
      Self
      (* Instance *) [ ("eq", InstanceField.Method eq) ].
End Impl_core_cmp_PartialEq_call_runtime_RuntimeError_for_call_runtime_RuntimeError.

Module Impl_core_cmp_Eq_for_call_runtime_RuntimeError.
  Definition Self : Ty.t := Ty.path "call_runtime::RuntimeError".
  
  Parameter assert_receiver_is_total_eq : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Axiom Implements :
    M.IsTraitInstance
      "core::cmp::Eq"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) []
      Self
      (* Instance *)
      [ ("assert_receiver_is_total_eq", InstanceField.Method assert_receiver_is_total_eq) ].
End Impl_core_cmp_Eq_for_call_runtime_RuntimeError.

(*
Enum EnvError
{
  const_params := [];
  ty_params := [];
  variants :=
    [
      {
        name := "CallRuntimeFailed";
        item := StructTuple [];
      };
      {
        name := "AnotherKindOfError";
        item := StructTuple [];
      }
    ];
}
*)

Axiom IsDiscriminant_EnvError_CallRuntimeFailed :
  M.IsDiscriminant "call_runtime::EnvError::CallRuntimeFailed" 0.
Axiom IsDiscriminant_EnvError_AnotherKindOfError :
  M.IsDiscriminant "call_runtime::EnvError::AnotherKindOfError" 1.

Module Impl_core_convert_From_call_runtime_EnvError_for_call_runtime_RuntimeError.
  Definition Self : Ty.t := Ty.path "call_runtime::RuntimeError".
  
  Parameter from : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Axiom Implements :
    M.IsTraitInstance
      "core::convert::From"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) [ Ty.path "call_runtime::EnvError" ]
      Self
      (* Instance *) [ ("from", InstanceField.Method from) ].
End Impl_core_convert_From_call_runtime_EnvError_for_call_runtime_RuntimeError.

Module Impl_call_runtime_Env.
  Definition Self : Ty.t := Ty.path "call_runtime::Env".
  
  Parameter call_runtime : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_call_runtime :
    M.IsAssociatedFunction.C Self "call_runtime" call_runtime.
  Admitted.
End Impl_call_runtime_Env.

Module Impl_call_runtime_RuntimeCaller.
  Definition Self : Ty.t := Ty.path "call_runtime::RuntimeCaller".
  
  Parameter init_env : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_init_env : M.IsAssociatedFunction.C Self "init_env" init_env.
  Admitted.
  
  Parameter env : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_env : M.IsAssociatedFunction.C Self "env" env.
  Admitted.
  
  Parameter new : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_new : M.IsAssociatedFunction.C Self "new" new.
  Admitted.
  
  Parameter transfer_through_runtime : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_transfer_through_runtime :
    M.IsAssociatedFunction.C Self "transfer_through_runtime" transfer_through_runtime.
  Admitted.
  
  Parameter call_nonexistent_extrinsic : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_call_nonexistent_extrinsic :
    M.IsAssociatedFunction.C Self "call_nonexistent_extrinsic" call_nonexistent_extrinsic.
  Admitted.
End Impl_call_runtime_RuntimeCaller.
