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

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.MenuItem
import M3e.Node
import M3e.Token


{-| Build the `<m3e-menu-item>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
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
            (M3e.Element.Element
                { text : M3e.Token.Supported
                , dialogTrigger : M3e.Token.Supported
                , dialogAction : M3e.Token.Supported
                , menuTrigger : M3e.Token.Supported
                , fabMenuTrigger : M3e.Token.Supported
                , bottomSheetTrigger : M3e.Token.Supported
                , bottomSheetAction : M3e.Token.Supported
                , stepperPrevious : M3e.Token.Supported
                , stepperReset : M3e.Token.Supported
                , richTooltipAction : M3e.Token.Supported
                , drawerToggle : M3e.Token.Supported
                , datepickerToggle : M3e.Token.Supported
                , navRailToggle : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | menuItem : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.MenuItem.menuItem
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.MenuItem.disabled


{-| Whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`)
-}
download : String -> M3e.Html.Attr.Attr { c | download : M3e.Token.Supported } msg
download =
    M3e.Html.MenuItem.download


{-| The URL to which the link button points. (default: `""`)
-}
href : String -> M3e.Html.Attr.Attr { c | href : M3e.Token.Supported } msg
href =
    M3e.Html.MenuItem.href


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel : String -> M3e.Html.Attr.Attr { c | rel : M3e.Token.Supported } msg
rel =
    M3e.Html.MenuItem.rel


{-| The target of the link button. (default: `""`)
-}
target : String -> M3e.Html.Attr.Attr { c | target : M3e.Token.Supported } msg
target =
    M3e.Html.MenuItem.target


{-| Listen for `click` events.
-}
onClick : msg -> M3e.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.MenuItem.onClick


{-| Place content in the `icon` slot.
-}
icon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
icon el =
    M3e.Element.Internal.placeSlot "icon" el


{-| Place content in the `trailing-icon` slot.
-}
trailingIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
trailingIcon el =
    M3e.Element.Internal.placeSlot "trailing-icon" el
