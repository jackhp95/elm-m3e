module M3e.Build.BreadcrumbItemButton exposing ( Builder, AttrCaps, SlotCaps, breadcrumbItemButton )

{-|
The ⑤ Build shape for `<m3e-breadcrumb-item-button>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.BreadcrumbItemButton as BreadcrumbItemButton`.

@docs Builder, AttrCaps, SlotCaps, breadcrumbItemButton
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-breadcrumb-item-button>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | breadcrumbItemButton : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { current : M3e.Build.Internal.Available
    , href : M3e.Build.Internal.Available
    , target : M3e.Build.Internal.Available
    , rel : M3e.Build.Internal.Available
    , download : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { icon : M3e.Build.Internal.Available
    , default : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-breadcrumb-item-button>`. -}
breadcrumbItemButton : Builder AttrCaps SlotCaps msg kind
breadcrumbItemButton =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")