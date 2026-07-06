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

<!-- elm-cem:docmeta category=Navigation -->

## Examples

### Examples

<!-- elm-cem:example title="Basic action menu triggered from a button" -->
```elm
[ M3e.Record.Button.view { content = Kit.text "File", action = M3e.Action.opensMenu "file-menu" } [ M3e.Record.Button.variant M3e.Value.outlined ] [ M3e.Record.Button.trailingIcon (M3e.Icon.view [ M3e.Icon.name "arrow_drop_down" ] []) ]
    , M3e.Menu.view [] (M3e.Menu.children [ M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "note_add" ] []), M3e.MenuItem.child (Kit.text "New document") ], M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "folder_open" ] []), M3e.MenuItem.child (Kit.text "Open") ], M3e.MenuItem.view [ M3e.MenuItem.disabled True ] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "save" ] []), M3e.MenuItem.child (Kit.text "Save") ] ])
    ]
```

<!-- elm-cem:example title="View menu with checkbox and radio selection groups" -->
```elm
[ M3e.Record.Button.view { content = Kit.text "View", action = M3e.Action.opensMenu "view-menu" } [ M3e.Record.Button.variant M3e.Value.text ] []
    , M3e.Menu.view [ M3e.Menu.variant M3e.Value.vibrant ] (M3e.Menu.children [ M3e.MenuItemCheckbox.view [ M3e.MenuItemCheckbox.checked True ] [ M3e.MenuItemCheckbox.child (Kit.text "Show sidebar") ], M3e.MenuItemCheckbox.view [] [ M3e.MenuItemCheckbox.child (Kit.text "Show status bar") ], M3e.Divider.view [] [], M3e.MenuItemGroup.view [] (M3e.MenuItemGroup.children [ M3e.MenuItemRadio.view [ M3e.MenuItemRadio.checked True ] [ M3e.MenuItemRadio.child (Kit.text "Comfortable") ], M3e.MenuItemRadio.view [] [ M3e.MenuItemRadio.child (Kit.text "Cozy") ], M3e.MenuItemRadio.view [] [ M3e.MenuItemRadio.child (Kit.text "Compact") ] ]) ])
    ]
```

<!-- elm-cem:example title="Nested submenu for sharing options" -->
```elm
[ M3e.Record.Button.view { content = Kit.text "Share", action = M3e.Action.opensMenu "share-menu" } [ M3e.Record.Button.variant M3e.Value.filled ] []
    , M3e.Menu.view [] (M3e.Menu.children [ M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "link" ] []), M3e.MenuItem.child (Kit.text "Copy link") ], M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "group" ] []), M3e.MenuItem.trailingIcon (M3e.Icon.view [ M3e.Icon.name "chevron_right" ] []), M3e.MenuItem.child (M3e.MenuTrigger.view [ M3e.MenuTrigger.for "people-menu" ] [ M3e.MenuTrigger.child (Kit.text "Share with people") ]) ] ])
    , M3e.Menu.view [ M3e.Menu.submenu True, M3e.Menu.positionX M3e.Value.after ] (M3e.Menu.children [ M3e.MenuItem.view [] [ M3e.MenuItem.child (Kit.text "Alex Chen") ], M3e.MenuItem.view [] [ M3e.MenuItem.child (Kit.text "Jordan Lee") ], M3e.MenuItem.view [] [ M3e.MenuItem.child (Kit.text "Sam Rivera") ] ])
    ]
```

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