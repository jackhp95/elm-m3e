module M3e.Badge exposing (component)

{-| A visual indicator used to label content.


## Component

@docs component

-}

import Html


{-| A visual indicator used to label content.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-badge" attributes children
