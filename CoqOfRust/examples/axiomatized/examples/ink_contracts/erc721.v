(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

(* StructRecord
  {
    name := "Mapping";
    const_params := [];
    ty_params := [ "K"; "V" ];
    fields :=
      [
        ("_key", Ty.apply (Ty.path "core::marker::PhantomData") [] [ K ]);
        ("_value", Ty.apply (Ty.path "core::marker::PhantomData") [] [ V ])
      ];
  } *)

Module Impl_core_default_Default_where_core_default_Default_K_where_core_default_Default_V_for_erc721_Mapping_K_V.
  Definition Self (K V : Ty.t) : Ty.t := Ty.apply (Ty.path "erc721::Mapping") [] [ K; V ].
  
  Parameter default : forall (K V : Ty.t), (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Axiom Implements :
    forall (K V : Ty.t),
    M.IsTraitInstance
      "core::default::Default"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) []
      (Self K V)
      (* Instance *) [ ("default", InstanceField.Method (default K V)) ].
End Impl_core_default_Default_where_core_default_Default_K_where_core_default_Default_V_for_erc721_Mapping_K_V.

Module Impl_erc721_Mapping_K_V.
  Definition Self (K V : Ty.t) : Ty.t := Ty.apply (Ty.path "erc721::Mapping") [] [ K; V ].
  
  Parameter contains : forall (K V : Ty.t), (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_contains :
    forall (K V : Ty.t),
    M.IsAssociatedFunction.C (Self K V) "contains" (contains K V).
  Admitted.
  
  Parameter get : forall (K V : Ty.t), (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_get :
    forall (K V : Ty.t),
    M.IsAssociatedFunction.C (Self K V) "get" (get K V).
  Admitted.
  
  Parameter insert : forall (K V : Ty.t), (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_insert :
    forall (K V : Ty.t),
    M.IsAssociatedFunction.C (Self K V) "insert" (insert K V).
  Admitted.
  
  Parameter remove : forall (K V : Ty.t), (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_remove :
    forall (K V : Ty.t),
    M.IsAssociatedFunction.C (Self K V) "remove" (remove K V).
  Admitted.
  
  Parameter size : forall (K V : Ty.t), (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_size :
    forall (K V : Ty.t),
    M.IsAssociatedFunction.C (Self K V) "size" (size K V).
  Admitted.
  
  Parameter take : forall (K V : Ty.t), (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_take :
    forall (K V : Ty.t),
    M.IsAssociatedFunction.C (Self K V) "take" (take K V).
  Admitted.
End Impl_erc721_Mapping_K_V.

(* StructTuple
  {
    name := "AccountId";
    const_params := [];
    ty_params := [];
    fields := [ Ty.path "u128" ];
  } *)

Module Impl_core_default_Default_for_erc721_AccountId.
  Definition Self : Ty.t := Ty.path "erc721::AccountId".
  
  Parameter default : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Axiom Implements :
    M.IsTraitInstance
      "core::default::Default"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) []
      Self
      (* Instance *) [ ("default", InstanceField.Method default) ].
End Impl_core_default_Default_for_erc721_AccountId.

Module Impl_core_clone_Clone_for_erc721_AccountId.
  Definition Self : Ty.t := Ty.path "erc721::AccountId".
  
  Parameter clone : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Axiom Implements :
    M.IsTraitInstance
      "core::clone::Clone"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) []
      Self
      (* Instance *) [ ("clone", InstanceField.Method clone) ].
End Impl_core_clone_Clone_for_erc721_AccountId.

Module Impl_core_marker_Copy_for_erc721_AccountId.
  Definition Self : Ty.t := Ty.path "erc721::AccountId".
  
  Axiom Implements :
    M.IsTraitInstance
      "core::marker::Copy"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) []
      Self
      (* Instance *) [].
End Impl_core_marker_Copy_for_erc721_AccountId.

Module Impl_core_marker_StructuralPartialEq_for_erc721_AccountId.
  Definition Self : Ty.t := Ty.path "erc721::AccountId".
  
  Axiom Implements :
    M.IsTraitInstance
      "core::marker::StructuralPartialEq"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) []
      Self
      (* Instance *) [].
End Impl_core_marker_StructuralPartialEq_for_erc721_AccountId.

Module Impl_core_cmp_PartialEq_erc721_AccountId_for_erc721_AccountId.
  Definition Self : Ty.t := Ty.path "erc721::AccountId".
  
  Parameter eq : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Axiom Implements :
    M.IsTraitInstance
      "core::cmp::PartialEq"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) [ Ty.path "erc721::AccountId" ]
      Self
      (* Instance *) [ ("eq", InstanceField.Method eq) ].
End Impl_core_cmp_PartialEq_erc721_AccountId_for_erc721_AccountId.

Module Impl_core_convert_From_array_Usize_32_u8_for_erc721_AccountId.
  Definition Self : Ty.t := Ty.path "erc721::AccountId".
  
  Parameter from : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Axiom Implements :
    M.IsTraitInstance
      "core::convert::From"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *)
      [ Ty.apply (Ty.path "array") [ Value.Integer IntegerKind.Usize 32 ] [ Ty.path "u8" ] ]
      Self
      (* Instance *) [ ("from", InstanceField.Method from) ].
End Impl_core_convert_From_array_Usize_32_u8_for_erc721_AccountId.

Axiom Balance : (Ty.path "erc721::Balance") = (Ty.path "u128").

(* StructRecord
  {
    name := "Env";
    const_params := [];
    ty_params := [];
    fields := [ ("caller", Ty.path "erc721::AccountId") ];
  } *)

Axiom TokenId : (Ty.path "erc721::TokenId") = (Ty.path "u32").

(* StructRecord
  {
    name := "Erc721";
    const_params := [];
    ty_params := [];
    fields :=
      [
        ("token_owner",
          Ty.apply (Ty.path "erc721::Mapping") [] [ Ty.path "u32"; Ty.path "erc721::AccountId" ]);
        ("token_approvals",
          Ty.apply (Ty.path "erc721::Mapping") [] [ Ty.path "u32"; Ty.path "erc721::AccountId" ]);
        ("owned_tokens_count",
          Ty.apply (Ty.path "erc721::Mapping") [] [ Ty.path "erc721::AccountId"; Ty.path "u32" ]);
        ("operator_approvals",
          Ty.apply
            (Ty.path "erc721::Mapping")
            []
            [ Ty.tuple [ Ty.path "erc721::AccountId"; Ty.path "erc721::AccountId" ]; Ty.tuple [] ])
      ];
  } *)

Module Impl_core_default_Default_for_erc721_Erc721.
  Definition Self : Ty.t := Ty.path "erc721::Erc721".
  
  Parameter default : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Axiom Implements :
    M.IsTraitInstance
      "core::default::Default"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) []
      Self
      (* Instance *) [ ("default", InstanceField.Method default) ].
