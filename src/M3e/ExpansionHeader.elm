module M3e.ExpansionHeader exposing
    ( view, hideToggle, toggleDirection, togglePosition, disabled, onClick
    , toggleIcon
    )

{-| A button used to toggle the expanded state of an expansion panel.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `toggle-icon`: Renders the icon of the expansion toggle.

@docs view, hideToggle, toggleDirection, togglePosition, disabled, onClick
@docs toggleIcon

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.ExpansionHeader
import M3e.Node
import M3e.Token


{-| Build the `<m3e-expansion-header>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { hideToggle : M3e.Token.Supported
            , toggleDirection : M3e.Token.Supported
            , togglePosition : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | expansionHeader : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.ExpansionHeader.expansionHeader
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| Whether to hide the expansion toggle. (default: `false`)
-}
hideToggle : Bool -> M3e.Html.Attr.Attr { c | hideToggle : M3e.Token.Supported } msg
hideToggle =
    M3e.Html.ExpansionHeader.hideToggle


{-| The direction of the expansion toggle. (default: `"vertical"`)
-}
toggleDirection :
    M3e.Token.Value
        { horizontal : M3e.Token.Supported
        , vertical : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | toggleDirection : M3e.Token.Supported } msg
toggleDirection =
    M3e.Html.ExpansionHeader.toggleDirection


{-| The position of the expansion toggle. (default: `"after"`)
-}
togglePosition :
    M3e.Token.Value
        { after : M3e.Token.Supported
        , before : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | togglePosition : M3e.Token.Supported } msg
togglePosition =
    M3e.Html.ExpansionHeader.togglePosition


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.ExpansionHeader.disabled


{-| Listen for `click` events.
-}
onClick : msg -> M3e.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.ExpansionHeader.onClick


{-| Place content in the `toggle-icon` slot.
-}
toggleIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
toggleIcon el =
    M3e.Element.Internal.placeSlot "toggle-icon" el
