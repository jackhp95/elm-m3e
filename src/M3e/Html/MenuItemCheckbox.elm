module M3e.Html.MenuItemCheckbox exposing (menuItemCheckbox, disabled, checked, onClick)

{-| Middle layer for `<m3e-menu-item-checkbox>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.MenuItemCheckbox` module for everyday use.

@docs menuItemCheckbox, disabled, checked, onClick

-}

import Html
import Json.Decode
import M3e.Raw.MenuItemCheckbox
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| An item of a menu which supports a checkable state.

**Component Info:**

  - **Extends:** `MenuItemElementBase` from `/src/menu/MenuItemElementBase`

**Events:**

  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `icon`: Renders an icon before the items's label.
  - `trailing-icon`: Renders an icon after the item's label.

-}
menuItemCheckbox :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , checked : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
menuItemCheckbox attributes children =
    M3e.Raw.MenuItemCheckbox.menuItemCheckbox
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.MenuItemCheckbox.disabled


{-| Whether the element is checked. (default: `false`)
-}
checked : Bool -> Markup.Html.Attr.Attr { c | checked : M3e.Token.Supported } msg
checked =
    Markup.Html.Attr.Internal.attribute M3e.Raw.MenuItemCheckbox.checked


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.MenuItemCheckbox.onClick
        (Json.Decode.succeed f_)
