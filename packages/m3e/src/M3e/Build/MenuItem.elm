module M3e.Build.MenuItem exposing ( Builder, AttrCaps, SlotCaps, menuItem )

{-|
The ⑤ Build shape for `<m3e-menu-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.MenuItem as MenuItem`.

@docs Builder, AttrCaps, SlotCaps, menuItem
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-menu-item>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | menuItem : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , download : M3e.Build.Internal.Available
    , href : M3e.Build.Internal.Available
    , rel : M3e.Build.Internal.Available
    , target : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available
    , icon : M3e.Build.Internal.Available
    , trailingIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-menu-item>`. -}
menuItem : Builder AttrCaps SlotCaps msg kind
menuItem =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")