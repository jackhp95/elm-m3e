module M3e.Cem.MenuItemRadio exposing ( menuItemRadio, disabled, checked, onClick )

{-|
Middle layer for `<m3e-menu-item-radio>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.MenuItemRadio` module for everyday use.

@docs menuItemRadio, disabled, checked, onClick
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.MenuItemRadio
import M3e.Value


{-| An item of a menu which supports a mutually exclusive checkable state.

**Component Info:**
- **Extends:** `MenuItemElementBase` from `/src/menu/MenuItemElementBase`

**Events:**
- `click`: Dispatched when the element is clicked.

**Slots:**
- `icon`: Renders an icon before the items's label.
- `trailing-icon`: Renders an icon after the item's label.
-}
menuItemRadio :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , checked : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
menuItemRadio attributes children =
    M3e.Cem.Html.MenuItemRadio.menuItemRadio
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.MenuItemRadio.disabled


{-| Whether the element is checked. (default: `false`) -}
checked : Bool -> M3e.Cem.Attr.Attr { c | checked : M3e.Value.Supported } msg
checked =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.MenuItemRadio.checked


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.MenuItemRadio.onClick
        (Json.Decode.succeed f_)