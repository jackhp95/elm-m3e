module M3e.ButtonGroup exposing (component)

{-| Organizes buttons and adds interactions between them.


## Component

@docs component

-}

import Html


{-| Organizes buttons and adds interactions between them.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-button-group" attributes children
