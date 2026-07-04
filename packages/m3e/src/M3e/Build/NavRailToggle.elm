module M3e.Build.NavRailToggle exposing ( Builder, AttrCaps, SlotCaps )

{-|
The ⑤ Build shape for `<m3e-nav-rail-toggle>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.NavRailToggle as NavRailToggle`.

@docs Builder, AttrCaps, SlotCaps
-}



{-| Opaque builder for `<m3e-nav-rail-toggle>`; see `.build` for the terminal. -}
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