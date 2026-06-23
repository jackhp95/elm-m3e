module M3e.ButtonGroup exposing (Size(..), Variant(..), component, multi, size, variant)

{-| 
Organizes buttons and adds interactions between them.

## Component

@docs component

### Attributes

@docs multi, Size, size, Variant, variant
-}


import Html
import Html.Attributes
import Json.Encode


{-| Organizes buttons and adds interactions between them. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-button-group" attributes children


{-| Whether multiple toggle buttons can be selected. (default: `false`) -}
multi : Bool -> Html.Attribute msg
multi val_ =
    Html.Attributes.property "multi" (Json.Encode.bool val_)


{-| Values for the `size` attribute. -}
type Size
    = ExtraLarge
    | ExtraSmall
    | Large
    | Medium
    | Small


{-| The size of the group. (default: `"small"`) -}
size : Size -> Html.Attribute msg
size val_ =
    Html.Attributes.attribute "size" (sizeToString val_)


sizeToString : Size -> String
sizeToString val_ =
    case val_ of
        ExtraLarge ->
            "extra-large"
    
        ExtraSmall ->
            "extra-small"
    
        Large ->
            "large"
    
        Medium ->
            "medium"
    
        Small ->
            "small"


{-| Values for the `variant` attribute. -}
type Variant
    = Connected
    | Standard


{-| The appearance variant of the group. (default: `"standard"`) -}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


variantToString : Variant -> String
variantToString val_ =
    case val_ of
        Connected ->
            "connected"
    
        Standard ->
            "standard"