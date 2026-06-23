module M3e.LoadingIndicator exposing (Variant(..), component, variant)

{-| 
Shows indeterminate progress for a short wait time.

## Component

@docs component

### Attributes

@docs Variant, variant
-}


import Html
import Html.Attributes


{-| Shows indeterminate progress for a short wait time. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-loading-indicator" attributes children


{-| Values for the `variant` attribute. -}
type Variant
    = Contained
    | Uncontained


{-| The appearance variant of the indicator. (default: `"uncontained"`) -}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


variantToString : Variant -> String
variantToString val_ =
    case val_ of
        Contained ->
            "contained"
    
        Uncontained ->
            "uncontained"