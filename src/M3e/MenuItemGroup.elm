module M3e.MenuItemGroup exposing (view)

{-| Groups related items (such a radios) in a menu.

**Component Info:**

  - **Extends:** `LitElement`

@docs view

-}

import M3e.Html.MenuItemGroup
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-menu-item-group>` element (lazy IR).
-}
view :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    ->
        List
            (Markup.Element.Element
                { menuItem : M3e.Kind.Brand
                , menuItemCheckbox : M3e.Kind.Brand
                , menuItemRadio : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | menuItemGroup : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.MenuItemGroup.menuItemGroup
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )
