module M3e.Build.NavRailToggle exposing ( Builder, AttrCaps, SlotCaps, navRailToggle )

{-|
The ⑤ Build shape for `<m3e-nav-rail-toggle>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.NavRailToggle as NavRailToggle`.

@docs Builder, AttrCaps, SlotCaps, navRailToggle
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-nav-rail-toggle>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | navRailToggle : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { for : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-nav-rail-toggle>`. -}
navRailToggle : Builder AttrCaps SlotCaps msg kind
navRailToggle =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")