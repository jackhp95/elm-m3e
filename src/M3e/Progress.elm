module M3e.Progress exposing
    ( Shape(..), Variant(..), Option
    , view
    , value, max, variant
    )

{-| `<m3e-linear-progress-indicator>` / `<m3e-circular-progress-indicator>` —
a determinate or indeterminate progress indicator.

Spec (per docs/CONVENTIONS.md):

  - Required:   { shape : Shape }
                (Linear or Circular — mutually exclusive, selects the HTML tag)
  - Options:    value, max, variant
  - Slots:      none (leaf elements)
  - Properties: value — via Node.property (Cem uses Html.Attributes.value =
                  stringProperty "value"; introspectable/testable)
                max — via Node.property (Cem uses Html.Attributes.property "max")
                indeterminate (Circular only) — via Node.property when no value
  - Attrs:      mode (Linear indeterminate) — Node.rawAttr; variant — Node.rawAttr
  - Escape:     none (leaves)
  - Tag:        progress

Value presence is the determinant of determinate vs indeterminate, matching
the Ui.Progress approach: when `value` is set the indicator is determinate;
when omitted it becomes indeterminate (Linear emits `mode=indeterminate`,
Circular emits `indeterminate=true` DOM property).

-}

import Cem.M3e.CircularProgressIndicator as CemCircular
import Cem.M3e.LinearProgressIndicator as CemLinear
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


{-| Selects the rendered element. `Linear` draws `<m3e-linear-progress-indicator>`;
`Circular` draws `<m3e-circular-progress-indicator>`.
-}
type Shape
    = Linear
    | Circular


{-| Visual style of the indicator. `Flat` (default) is the standard bar/ring;
`Wavy` renders an expressive wavy fill.
-}
type Variant
    = Flat
    | Wavy


type Option msg
    = Value Int
    | MaxVal Int
    | VariantOpt Variant


{-| Set the progress value (0..max). Passing this option makes the indicator
determinate. Omitting it leaves the indicator indeterminate (animated, no value).
-}
value : Int -> Option msg
value =
    Value


{-| Set the maximum value the indicator measures against. Default 100.
Maps to the `max` DOM property.
-}
max : Int -> Option msg
max =
    MaxVal


{-| Set the visual style — `Flat` (default) or `Wavy`.
-}
variant : Variant -> Option msg
variant =
    VariantOpt


type alias Config =
    { value : Maybe Int
    , max : Int
    , variant : Maybe Variant
    }


apply : Option msg -> Config -> Config
apply opt c =
    case opt of
        Value v ->
            { c | value = Just v }

        MaxVal m ->
            { c | max = m }

        VariantOpt v ->
            { c | variant = Just v }


view : { shape : Shape } -> List (Option msg) -> Renderable { s | progress : Supported } msg
view req opts =
    let
        c =
            List.foldl apply
                { value = Nothing
                , max = 100
                , variant = Nothing
                }
                opts
    in
    case req.shape of
        Linear ->
            Renderable.fromNode
                (Node.element "m3e-linear-progress-indicator"
                    (List.filterMap identity
                        [ Just (Node.property "max" (Encode.float (toFloat c.max)))
                        , case c.value of
                            Just v ->
                                Just (Node.property "value" (Encode.string (String.fromInt v)))

                            Nothing ->
                                Just (Node.rawAttr (CemLinear.mode CemLinear.Indeterminate))
                        , Maybe.map (\v -> Node.rawAttr (CemLinear.variant (toCemLinearVariant v))) c.variant
                        ]
                    )
                    []
                )

        Circular ->
            Renderable.fromNode
                (Node.element "m3e-circular-progress-indicator"
                    (List.filterMap identity
                        [ Just (Node.property "max" (Encode.float (toFloat c.max)))
                        , case c.value of
                            Just v ->
                                Just (Node.property "value" (Encode.string (String.fromInt v)))

                            Nothing ->
                                Just (Node.property "indeterminate" (Encode.bool True))
                        , Maybe.map (\v -> Node.rawAttr (CemCircular.variant (toCemCircularVariant v))) c.variant
                        ]
                    )
                    []
                )


toCemLinearVariant : Variant -> CemLinear.Variant
toCemLinearVariant v =
    case v of
        Flat ->
            CemLinear.Flat

        Wavy ->
            CemLinear.Wavy


toCemCircularVariant : Variant -> CemCircular.Variant
toCemCircularVariant v =
    case v of
        Flat ->
            CemCircular.Flat

        Wavy ->
            CemCircular.Wavy
