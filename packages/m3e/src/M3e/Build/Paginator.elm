module M3e.Build.Paginator exposing ( Builder, AttrCaps, SlotCaps, paginator )

{-|
The ⑤ Build shape for `<m3e-paginator>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Paginator as Paginator`.

@docs Builder, AttrCaps, SlotCaps, paginator
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-paginator>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { disabled : Maybe Bool
    , firstPageLabel : Maybe String
    , hidePageSize : Maybe Bool
    , itemsPerPageLabel : Maybe String
    , lastPageLabel : Maybe String
    , length : Maybe Float
    , nextPageLabel : Maybe String
    , pageIndex : Maybe Float
    , pageSize :
        Maybe (M3e.Value.Value { number : M3e.Value.Supported
        , all : M3e.Value.Supported
        })
    , pageSizes : Maybe String
    , pageSizeVariant :
        Maybe (M3e.Value.Value { filled : M3e.Value.Supported
        , outlined : M3e.Value.Supported
        })
    , previousPageLabel : Maybe String
    , showFirstLastButtons : Maybe Bool
    , onPage : Maybe (Json.Decode.Decoder msg)
    , firstPageIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , previousPageIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , nextPageIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , lastPageIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-paginator>`. -}
paginator : Builder AttrCaps SlotCaps msg
paginator =
    Builder
        { disabled = Nothing
        , firstPageLabel = Nothing
        , hidePageSize = Nothing
        , itemsPerPageLabel = Nothing
        , lastPageLabel = Nothing
        , length = Nothing
        , nextPageLabel = Nothing
        , pageIndex = Nothing
        , pageSize = Nothing
        , pageSizes = Nothing
        , pageSizeVariant = Nothing
        , previousPageLabel = Nothing
        , showFirstLastButtons = Nothing
        , onPage = Nothing
        , firstPageIcon = Nothing
        , previousPageIcon = Nothing
        , nextPageIcon = Nothing
        , lastPageIcon = Nothing
        , phantomMsg_ = Nothing
        }