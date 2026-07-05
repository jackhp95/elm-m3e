module M3e.Build.NavMenuItemGroup exposing ( Builder, AttrCaps, SlotCaps, navMenuItemGroup )

{-|
The ⑤ Build shape for `<m3e-nav-menu-item-group>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.NavMenuItemGroup as NavMenuItemGroup`.

@docs Builder, AttrCaps, SlotCaps, navMenuItemGroup
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-nav-menu-item-group>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | navMenuItemGroup : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { label : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-nav-menu-item-group>`. -}
navMenuItemGroup : Builder AttrCaps SlotCaps msg kind
navMenuItemGroup =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")