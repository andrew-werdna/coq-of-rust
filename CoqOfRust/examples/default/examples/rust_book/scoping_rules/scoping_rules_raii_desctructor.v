(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

(* StructTuple
  {
    name := "ToDrop";
    const_params := [];
    ty_params := [];
    fields := [];
  } *)

Module Impl_core_ops_drop_Drop_for_scoping_rules_raii_desctructor_ToDrop.
  Definition Self : Ty.t := Ty.path "scoping_rules_raii_desctructor::ToDrop".
  
  (*
      fn drop(&mut self) {
          println!("ToDrop is being dropped");
      }
  *)
  Definition drop (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
    match ε, τ, α with
    | [], [], [ self ] =>
      ltac:(M.monadic
        (let self := M.alloc (| self |) in
        M.read (|
          let~ _ : Ty.apply (Ty.path "*") [] [ Ty.tuple [] ] :=
            let~ _ : Ty.apply (Ty.path "*") [] [ Ty.tuple [] ] :=
              M.alloc (|
                M.call_closure (|
                  Ty.tuple [],
                  M.get_function (| "std::io::stdio::_print", [], [] |),
                  [
                    M.call_closure (|
                      Ty.path "core::fmt::Arguments",
                      M.get_associated_function (|
                        Ty.path "core::fmt::Arguments",
                        "new_const",
                        [ Value.Integer IntegerKind.Usize 1 ],
                        []
                      |),
                      [
                        M.borrow (|
                          Pointer.Kind.Ref,
                          M.deref (|
                            M.borrow (|
                              Pointer.Kind.Ref,
                              M.alloc (| Value.Array [ mk_str (| "ToDrop is being dropped
" |) ] |)
                            |)
                          |)
                        |)
                      ]
                    |)
                  ]
                |)
              |) in
            M.alloc (| Value.Tuple [] |) in
          M.alloc (| Value.Tuple [] |)
        |)))
    | _, _, _ => M.impossible "wrong number of arguments"
    end.
  
  Axiom Implements :
    M.IsTraitInstance
      "core::ops::drop::Drop"
      (* Trait polymorphic consts *) []
      (* Trait polymorphic types *) []
      Self
      (* Instance *) [ ("drop", InstanceField.Method drop) ].
End Impl_core_ops_drop_Drop_for_scoping_rules_raii_desctructor_ToDrop.

(*
fn main() {
    let x = ToDrop;
    println!("Made a ToDrop!");
}
*)
Definition main (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
  match ε, τ, α with
  | [], [], [] =>
    ltac:(M.monadic
      (M.read (|
        let~ x : Ty.apply (Ty.path "*") [] [ Ty.path "scoping_rules_raii_desctructor::ToDrop" ] :=
          M.alloc (| Value.StructTuple "scoping_rules_raii_desctructor::ToDrop" [] [] [] |) in
        let~ _ : Ty.apply (Ty.path "*") [] [ Ty.tuple [] ] :=
          let~ _ : Ty.apply (Ty.path "*") [] [ Ty.tuple [] ] :=
            M.alloc (|
              M.call_closure (|
                Ty.tuple [],
                M.get_function (| "std::io::stdio::_print", [], [] |),
                [
                  M.call_closure (|
                    Ty.path "core::fmt::Arguments",
                    M.get_associated_function (|
                      Ty.path "core::fmt::Arguments",
                      "new_const",
                      [ Value.Integer IntegerKind.Usize 1 ],
                      []
                    |),
                    [
                      M.borrow (|
                        Pointer.Kind.Ref,
                        M.deref (|
                          M.borrow (|
                            Pointer.Kind.Ref,
                            M.alloc (| Value.Array [ mk_str (| "Made a ToDrop!
" |) ] |)
                          |)
                        |)
                      |)
                    ]
                  |)
                ]
              |)
            |) in
          M.alloc (| Value.Tuple [] |) in
        M.alloc (| Value.Tuple [] |)
      |)))
  | _, _, _ => M.impossible "wrong number of arguments"
  end.

Global Instance Instance_IsFunction_main :
  M.IsFunction.C "scoping_rules_raii_desctructor::main" main.
Admitted.
Global Typeclasses Opaque main.
