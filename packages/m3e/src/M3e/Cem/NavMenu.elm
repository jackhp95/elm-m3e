module M3e.Cem.NavMenu exposing (navMenu)

{-| 
@docs navMenu
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.NavMenu
import M3e.Value


{-| A hierarchical menu, typically used on larger devices, that allows a user to switch between views. -}
navMenu :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
navMenu attributes children =
    M3e.Cem.Html.NavMenu.navMenu
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children