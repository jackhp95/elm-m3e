module M3e.Build.ListItemButton exposing ( Builder, AttrCaps, SlotCaps, listItemButton )

{-|
The ⑤ Build shape for `<m3e-list-item-button>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ListItemButton as ListItemButton`.

@docs Builder, AttrCaps, SlotCaps, listItemButton
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-list-item-button>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { href : Maybe String
    , target : Maybe String
    , rel : Maybe String
    , download : Maybe String
    , disabled : Maybe Bool
    , onClick : Maybe (Json.Decode.Decoder msg)
    , default :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , html : M3e.Value.Supported
        } msg)
    , leading :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported
        , avatar : M3e.Value.Supported
        , text : M3e.Value.Supported
        , html : M3e.Value.Supported
        } msg)
    , overline :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , html : M3e.Value.Supported
        } msg)
    , supportingText :
        Maybe (M3e.Element.Element { text : M3e.Value.Supported
        , html : M3e.Value.Supported
        } msg)
    , trailing :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported
        , avatar : M3e.Value.Supported
        , text : M3e.Value.Supported
        , html : M3e.Value.Supported
        , switch : M3e.Value.Supported
        , radio : M3e.Value.Supported
        , checkbox : M3e.Value.Supported
        } msg)
    }


{-| Seed a `Builder` for `<m3e-list-item-button>`. -}
listItemButton : Builder AttrCaps SlotCaps msg
listItemButton =
    Builder
        { href = Nothing
        , target = Nothing
        , rel = Nothing
        , download = Nothing
        , disabled = Nothing
        , onClick = Nothing
        , default = Nothing
        , leading = Nothing
        , overline = Nothing
        , supportingText = Nothing
        , trailing = Nothing
        }