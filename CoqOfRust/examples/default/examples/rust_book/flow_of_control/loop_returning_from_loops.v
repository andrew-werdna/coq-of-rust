(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

(*
fn main() {
    let mut counter = 0;

    let result = loop {
        counter += 1;

        if counter == 10 {
            break counter * 2;
        }
    };

    assert_eq!(result, 20);
}
*)
Definition main (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
  match ε, τ, α with
  | [], [], [] =>
    ltac:(M.monadic
      (M.read (|
        let~ counter : Ty.apply (Ty.path "*") [] [ Ty.path "i32" ] :=
          M.alloc (| Value.Integer IntegerKind.I32 0 |) in
        let~ result : Ty.apply (Ty.path "*") [] [ Ty.path "i32" ] :=
          M.copy (|
            M.loop (|
              Ty.apply (Ty.path "*") [] [ Ty.path "i32" ],
              ltac:(M.monadic
                (let~ _ : Ty.apply (Ty.path "*") [] [ Ty.tuple [] ] :=
                  M.alloc (|
                    let β := counter in
                    M.write (|
                      β,
                      M.call_closure (|
                        Ty.path "i32",
                        BinOp.Wrap.add,
                        [ M.read (| β |); Value.Integer IntegerKind.I32 1 ]
                      |)
                    |)
                  |) in
                M.match_operator (|
                  Ty.apply (Ty.path "*") [] [ Ty.tuple [] ],
                  M.alloc (| Value.Tuple [] |),
                  [
                    fun γ =>
                      ltac:(M.monadic
                        (let γ :=
                          M.use
                            (M.alloc (|
                              M.call_closure (|
                                Ty.path "bool",
                                BinOp.eq,
                                [ M.read (| counter |); Value.Integer IntegerKind.I32 10 ]
                              |)
                            |)) in
                        let _ := is_constant_or_break_match (| M.read (| γ |), Value.Bool true |) in
                        M.alloc (| M.never_to_any (| M.read (| M.break (||) |) |) |)));
                    fun γ => ltac:(M.monadic (M.alloc (| Value.Tuple [] |)))
                  ]
                |)))
            |)
          |) in
        let~ _ : Ty.apply (Ty.path "*") [] [ Ty.tuple [] ] :=
          M.match_operator (|
            Ty.apply (Ty.path "*") [] [ Ty.tuple [] ],
            M.alloc (|
              Value.Tuple
                [
                  M.borrow (| Pointer.Kind.Ref, result |);
                  M.borrow (| Pointer.Kind.Ref, M.alloc (| Value.Integer IntegerKind.I32 20 |) |)
                ]
            |),
            [
              fun γ =>
                ltac:(M.monadic
                  (let γ0_0 := M.SubPointer.get_tuple_field (| γ, 0 |) in
                  let γ0_1 := M.SubPointer.get_tuple_field (| γ, 1 |) in
                  let left_val := M.copy (| γ0_0 |) in
                  let right_val := M.copy (| γ0_1 |) in
                  M.match_operator (|
                    Ty.apply (Ty.path "*") [] [ Ty.tuple [] ],
                    M.alloc (| Value.Tuple [] |),
                    [
                      fun γ =>
                        ltac:(M.monadic
                          (let γ :=
                            M.use
                              (M.alloc (|
                                UnOp.not (|
                                  M.call_closure (|
                                    Ty.path "bool",
                                    BinOp.eq,
                                    [
                                      M.read (| M.deref (| M.read (| left_val |) |) |);
                                      M.read (| M.deref (| M.read (| right_val |) |) |)
                                    ]
                                  |)
                                |)
                              |)) in
                          let _ :=
                            is_constant_or_break_match (| M.read (| γ |), Value.Bool true |) in
                          M.alloc (|
                            M.never_to_any (|
                              M.read (|
                                let~ kind :
                                    Ty.apply
                                      (Ty.path "*")
                                      []
                                      [ Ty.path "core::panicking::AssertKind" ] :=
                                  M.alloc (|
                                    Value.StructTuple "core::panicking::AssertKind::Eq" [] [] []
                                  |) in
                                M.alloc (|
                                  M.call_closure (|
                                    Ty.path "never",
                                    M.get_function (|
                                      "core::panicking::assert_failed",
                                      [],
                                      [ Ty.path "i32"; Ty.path "i32" ]
                                    |),
                                    [
                                      M.read (| kind |);
                                      M.borrow (|
                                        Pointer.Kind.Ref,
                                        M.deref (|
                                          M.borrow (|
                                            Pointer.Kind.Ref,
                                            M.deref (| M.read (| left_val |) |)
                                          |)
                                        |)
                                      |);
                                      M.borrow (|
                                        Pointer.Kind.Ref,
                                        M.deref (|
                                          M.borrow (|
                                            Pointer.Kind.Ref,
                                            M.deref (| M.read (| right_val |) |)
                                          |)
                                        |)
                                      |);
                                      Value.StructTuple
                                        "core::option::Option::None"
                                        []
                                        [ Ty.path "core::fmt::Arguments" ]
                                        []
                                    ]
                                  |)
                                |)
                              |)
                            |)
                          |)));
                      fun γ => ltac:(M.monadic (M.alloc (| Value.Tuple [] |)))
                    ]
                  |)))
            ]
          |) in
        M.alloc (| Value.Tuple [] |)
      |)))
  | _, _, _ => M.impossible "wrong number of arguments"
  end.

Global Instance Instance_IsFunction_main : M.IsFunction.C "loop_returning_from_loops::main" main.
Admitted.
Global Typeclasses Opaque main.
