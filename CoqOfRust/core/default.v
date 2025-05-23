(* Generated by coq-of-rust *)
Require Import CoqOfRust.CoqOfRust.

Module default.
  (* Trait *)
  (* Empty module 'Default' *)
  
  Module Impl_core_default_Default_for_Tuple_.
    Definition Self : Ty.t := Ty.tuple [].
    
    (*
                fn default() -> $t {
                    $v
                }
    *)
    Definition default (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
      match ε, τ, α with
      | [], [], [] => ltac:(M.monadic (Value.Tuple []))
      | _, _, _ => M.impossible "wrong number of arguments"
      end.
    
    Axiom Implements :
      M.IsTraitInstance
        "core::default::Default"
        (* Trait polymorphic consts *) []
        (* Trait polymorphic types *) []
        Self
        (* Instance *) [ ("default", InstanceField.Method default) ].
  End Impl_core_default_Default_for_Tuple_.
  
  Module Impl_core_default_Default_for_bool.
    Definition Self : Ty.t := Ty.path "bool".
    
    (*
                fn default() -> $t {
                    $v
                }
    *)
    Definition default (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
      match ε, τ, α with
      | [], [], [] => ltac:(M.monadic (Value.Bool false))
      | _, _, _ => M.impossible "wrong number of arguments"
      end.
    
    Axiom Implements :
      M.IsTraitInstance
        "core::default::Default"
        (* Trait polymorphic consts *) []
        (* Trait polymorphic types *) []
        Self
        (* Instance *) [ ("default", InstanceField.Method default) ].
  End Impl_core_default_Default_for_bool.
  
  Module Impl_core_default_Default_for_char.
    Definition Self : Ty.t := Ty.path "char".
    
    (*
                fn default() -> $t {
                    $v
                }
    *)
    Definition default (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
      match ε, τ, α with
      | [], [], [] => ltac:(M.monadic (Value.UnicodeChar 0))
      | _, _, _ => M.impossible "wrong number of arguments"
      end.
    
    Axiom Implements :
      M.IsTraitInstance
        "core::default::Default"
        (* Trait polymorphic consts *) []
        (* Trait polymorphic types *) []
        Self
        (* Instance *) [ ("default", InstanceField.Method default) ].
  End Impl_core_default_Default_for_char.
  
  Module Impl_core_default_Default_for_core_ascii_ascii_char_AsciiChar.
    Definition Self : Ty.t := Ty.path "core::ascii::ascii_char::AsciiChar".
    
    (*
                fn default() -> $t {
                    $v
                }
    *)
    Definition default (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
      match ε, τ, α with
      | [], [], [] =>
        ltac:(M.monadic (Value.StructTuple "core::ascii::ascii_char::AsciiChar::Null" [] [] []))
      | _, _, _ => M.impossible "wrong number of arguments"
      end.
    
    Axiom Implements :
      M.IsTraitInstance
        "core::default::Default"
        (* Trait polymorphic consts *) []
        (* Trait polymorphic types *) []
        Self
        (* Instance *) [ ("default", InstanceField.Method default) ].
  End Impl_core_default_Default_for_core_ascii_ascii_char_AsciiChar.
  
  Module Impl_core_default_Default_for_usize.
    Definition Self : Ty.t := Ty.path "usize".
    
    (*
                fn default() -> $t {
                    $v
                }
    *)
    Definition default (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
      match ε, τ, α with
      | [], [], [] => ltac:(M.monadic (Value.Integer IntegerKind.Usize 0))
      | _, _, _ => M.impossible "wrong number of arguments"
      end.
    
    Axiom Implements :
      M.IsTraitInstance
        "core::default::Default"
        (* Trait polymorphic consts *) []
        (* Trait polymorphic types *) []
        Self
        (* Instance *) [ ("default", InstanceField.Method default) ].
  End Impl_core_default_Default_for_usize.
  
  Module Impl_core_default_Default_for_u8.
    Definition Self : Ty.t := Ty.path "u8".
    
    (*
                fn default() -> $t {
                    $v
                }
    *)
    Definition default (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
      match ε, τ, α with
      | [], [], [] => ltac:(M.monadic (Value.Integer IntegerKind.U8 0))
      | _, _, _ => M.impossible "wrong number of arguments"
      end.
    
    Axiom Implements :
      M.IsTraitInstance
        "core::default::Default"
        (* Trait polymorphic consts *) []
        (* Trait polymorphic types *) []
        Self
        (* Instance *) [ ("default", InstanceField.Method default) ].
  End Impl_core_default_Default_for_u8.
  
  Module Impl_core_default_Default_for_u16.
    Definition Self : Ty.t := Ty.path "u16".
    
    (*
                fn default() -> $t {
                    $v
                }
    *)
    Definition default (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
      match ε, τ, α with
      | [], [], [] => ltac:(M.monadic (Value.Integer IntegerKind.U16 0))
      | _, _, _ => M.impossible "wrong number of arguments"
      end.
    
    Axiom Implements :
      M.IsTraitInstance
        "core::default::Default"
        (* Trait polymorphic consts *) []
        (* Trait polymorphic types *) []
        Self
        (* Instance *) [ ("default", InstanceField.Method default) ].
  End Impl_core_default_Default_for_u16.
  
  Module Impl_core_default_Default_for_u32.
    Definition Self : Ty.t := Ty.path "u32".
    
    (*
                fn default() -> $t {
                    $v
                }
    *)
    Definition default (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
      match ε, τ, α with
      | [], [], [] => ltac:(M.monadic (Value.Integer IntegerKind.U32 0))
      | _, _, _ => M.impossible "wrong number of arguments"
      end.
    
    Axiom Implements :
      M.IsTraitInstance
        "core::default::Default"
        (* Trait polymorphic consts *) []
        (* Trait polymorphic types *) []
        Self
        (* Instance *) [ ("default", InstanceField.Method default) ].
  End Impl_core_default_Default_for_u32.
  
  Module Impl_core_default_Default_for_u64.
    Definition Self : Ty.t := Ty.path "u64".
    
    (*
                fn default() -> $t {
                    $v
                }
    *)
    Definition default (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
      match ε, τ, α with
      | [], [], [] => ltac:(M.monadic (Value.Integer IntegerKind.U64 0))
      | _, _, _ => M.impossible "wrong number of arguments"
      end.
    
    Axiom Implements :
      M.IsTraitInstance
        "core::default::Default"
        (* Trait polymorphic consts *) []
        (* Trait polymorphic types *) []
        Self
        (* Instance *) [ ("default", InstanceField.Method default) ].
  End Impl_core_default_Default_for_u64.
  
  Module Impl_core_default_Default_for_u128.
    Definition Self : Ty.t := Ty.path "u128".
    
    (*
                fn default() -> $t {
                    $v
                }
    *)
    Definition default (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
      match ε, τ, α with
      | [], [], [] => ltac:(M.monadic (Value.Integer IntegerKind.U128 0))
      | _, _, _ => M.impossible "wrong number of arguments"
      end.
    
    Axiom Implements :
      M.IsTraitInstance
        "core::default::Default"
        (* Trait polymorphic consts *) []
        (* Trait polymorphic types *) []
        Self
        (* Instance *) [ ("default", InstanceField.Method default) ].
  End Impl_core_default_Default_for_u128.
  
  Module Impl_core_default_Default_for_isize.
    Definition Self : Ty.t := Ty.path "isize".
    
    (*
                fn default() -> $t {
                    $v
                }
    *)
    Definition default (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
      match ε, τ, α with
      | [], [], [] => ltac:(M.monadic (Value.Integer IntegerKind.Isize 0))
      | _, _, _ => M.impossible "wrong number of arguments"
      end.
    
    Axiom Implements :
      M.IsTraitInstance
        "core::default::Default"
        (* Trait polymorphic consts *) []
        (* Trait polymorphic types *) []
        Self
        (* Instance *) [ ("default", InstanceField.Method default) ].
  End Impl_core_default_Default_for_isize.
  
  Module Impl_core_default_Default_for_i8.
    Definition Self : Ty.t := Ty.path "i8".
    
    (*
                fn default() -> $t {
                    $v
                }
    *)
    Definition default (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
      match ε, τ, α with
      | [], [], [] => ltac:(M.monadic (Value.Integer IntegerKind.I8 0))
      | _, _, _ => M.impossible "wrong number of arguments"
      end.
    
    Axiom Implements :
      M.IsTraitInstance
        "core::default::Default"
        (* Trait polymorphic consts *) []
        (* Trait polymorphic types *) []
        Self
        (* Instance *) [ ("default", InstanceField.Method default) ].
  End Impl_core_default_Default_for_i8.
  
  Module Impl_core_default_Default_for_i16.
    Definition Self : Ty.t := Ty.path "i16".
    
    (*
                fn default() -> $t {
                    $v
                }
    *)
    Definition default (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
      match ε, τ, α with
      | [], [], [] => ltac:(M.monadic (Value.Integer IntegerKind.I16 0))
      | _, _, _ => M.impossible "wrong number of arguments"
      end.
    
    Axiom Implements :
      M.IsTraitInstance
        "core::default::Default"
        (* Trait polymorphic consts *) []
        (* Trait polymorphic types *) []
        Self
        (* Instance *) [ ("default", InstanceField.Method default) ].
  End Impl_core_default_Default_for_i16.
  
  Module Impl_core_default_Default_for_i32.
    Definition Self : Ty.t := Ty.path "i32".
    
    (*
                fn default() -> $t {
                    $v
                }
    *)
    Definition default (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
      match ε, τ, α with
      | [], [], [] => ltac:(M.monadic (Value.Integer IntegerKind.I32 0))
      | _, _, _ => M.impossible "wrong number of arguments"
      end.
    
    Axiom Implements :
      M.IsTraitInstance
        "core::default::Default"
        (* Trait polymorphic consts *) []
        (* Trait polymorphic types *) []
        Self
        (* Instance *) [ ("default", InstanceField.Method default) ].
  End Impl_core_default_Default_for_i32.
  
  Module Impl_core_default_Default_for_i64.
    Definition Self : Ty.t := Ty.path "i64".
    
    (*
                fn default() -> $t {
                    $v
                }
    *)
    Definition default (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
      match ε, τ, α with
      | [], [], [] => ltac:(M.monadic (Value.Integer IntegerKind.I64 0))
      | _, _, _ => M.impossible "wrong number of arguments"
      end.
    
    Axiom Implements :
      M.IsTraitInstance
        "core::default::Default"
        (* Trait polymorphic consts *) []
        (* Trait polymorphic types *) []
        Self
        (* Instance *) [ ("default", InstanceField.Method default) ].
  End Impl_core_default_Default_for_i64.
  
  Module Impl_core_default_Default_for_i128.
    Definition Self : Ty.t := Ty.path "i128".
    
    (*
                fn default() -> $t {
                    $v
                }
    *)
    Definition default (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
      match ε, τ, α with
      | [], [], [] => ltac:(M.monadic (Value.Integer IntegerKind.I128 0))
      | _, _, _ => M.impossible "wrong number of arguments"
      end.
    
    Axiom Implements :
      M.IsTraitInstance
        "core::default::Default"
        (* Trait polymorphic consts *) []
        (* Trait polymorphic types *) []
        Self
        (* Instance *) [ ("default", InstanceField.Method default) ].
  End Impl_core_default_Default_for_i128.
  
  Module Impl_core_default_Default_for_f16.
    Definition Self : Ty.t := Ty.path "f16".
    
    (*
                fn default() -> $t {
                    $v
                }
    *)
    Definition default (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
      match ε, τ, α with
      | [], [], [] => ltac:(M.monadic (M.read (| UnsupportedLiteral |)))
      | _, _, _ => M.impossible "wrong number of arguments"
      end.
    
    Axiom Implements :
      M.IsTraitInstance
        "core::default::Default"
        (* Trait polymorphic consts *) []
        (* Trait polymorphic types *) []
        Self
        (* Instance *) [ ("default", InstanceField.Method default) ].
  End Impl_core_default_Default_for_f16.
  
  Module Impl_core_default_Default_for_f32.
    Definition Self : Ty.t := Ty.path "f32".
    
    (*
                fn default() -> $t {
                    $v
                }
    *)
    Definition default (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
      match ε, τ, α with
      | [], [], [] => ltac:(M.monadic (M.read (| UnsupportedLiteral |)))
      | _, _, _ => M.impossible "wrong number of arguments"
      end.
    
    Axiom Implements :
      M.IsTraitInstance
        "core::default::Default"
        (* Trait polymorphic consts *) []
        (* Trait polymorphic types *) []
        Self
        (* Instance *) [ ("default", InstanceField.Method default) ].
  End Impl_core_default_Default_for_f32.
  
  Module Impl_core_default_Default_for_f64.
    Definition Self : Ty.t := Ty.path "f64".
    
    (*
                fn default() -> $t {
                    $v
                }
    *)
    Definition default (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
      match ε, τ, α with
      | [], [], [] => ltac:(M.monadic (M.read (| UnsupportedLiteral |)))
      | _, _, _ => M.impossible "wrong number of arguments"
      end.
    
    Axiom Implements :
      M.IsTraitInstance
        "core::default::Default"
        (* Trait polymorphic consts *) []
        (* Trait polymorphic types *) []
        Self
        (* Instance *) [ ("default", InstanceField.Method default) ].
  End Impl_core_default_Default_for_f64.
  
  Module Impl_core_default_Default_for_f128.
    Definition Self : Ty.t := Ty.path "f128".
    
    (*
                fn default() -> $t {
                    $v
                }
    *)
    Definition default (ε : list Value.t) (τ : list Ty.t) (α : list Value.t) : M :=
      match ε, τ, α with
      | [], [], [] => ltac:(M.monadic (M.read (| UnsupportedLiteral |)))
      | _, _, _ => M.impossible "wrong number of arguments"
      end.
    
    Axiom Implements :
      M.IsTraitInstance
        "core::default::Default"
        (* Trait polymorphic consts *) []
        (* Trait polymorphic types *) []
        Self
        (* Instance *) [ ("default", InstanceField.Method default) ].
  End Impl_core_default_Default_for_f128.
End default.
