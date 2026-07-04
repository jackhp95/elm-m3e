module M3e.Build.Slider exposing
    ( Builder, AttrCaps, SlotCaps, slider, disabled, discrete
    , labelled, max, min, step, size, onBeforeinput, onInput
    , onChange
    )

{-|
The ⑤ Build shape for `<m3e-slider>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Slider as Slider`.

@docs Builder, AttrCaps, SlotCaps, slider, disabled, discrete
@docs labelled, max, min, step, size, onBeforeinput
@docs onInput, onChange
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-slider>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , discrete : M3e.Build.Internal.Available
    , labelled : M3e.Build.Internal.Available
    , max : M3e.Build.Internal.Available
    , min : M3e.Build.Internal.Available
    , step : M3e.Build.Internal.Available
    , size : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
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
    , default : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
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
        , phantomMsg_ = Nothing
        }


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| Whether to show tick marks. (default: `false`) -}
discrete :
    Bool
    -> Builder { a | discrete : M3e.Build.Internal.Available } s msg
    -> Builder { a | discrete : M3e.Build.Internal.Used } s msg
discrete v_ (Builder f_) =
    Builder { f_ | discrete = Just v_ }


{-| Whether to show value labels when activated. (default: `false`) -}
labelled :
    Bool
    -> Builder { a | labelled : M3e.Build.Internal.Available } s msg
    -> Builder { a | labelled : M3e.Build.Internal.Used } s msg
labelled v_ (Builder f_) =
    Builder { f_ | labelled = Just v_ }


{-| The maximum allowable value. (default: `100`) -}
max :
    Float
    -> Builder { a | max : M3e.Build.Internal.Available } s msg
    -> Builder { a | max : M3e.Build.Internal.Used } s msg
max v_ (Builder f_) =
    Builder { f_ | max = Just v_ }


{-| The minimum allowable value. (default: `0`) -}
min :
    Float
    -> Builder { a | min : M3e.Build.Internal.Available } s msg
    -> Builder { a | min : M3e.Build.Internal.Used } s msg
min v_ (Builder f_) =
    Builder { f_ | min = Just v_ }


{-| The value at which the thumb will snap. (default: `1`) -}
step :
    Float
    -> Builder { a | step : M3e.Build.Internal.Available } s msg
    -> Builder { a | step : M3e.Build.Internal.Used } s msg
step v_ (Builder f_) =
    Builder { f_ | step = Just v_ }


{-| The size of the slider. (default: `"extra-small"`) -}
size :
    M3e.Value.Value { extraLarge : M3e.Value.Supported
    , extraSmall : M3e.Value.Supported
    , large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> Builder { a | size : M3e.Build.Internal.Available } s msg
    -> Builder { a | size : M3e.Build.Internal.Used } s msg
size v_ (Builder f_) =
    Builder { f_ | size = Just v_ }


{-| Dispatched before the value of a thumb changes. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg
onBeforeinput v_ (Builder f_) =
    Builder { f_ | onBeforeinput = Just v_ }


{-| Dispatched when the value of a thumb changes. -}
onInput :
    Json.Decode.Decoder msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg
onInput v_ (Builder f_) =
    Builder { f_ | onInput = Just v_ }


{-| Dispatched when the value of a thumb changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg
onChange v_ (Builder f_) =
    Builder { f_ | onChange = Just v_ }