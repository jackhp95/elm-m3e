module M3e.Raw.TabPanel exposing (tabPanel)

{-| Bottom layer for `<m3e-tab-panel>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs tabPanel

-}

import Html


{-| The raw `<m3e-tab-panel>` element — a partial application of `Html.node`.
-}
tabPanel : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
tabPanel =
    Html.node "m3e-tab-panel"