End Impl_core_default_Default_for_erc721_Erc721.

(*
Enum Error
{
  const_params := [];
  ty_params := [];
  variants :=
    [
      {
        name := "NotOwner";
        item := StructTuple [];
      };
      {
        name := "NotApproved";
        item := StructTuple [];
      };
      {
        name := "TokenExists";
        item := StructTuple [];
      };
      {
        name := "TokenNotFound";
        item := StructTuple [];
      };
      {
        name := "CannotInsert";
        item := StructTuple [];
      };
      {
        name := "CannotFetchValue";
        item := StructTuple [];
      };
      {
        name := "NotAllowed";
        item := StructTuple [];
      }
    ];
}
*)

Axiom IsDiscriminant_Error_NotOwner : M.IsDiscriminant "erc721::Error::NotOwner" 0.
Axiom IsDiscriminant_Error_NotApproved : M.IsDiscriminant "erc721::Error::NotApproved" 1.
Axiom IsDiscriminant_Error_TokenExists : M.IsDiscriminant "erc721::Error::TokenExists" 2.
Axiom IsDiscriminant_Error_TokenNotFound : M.IsDiscriminant "erc721::Error::TokenNotFound" 3.
Axiom IsDiscriminant_Error_CannotInsert : M.IsDiscriminant "erc721::Error::CannotInsert" 4.
Axiom IsDiscriminant_Error_CannotFetchValue : M.IsDiscriminant "erc721::Error::CannotFetchValue" 5.
Axiom IsDiscriminant_Error_NotAllowed : M.IsDiscriminant "erc721::Error::NotAllowed" 6.

