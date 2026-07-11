module M3e.Raw.ListItem exposing (listItem)

{-| Bottom layer for `<m3e-list-item>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs listItem

-}

import Html


{-| The raw `<m3e-list-item>` element — a partial application of `Html.node`.
-}
listItem : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
listItem =
    Html.node "m3e-list-item"
