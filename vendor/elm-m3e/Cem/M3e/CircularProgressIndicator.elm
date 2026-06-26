module Cem.M3e.CircularProgressIndicator exposing (Variant(..), component, indeterminate, maxAttr, value, variant)

{-| 
A circular indicator of progress and activity.

## Component

@docs component

### Attributes

@docs indeterminate, maxAttr, value, Variant, variant
-}


import Html
import Html.Attributes
import Json.Encode


{-| A circular indicator of progress and activity.

**Component Info:**
- **Extends:** `ProgressElementIndicatorBase` from `/src/progress-indicator/ProgressElementIndicatorBase`
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-circular-progress-indicator" attributes children


{-| Whether to show something is happening without conveying progress. (default: `false`) -}
indeterminate : Bool -> Html.Attribute msg
indeterminate val_ =
    Html.Attributes.property "indeterminate" (Json.Encode.bool val_)


{-| The maximum progress value. (default: `100`) -}
maxAttr : Float -> Html.Attribute msg
maxAttr val_ =
    Html.Attributes.property "max" (Json.Encode.float val_)


{-| A fractional value, between 0 and `max`, indicating progress. (default: `0`) -}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| Values for the `variant` attribute. -}
type Variant
    = Flat
    | Wavy


{-| The appearance of the indicator. (default: `"flat"`) -}
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