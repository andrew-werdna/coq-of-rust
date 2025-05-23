(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

(* StructRecord
  {
    name := "Incrementer";
    const_params := [];
    ty_params := [];
    fields := [ ("value", Ty.path "i32") ];
  } *)

Module Impl_incrementer_Incrementer.
  Definition Self : Ty.t := Ty.path "incrementer::Incrementer".
  
  Parameter new : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_new : M.IsAssociatedFunction.C Self "new" new.
  Admitted.
  
  Parameter new_default : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_new_default :
    M.IsAssociatedFunction.C Self "new_default" new_default.
  Admitted.
  
  Parameter inc : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_inc : M.IsAssociatedFunction.C Self "inc" inc.
  Admitted.
  
  Parameter get : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.
  
  Global Instance AssociatedFunction_get : M.IsAssociatedFunction.C Self "get" get.
  Admitted.
End Impl_incrementer_Incrementer.
