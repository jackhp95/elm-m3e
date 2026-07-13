module M3e.MenuItem exposing
    ( view, disabled, download, href, rel, target
    , onClick, icon, trailingIcon
    )

{-| An item of a menu.

**Component Info:**

  - **Extends:** `MenuItemElementBase` from `/src/menu/MenuItemElementBase`

**Events:**

  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `icon`: Renders an icon before the items's label.
  - `trailing-icon`: Renders an icon after the item's label.

@docs view, disabled, download, href, rel, target
@docs onClick, icon, trailingIcon

-}

import M3e.Html.MenuItem
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-menu-item>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , download : M3e.Token.Supported
            , href : M3e.Token.Supported
            , rel : M3e.Token.Supported
            , target : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { text : Markup.Kind.Shared
                , dialogTrigger : M3e.Kind.Brand
                , dialogAction : M3e.Kind.Brand
                , menuTrigger : M3e.Kind.Brand
                , fabMenuTrigger : M3e.Kind.Brand
                , bottomSheetTrigger : M3e.Kind.Brand
                , bottomSheetAction : M3e.Kind.Brand
                , stepperPrevious : M3e.Kind.Brand
                , stepperReset : M3e.Kind.Brand
                , richTooltipAction : M3e.Kind.Brand
                , drawerToggle : M3e.Kind.Brand
                , datepickerToggle : M3e.Kind.Brand
                , navRailToggle : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | menuItem : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.MenuItem.menuItem
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
    M3e.Html.MenuItem.disabled


{-| Whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`)
-}
download : String -> Markup.Html.Attr.Attr { c | download : M3e.Token.Supported } msg
download =
    M3e.Html.MenuItem.download


{-| The URL to which the link button points. (default: `""`)
-}
href : String -> Markup.Html.Attr.Attr { c | href : M3e.Token.Supported } msg
href =
    M3e.Html.MenuItem.href


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel : String -> Markup.Html.Attr.Attr { c | rel : M3e.Token.Supported } msg
rel =
    M3e.Html.MenuItem.rel


{-| The target of the link button. (default: `""`)
-}
target : String -> Markup.Html.Attr.Attr { c | target : M3e.Token.Supported } msg
target =
    M3e.Html.MenuItem.target


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.MenuItem.onClick


{-| Place content in the `icon` slot.
-}
icon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
icon el =
    Markup.Element.Internal.placeSlot "icon" el


{-| Place content in the `trailing-icon` slot.
-}
trailingIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
trailingIcon el =
    Markup.Element.Internal.placeSlot "trailing-icon" el
