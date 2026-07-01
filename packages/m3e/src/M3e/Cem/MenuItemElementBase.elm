module M3e.Cem.MenuItemElementBase exposing (disabled, menuItemElementBase, onClick)

{-| 
@docs menuItemElementBase, disabled, onClick
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.MenuItemElementBase
import M3e.Value


{-| A base implementation for an item of a menu. This class must be inherited.

**Events:**
- `click`: No description
-}
menuItemElementBase :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
menuItemElementBase attributes children =
    M3e.Cem.Html.MenuItemElementBase.menuItemElementBase
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.MenuItemElementBase.disabled


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.MenuItemElementBase.onClick
        (Json.Decode.succeed f_)