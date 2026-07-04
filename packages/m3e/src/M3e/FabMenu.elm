module M3e.FabMenu exposing
    ( view, variant, onBeforetoggle, onToggle, child, children
    )

{-|
A menu, opened from a floating action button (FAB), used to display multiple related actions.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `beforetoggle`: Dispatched before the toggle state changes.
- `toggle`: Dispatched after the toggle state has changed.

<!-- elm-cem:docmeta category=Actions -->

## Examples

### Examples

<!-- elm-cem:example title="Primary FAB revealing a secondary action menu" -->
```elm
[ M3e.Record.Button.view { content = Kit.text "Compose", action = M3e.Action.opensFabMenu "compose-menu" } [ M3e.Record.Button.variant M3e.Value.filled, M3e.Record.Button.size M3e.Value.large ] [ M3e.Record.Button.icon (M3e.Icon.view [ M3e.Icon.name "edit" ] []) ]
    , M3e.FabMenu.view [ M3e.FabMenu.variant M3e.Value.secondary ] (M3e.FabMenu.children [ M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "mail" ] []), M3e.MenuItem.child (Kit.text "New email") ], M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "event" ] []), M3e.MenuItem.child (Kit.text "New event") ], M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "group" ] []), M3e.MenuItem.child (Kit.text "New group") ] ])
    ]
```

<!-- elm-cem:example title="Tertiary FAB menu with link and disabled items" -->
```elm
[ M3e.Record.Button.view { content = M3e.Icon.view [ M3e.Icon.name "share" ] [], action = M3e.Action.opensFabMenu "share-menu" } [ M3e.Record.Button.variant M3e.Value.tonal, M3e.Record.Button.size M3e.Value.large ] []
    , M3e.FabMenu.view [ M3e.FabMenu.variant M3e.Value.tertiary ] (M3e.FabMenu.children [ M3e.MenuItem.view [ M3e.MenuItem.href "https://example.com/link", M3e.MenuItem.target "_blank" ] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "link" ] []), M3e.MenuItem.child (Kit.text "Copy link") ], M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "download" ] []), M3e.MenuItem.child (Kit.text "Export PDF") ], M3e.MenuItem.view [ M3e.MenuItem.disabled True ] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "print" ] []), M3e.MenuItem.child (Kit.text "Print") ] ])
    ]
```

@docs view, variant, onBeforetoggle, onToggle, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.FabMenu
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-fab-menu>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | fabMenu : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.FabMenu.fabMenu
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| The appearance variant of the menu. (default: `"primary"`) -}
variant :
    M3e.Value.Value { primary : M3e.Value.Supported
    , secondary : M3e.Value.Supported
    , tertiary : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.FabMenu.variant


{-| Listen for `beforetoggle` events. -}
onBeforetoggle :
    msg -> M3e.Cem.Attr.Attr { c | onBeforetoggle : M3e.Value.Supported } msg
onBeforetoggle =
    M3e.Cem.FabMenu.onBeforetoggle


{-| Listen for `toggle` events. -}
onToggle : msg -> M3e.Cem.Attr.Attr { c | onToggle : M3e.Value.Supported } msg
onToggle =
    M3e.Cem.FabMenu.onToggle


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { fabMenuItem : M3e.Value.Supported
    , menuItem : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { fabMenuItem : M3e.Value.Supported
    , menuItem : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els