Require Import CoqOfRust.CoqOfRust.
Require Import CoqOfRust.simulations.M.
Require Import CoqOfRust.lib.lib.

Import simulations.M.Notations.

Require CoqOfRust.move_sui.simulations.move_binary_format.file_format.
Module Bytecode := file_format.Bytecode.
Module CompiledModule := file_format.CompiledModule.

(* TODO(progress):
- Implement `Resolver`'s func chain:
  - resolver
      .loader()
      .vm_config()
      .enable_invariant_violation_check_in_swap_loc
*)

(* NOTE(STUB): only implement if necessary *)
Module Function.
  Parameter t : Set.
End Function.

Module ModuleCache.
  Parameter t : Set.
End ModuleCache.

Module TypeCache.
  Parameter t : Set.
End TypeCache.

Module NativeFunctions.
  Parameter t : Set.
End NativeFunctions.

Module VMConfig.
  Parameter t : Set.
End VMConfig.

(* 
pub(crate) struct Loader {
    module_cache: RwLock<ModuleCache>,
    type_cache: RwLock<TypeCache>,
    natives: NativeFunctions,
    vm_config: VMConfig,
}
*)
Module Loader.
  Record t : Set := {
    (* NOTE: Should we ignore the `RwLock`? *)
    (* module_cache : RwLock<ModuleCache>; *)
    (* type_cache : RwLock<TypeCache>; *)
    natives : NativeFunctions.t;
    vm_config : VMConfig.t;
  }.
End Loader.

Module LoadedModule.
  Parameter t : Set.
End LoadedModule.

(* **************** *)

(* 
// A simple wrapper for a `Module` in the `Resolver`
struct BinaryType {
    compiled: Arc<CompiledModule>,
    loaded: Arc<LoadedModule>,
}
*)
Module BinaryType.
  Record t : Set := {
    compiled : CompiledModule.t;
    loaded : LoadedModule.t;
  }.
End BinaryType.

(* 
// A Resolver is a simple and small structure allocated on the stack and used by the
// interpreter. It's the only API known to the interpreter and it's tailored to the interpreter
// needs.
pub(crate) struct Resolver<'a> {
    loader: &'a Loader,
    binary: BinaryType,
}
*)
Module Resolver.
  Record t : Set := {
    loader : Loader.t;
    binary : BinaryType.t;
  }.
End Resolver.
