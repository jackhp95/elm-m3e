module M3e.Build.DrawerToggle exposing ( Builder, AttrCaps, SlotCaps, drawerToggle )

{-|
The ⑤ Build shape for `<m3e-drawer-toggle>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.DrawerToggle as DrawerToggle`.

@docs Builder, AttrCaps, SlotCaps, drawerToggle
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-drawer-toggle>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | drawerToggle : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { for : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-drawer-toggle>`. -}
drawerToggle : Builder AttrCaps SlotCaps msg kind
drawerToggle =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")