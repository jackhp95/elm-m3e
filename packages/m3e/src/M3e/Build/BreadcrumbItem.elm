module M3e.Build.BreadcrumbItem exposing ( Builder, AttrCaps, SlotCaps, breadcrumbItem )

{-|
The ⑤ Build shape for `<m3e-breadcrumb-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.BreadcrumbItem as BreadcrumbItem`.

@docs Builder, AttrCaps, SlotCaps, breadcrumbItem
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-breadcrumb-item>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | breadcrumbItem : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { itemLabel : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , current : M3e.Build.Internal.Available
    , href : M3e.Build.Internal.Available
    , target : M3e.Build.Internal.Available
    , download : M3e.Build.Internal.Available
    , rel : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available
    , icon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-breadcrumb-item>`. -}
breadcrumbItem : Builder AttrCaps SlotCaps msg kind
breadcrumbItem =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")