module M3e.Build.SelectionList exposing ( Builder, AttrCaps, SlotCaps, selectionList )

{-|
The ⑤ Build shape for `<m3e-selection-list>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SelectionList as SelectionList`.

@docs Builder, AttrCaps, SlotCaps, selectionList
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-selection-list>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { hideSelectionIndicator : Maybe Bool
    , multi : Maybe Bool
    , variant :
        Maybe (M3e.Value.Value { segmented : M3e.Value.Supported
        , standard : M3e.Value.Supported
        })
    , name : Maybe String
    , disabled : Maybe Bool
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , default :
        List (M3e.Element.Element { listOption : M3e.Value.Supported
        , expandableListItem : M3e.Value.Supported
        , divider : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-selection-list>`. -}
selectionList : Builder AttrCaps SlotCaps msg
selectionList =
    Builder
        { hideSelectionIndicator = Nothing
        , multi = Nothing
        , variant = Nothing
        , name = Nothing
        , disabled = Nothing
        , onChange = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }