module M3e.ProgressElementIndicatorBase exposing (Variant(..), component, maxAttr, value, variant)

{-| 
A base implementation for an element used to convey progress. This class must be inherited.

## Component

@docs component

### Attributes

@docs value, maxAttr, Variant, variant
-}


import Html
import Html.Attributes
import Json.Encode


{-| A base implementation for an element used to convey progress. This class must be inherited. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "div" attributes children


{-| A fractional value, between 0 and `max`, indicating progress. (default: `0`) -}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| The maximum progress value. (default: `100`) -}
maxAttr : Float -> Html.Attribute msg
maxAttr val_ =
    Html.Attributes.property "max" (Json.Encode.float val_)


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