module Ui.Slider exposing
    ( Slider, Single, Range
    , value, range
    , withId, withMin, withMax, withStep, withDiscrete, withDisabled
    , withHelp, withError, withLabelled
    , view
    )

{-| Typed builder for `<m3e-slider>` — a control for selecting a value
(or range) from a continuous or stepped range. Mirrors the Material 3
[Sliders][m3] surface.

[m3]: https://m3.material.io/components/sliders/overview


# Two kinds, gated by the type system

  - **Single** (`value`) — selects one `Float` from the range.
  - **Range** (`range`) — selects a `{ start, end }` pair (two thumbs).


# Required-by-design

`value` and `range` both require:

  - `label` — visible adjacent text.
  - the current value(s).
  - `onChange` — handler receiving the new value(s).


# Optional modifiers

`withMin` / `withMax` set the range bounds (default 0..100 from m3e).
`withStep` sets a step increment (continuous when unset). `withDiscrete`
shows tick marks at each step. `withLabelled` toggles the in-thumb value
label (default `True`).


# Quick examples

A volume slider:

    Ui.Slider.value
        { label = "Volume"
        , value = state.volume
        , onChange = VolumeChanged
        }
        |> Ui.Slider.withMin 0
        |> Ui.Slider.withMax 100
        |> Ui.Slider.view

A price-range filter:

    Ui.Slider.range
        { label = "Price"
        , value = { start = state.lo, end = state.hi }
        , onChange = PriceRangeChanged
        }
        |> Ui.Slider.withMin 0
        |> Ui.Slider.withMax 1000
        |> Ui.Slider.withStep 50
        |> Ui.Slider.withDiscrete True
        |> Ui.Slider.view


# Type

@docs Slider, Single, Range


# Constructors

@docs value, range


# Modifiers

@docs withId, withMin, withMax, withStep, withDiscrete, withDisabled
@docs withHelp, withError, withLabelled


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Json.Decode as Decode
import M3e.FormField
import M3e.Slider
import M3e.SliderThumb



-- TYPES ------------------------------------------------------------------


{-| A slider, parameterized by its kind tag (`Single` / `Range`) and
the message type.
-}
type Slider kind msg
    = Slider (Config msg)


{-| Phantom tag for single-value sliders. Has no values.
-}
type Single
    = SinglePhantomTag Never


{-| Phantom tag for range sliders. Has no values.
-}
type Range
    = RangePhantomTag Never


type alias Config msg =
    { id : Maybe String
    , label : String
    , thumbs : Thumbs msg
    , min : Maybe Float
    , max : Maybe Float
    , step : Maybe Float
    , discrete : Bool
    , labelled : Bool
    , disabled : Bool
    , help : Maybe (Html msg)
    , error : Maybe (Html msg)
    }


type Thumbs msg
    = SingleThumb { value : Float, onChange : Float -> msg }
    | RangeThumbs
        { start : Float
        , end : Float
        , onChange : { start : Float, end : Float } -> msg
        }



-- CONSTRUCTORS -----------------------------------------------------------


{-| Construct a single-value slider.
-}
value :
    { label : String, value : Float, onChange : Float -> msg }
    -> Slider Single msg
value c =
    Slider (baseConfig c.label (SingleThumb { value = c.value, onChange = c.onChange }))


{-| Construct a range slider (two thumbs).
-}
range :
    { label : String
    , value : { start : Float, end : Float }
    , onChange : { start : Float, end : Float } -> msg
    }
    -> Slider Range msg
range c =
    Slider
        (baseConfig c.label
            (RangeThumbs
                { start = c.value.start
                , end = c.value.end
                , onChange = c.onChange
                }
            )
        )


baseConfig : String -> Thumbs msg -> Config msg
baseConfig label thumbs =
    { id = Nothing
    , label = label
    , thumbs = thumbs
    , min = Nothing
    , max = Nothing
    , step = Nothing
    , discrete = False
    , labelled = True
    , disabled = False
    , help = Nothing
    , error = Nothing
    }



-- MODIFIERS --------------------------------------------------------------


{-| Set the `id` attribute.
-}
withId : String -> Slider kind msg -> Slider kind msg
withId id (Slider cfg) =
    Slider { cfg | id = Just id }


{-| Set the minimum value (default: m3e's element default, typically 0).
-}
withMin : Float -> Slider kind msg -> Slider kind msg
withMin n (Slider cfg) =
    Slider { cfg | min = Just n }


{-| Set the maximum value (default: m3e's element default, typically 100).
-}
withMax : Float -> Slider kind msg -> Slider kind msg
withMax n (Slider cfg) =
    Slider { cfg | max = Just n }


{-| Set the step increment. Continuous when unset.
-}
withStep : Float -> Slider kind msg -> Slider kind msg
withStep n (Slider cfg) =
    Slider { cfg | step = Just n }


{-| Show tick marks at each step. Pair with `withStep` for a clear
discrete-value scale.
-}
withDiscrete : Bool -> Slider kind msg -> Slider kind msg
withDiscrete b (Slider cfg) =
    Slider { cfg | discrete = b }


{-| Show or hide the in-thumb value label. Default `True`.
-}
withLabelled : Bool -> Slider kind msg -> Slider kind msg
withLabelled b (Slider cfg) =
    Slider { cfg | labelled = b }


{-| Disable the slider.
-}
withDisabled : Bool -> Slider kind msg -> Slider kind msg
withDisabled b (Slider cfg) =
    Slider { cfg | disabled = b }


{-| Set help text rendered beneath the slider.
-}
withHelp : Html msg -> Slider kind msg -> Slider kind msg
withHelp h (Slider cfg) =
    Slider { cfg | help = Just h }


{-| Set an error message. Replaces help text.
-}
withError : Html msg -> Slider kind msg -> Slider kind msg
withError e (Slider cfg) =
    Slider { cfg | error = Just e }



-- RENDER -----------------------------------------------------------------


{-| Render the slider to `Html`.
-}
view : Slider kind msg -> Html msg
view (Slider cfg) =
    M3e.FormField.component
        []
        (List.concat
            [ [ sliderElement cfg
              , labelElement cfg
              ]
            , subscriptElements cfg
            ]
        )


sliderElement : Config msg -> Html msg
sliderElement cfg =
    M3e.Slider.component
        (List.filterMap identity
            [ Maybe.map Attr.id cfg.id
            , Maybe.map M3e.Slider.minAttr cfg.min
            , Maybe.map M3e.Slider.maxAttr cfg.max
            , Maybe.map M3e.Slider.step cfg.step
            , Just (M3e.Slider.discrete cfg.discrete)
            , Just (M3e.Slider.labelled cfg.labelled)
            , Just (M3e.Slider.disabled cfg.disabled)
            ]
        )
        (thumbsElements cfg.thumbs)


thumbsElements : Thumbs msg -> List (Html msg)
thumbsElements thumbs =
    case thumbs of
        SingleThumb t ->
            [ thumbView t.value t.onChange ]

        RangeThumbs r ->
            [ thumbView r.start (\v -> r.onChange { start = v, end = r.end })
            , thumbView r.end (\v -> r.onChange { start = r.start, end = v })
            ]


thumbView : Float -> (Float -> msg) -> Html msg
thumbView v toMsg =
    M3e.SliderThumb.component
        [ Attr.attribute "value" (String.fromFloat v)
        , M3e.SliderThumb.onInput (floatDecoder toMsg)
        ]
        []


floatDecoder : (Float -> msg) -> Decode.Decoder msg
floatDecoder toMsg =
    Decode.at [ "target", "value" ] Decode.string
        |> Decode.map (\s -> String.toFloat s |> Maybe.withDefault 0)
        |> Decode.map toMsg


labelElement : Config msg -> Html msg
labelElement cfg =
    Html.label
        (List.filterMap identity
            -- FormField has no label slot; the label is a default-slot child.
            [ Maybe.map Attr.for cfg.id
            ]
        )
        [ Html.text cfg.label ]


subscriptElements : Config msg -> List (Html msg)
subscriptElements cfg =
    case ( cfg.error, cfg.help ) of
        ( Just err, _ ) ->
            [ Html.span [ M3e.FormField.errorSlot ] [ err ] ]

        ( Nothing, Just help ) ->
            [ Html.span [ M3e.FormField.hintSlot ] [ help ] ]

        ( Nothing, Nothing ) ->
            []
