module M3e.Build.PseudoRadio exposing ( Builder, AttrCaps, SlotCaps, pseudoRadio )

{-|
The ⑤ Build shape for `<m3e-pseudo-radio>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.PseudoRadio as PseudoRadio`.

@docs Builder, AttrCaps, SlotCaps, pseudoRadio
-}



{-| Opaque builder for `<m3e-pseudo-radio>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields =
    { checked : Maybe Bool, disabled : Maybe Bool }


{-| Seed a `Builder` for `<m3e-pseudo-radio>`. -}
pseudoRadio : Builder AttrCaps SlotCaps msg
pseudoRadio =
    Builder { checked = Nothing, disabled = Nothing }