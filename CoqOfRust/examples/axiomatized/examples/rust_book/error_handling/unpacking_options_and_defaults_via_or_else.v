(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

(*
Enum Fruit
{
  const_params := [];
  ty_params := [];
  variants :=
    [
      {
        name := "Apple";
        item := StructTuple [];
      };
      {
        name := "Orange";
        item := StructTuple [];
      };
      {
        name := "Banana";
        item := StructTuple [];
      };
      {
        name := "Kiwi";
        item := StructTuple [];
      };
      {
        name := "Lemon";
        item := StructTuple [];
      }
    ];
}
*)

Axiom IsDiscriminant_Fruit_Apple :
  M.IsDiscriminant "unpacking_options_and_defaults_via_or_else::Fruit::Apple" 0.
Axiom IsDiscriminant_Fruit_Orange :
  M.IsDiscriminant "unpacking_options_and_defaults_via_or_else::Fruit::Orange" 1.
Axiom IsDiscriminant_Fruit_Banana :
  M.IsDiscriminant "unpacking_options_and_defaults_via_or_else::Fruit::Banana" 2.
Axiom IsDiscriminant_Fruit_Kiwi :
  M.IsDiscriminant "unpacking_options_and_defaults_via_or_else::Fruit::Kiwi" 3.
Axiom IsDiscriminant_Fruit_Lemon :
  M.IsDiscriminant "unpacking_options_and_defaults_via_or_else::Fruit::Lemon" 4.

Module Impl_core_fmt_Debug_for_unpacking_options_and_defaults_via_or_else_Fruit.
  Definition Self : Ty.t := Ty.path "unpacking_options_and_defaults_via_or_else::Fruit".
  
  Parameter fmt : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Axiom Implements :
    M.IsTraitInstance
      "core::fmt::Debug"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) []
      Self
      (* Instance *) [ ("fmt", InstanceField.Method fmt) ].
End Impl_core_fmt_Debug_for_unpacking_options_and_defaults_via_or_else_Fruit.

Parameter main : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.

Global Instance Instance_IsFunction_main :
  M.IsFunction.C "unpacking_options_and_defaults_via_or_else::main" main.
Admitted.