Module Impl_core_marker_StructuralPartialEq_for_erc721_Error.
  Definition Self : Ty.t := Ty.path "erc721::Error".
  
  Axiom Implements :
    M.IsTraitInstance
      "core::marker::StructuralPartialEq"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) []
      Self
      (* Instance *) [].
End Impl_core_marker_StructuralPartialEq_for_erc721_Error.

Module Impl_core_cmp_PartialEq_erc721_Error_for_erc721_Error.
  Definition Self : Ty.t := Ty.path "erc721::Error".
  
  Parameter eq : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Axiom Implements :
    M.IsTraitInstance
      "core::cmp::PartialEq"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) [ Ty.path "erc721::Error" ]
      Self
      (* Instance *) [ ("eq", InstanceField.Method eq) ].
End Impl_core_cmp_PartialEq_erc721_Error_for_erc721_Error.

Module Impl_core_cmp_Eq_for_erc721_Error.
  Definition Self : Ty.t := Ty.path "erc721::Error".
  
  Parameter assert_receiver_is_total_eq : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Axiom Implements :
    M.IsTraitInstance
      "core::cmp::Eq"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) []
      Self
      (* Instance *)
      [ ("assert_receiver_is_total_eq", InstanceField.Method assert_receiver_is_total_eq) ].
End Impl_core_cmp_Eq_for_erc721_Error.

Module Impl_core_clone_Clone_for_erc721_Error.
  Definition Self : Ty.t := Ty.path "erc721::Error".
  
  Parameter clone : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Axiom Implements :
    M.IsTraitInstance
      "core::clone::Clone"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) []
      Self
      (* Instance *) [ ("clone", InstanceField.Method clone) ].
End Impl_core_clone_Clone_for_erc721_Error.

Module Impl_core_marker_Copy_for_erc721_Error.
  Definition Self : Ty.t := Ty.path "erc721::Error".
  
  Axiom Implements :
    M.IsTraitInstance
      "core::marker::Copy"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) []
      Self
      (* Instance *) [].
End Impl_core_marker_Copy_for_erc721_Error.

(* StructRecord
  {
    name := "Transfer";
    const_params := [];
    ty_params := [];
    fields :=
      [
        ("from", Ty.apply (Ty.path "core::option::Option") [] [ Ty.path "erc721::AccountId" ]);
        ("to", Ty.apply (Ty.path "core::option::Option") [] [ Ty.path "erc721::AccountId" ]);
        ("id", Ty.path "u32")
      ];
  } *)

(* StructRecord
  {
    name := "Approval";
    const_params := [];
    ty_params := [];
    fields :=
      [
        ("from", Ty.path "erc721::AccountId");
        ("to", Ty.path "erc721::AccountId");
        ("id", Ty.path "u32")
      ];
  } *)

(* StructRecord
  {
    name := "ApprovalForAll";
    const_params := [];
    ty_params := [];
    fields :=
      [
        ("owner", Ty.path "erc721::AccountId");
        ("operator", Ty.path "erc721::AccountId");
        ("approved", Ty.path "bool")
      ];
  } *)

(*
Enum Event
{
  const_params := [];
  ty_params := [];
  variants :=
    [
      {
        name := "Transfer";
        item := StructTuple [ Ty.path "erc721::Transfer" ];
      };
      {
        name := "Approval";
        item := StructTuple [ Ty.path "erc721::Approval" ];
      };
      {
        name := "ApprovalForAll";
        item := StructTuple [ Ty.path "erc721::ApprovalForAll" ];
      }
    ];
}
*)

