module M3e.Raw.Avatar exposing (avatar)

{-| Bottom layer for `<m3e-avatar>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs avatar

-}

import Html


{-| The raw `<m3e-avatar>` element — a partial application of `Html.node`.
-}
avatar : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
avatar =
    Html.node "m3e-avatar"
