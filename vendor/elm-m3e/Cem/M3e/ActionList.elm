module Cem.M3e.ActionList exposing (Variant(..), component, variant)

{-| 
A list of actions.

## Component

@docs component

### Attributes

@docs Variant, variant
-}


import Html
import Html.Attributes


{-| A list of actions.

**Component Info:**
- **Extends:** `M3eListElement` from `/src/list/ListElement`
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-action-list" attributes children


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