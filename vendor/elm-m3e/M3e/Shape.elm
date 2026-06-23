module M3e.Shape exposing (component)

{-| A shape used to add emphasis and decorative flair.


## Component

@docs component

-}

import Html


{-| A shape used to add emphasis and decorative flair.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-shape" attributes children
