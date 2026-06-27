module Cem.M3e.LinearProgressIndicator exposing
    ( component
    , bufferValue, maxAttr, Mode(..), mode, value, Variant(..), variant
    , modeToString, variantToString
    )

{-| A horizontal bar for indicating progress and activity.


## Component

@docs component


### Attributes

@docs bufferValue, maxAttr, Mode, mode, value, Variant, variant

-}

import Html
import Html.Attributes
import Json.Encode


{-| A horizontal bar for indicating progress and activity.

**Component Info:**

  - **Extends:** `ProgressElementIndicatorBase` from `/src/progress-indicator/ProgressElementIndicatorBase`

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-linear-progress-indicator" attributes children


{-| A fractional value, between 0 and `max`, indicating buffer progress. (default: `0`)
-}
bufferValue : Float -> Html.Attribute msg
bufferValue val_ =
    Html.Attributes.property "buffer-value" (Json.Encode.float val_)


{-| The maximum progress value. (default: `100`)
-}
maxAttr : Float -> Html.Attribute msg
maxAttr val_ =
    Html.Attributes.property "max" (Json.Encode.float val_)


{-| Values for the `mode` attribute.
-}
type Mode
    = Buffer
    | Determinate
    | Indeterminate
    | Query


{-| The mode of the progress bar. (default: `"determinate"`)
-}
mode : Mode -> Html.Attribute msg
mode val_ =
    Html.Attributes.attribute "mode" (modeToString val_)


modeToString : Mode -> String
modeToString val_ =
    case val_ of
        Buffer ->
            "buffer"

        Determinate ->
            "determinate"

        Indeterminate ->
            "indeterminate"

        Query ->
            "query"


{-| A fractional value, between 0 and `max`, indicating progress. (default: `0`)
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| Values for the `variant` attribute.
-}
type Variant
    = Flat
    | Wavy


{-| The appearance of the indicator. (default: `"flat"`)
-}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


variantToString : Variant -> String
variantToString val_ =
    case val_ of
        Flat ->
            "flat"

        Wavy ->
            "wavy"
