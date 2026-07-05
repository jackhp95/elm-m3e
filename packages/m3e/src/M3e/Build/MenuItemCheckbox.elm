module M3e.Build.MenuItemCheckbox exposing ( Builder, AttrCaps, SlotCaps, menuItemCheckbox )

{-|
The ⑤ Build shape for `<m3e-menu-item-checkbox>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.MenuItemCheckbox as MenuItemCheckbox`.

@docs Builder, AttrCaps, SlotCaps, menuItemCheckbox
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-menu-item-checkbox>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | menuItemCheckbox : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , checked : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available
    , icon : M3e.Build.Internal.Available
    , trailingIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-menu-item-checkbox>`. -}
menuItemCheckbox : Builder AttrCaps SlotCaps msg kind
menuItemCheckbox =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")