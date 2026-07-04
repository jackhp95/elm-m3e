module M3e.Build.ExpansionPanel exposing ( Builder, AttrCaps, SlotCaps, expansionPanel )

{-|
The ⑤ Build shape for `<m3e-expansion-panel>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ExpansionPanel as ExpansionPanel`.

@docs Builder, AttrCaps, SlotCaps, expansionPanel
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-expansion-panel>`; see `.build` for the terminal. -}
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
    , hideToggle : Maybe Bool
    , open : Maybe Bool
    , toggleDirection :
        Maybe (M3e.Value.Value { horizontal : M3e.Value.Supported
        , vertical : M3e.Value.Supported
        })
    , togglePosition :
        Maybe (M3e.Value.Value { after : M3e.Value.Supported
        , before : M3e.Value.Supported
        })
    , onOpening : Maybe (Json.Decode.Decoder msg)
    , onOpened : Maybe (Json.Decode.Decoder msg)
    , onClosing : Maybe (Json.Decode.Decoder msg)
    , onClosed : Maybe (Json.Decode.Decoder msg)
    , default : Maybe (M3e.Element.Element {} msg)
    , header : Maybe (M3e.Element.Element {} msg)
    , toggleIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , actions : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-expansion-panel>`. -}
expansionPanel : Builder AttrCaps SlotCaps msg
expansionPanel =
    Builder
        { disabled = Nothing
        , hideToggle = Nothing
        , open = Nothing
        , toggleDirection = Nothing
        , togglePosition = Nothing
        , onOpening = Nothing
        , onOpened = Nothing
        , onClosing = Nothing
        , onClosed = Nothing
        , default = Nothing
        , header = Nothing
        , toggleIcon = Nothing
        , actions = []
        , phantomMsg_ = Nothing
        }