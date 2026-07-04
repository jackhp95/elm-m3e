module M3e.Build.PseudoRadio exposing ( Builder, AttrCaps, SlotCaps )

{-|
The ⑤ Build shape for `<m3e-pseudo-radio>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.PseudoRadio as PseudoRadio`.

@docs Builder, AttrCaps, SlotCaps
-}



{-| Opaque builder for `<m3e-pseudo-radio>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder Fields


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields =
    {}