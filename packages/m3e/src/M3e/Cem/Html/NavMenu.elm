module M3e.Cem.Html.NavMenu exposing (navMenu)

{-| 
@docs navMenu
-}


import Html


{-| The raw `<m3e-nav-menu>` element — a partial application of `Html.node`. -}
navMenu : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
navMenu =
    Html.node "m3e-nav-menu"