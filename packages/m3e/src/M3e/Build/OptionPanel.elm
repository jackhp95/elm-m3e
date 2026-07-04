module M3e.Build.OptionPanel exposing ( Builder, AttrCaps, SlotCaps, optionPanel )

{-|
The ⑤ Build shape for `<m3e-option-panel>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.OptionPanel as OptionPanel`.

@docs Builder, AttrCaps, SlotCaps, optionPanel
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-option-panel>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { state :
        Maybe (M3e.Value.Value { content : M3e.Value.Supported
        , loading : M3e.Value.Supported
        , noData : M3e.Value.Supported
        })
    , scrollStrategy :
        Maybe (M3e.Value.Value { hide : M3e.Value.Supported
        , reposition : M3e.Value.Supported
        })
    , fitAnchorWidth : Maybe Bool
    , anchorOffset : Maybe Float
    , onBeforetoggle : Maybe (Json.Decode.Decoder msg)
    , onToggle : Maybe (Json.Decode.Decoder msg)
    , noData : Maybe (M3e.Element.Element {} msg)
    , default :
        List (M3e.Element.Element { option : M3e.Value.Supported
        , optgroup : M3e.Value.Supported
        , divider : M3e.Value.Supported
        } msg)
    , loading :
        List (M3e.Element.Element { circularProgressIndicator :
            M3e.Value.Supported
        , loadingIndicator : M3e.Value.Supported
        , text : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-option-panel>`. -}
optionPanel : Builder AttrCaps SlotCaps msg
optionPanel =
    Builder
        { state = Nothing
        , scrollStrategy = Nothing
        , fitAnchorWidth = Nothing
        , anchorOffset = Nothing
        , onBeforetoggle = Nothing
        , onToggle = Nothing
        , noData = Nothing
        , default = []
        , loading = []
        , phantomMsg_ = Nothing
        }