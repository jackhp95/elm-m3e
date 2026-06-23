module M3e.FocusTrap exposing (component, disabled)

{-| 
A non-visual element used to trap focus within nested content.

## Component

@docs component

### Attributes

@docs disabled
-}


import Html
import Html.Attributes
import Json.Encode


{-| A non-visual element used to trap focus within nested content. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-focus-trap" attributes children


{-| Disables the focus trap. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)