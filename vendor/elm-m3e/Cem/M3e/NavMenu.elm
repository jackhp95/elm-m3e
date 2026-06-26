module Cem.M3e.NavMenu exposing (component)

{-| 
A hierarchical menu, typically used on larger devices, that allows a user to switch between views.

## Component

@docs component
-}


import Html


{-| A hierarchical menu, typically used on larger devices, that allows a user to switch between views. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-nav-menu" attributes children