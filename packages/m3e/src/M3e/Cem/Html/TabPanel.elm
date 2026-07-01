module M3e.Cem.Html.TabPanel exposing (tabPanel)

{-| 
@docs tabPanel
-}


import Html


{-| The raw `<m3e-tab-panel>` element — a partial application of `Html.node`. -}
tabPanel : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
tabPanel =
    Html.node "m3e-tab-panel"