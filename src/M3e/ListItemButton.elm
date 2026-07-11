module M3e.ListItemButton exposing
    ( view, href, target, rel, download, disabled
    , onClick, leading, overline, supportingText, trailing
    )

{-| Create a m3e-list-item-button element

**Component Info:**

  - **Extends:** `M3eListItemElement` from `/src/list/ListItemElement`

**Events:**

  - `click`: No description

**Slots:**

  - `leading`: Renders the leading content of the list item.
  - `overline`: Renders the overline of the list item.
  - `supporting-text`: Renders the supporting text of the list item.
  - `trailing`: Renders the trailing content of the list item.

@docs view, href, target, rel, download, disabled
@docs onClick, leading, overline, supportingText, trailing

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.ListItemButton
import M3e.Node
import M3e.Token


{-| Build the `<m3e-list-item-button>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { href : M3e.Token.Supported
            , target : M3e.Token.Supported
            , rel : M3e.Token.Supported
            , download : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (M3e.Element.Element
                { text : M3e.Token.Supported
                , html : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | listItemButton : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.ListItemButton.listItemButton
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| The URL to which the link button points. (default: `""`)
-}
href : String -> M3e.Html.Attr.Attr { c | href : M3e.Token.Supported } msg
href =
    M3e.Html.ListItemButton.href


{-| The target of the link button. (default: `""`)
-}
target : String -> M3e.Html.Attr.Attr { c | target : M3e.Token.Supported } msg
target =
    M3e.Html.ListItemButton.target


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel : String -> M3e.Html.Attr.Attr { c | rel : M3e.Token.Supported } msg
rel =
    M3e.Html.ListItemButton.rel


{-| A value indicating whether the `target` of the link button will be downloaded,
optionally specifying the new name of the file. (default: `null`)
-}
download : String -> M3e.Html.Attr.Attr { c | download : M3e.Token.Supported } msg
download =
    M3e.Html.ListItemButton.download


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.ListItemButton.disabled


{-| Listen for `click` events.
-}
onClick : msg -> M3e.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.ListItemButton.onClick


{-| Place content in the `leading` slot.
-}
leading :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , avatar : M3e.Token.Supported
        , text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
leading el =
    M3e.Element.Internal.placeSlot "leading" el


{-| Place content in the `overline` slot.
-}
overline :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
overline el =
    M3e.Element.Internal.placeSlot "overline" el


{-| Place content in the `supporting-text` slot.
-}
supportingText :
    M3e.Element.Element
        { text : M3e.Token.Supported
        , html : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
supportingText el =
    M3e.Element.Internal.placeSlot "supporting-text" el


{-| Place content in the `trailing` slot.
-}
trailing :
    M3e.Element.Element
        { icon : M3e.Token.Supported
        , avatar : M3e.Token.Supported
        , text : M3e.Token.Supported
        , html : M3e.Token.Supported
        , switch : M3e.Token.Supported
        , radio : M3e.Token.Supported
        , checkbox : M3e.Token.Supported
        }
        msg
    -> M3e.Element.Element k msg
trailing el =
    M3e.Element.Internal.placeSlot "trailing" el
