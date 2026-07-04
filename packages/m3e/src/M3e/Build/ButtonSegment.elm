module M3e.Build.ButtonSegment exposing ( Builder, AttrCaps, SlotCaps, buttonSegment )

{-|
The ⑤ Build shape for `<m3e-button-segment>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ButtonSegment as ButtonSegment`.

@docs Builder, AttrCaps, SlotCaps, buttonSegment
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-button-segment>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { checked : Maybe Bool
    , disabled : Maybe Bool
    , value : Maybe String
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onClick : Maybe (Json.Decode.Decoder msg)
    , default : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg)
    , icon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-button-segment>`. -}
buttonSegment : Builder AttrCaps SlotCaps msg
buttonSegment =
    Builder
        { checked = Nothing
        , disabled = Nothing
        , value = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , onChange = Nothing
        , onClick = Nothing
        , default = Nothing
        , icon = Nothing
        , phantomMsg_ = Nothing
        }