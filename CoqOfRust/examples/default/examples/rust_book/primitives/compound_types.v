(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

(*
fn main() {
    // Variables can be type annotated.
    let logical: bool = true;

    let a_float: f64 = 1.0;  // Regular annotation
    let an_integer   = 5i32; // Suffix annotation

    // Or a default will be used.
    let default_float   = 3.0; // `f64`
    let default_integer = 7;   // `i32`
    
    // A type can also be inferred from context 
    let mut inferred_type = 12; // Type i64 is inferred from another line
    inferred_type = 4294967296i64;
    
    // A mutable variable's value can be changed.
    let mut mutable = 12; // Mutable `i32`
    mutable = 21;
    
    // Error! The type of a variable can't be changed.
    // mutable = true;
    
    // Variables can be overwritten with shadowing.
    let mutable = true;
}
*)
Definition main (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
  match ε, τ, α with
  | [], [], [] =>
    ltac:(M.monadic
      (M.read (|
        let~ logical : Ty.apply (Ty.path "*") [] [ Ty.path "bool" ] :=
          M.alloc (| Value.Bool true |) in
        let~ a_float : Ty.apply (Ty.path "*") [] [ Ty.path "f64" ] :=
          M.copy (| UnsupportedLiteral |) in
        let~ an_integer : Ty.apply (Ty.path "*") [] [ Ty.path "i32" ] :=
          M.alloc (| Value.Integer IntegerKind.I32 5 |) in
        let~ default_float : Ty.apply (Ty.path "*") [] [ Ty.path "f64" ] :=
          M.copy (| UnsupportedLiteral |) in
        let~ default_integer : Ty.apply (Ty.path "*") [] [ Ty.path "i32" ] :=
          M.alloc (| Value.Integer IntegerKind.I32 7 |) in
        let~ inferred_type : Ty.apply (Ty.path "*") [] [ Ty.path "i64" ] :=
          M.alloc (| Value.Integer IntegerKind.I64 12 |) in
        let~ _ : Ty.apply (Ty.path "*") [] [ Ty.tuple [] ] :=
          M.alloc (| M.write (| inferred_type, Value.Integer IntegerKind.I64 4294967296 |) |) in
        let~ mutable : Ty.apply (Ty.path "*") [] [ Ty.path "i32" ] :=
          M.alloc (| Value.Integer IntegerKind.I32 12 |) in
        let~ _ : Ty.apply (Ty.path "*") [] [ Ty.tuple [] ] :=
          M.alloc (| M.write (| mutable, Value.Integer IntegerKind.I32 21 |) |) in
        let~ mutable : Ty.apply (Ty.path "*") [] [ Ty.path "bool" ] :=
          M.alloc (| Value.Bool true |) in
        M.alloc (| Value.Tuple [] |)
      |)))
  | _, _, _ => M.impossible "wrong number of arguments"
  end.

Global Instance Instance_IsFunction_main : M.IsFunction.C "compound_types::main" main.
Admitted.
Global Typeclasses Opaque main.
