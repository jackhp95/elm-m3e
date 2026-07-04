module M3e.Build.PseudoCheckbox exposing
    ( Builder, AttrCaps, SlotCaps, pseudoCheckbox, checked, disabled
    , indeterminate
    )

{-|
The ⑤ Build shape for `<m3e-pseudo-checkbox>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.PseudoCheckbox as PseudoCheckbox`.

@docs Builder, AttrCaps, SlotCaps, pseudoCheckbox, checked, disabled
@docs indeterminate
-}


import M3e.Build.Internal


{-| Opaque builder for `<m3e-pseudo-checkbox>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { checked : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , indeterminate : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { checked : Maybe Bool
    , disabled : Maybe Bool
    , indeterminate : Maybe Bool
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-pseudo-checkbox>`. -}
pseudoCheckbox : Builder AttrCaps SlotCaps msg
pseudoCheckbox =
    Builder
        { checked = Nothing
        , disabled = Nothing
        , indeterminate = Nothing
        , phantomMsg_ = Nothing
        }


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


{-| A value indicating whether the element's checked state is indeterminate. (default: `false`) -}
indeterminate :
    Bool
    -> Builder { a | indeterminate : M3e.Build.Internal.Available } s msg
    -> Builder { a | indeterminate : M3e.Build.Internal.Used } s msg
indeterminate v_ (Builder f_) =
    Builder { f_ | indeterminate = Just v_ }