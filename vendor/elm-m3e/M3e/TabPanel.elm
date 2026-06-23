module M3e.TabPanel exposing (component)

{-| 
A panel presented for a tab.

## Component

@docs component
-}


import Html


{-| A panel presented for a tab. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-tab-panel" attributes children