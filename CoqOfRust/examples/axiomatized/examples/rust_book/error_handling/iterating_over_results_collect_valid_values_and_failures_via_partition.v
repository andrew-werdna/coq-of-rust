(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

Parameter main : (list Value.t) -> (list Ty.t) -> (list Value.t) -> M.

Global Instance Instance_IsFunction_main :
  M.IsFunction.C
    "iterating_over_results_collect_valid_values_and_failures_via_partition::main"
    main.
Admitted.
