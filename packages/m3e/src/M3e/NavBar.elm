module M3e.NavBar exposing
    ( view, mode, onChange, onBeforeinput, onInput, child
    , children
    )

{-|
A horizontal bar, typically used on smaller devices, that allows a user to switch between 3-5 views.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `change`: Dispatched when the selected state of an item changes.
- `beforeinput`: Dispatched before the selected state of an item changes.
- `input`: Dispatched when the selected state of an item changes.

<!-- elm-cem:docmeta category=Navigation -->

## Examples

### Examples

<!-- elm-cem:example title="Bottom navigation bar with selected destination" -->
```elm
Native.nav [] [ M3e.NavBar.view [ M3e.NavBar.mode M3e.Value.compact ] (M3e.NavBar.children [ M3e.NavItem.view [ M3e.NavItem.selected True ] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "home" ] []), M3e.NavItem.selectedIcon (M3e.Icon.view [ M3e.Icon.name "home", M3e.Icon.filled True ] []), M3e.NavItem.child (Kit.text "Home") ], M3e.NavItem.view [] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "search" ] []), M3e.NavItem.child (Kit.text "Explore") ], M3e.NavItem.view [] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "favorite" ] []), M3e.NavItem.selectedIcon (M3e.Icon.view [ M3e.Icon.name "favorite", M3e.Icon.filled True ] []), M3e.NavItem.child (Kit.text "Saved") ], M3e.NavItem.view [] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "person" ] []), M3e.NavItem.child (Kit.text "Profile") ] ]) ]
```

<!-- elm-cem:example title="Expanded nav bar linking to app sections" -->
```elm
Native.nav [] [ M3e.NavBar.view [ M3e.NavBar.mode M3e.Value.expanded ] (M3e.NavBar.children [ M3e.NavItem.view [ M3e.NavItem.href "/inbox", M3e.NavItem.selected True ] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "inbox" ] []), M3e.NavItem.child (Kit.text "Inbox") ], M3e.NavItem.view [ M3e.NavItem.href "/sent" ] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "send" ] []), M3e.NavItem.child (Kit.text "Sent") ], M3e.NavItem.view [ M3e.NavItem.href "/drafts" ] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "drafts" ] []), M3e.NavItem.child (Kit.text "Drafts") ], M3e.NavItem.view [ M3e.NavItem.href "/archive", M3e.NavItem.disabled True ] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "archive" ] []), M3e.NavItem.child (Kit.text "Archive") ] ]) ]
```

@docs view, mode, onChange, onBeforeinput, onInput, child
@docs children
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.NavBar
import M3e.Content
import M3e.Content.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-nav-bar>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { mode : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | navBar : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.NavBar.navBar
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| The mode in which items in the bar are presented. (default: `"compact"`) -}
mode :
    M3e.Value.Value { auto : M3e.Value.Supported
    , compact : M3e.Value.Supported
    , expanded : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
mode =
    M3e.Cem.NavBar.mode


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.NavBar.onChange


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    msg -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.NavBar.onBeforeinput


{-| Listen for `input` events. -}
onInput : msg -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.NavBar.onInput


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { navItem : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.Internal.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { navItem : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.Internal.slot "") els