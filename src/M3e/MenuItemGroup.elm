module M3e.MenuItemGroup exposing (view)

{-| Groups related items (such a radios) in a menu.

**Component Info:**

  - **Extends:** `LitElement`

@docs view

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.MenuItemGroup
import M3e.Node
import M3e.Token


{-| Build the `<m3e-menu-item-group>` element (lazy IR).
-}
view :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    ->
        List
            (M3e.Element.Element
                { menuItem : M3e.Token.Supported
                , menuItemCheckbox : M3e.Token.Supported
                , menuItemRadio : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | menuItemGroup : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.MenuItemGroup.menuItemGroup
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )
