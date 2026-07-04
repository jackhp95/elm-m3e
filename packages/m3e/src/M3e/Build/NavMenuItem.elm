module M3e.Build.NavMenuItem exposing ( Builder, AttrCaps, SlotCaps, navMenuItem )

{-|
The ⑤ Build shape for `<m3e-nav-menu-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.NavMenuItem as NavMenuItem`.

@docs Builder, AttrCaps, SlotCaps, navMenuItem
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-nav-menu-item>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { label :
        M3e.Element.Element { text : M3e.Value.Supported
        , link : M3e.Value.Supported
        } msg
    , disabled : Maybe Bool
    , open : Maybe Bool
    , selected : Maybe Bool
    , onOpening : Maybe (Json.Decode.Decoder msg)
    , onOpened : Maybe (Json.Decode.Decoder msg)
    , onClosing : Maybe (Json.Decode.Decoder msg)
    , onClosed : Maybe (Json.Decode.Decoder msg)
    , onClick : Maybe (Json.Decode.Decoder msg)
    , icon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , badge :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , badge : M3e.Value.Supported
        } msg)
    , selectedIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , toggleIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , default :
        List (M3e.Element.Element { navMenuItem : M3e.Value.Supported } msg)
    }


{-| Seed a `Builder` for `<m3e-nav-menu-item>` with the required fields. -}
navMenuItem :
    { label :
        M3e.Element.Element { text : M3e.Value.Supported
        , link : M3e.Value.Supported
        } msg
    }
    -> Builder AttrCaps SlotCaps msg
navMenuItem req_ =
    Builder
        { label = req_.label
        , disabled = Nothing
        , open = Nothing
        , selected = Nothing
        , onOpening = Nothing
        , onOpened = Nothing
        , onClosing = Nothing
        , onClosed = Nothing
        , onClick = Nothing
        , icon = Nothing
        , badge = Nothing
        , selectedIcon = Nothing
        , toggleIcon = Nothing
        , default = []
        }