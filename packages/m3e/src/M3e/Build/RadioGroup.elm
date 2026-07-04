module M3e.Build.RadioGroup exposing ( Builder, AttrCaps, SlotCaps, radioGroup )

{-|
The ⑤ Build shape for `<m3e-radio-group>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.RadioGroup as RadioGroup`.

@docs Builder, AttrCaps, SlotCaps, radioGroup
-}


import Json.Decode
import M3e.Element


{-| Opaque builder for `<m3e-radio-group>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { ariaInvalid : Maybe String
    , disabled : Maybe Bool
    , name : Maybe String
    , required : Maybe Bool
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , onChange : Maybe (Json.Decode.Decoder msg)
    , default : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-radio-group>`. -}
radioGroup : Builder AttrCaps SlotCaps msg
radioGroup =
    Builder
        { ariaInvalid = Nothing
        , disabled = Nothing
        , name = Nothing
        , required = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , onChange = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }