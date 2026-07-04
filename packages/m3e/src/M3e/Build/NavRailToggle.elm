module M3e.Build.NavRailToggle exposing ( Builder, AttrCaps, SlotCaps, navRailToggle )

{-|
The ⑤ Build shape for `<m3e-nav-rail-toggle>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.NavRailToggle as NavRailToggle`.

@docs Builder, AttrCaps, SlotCaps, navRailToggle
-}


import M3e.Element


{-| Opaque builder for `<m3e-nav-rail-toggle>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg any_ =
    { for : Maybe String, default : Maybe (M3e.Element.Element any_ msg) }


{-| Seed a `Builder` for `<m3e-nav-rail-toggle>`. -}
navRailToggle : Builder AttrCaps SlotCaps msg
navRailToggle =
    Builder { for = Nothing, default = Nothing }