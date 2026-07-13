module M3e.Raw.StepPanel exposing (stepPanel)

{-| Bottom layer for `<m3e-step-panel>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs stepPanel

-}

import Html


{-| The raw `<m3e-step-panel>` element — a partial application of `Html.node`.
-}
stepPanel : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
stepPanel =
    Html.node "m3e-step-panel"
