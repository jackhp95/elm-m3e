module M3e.Elevation exposing (component)

{-| 
Visually depicts elevation using a shadow.

## Component

@docs component
-}


import Html


{-| Visually depicts elevation using a shadow. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-elevation" attributes children