module M3e.ExpansionHeader exposing
    ( view, hideToggle, toggleDirection, togglePosition, disabled, onClick
    , toggleIcon
    )

{-|
A button used to toggle the expanded state of an expansion panel.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `click`: Dispatched when the element is clicked.

**Slots:**
- `toggle-icon`: Renders the icon of the expansion toggle.

@docs view, hideToggle, toggleDirection, togglePosition, disabled, onClick
@docs toggleIcon
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.ExpansionHeader
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-expansion-header>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { hideToggle : M3e.Value.Supported
    , toggleDirection : M3e.Value.Supported
    , togglePosition : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element { text : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | expansionHeader : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.ExpansionHeader.expansionHeader
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Whether to hide the expansion toggle. (default: `false`) -}
hideToggle :
    Bool -> M3e.Cem.Attr.Attr { c | hideToggle : M3e.Value.Supported } msg
hideToggle =
    M3e.Cem.ExpansionHeader.hideToggle


{-| The direction of the expansion toggle. (default: `"vertical"`) -}
toggleDirection :
    M3e.Value.Value { horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | toggleDirection : M3e.Value.Supported } msg
toggleDirection =
    M3e.Cem.ExpansionHeader.toggleDirection


{-| The position of the expansion toggle. (default: `"after"`) -}
togglePosition :
    M3e.Value.Value { after : M3e.Value.Supported
    , before : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | togglePosition : M3e.Value.Supported } msg
togglePosition =
    M3e.Cem.ExpansionHeader.togglePosition


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.ExpansionHeader.disabled


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick =
    M3e.Cem.ExpansionHeader.onClick


{-| Place content in the `toggle-icon` slot. -}
toggleIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
toggleIcon el =
    M3e.Element.Internal.placeSlot "toggle-icon" el