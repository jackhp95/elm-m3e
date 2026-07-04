module M3e.Build.BreadcrumbItem exposing ( Builder, AttrCaps, SlotCaps, breadcrumbItem )

{-|
The ⑤ Build shape for `<m3e-breadcrumb-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.BreadcrumbItem as BreadcrumbItem`.

@docs Builder, AttrCaps, SlotCaps, breadcrumbItem
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-breadcrumb-item>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { itemLabel : Maybe String
    , disabled : Maybe Bool
    , current :
        Maybe (M3e.Value.Value { date : M3e.Value.Supported
        , location : M3e.Value.Supported
        , page : M3e.Value.Supported
        , step : M3e.Value.Supported
        , time : M3e.Value.Supported
        , true : M3e.Value.Supported
        })
    , href : Maybe String
    , target : Maybe String
    , download : Maybe String
    , rel : Maybe String
    , onClick : Maybe (Json.Decode.Decoder msg)
    , default :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , icon : M3e.Value.Supported
        } msg)
    , icon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    }


{-| Seed a `Builder` for `<m3e-breadcrumb-item>`. -}
breadcrumbItem : Builder AttrCaps SlotCaps msg
breadcrumbItem =
    Builder
        { itemLabel = Nothing
        , disabled = Nothing
        , current = Nothing
        , href = Nothing
        , target = Nothing
        , download = Nothing
        , rel = Nothing
        , onClick = Nothing
        , default = Nothing
        , icon = Nothing
        }