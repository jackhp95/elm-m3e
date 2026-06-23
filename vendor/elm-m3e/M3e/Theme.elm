module M3e.Theme exposing (Contrast(..), Motion(..), Variant(..), component, contrast, density, motion, onChange, strongFocus, variant)

{-| 
A non-visual element responsible for application-level theming.

## Component

@docs component

### Attributes

@docs Contrast, contrast, density, strongFocus, Variant, variant, Motion, motion

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


{-| Values for the `contrast` attribute. -}
type Contrast
    = High
    | Medium
    | ContrastStandard


{-| The contrast level of the theme. (default: `"standard"`) -}
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


{-| The density scale (0, -1, -2). (default: `0`) -}
density : Float -> Html.Attribute msg
density val_ =
    Html.Attributes.property "density" (Json.Encode.float val_)


{-| Whether to enable strong focus indicators. (default: `false`) -}
strongFocus : Bool -> Html.Attribute msg
strongFocus val_ =
    Html.Attributes.property "strong-focus" (Json.Encode.bool val_)


{-| Values for the `variant` attribute. -}
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


{-| The color variant of the theme. (default: `"neutral"`) -}
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


{-| Values for the `motion` attribute. -}
type Motion
    = MotionExpressive
    | MotionStandard


{-| The motion scheme. (default: `"standard"`) -}
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

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder