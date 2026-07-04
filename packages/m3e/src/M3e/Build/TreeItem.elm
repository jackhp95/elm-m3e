module M3e.Build.TreeItem exposing ( Builder, AttrCaps, SlotCaps, treeItem )

{-|
The ⑤ Build shape for `<m3e-tree-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TreeItem as TreeItem`.

@docs Builder, AttrCaps, SlotCaps, treeItem
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-tree-item>`; see `.build` for the terminal. -}
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
    , indeterminate : Maybe Bool
    , open : Maybe Bool
    , selected : Maybe Bool
    , onOpening : Maybe (Json.Decode.Decoder msg)
    , onOpened : Maybe (Json.Decode.Decoder msg)
    , onClosing : Maybe (Json.Decode.Decoder msg)
    , onClosed : Maybe (Json.Decode.Decoder msg)
    , onClick : Maybe (Json.Decode.Decoder msg)
    , icon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , selectedIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , toggleIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , openToggleIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , default :
        List (M3e.Element.Element { treeItem : M3e.Value.Supported } msg)
    }


{-| Seed a `Builder` for `<m3e-tree-item>` with the required fields. -}
treeItem :
    { label :
        M3e.Element.Element { text : M3e.Value.Supported
        , link : M3e.Value.Supported
        } msg
    }
    -> Builder AttrCaps SlotCaps msg
treeItem req_ =
    Builder
        { label = req_.label
        , disabled = Nothing
        , indeterminate = Nothing
        , open = Nothing
        , selected = Nothing
        , onOpening = Nothing
        , onOpened = Nothing
        , onClosing = Nothing
        , onClosed = Nothing
        , onClick = Nothing
        , icon = Nothing
        , selectedIcon = Nothing
        , toggleIcon = Nothing
        , openToggleIcon = Nothing
        , default = []
        }