module M3e.PseudoRadio exposing (component)

{-| An element which looks like a radio button.


## Component

@docs component

-}

import Html


{-| An element which looks like a radio button.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-pseudo-radio" attributes children
