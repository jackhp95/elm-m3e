module M3e.Build.NavItem exposing ( Builder, AttrCaps, SlotCaps, navItem )

{-|
The ⑤ Build shape for `<m3e-nav-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.NavItem as NavItem`.

@docs Builder, AttrCaps, SlotCaps, navItem
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-nav-item>`; see `.build` for the terminal. -}
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
    , disabledInteractive : Maybe Bool
    , download : Maybe String
    , href : Maybe String
    , orientation :
        Maybe (M3e.Value.Value { horizontal : M3e.Value.Supported
        , vertical : M3e.Value.Supported
        })
    , rel : Maybe String
    , selected : Maybe Bool
    , target : Maybe String
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onClick : Maybe (Json.Decode.Decoder msg)
    , default : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg)
    , icon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , selectedIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-nav-item>`. -}
navItem : Builder AttrCaps SlotCaps msg
navItem =
    Builder
        { disabled = Nothing
        , disabledInteractive = Nothing
        , download = Nothing
        , href = Nothing
        , orientation = Nothing
        , rel = Nothing
        , selected = Nothing
        , target = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , onChange = Nothing
        , onClick = Nothing
        , default = Nothing
        , icon = Nothing
        , selectedIcon = Nothing
        , phantomMsg_ = Nothing
        }