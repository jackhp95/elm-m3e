module M3e.Slider exposing
    ( view
    , Option
    , value, min, max, step
    , discrete, labelled, disabled, onChange, onInput
    )

{-| `<m3e-slider>` — a control for choosing a numeric value from a range
(Material 3 Sliders, single-value mode).

Spec (per docs/CONVENTIONS.md):

  - Required: { name : String }
    (bare control with no visible text — a required aria-label
    is mandatory for accessibility)
  - Options: value, min, max, step, discrete, labelled, disabled,
    onChange, onInput
  - Slots: one `<m3e-slider-thumb>` child (default slot)
  - Properties: min, max, step, discrete, labelled, disabled — on the
    slider element (via Node.property — introspectable/testable);
    value — on the thumb child (Node.property "value")
  - Events (upstream `M3eSliderThumbElement` and `M3eSliderElement`):
    `input` — fires continuously during drag → decoded as Float from
    `event.target.value` — exposed as `onInput`
    `change` — fires once when the drag commits → decoded as Float
    from `event.target.value` — exposed as `onChange`
    Both events bubble from `<m3e-slider-thumb>` to `<m3e-slider>`;
    the handler is attached on the thumb child.
  - A11y: aria-label = name
  - Tag: slider

@docs view
@docs Option
@docs value, min, max, step
@docs discrete, labelled, disabled, onChange, onInput

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)


{-| An option configuring the `<m3e-slider>` element.
-}
type alias Option msg =
    Internal.Option (Config msg) msg


{-| Set the current value (default: not set, element uses its own default).
-}
value : Float -> Option msg
value v =
    Internal.option (\c -> { c | value = Just v })


{-| Set the lower bound of the range.
-}
min : Float -> Option msg
min v =
    Internal.option (\c -> { c | min = Just v })


{-| Set the upper bound of the range.
-}
max : Float -> Option msg
max v =
    Internal.option (\c -> { c | max = Just v })


{-| Set the snap increment.
-}
step : Float -> Option msg
step v =
    Internal.option (\c -> { c | step = Just v })


{-| Show tick marks at each step.
-}
discrete : Bool -> Option msg
discrete b =
    Internal.option (\c -> { c | discrete = b })


{-| Show or hide the in-thumb value label.
-}
labelled : Bool -> Option msg
labelled b =
    Internal.option (\c -> { c | labelled = b })


{-| Mark the slider disabled — non-interactive.
-}
disabled : Bool -> Option msg
disabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Wire a committed-change handler. Fires once when the user releases
the thumb (the `change` event on `<m3e-slider-thumb>`). Receives the
final Float value decoded from `event.target.value`.
-}
onChange : (Float -> msg) -> Option msg
onChange f =
    Internal.option (\c -> { c | onChange = Just f })


{-| Wire a live-input handler. Fires continuously while the user drags
the thumb (the `input` event on `<m3e-slider-thumb>`). Receives the
current Float value decoded from `event.target.value`.
-}
onInput : (Float -> msg) -> Option msg
onInput f =
    Internal.option (\c -> { c | onInput = Just f })


type alias Config msg =
    { value : Maybe Float
    , min : Maybe Float
    , max : Maybe Float
    , step : Maybe Float
    , discrete : Bool
    , labelled : Bool
    , disabled : Bool
    , onChange : Maybe (Float -> msg)
    , onInput : Maybe (Float -> msg)
    }


{-| Build the `<m3e-slider>` IR node. Requires `name`, used as the
`aria-label` for this otherwise text-free control.
-}
view : { name : String } -> List (Option msg) -> Element { s | slider : Supported } msg
view req opts =
    let
        c : Config msg
        c =
            Internal.applyOptions opts
                { value = Nothing
                , min = Nothing
                , max = Nothing
                , step = Nothing
                , discrete = False
                , labelled = False
                , disabled = False
                , onChange = Nothing
                , onInput = Nothing
                }
    in
    Internal.fromNode
        (Node.element "m3e-slider"
            (List.filterMap identity
                [ Just (Node.attribute "aria-label" req.name)
                , Maybe.map (\v -> Node.property "min" (Encode.float v)) c.min
                , Maybe.map (\v -> Node.property "max" (Encode.float v)) c.max
                , Maybe.map (\v -> Node.property "step" (Encode.float v)) c.step
                , Just (Node.property "discrete" (Encode.bool c.discrete))
                , Just (Node.property "labelled" (Encode.bool c.labelled))
                , Just (Node.property "disabled" (Encode.bool c.disabled))
                ]
            )
            [ thumbNode c ]
        )


thumbNode : Config msg -> Node msg
thumbNode c =
    Node.element "m3e-slider-thumb"
        (List.filterMap identity
            [ Maybe.map
                (\v -> Node.property "value" (Encode.float v))
                c.value
            , Maybe.map (decodeThumbValue "change") c.onChange
            , Maybe.map (decodeThumbValue "input") c.onInput
            ]
        )
        []


{-| Decode `event.target.value` as a Float for either "change" or "input"
events on `<m3e-slider-thumb>`. The element exposes the value as a
numeric string via its form-associated `value` attribute.
-}
decodeThumbValue : String -> (Float -> msg) -> Node.Attr msg
decodeThumbValue eventName f =
    Node.on eventName
        (Decode.at [ "target", "value" ] Decode.string
            |> Decode.map (String.toFloat >> Maybe.withDefault 0)
            |> Decode.map f
        )
