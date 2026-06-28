module M3e.Icon exposing
    ( Option, Grade(..), Weight(..)
    , variant, grade, weight, opticalSize, filled
    , view
    )

{-| `<m3e-icon>` — a single Material Symbol. The glyph rides the `name`
ATTRIBUTE (the element has no slot for it; passing it as a child is the F1 bug).

Visual axes (fill, weight, grade, optical-size, variant) are all opt-in via the
options list. Omitting any axis leaves the upstream default in effect.

Upstream defaults (CEM-confirmed):

  - variant: `"outlined"`
  - filled: `false`
  - grade: `"medium"`
  - weight: `400`
  - optical-size: `24`


# Types

@docs Option, Grade, Weight


# Options

@docs variant, grade, weight, opticalSize, filled

@docs view

-}

import Cem.M3e.Icon as Cem
import Json.Encode as Encode
import M3e.Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Value as Value exposing (Value)



-- TYPES -----------------------------------------------------------------------


{-| Icon glyph style variant (default `outlined`), supplied as shared
[`M3e.Value`](M3e-Value) tokens.

  - `outlined` — default Material Symbols style.
  - `rounded` — rounded corners on the symbol paths.
  - `sharp` — sharp corners on the symbol paths.

Upstream: `variant` attribute on `<m3e-icon>`. CEM: `IconVariant`.

-}
type alias Variants =
    Value
        { outlined : Supported
        , rounded : Supported
        , sharp : Supported
        }


{-| Visual grade — adjusts icon weight for different backgrounds (default `Medium`).

  - `Low` — lighter visual weight (good on dark surfaces), maps to `"low"`.
  - `Medium` — default (neutral), maps to `"medium"`.
  - `High` — heavier visual weight (good for emphasis), maps to `"high"`.

Upstream: `grade` attribute on `<m3e-icon>`. CEM: `IconGrade`.

-}
type Grade
    = Low
    | Medium
    | High


{-| Stroke weight of the icon glyph (default `W400`).

Upstream: `weight` attribute on `<m3e-icon>`. CEM: `IconWeight` —
a numeric union of `100 | 200 | 300 | 400 | 500 | 600 | 700`.

-}
type Weight
    = W100
    | W200
    | W300
    | W400
    | W500
    | W600
    | W700


type alias Config =
    { variant : Maybe Variants
    , grade : Maybe Grade
    , weight : Maybe Weight
    , opticalSize : Maybe Int
    , filled : Bool
    }


{-| An opaque option for [`view`](#view).
-}
type alias Option msg =
    Internal.Option Config msg



-- OPTIONS ---------------------------------------------------------------------


{-| Set the glyph style variant (`outlined`, `rounded`, or `sharp`;
default `outlined`).

Upstream: `variant` attribute on `<m3e-icon>`.

-}
variant : Variants -> Option msg
variant v =
    Internal.option (\c -> { c | variant = Just v })


{-| Set the visual grade (`Low`, `Medium`, or `High`; default `Medium`).

Upstream: `grade` attribute on `<m3e-icon>`.

-}
grade : Grade -> Option msg
grade g =
    Internal.option (\c -> { c | grade = Just g })


{-| Set the stroke weight (`W100`–`W700`; default `W400`).

Upstream: `weight` attribute on `<m3e-icon>` — accepts numeric values
`100`–`700` as an attribute string.

-}
weight : Weight -> Option msg
weight w =
    Internal.option (\c -> { c | weight = Just w })


{-| Set the optical size in dp (`20`–`48`; default `24`).

Upstream: `optical-size` attribute on `<m3e-icon>` (number). Values outside
the `20`–`48` range are accepted but may produce unexpected results.

-}
opticalSize : Int -> Option msg
opticalSize n =
    Internal.option (\c -> { c | opticalSize = Just n })


{-| Fill the icon (default `False`). When used inside a toggle button,
`<m3e-button>` sets this automatically based on the selected state.

Upstream: `filled` property on `<m3e-icon>` (boolean DOM property).

-}
filled : Bool -> Option msg
filled b =
    Internal.option (\c -> { c | filled = b })



-- VIEW ------------------------------------------------------------------------


{-| Build the `<m3e-icon>` IR node. The `name` is the Material Symbol glyph
name, set on the `name` attribute. Pass `[]` when no visual axes are needed.

    Icon.view { name = "home" } []

    Icon.view { name = "favorite" }
        [ Icon.filled True
        , Icon.variant M3e.Value.rounded
        , Icon.weight Icon.W600
        ]

-}
view : { name : String } -> List (Option msg) -> Element { s | icon : Supported } msg
view req opts =
    let
        c : Config
        c =
            Internal.applyOptions opts
                { variant = Nothing
                , grade = Nothing
                , weight = Nothing
                , opticalSize = Nothing
                , filled = False
                }
    in
    Internal.fromNode
        (Node.element "m3e-icon"
            (List.filterMap identity
                [ Just (Node.attribute "name" req.name)
                , Maybe.map (\v -> Node.attribute "variant" (Value.toString v)) c.variant
                , Maybe.map (\g -> Node.attribute "grade" (Cem.gradeToString (toCemGrade g))) c.grade
                , Maybe.map (\w -> Node.attribute "weight" (weightToString w)) c.weight
                , Maybe.map (\n -> Node.attribute "optical-size" (String.fromInt n)) c.opticalSize
                , Just (Node.property "filled" (Encode.bool c.filled))
                ]
            )
            []
        )



-- INTERNAL --------------------------------------------------------------------


toCemGrade : Grade -> Cem.Grade
toCemGrade g =
    case g of
        Low ->
            Cem.Low

        Medium ->
            Cem.Medium

        High ->
            Cem.High


weightToString : Weight -> String
weightToString w =
    case w of
        W100 ->
            "100"

        W200 ->
            "200"

        W300 ->
            "300"

        W400 ->
            "400"

        W500 ->
            "500"

        W600 ->
            "600"

        W700 ->
            "700"
