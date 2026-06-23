module M3e.List exposing (component)

{-| A list of items.


## Component

@docs component

-}

import Html


{-| A list of items.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-list" attributes children
