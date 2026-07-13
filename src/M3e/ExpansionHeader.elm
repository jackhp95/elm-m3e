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

import M3e.Html.ExpansionHeader
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-expansion-header>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { hideToggle : M3e.Token.Supported
            , toggleDirection : M3e.Token.Supported
            , togglePosition : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | expansionHeader : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.ExpansionHeader.expansionHeader
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether to hide the expansion toggle. (default: `false`)
-}
hideToggle : Bool -> Markup.Html.Attr.Attr { c | hideToggle : M3e.Token.Supported } msg
hideToggle =
    M3e.Html.ExpansionHeader.hideToggle


{-| The direction of the expansion toggle. (default: `"vertical"`)
-}
toggleDirection :
    M3e.Token.Value
        { horizontal : M3e.Token.Supported
        , vertical : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | toggleDirection : M3e.Token.Supported } msg
toggleDirection =
    M3e.Html.ExpansionHeader.toggleDirection


{-| The position of the expansion toggle. (default: `"after"`)
-}
togglePosition :
    M3e.Token.Value
        { after : M3e.Token.Supported
        , before : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | togglePosition : M3e.Token.Supported } msg
togglePosition =
    M3e.Html.ExpansionHeader.togglePosition


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.ExpansionHeader.disabled


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.ExpansionHeader.onClick


{-| Place content in the `toggle-icon` slot.
-}
toggleIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
toggleIcon el =
    Markup.Element.Internal.placeSlot "toggle-icon" el
