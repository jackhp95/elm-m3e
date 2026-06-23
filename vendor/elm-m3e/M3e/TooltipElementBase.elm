module M3e.TooltipElementBase exposing (component)

{-| 
Provides a base implementation for a tooltip. This class must be inherited.

## Component

@docs component
-}


import Html


{-| Provides a base implementation for a tooltip. This class must be inherited. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "div" attributes children