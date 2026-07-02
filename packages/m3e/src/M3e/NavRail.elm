module M3e.NavRail exposing
    ( view, mode, onBeforeinput, onInput, onChange, child
    , children
    )

{-|
A vertical bar, typically used on larger devices, that allows a user to switch between views.

**Events:**
- `beforeinput`: Dispatched before the selected state of an item changes.
- `input`: Dispatched when the selected state of an item changes.
- `change`: Dispatched when the selected state of an item changes.

<!-- elm-cem:docmeta category=Navigation -->

## Examples

### Examples

<!-- elm-cem:example title="Collapsible navigation rail with toggle" -->
```elm
M3e.NavRail.view [ M3e.NavRail.mode M3e.Value.auto ] (M3e.NavRail.children [ M3e.Button.view [ M3e.Button.toggle True ] ([ M3e.Button.selectedSlot (M3e.Icon.view [ M3e.Icon.name "menu_open" ] []) ] ++ M3e.Button.children [ M3e.Icon.view [ M3e.Icon.name "menu" ] [], M3e.NavRailToggle.view [ M3e.NavRailToggle.for "main-rail" ] [] ]), M3e.NavItem.view [ M3e.NavItem.selected True ] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "dashboard" ] []), M3e.NavItem.child (Kit.text "Dashboard") ], M3e.NavItem.view [] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "folder" ] []), M3e.NavItem.child (Kit.text "Projects") ], M3e.NavItem.view [] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "insights" ] []), M3e.NavItem.child (Kit.text "Reports") ], M3e.NavItem.view [] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "settings" ] []), M3e.NavItem.child (Kit.text "Settings") ] ])
```

<!-- elm-cem:example title="Expanded navigation rail with link destinations" -->
```elm
M3e.NavRail.view [ M3e.NavRail.mode M3e.Value.expanded ] (M3e.NavRail.children [ M3e.NavItem.view [ M3e.NavItem.href "/overview", M3e.NavItem.selected True ] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "home" ] []), M3e.NavItem.selectedIcon (M3e.Icon.view [ M3e.Icon.name "home", M3e.Icon.filled True ] []), M3e.NavItem.child (Kit.text "Overview") ], M3e.NavItem.view [ M3e.NavItem.href "/components" ] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "widgets" ] []), M3e.NavItem.child (Kit.text "Components") ], M3e.NavItem.view [ M3e.NavItem.href "/guides" ] [ M3e.NavItem.icon (M3e.Icon.view [ M3e.Icon.name "menu_book" ] []), M3e.NavItem.child (Kit.text "Guides") ] ])
```

@docs view, mode, onBeforeinput, onInput, onChange, child
@docs children
-}


import M3e.Cem.Attr
import M3e.Cem.NavRail
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-nav-rail>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { mode : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | navRail : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.NavRail.navRail
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| The mode in which items in the rail are presented. (default: `"compact"`) -}
mode :
    M3e.Value.Value { auto : M3e.Value.Supported
    , compact : M3e.Value.Supported
    , expanded : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
mode =
    M3e.Cem.NavRail.mode


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    msg -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.NavRail.onBeforeinput


{-| Listen for `input` events. -}
onInput : msg -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.NavRail.onInput


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.NavRail.onChange


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element any msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els