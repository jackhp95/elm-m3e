module M3e.Raw.TextOverflow exposing (textOverflow)

{-| Bottom layer for `<m3e-text-overflow>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs textOverflow

-}

import Html


{-| The raw `<m3e-text-overflow>` element — a partial application of `Html.node`.
-}
textOverflow : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
textOverflow =
    Html.node "m3e-text-overflow"
