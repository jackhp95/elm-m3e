module M3e.MenuItemRadio exposing (view, disabled, checked, onClick, icon, trailingIcon)

{-| An item of a menu which supports a mutually exclusive checkable state.

**Component Info:**

  - **Extends:** `MenuItemElementBase` from `/src/menu/MenuItemElementBase`

**Events:**

  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `icon`: Renders an icon before the items's label.
  - `trailing-icon`: Renders an icon after the item's label.

@docs view, disabled, checked, onClick, icon, trailingIcon

-}

import M3e.Html.MenuItemRadio
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-menu-item-radio>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , checked : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { sharedText : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | menuItemRadio : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.MenuItemRadio.menuItemRadio
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.MenuItemRadio.disabled


{-| Whether the element is checked. (default: `false`)
-}
checked : Bool -> Markup.Html.Attr.Attr { c | checked : M3e.Token.Supported } msg
checked =
    M3e.Html.MenuItemRadio.checked


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.MenuItemRadio.onClick


{-| Place content in the `icon` slot.
-}
icon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
icon el =
    Markup.Element.Internal.placeSlot "icon" el


{-| Place content in the `trailing-icon` slot.
-}
trailingIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
trailingIcon el =
    Markup.Element.Internal.placeSlot "trailing-icon" el
