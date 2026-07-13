module M3e.NavMenuItemGroup exposing (view, label)

{-| A top-level semantic grouping of items in a navigation menu.

**Component Info:**

  - **Extends:** `LitElement`

**Slots:**

  - `label`: Renders the label of the group.

@docs view, label

-}

import M3e.Html.NavMenuItemGroup
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-nav-menu-item-group>` element (lazy IR).
-}
view :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Markup.Element.Element { navMenuItem : M3e.Kind.Brand } msg)
    -> Markup.Element.Element { s | navMenuItemGroup : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.NavMenuItemGroup.navMenuItemGroup
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Place content in the `label` slot.
-}
label :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , heading : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
label el =
    Markup.Element.Internal.placeSlot "label" el
