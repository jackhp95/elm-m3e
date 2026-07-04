module M3e.Build.Card exposing ( Builder, AttrCaps, SlotCaps, card )

{-|
The ⑤ Build shape for `<m3e-card>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Card as Card`.

@docs Builder, AttrCaps, SlotCaps, card
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-card>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { actionable : Maybe Bool
    , inline : Maybe Bool
    , orientation :
        Maybe (M3e.Value.Value { horizontal : M3e.Value.Supported
        , vertical : M3e.Value.Supported
        })
    , variant :
        Maybe (M3e.Value.Value { elevated : M3e.Value.Supported
        , filled : M3e.Value.Supported
        , outlined : M3e.Value.Supported
        })
    , href : Maybe String
    , target : Maybe String
    , rel : Maybe String
    , download : Maybe String
    , name : Maybe String
    , value : Maybe String
    , type_ :
        Maybe (M3e.Value.Value { button : M3e.Value.Supported
        , reset : M3e.Value.Supported
        , submit : M3e.Value.Supported
        })
    , disabledInteractive : Maybe Bool
    , disabled : Maybe Bool
    , onClick : Maybe (Json.Decode.Decoder msg)
    , default : Maybe (M3e.Element.Element {} msg)
    , header : Maybe (M3e.Element.Element {} msg)
    , content : Maybe (M3e.Element.Element {} msg)
    , actions : Maybe (M3e.Element.Element {} msg)
    , footer : Maybe (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-card>`. -}
card : Builder AttrCaps SlotCaps msg
card =
    Builder
        { actionable = Nothing
        , inline = Nothing
        , orientation = Nothing
        , variant = Nothing
        , href = Nothing
        , target = Nothing
        , rel = Nothing
        , download = Nothing
        , name = Nothing
        , value = Nothing
        , type_ = Nothing
        , disabledInteractive = Nothing
        , disabled = Nothing
        , onClick = Nothing
        , default = Nothing
        , header = Nothing
        , content = Nothing
        , actions = Nothing
        , footer = Nothing
        , phantomMsg_ = Nothing
        }