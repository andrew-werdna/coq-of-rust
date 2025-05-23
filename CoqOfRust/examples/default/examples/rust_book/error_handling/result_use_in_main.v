(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

(*
fn main() -> Result<(), ParseIntError> {
    let number_str = "10";
    let number = match number_str.parse::<i32>() {
        Ok(number) => number,
        Err(e) => return Err(e),
    };
    println!("{}", number);
    Ok(())
}
*)
Definition main (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
  match ε, τ, α with
  | [], [], [] =>
    ltac:(M.monadic
      (M.catch_return
        (Ty.apply
          (Ty.path "core::result::Result")
          []
          [ Ty.tuple []; Ty.path "core::num::error::ParseIntError" ]) (|
        ltac:(M.monadic
          (M.read (|
            let~ number_str :
                Ty.apply (Ty.path "*") [] [ Ty.apply (Ty.path "&") [] [ Ty.path "str" ] ] :=
              M.alloc (| mk_str (| "10" |) |) in
            let~ number : Ty.apply (Ty.path "*") [] [ Ty.path "i32" ] :=
              M.copy (|
                M.match_operator (|
                  Ty.apply (Ty.path "*") [] [ Ty.path "i32" ],
                  M.alloc (|
                    M.call_closure (|
                      Ty.apply
                        (Ty.path "core::result::Result")
                        []
                        [ Ty.path "i32"; Ty.path "core::num::error::ParseIntError" ],
                      M.get_associated_function (| Ty.path "str", "parse", [], [ Ty.path "i32" ] |),
                      [ M.borrow (| Pointer.Kind.Ref, M.deref (| M.read (| number_str |) |) |) ]
                    |)
                  |),
                  [
                    fun γ =>
                      ltac:(M.monadic
                        (let γ0_0 :=
                          M.SubPointer.get_struct_tuple_field (|
                            γ,
                            "core::result::Result::Ok",
                            0
                          |) in
                        let number := M.copy (| γ0_0 |) in
                        number));
                    fun γ =>
                      ltac:(M.monadic
                        (let γ0_0 :=
                          M.SubPointer.get_struct_tuple_field (|
                            γ,
                            "core::result::Result::Err",
                            0
                          |) in
                        let e := M.copy (| γ0_0 |) in
                        M.alloc (|
                          M.never_to_any (|
                            M.read (|
                              M.return_ (|
                                Value.StructTuple
                                  "core::result::Result::Err"
                                  []
                                  [ Ty.tuple []; Ty.path "core::num::error::ParseIntError" ]
                                  [ M.read (| e |) ]
                              |)
                            |)
                          |)
                        |)))
                  ]
                |)
              |) in
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
                          "new_v1",
                          [ Value.Integer IntegerKind.Usize 2; Value.Integer IntegerKind.Usize 1 ],
                          []
                        |),
                        [
                          M.borrow (|
                            Pointer.Kind.Ref,
                            M.deref (|
                              M.borrow (|
                                Pointer.Kind.Ref,
                                M.alloc (| Value.Array [ mk_str (| "" |); mk_str (| "
" |) ] |)
                              |)
                            |)
                          |);
                          M.borrow (|
                            Pointer.Kind.Ref,
                            M.deref (|
                              M.borrow (|
                                Pointer.Kind.Ref,
                                M.alloc (|
                                  Value.Array
                                    [
                                      M.call_closure (|
                                        Ty.path "core::fmt::rt::Argument",
                                        M.get_associated_function (|
                                          Ty.path "core::fmt::rt::Argument",
                                          "new_display",
                                          [],
                                          [ Ty.path "i32" ]
                                        |),
                                        [
                                          M.borrow (|
                                            Pointer.Kind.Ref,
                                            M.deref (| M.borrow (| Pointer.Kind.Ref, number |) |)
                                          |)
                                        ]
                                      |)
                                    ]
                                |)
                              |)
                            |)
                          |)
                        ]
                      |)
                    ]
                  |)
                |) in
              M.alloc (| Value.Tuple [] |) in
            M.alloc (|
              Value.StructTuple
                "core::result::Result::Ok"
                []
                [ Ty.tuple []; Ty.path "core::num::error::ParseIntError" ]
                [ Value.Tuple [] ]
            |)
          |)))
      |)))
  | _, _, _ => M.impossible "wrong number of arguments"
  end.

Global Instance Instance_IsFunction_main : M.IsFunction.C "result_use_in_main::main" main.
Admitted.
Global Typeclasses Opaque main.
