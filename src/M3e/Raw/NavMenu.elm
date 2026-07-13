module M3e.Raw.NavMenu exposing (navMenu)

{-| Bottom layer for `<m3e-nav-menu>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs navMenu

-}

import Html


{-| The raw `<m3e-nav-menu>` element — a partial application of `Html.node`.
-}
navMenu : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
navMenu =
    Html.node "m3e-nav-menu"
