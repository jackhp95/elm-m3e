module M3e.Build.PseudoRadio exposing
    ( Builder, AttrCaps, SlotCaps, pseudoRadio, checked, disabled
    )

{-|
The ⑤ Build shape for `<m3e-pseudo-radio>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.PseudoRadio as PseudoRadio`.

@docs Builder, AttrCaps, SlotCaps, pseudoRadio, checked, disabled
-}


import M3e.Build.Internal


{-| Opaque builder for `<m3e-pseudo-radio>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { checked : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { checked : Maybe Bool, disabled : Maybe Bool, phantomMsg_ : Maybe msg }


{-| Seed a `Builder` for `<m3e-pseudo-radio>`. -}
pseudoRadio : Builder AttrCaps SlotCaps msg
pseudoRadio =
    Builder { checked = Nothing, disabled = Nothing, phantomMsg_ = Nothing }


{-| A value indicating whether the element is checked. (default: `false`) -}
checked :
    Bool
    -> Builder { a | checked : M3e.Build.Internal.Available } s msg
    -> Builder { a | checked : M3e.Build.Internal.Used } s msg
checked v_ (Builder f_) =
    Builder { f_ | checked = Just v_ }


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }