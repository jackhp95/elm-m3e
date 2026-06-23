module M3e.PseudoCheckbox exposing (component)

{-| 
An element which looks like a checkbox.

## Component

@docs component
-}


import Html


{-| An element which looks like a checkbox. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-pseudo-checkbox" attributes children