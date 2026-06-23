module M3e.FocusTrap exposing (component)

{-| A non-visual element used to trap focus within nested content.


## Component

@docs component

-}

import Html


{-| A non-visual element used to trap focus within nested content.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-focus-trap" attributes children