Axiom IsDiscriminant_Event_Transfer : M.IsDiscriminant "erc721::Event::Transfer" 0.
Axiom IsDiscriminant_Event_Approval : M.IsDiscriminant "erc721::Event::Approval" 1.
Axiom IsDiscriminant_Event_ApprovalForAll : M.IsDiscriminant "erc721::Event::ApprovalForAll" 2.

Module Impl_erc721_Env.
  Definition Self : Ty.t := Ty.path "erc721::Env".
  
  Parameter caller : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_caller : M.IsAssociatedFunction.C Self "caller" caller.
  Admitted.
  
  Parameter emit_event : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_emit_event :
    M.IsAssociatedFunction.C Self "emit_event" emit_event.
  Admitted.
End Impl_erc721_Env.

Module Impl_erc721_Erc721.
  Definition Self : Ty.t := Ty.path "erc721::Erc721".
  
  Parameter init_env : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_init_env : M.IsAssociatedFunction.C Self "init_env" init_env.
  Admitted.
  
  Parameter env : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_env : M.IsAssociatedFunction.C Self "env" env.
  Admitted.
  
  Parameter new : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_new : M.IsAssociatedFunction.C Self "new" new.
  Admitted.
  
  Parameter balance_of_or_zero : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_balance_of_or_zero :
    M.IsAssociatedFunction.C Self "balance_of_or_zero" balance_of_or_zero.
  Admitted.
  
  Parameter clear_approval : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_clear_approval :
    M.IsAssociatedFunction.C Self "clear_approval" clear_approval.
  Admitted.
  
  Parameter approved_for_all : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_approved_for_all :
    M.IsAssociatedFunction.C Self "approved_for_all" approved_for_all.
  Admitted.
  
  Parameter owner_of : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_owner_of : M.IsAssociatedFunction.C Self "owner_of" owner_of.
  Admitted.
  
  Parameter approved_or_owner : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_approved_or_owner :
    M.IsAssociatedFunction.C Self "approved_or_owner" approved_or_owner.
  Admitted.
  
  Parameter exists_ : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_exists_ : M.IsAssociatedFunction.C Self "exists" exists_.
  Admitted.
  
  Parameter balance_of : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_balance_of :
    M.IsAssociatedFunction.C Self "balance_of" balance_of.
  Admitted.
  
  Parameter get_approved : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_get_approved :
    M.IsAssociatedFunction.C Self "get_approved" get_approved.
  Admitted.
  
  Parameter is_approved_for_all : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_is_approved_for_all :
    M.IsAssociatedFunction.C Self "is_approved_for_all" is_approved_for_all.
  Admitted.
  
  Parameter approve_for_all : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_approve_for_all :
    M.IsAssociatedFunction.C Self "approve_for_all" approve_for_all.
  Admitted.
  
  Parameter set_approval_for_all : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_set_approval_for_all :
    M.IsAssociatedFunction.C Self "set_approval_for_all" set_approval_for_all.
  Admitted.
  
  Parameter approve_for : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_approve_for :
    M.IsAssociatedFunction.C Self "approve_for" approve_for.
  Admitted.
  
  Parameter approve : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_approve : M.IsAssociatedFunction.C Self "approve" approve.
  Admitted.
  
  Parameter remove_token_from : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_remove_token_from :
    M.IsAssociatedFunction.C Self "remove_token_from" remove_token_from.
  Admitted.
  
  Parameter add_token_to : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_add_token_to :
    M.IsAssociatedFunction.C Self "add_token_to" add_token_to.
  Admitted.
  
  Parameter transfer_token_from : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_transfer_token_from :
    M.IsAssociatedFunction.C Self "transfer_token_from" transfer_token_from.
  Admitted.
  
  Parameter transfer : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_transfer : M.IsAssociatedFunction.C Self "transfer" transfer.
  Admitted.
  
  Parameter transfer_from : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_transfer_from :
    M.IsAssociatedFunction.C Self "transfer_from" transfer_from.
  Admitted.
  
  Parameter mint : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_mint : M.IsAssociatedFunction.C Self "mint" mint.
  Admitted.
  
  Parameter burn : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_burn : M.IsAssociatedFunction.C Self "burn" burn.
  Admitted.
End Impl_erc721_Erc721.
