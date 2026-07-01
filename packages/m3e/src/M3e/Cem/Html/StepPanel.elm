module M3e.Cem.Html.StepPanel exposing (stepPanel)

{-| 
@docs stepPanel
-}


import Html


{-| The raw `<m3e-step-panel>` element — a partial application of `Html.node`. -}
stepPanel : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
stepPanel =
    Html.node "m3e-step-panel"