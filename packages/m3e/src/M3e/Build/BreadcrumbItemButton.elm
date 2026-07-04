module M3e.Build.BreadcrumbItemButton exposing ( Builder, AttrCaps, SlotCaps, breadcrumbItemButton )

{-|
The ⑤ Build shape for `<m3e-breadcrumb-item-button>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.BreadcrumbItemButton as BreadcrumbItemButton`.

@docs Builder, AttrCaps, SlotCaps, breadcrumbItemButton
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-breadcrumb-item-button>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { current :
        Maybe (M3e.Value.Value { date : M3e.Value.Supported
        , location : M3e.Value.Supported
        , page : M3e.Value.Supported
        , step : M3e.Value.Supported
        , time : M3e.Value.Supported
        , true : M3e.Value.Supported
        })
    , href : Maybe String
    , target : Maybe String
    , rel : Maybe String
    , download : Maybe String
    , disabled : Maybe Bool
    , onClick : Maybe (Json.Decode.Decoder msg)
    , icon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , default :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , icon : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-breadcrumb-item-button>`. -}
breadcrumbItemButton : Builder AttrCaps SlotCaps msg
breadcrumbItemButton =
    Builder
        { current = Nothing
        , href = Nothing
        , target = Nothing
        , rel = Nothing
        , download = Nothing
        , disabled = Nothing
        , onClick = Nothing
        , icon = Nothing
        , default = Nothing
        , phantomMsg_ = Nothing
        }