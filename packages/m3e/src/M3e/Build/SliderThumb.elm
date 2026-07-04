module M3e.Build.SliderThumb exposing ( Builder, AttrCaps, SlotCaps, sliderThumb )

{-|
The ⑤ Build shape for `<m3e-slider-thumb>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SliderThumb as SliderThumb`.

@docs Builder, AttrCaps, SlotCaps, sliderThumb
-}


import Json.Decode


{-| Opaque builder for `<m3e-slider-thumb>`; see `.build` for the terminal. -}
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
    , name : Maybe String
    , value : Maybe Float
    , onValueChange : Maybe (Json.Decode.Decoder msg)
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onClick : Maybe (Json.Decode.Decoder msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-slider-thumb>`. -}
sliderThumb : Builder AttrCaps SlotCaps msg
sliderThumb =
    Builder
        { disabled = Nothing
        , name = Nothing
        , value = Nothing
        , onValueChange = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , onChange = Nothing
        , onClick = Nothing
        , phantomMsg_ = Nothing
        }