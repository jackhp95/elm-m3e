module M3e.Build.FocusTrap exposing
    ( Builder, AttrCaps, SlotCaps, focusTrap, disabled, default
    )

{-|
The ⑤ Build shape for `<m3e-focus-trap>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FocusTrap as FocusTrap`.

@docs Builder, AttrCaps, SlotCaps, focusTrap, disabled, default
-}


import M3e.Build.Internal
import M3e.Element


{-| Opaque builder for `<m3e-focus-trap>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { disabled : Maybe Bool
    , default : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-focus-trap>`. -}
focusTrap : Builder AttrCaps SlotCaps msg
focusTrap =
    Builder { disabled = Nothing, default = [], phantomMsg_ = Nothing }


{-| Disables the focus trap. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| Add an element to the `unnamed` (multi) slot. -}
default : M3e.Element.Element {} msg -> Builder a s msg -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }