module M3e.Build.Stepper exposing ( Builder, AttrCaps, SlotCaps, stepper )

{-|
The ⑤ Build shape for `<m3e-stepper>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Stepper as Stepper`.

@docs Builder, AttrCaps, SlotCaps, stepper
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-stepper>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { headerPosition :
        Maybe (M3e.Value.Value { above : M3e.Value.Supported
        , below : M3e.Value.Supported
        })
    , labelPosition :
        Maybe (M3e.Value.Value { below : M3e.Value.Supported
        , end : M3e.Value.Supported
        })
    , linear : Maybe Bool
    , orientation :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , horizontal : M3e.Value.Supported
        , vertical : M3e.Value.Supported
        })
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , step : List (M3e.Element.Element { step : M3e.Value.Supported } msg)
    , panel : List (M3e.Element.Element { stepPanel : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-stepper>`. -}
stepper : Builder AttrCaps SlotCaps msg
stepper =
    Builder
        { headerPosition = Nothing
        , labelPosition = Nothing
        , linear = Nothing
        , orientation = Nothing
        , onChange = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , step = []
        , panel = []
        , phantomMsg_ = Nothing
        }