module M3e.Build.ExpandableListItem exposing ( Builder, AttrCaps, SlotCaps, expandableListItem )

{-|
The ⑤ Build shape for `<m3e-expandable-list-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ExpandableListItem as ExpandableListItem`.

@docs Builder, AttrCaps, SlotCaps, expandableListItem
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-expandable-list-item>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg any_ =
    { disabled : Maybe Bool
    , open : Maybe Bool
    , onOpening : Maybe (Json.Decode.Decoder msg)
    , onOpened : Maybe (Json.Decode.Decoder msg)
    , onClosing : Maybe (Json.Decode.Decoder msg)
    , onClosed : Maybe (Json.Decode.Decoder msg)
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
    , toggleIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , items : Maybe (M3e.Element.Element any_ msg)
    }


{-| Seed a `Builder` for `<m3e-expandable-list-item>`. -}
expandableListItem : Builder AttrCaps SlotCaps msg
expandableListItem =
    Builder
        { disabled = Nothing
        , open = Nothing
        , onOpening = Nothing
        , onOpened = Nothing
        , onClosing = Nothing
        , onClosed = Nothing
        , default = Nothing
        , leading = Nothing
        , overline = Nothing
        , supportingText = Nothing
        , toggleIcon = Nothing
        , items = Nothing
        }