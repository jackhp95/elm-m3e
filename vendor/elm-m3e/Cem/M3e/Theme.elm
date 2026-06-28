module Cem.M3e.Theme exposing
    ( component
    , color, Contrast(..), contrast, density, Scheme(..), scheme, strongFocus, Variant(..), variant, Motion(..), motion
    , onChange
    , contrastToString, motionToString, schemeToString, variantToString
    )

{-| A non-visual element responsible for application-level theming.


## Component

@docs component


### Attributes

@docs color, Contrast, contrast, density, Scheme, scheme, strongFocus, Variant, variant, Motion, motion


### Events

@docs onChange

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A non-visual element responsible for application-level theming.

**Events:**

  - `change`: Dispatched when the theme changes.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-theme" attributes children


{-| The hex color from which to derive dynamic color palettes. (default: `"#6750A4"`)
-}
color : String -> Html.Attribute msg
color val_ =
    Html.Attributes.attribute "color" val_


{-| Values for the `contrast` attribute.
-}
type Contrast
    = High
    | Medium
    | ContrastStandard


{-| The contrast level of the theme. (default: `"standard"`)
-}
contrast : Contrast -> Html.Attribute msg
contrast val_ =
    Html.Attributes.attribute "contrast" (contrastToString val_)


contrastToString : Contrast -> String
contrastToString val_ =
    case val_ of
        High ->
            "high"

        Medium ->
            "medium"

        ContrastStandard ->
            "standard"


{-| The density scale (0, -1, -2). (default: `0`)
-}
density : Float -> Html.Attribute msg
density val_ =
    Html.Attributes.property "density" (Json.Encode.float val_)


{-| Values for the `scheme` attribute.
-}
type Scheme
    = Auto
    | Dark
    | Light


{-| The color scheme of the theme. (default: `"auto"`)
-}
scheme : Scheme -> Html.Attribute msg
scheme val_ =
    Html.Attributes.attribute "scheme" (schemeToString val_)


schemeToString : Scheme -> String
schemeToString val_ =
    case val_ of
        Auto ->
            "auto"

        Dark ->
            "dark"

        Light ->
            "light"


{-| Whether to enable strong focus indicators. (default: `false`)
-}
strongFocus : Bool -> Html.Attribute msg
strongFocus val_ =
    Html.Attributes.property "strongFocus" (Json.Encode.bool val_)


{-| Values for the `variant` attribute.
-}
type Variant
    = Content
    | VariantExpressive
    | Fidelity
    | FruitSalad
    | Monochrome
    | Neutral
    | Rainbow
    | TonalSpot
    | Vibrant


{-| The color variant of the theme. (default: `"neutral"`)
-}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


variantToString : Variant -> String
variantToString val_ =
    case val_ of
        Content ->
            "content"

        VariantExpressive ->
            "expressive"

        Fidelity ->
            "fidelity"

        FruitSalad ->
            "fruit-salad"

        Monochrome ->
            "monochrome"

        Neutral ->
            "neutral"

        Rainbow ->
            "rainbow"

        TonalSpot ->
            "tonal-spot"

        Vibrant ->
            "vibrant"


{-| Values for the `motion` attribute.
-}
type Motion
    = MotionExpressive
    | MotionStandard


{-| The motion scheme. (default: `"standard"`)
-}
motion : Motion -> Html.Attribute msg
motion val_ =
    Html.Attributes.attribute "motion" (motionToString val_)


motionToString : Motion -> String
motionToString val_ =
    case val_ of
        MotionExpressive ->
            "expressive"

        MotionStandard ->
            "standard"


{-| Dispatched when the theme changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder
