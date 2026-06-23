module M3e.List exposing (Variant(..), component, variant)

{-| 
A list of items.

## Component

@docs component

### Attributes

@docs Variant, variant
-}


import Html
import Html.Attributes


{-| A list of items. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-list" attributes children


{-| Values for the `variant` attribute. -}
type Variant
    = Segmented
    | Standard


{-| The appearance variant of the list. (default: `"standard"`) -}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


variantToString : Variant -> String
variantToString val_ =
    case val_ of
        Segmented ->
            "segmented"
    
        Standard ->
            "standard"