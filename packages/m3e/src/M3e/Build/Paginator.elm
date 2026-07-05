module M3e.Build.Paginator exposing ( Builder, AttrCaps, SlotCaps, paginator )

{-|
The ⑤ Build shape for `<m3e-paginator>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Paginator as Paginator`.

@docs Builder, AttrCaps, SlotCaps, paginator
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-paginator>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | paginator : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , firstPageLabel : M3e.Build.Internal.Available
    , hidePageSize : M3e.Build.Internal.Available
    , itemsPerPageLabel : M3e.Build.Internal.Available
    , lastPageLabel : M3e.Build.Internal.Available
    , length : M3e.Build.Internal.Available
    , nextPageLabel : M3e.Build.Internal.Available
    , pageIndex : M3e.Build.Internal.Available
    , pageSize : M3e.Build.Internal.Available
    , pageSizes : M3e.Build.Internal.Available
    , pageSizeVariant : M3e.Build.Internal.Available
    , previousPageLabel : M3e.Build.Internal.Available
    , showFirstLastButtons : M3e.Build.Internal.Available
    , onPage : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { firstPageIcon : M3e.Build.Internal.Available
    , previousPageIcon : M3e.Build.Internal.Available
    , nextPageIcon : M3e.Build.Internal.Available
    , lastPageIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-paginator>`. -}
paginator : Builder AttrCaps SlotCaps msg kind
paginator =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")