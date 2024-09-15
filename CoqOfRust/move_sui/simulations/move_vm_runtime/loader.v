Require Import CoqOfRust.CoqOfRust.
Require Import CoqOfRust.simulations.M.
Require Import CoqOfRust.lib.lib.

Import simulations.M.Notations.

Require CoqOfRust.move_sui.simulations.move_binary_format.file_format.
Module Bytecode := file_format.Bytecode.
Module CompiledModule := file_format.CompiledModule.
Module Constant := file_format.Constant.
Module ConstantPoolIndex := file_format.ConstantPoolIndex.

Require CoqOfRust.move_sui.simulations.move_vm_config.runtime.
Module VMConfig := runtime.VMConfig.

(* TODO(progress):
- None
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

  Module Impl_Resolver.
    Definition Self := move_sui.simulations.move_vm_runtime.loader.Resolver.t.
    (* 
    pub(crate) fn constant_at(&self, idx: ConstantPoolIndex) -> &Constant {
        self.binary.compiled.constant_at(idx)
    }
    *)
    Definition constant_at (self : Self) (idx : ConstantPoolIndex.t) : Constant.t :=
      CompiledModule.Impl_CompiledModule.constant_at self.(Resolver.binary).(BinaryType.compiled) idx.

    (* 
    pub(crate) fn field_count(&self, idx: StructDefinitionIndex) -> u16 {
        self.binary.loaded.field_count(idx.0)
    }
    *)
    Definition field_count : Set. Admitted.

  End Impl_Resolver.
End Resolver.
