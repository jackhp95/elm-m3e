module Cem.M3e.TextOverflow exposing (component)

{-| An inline container which presents an ellipsis when content overflows.

@docs component

-}

import Html


{-| An inline container which presents an ellipsis when content overflows.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-text-overflow" attributes children
