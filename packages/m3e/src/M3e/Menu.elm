module M3e.Menu exposing
    ( view, positionX, positionY, variant, submenu, onBeforetoggle
    , onToggle, child, children
    )

{-|
Presents a list of choices on a temporary surface.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `beforetoggle`: Dispatched before the toggle state changes.
- `toggle`: Dispatched after the toggle state has changed.

@docs view, positionX, positionY, variant, submenu, onBeforetoggle
@docs onToggle, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Menu
import M3e.Content
import M3e.Content.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-menu>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { positionX : M3e.Value.Supported
    , positionY : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , submenu : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | menu : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Menu.menu
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| The position of the menu, on the x-axis. (default: `"after"`) -}
positionX :
    M3e.Value.Value { after : M3e.Value.Supported
    , before : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | positionX : M3e.Value.Supported } msg
positionX =
    M3e.Cem.Menu.positionX


{-| The position of the menu, on the y-axis. (default: `"below"`) -}
positionY :
    M3e.Value.Value { above : M3e.Value.Supported, below : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | positionY : M3e.Value.Supported } msg
positionY =
    M3e.Cem.Menu.positionY


{-| The appearance variant of the menu. (default: `"standard"`) -}
variant :
    M3e.Value.Value { standard : M3e.Value.Supported
    , vibrant : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.Menu.variant


{-| A value indicating whether the menu is a submenu. (default: `false`) -}
submenu : Bool -> M3e.Cem.Attr.Attr { c | submenu : M3e.Value.Supported } msg
submenu =
    M3e.Cem.Menu.submenu


{-| Listen for `beforetoggle` events. -}
onBeforetoggle :
    msg -> M3e.Cem.Attr.Attr { c | onBeforetoggle : M3e.Value.Supported } msg
onBeforetoggle =
    M3e.Cem.Menu.onBeforetoggle


{-| Listen for `toggle` events. -}
onToggle :
    (String -> msg)
    -> M3e.Cem.Attr.Attr { c | onToggle : M3e.Value.Supported } msg
onToggle =
    M3e.Cem.Menu.onToggle


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { menuItem : M3e.Value.Supported
    , menuItemCheckbox : M3e.Value.Supported
    , menuItemRadio : M3e.Value.Supported
    , menuItemGroup : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.Internal.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { menuItem : M3e.Value.Supported
    , menuItemCheckbox : M3e.Value.Supported
    , menuItemRadio : M3e.Value.Supported
    , menuItemGroup : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.Internal.slot "") els