module M3e.Cem.MenuItemGroup exposing (menuItemGroup)

{-| 
@docs menuItemGroup
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.MenuItemGroup
import M3e.Value


{-| Groups related items (such a radios) in a menu. -}
menuItemGroup :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
menuItemGroup attributes children =
    M3e.Cem.Html.MenuItemGroup.menuItemGroup
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children