module M3e.Build.Slider exposing ( Builder, AttrCaps, SlotCaps, slider )

{-|
The ⑤ Build shape for `<m3e-slider>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Slider as Slider`.

@docs Builder, AttrCaps, SlotCaps, slider
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-slider>`; see `.build` for the terminal. -}
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
    , discrete : Maybe Bool
    , labelled : Maybe Bool
    , max : Maybe Float
    , min : Maybe Float
    , step : Maybe Float
    , size :
        Maybe (M3e.Value.Value { extraLarge : M3e.Value.Supported
        , extraSmall : M3e.Value.Supported
        , large : M3e.Value.Supported
        , medium : M3e.Value.Supported
        , small : M3e.Value.Supported
        })
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , onChange : Maybe (Json.Decode.Decoder msg)
    , default : List (M3e.Element.Element any_ msg)
    }


{-| Seed a `Builder` for `<m3e-slider>`. -}
slider : Builder AttrCaps SlotCaps msg
slider =
    Builder
        { disabled = Nothing
        , discrete = Nothing
        , labelled = Nothing
        , max = Nothing
        , min = Nothing
        , step = Nothing
        , size = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , onChange = Nothing
        , default = []
        }