module M3e.Build.Option exposing ( Builder, AttrCaps, SlotCaps )

{-|
The ⑤ Build shape for `<m3e-option>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Option as Option`.

@docs Builder, AttrCaps, SlotCaps
-}



{-| Opaque builder for `<m3e-option>`; see `.build` for the terminal. -}
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