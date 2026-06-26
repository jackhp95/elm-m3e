module M3e.Slider exposing
    ( Option
    , view
    , value, min, max, step, discrete, labelled, disabled, onChange
    )

{-| `<m3e-slider>` — a control for choosing a numeric value from a range
(Material 3 Sliders, single-value mode).

Spec (per docs/CONVENTIONS.md):

  - Required:   { name : String }
               (bare control with no visible text — a required aria-label
               is mandatory for accessibility)
  - Options:    value, min, max, step, discrete, labelled, disabled, onChange
  - Slots:      one `<m3e-slider-thumb>` child (default slot)
  - Properties: min, max, step, discrete, labelled, disabled — on the
               slider element (via Node.property — introspectable/testable);
               value — on the thumb child (Node.property "value")
  - Events:     input on the thumb → Float (decoded from target.value)
  - A11y:       aria-label = name
  - Tag:        slider

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


type Option msg
    = Value Float
    | Min Float
    | Max Float
    | Step Float
    | Discrete Bool
    | Labelled Bool
    | Disabled Bool
    | OnChange (Float -> msg)


{-| Set the current value (default: not set, element uses its own default). -}
value : Float -> Option msg
value =
    Value


{-| Set the lower bound of the range. -}
min : Float -> Option msg
min =
    Min


{-| Set the upper bound of the range. -}
max : Float -> Option msg
max =
    Max


{-| Set the snap increment. -}
step : Float -> Option msg
step =
    Step


{-| Show tick marks at each step. -}
discrete : Bool -> Option msg
discrete =
    Discrete


{-| Show or hide the in-thumb value label. -}
labelled : Bool -> Option msg
labelled =
    Labelled


{-| Mark the slider disabled — non-interactive. -}
disabled : Bool -> Option msg
disabled =
    Disabled


{-| Wire a change handler. Receives the new Float value from the thumb. -}
onChange : (Float -> msg) -> Option msg
onChange =
    OnChange


type alias Config msg =
    { value : Maybe Float
    , min : Maybe Float
    , max : Maybe Float
    , step : Maybe Float
    , discrete : Bool
    , labelled : Bool
    , disabled : Bool
    , onChange : Maybe (Float -> msg)
    }


apply : Option msg -> Config msg -> Config msg
apply opt c =
    case opt of
        Value v ->
            { c | value = Just v }

        Min v ->
            { c | min = Just v }

        Max v ->
            { c | max = Just v }

        Step v ->
            { c | step = Just v }

        Discrete b ->
            { c | discrete = b }

        Labelled b ->
            { c | labelled = b }

        Disabled b ->
            { c | disabled = b }

        OnChange f ->
            { c | onChange = Just f }


view : { name : String } -> List (Option msg) -> Renderable { s | slider : Supported } msg
view req opts =
    let
        c =
            List.foldl apply
                { value = Nothing
                , min = Nothing
                , max = Nothing
                , step = Nothing
                , discrete = False
                , labelled = False
                , disabled = False
                , onChange = Nothing
                }
                opts
    in
    Renderable.fromNode
        (Node.element "m3e-slider"
            (List.filterMap identity
                [ Just (Node.attribute "aria-label" req.name)
                , Maybe.map (\v -> Node.property "min" (Encode.float v)) c.min
                , Maybe.map (\v -> Node.property "max" (Encode.float v)) c.max
                , Maybe.map (\v -> Node.property "step" (Encode.float v)) c.step
                , if c.discrete then
                    Just (Node.property "discrete" (Encode.bool True))

                  else
                    Nothing
                , if c.labelled then
                    Just (Node.property "labelled" (Encode.bool True))

                  else
                    Nothing
                , if c.disabled then
                    Just (Node.property "disabled" (Encode.bool True))

                  else
                    Nothing
                ]
            )
            [ thumbNode c ]
        )


thumbNode : Config msg -> Node.Node msg
thumbNode c =
    Node.element "m3e-slider-thumb"
        (List.filterMap identity
            [ Maybe.map
                (\v -> Node.property "value" (Encode.string (String.fromFloat v)))
                c.value
            , Maybe.map
                (\f ->
                    Node.on "input"
                        (Decode.at [ "target", "value" ] Decode.string
                            |> Decode.map (\s -> String.toFloat s |> Maybe.withDefault 0)
                            |> Decode.map f
                        )
                )
                c.onChange
            ]
        )
        []
