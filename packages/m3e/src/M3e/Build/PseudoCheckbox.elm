module M3e.Build.PseudoCheckbox exposing ( Builder, AttrCaps, SlotCaps, pseudoCheckbox )

{-|
The ⑤ Build shape for `<m3e-pseudo-checkbox>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.PseudoCheckbox as PseudoCheckbox`.

@docs Builder, AttrCaps, SlotCaps, pseudoCheckbox
-}



{-| Opaque builder for `<m3e-pseudo-checkbox>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


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