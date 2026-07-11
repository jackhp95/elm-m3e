module M3e.ListItem exposing (view, leading, overline, supportingText, trailing)

{-| An item in a list.

**Component Info:**

  - **Extends:** `LitElement`

**Slots:**

  - `leading`: Renders the leading content of the list item.
  - `overline`: Renders the overline of the list item.
  - `supporting-text`: Renders the supporting text of the list item.
  - `trailing`: Renders the trailing content of the list item.

@docs view, leading, overline, supportingText, trailing

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.ListItem
import M3e.Node
import M3e.Token


{-| Build the `<m3e-list-item>` element (lazy IR).
-}
view :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    ->
        List
            (M3e.Element.Element
                { text : M3e.Token.Supported
                , html : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | listItem : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.ListItem.listItem
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


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
