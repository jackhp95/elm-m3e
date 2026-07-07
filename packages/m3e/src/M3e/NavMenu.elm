module M3e.NavMenu exposing ( view, child, children )

{-|
A hierarchical menu, typically used on larger devices, that allows a user to switch between views.

**Component Info:**
- **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Navigation -->

## Examples

### Examples

<!-- elm-cem:example title="Multilevel menus" -->
```elm
M3e.NavMenu.view [] (M3e.NavMenu.children [ M3e.NavMenuItem.view [ M3e.NavMenuItem.open True ] ([ M3e.NavMenuItem.label (Kit.text "Getting Started"), M3e.NavMenuItem.icon (M3e.Icon.view [ M3e.Icon.name "rocket_launch", M3e.Aria.hidden "true" ] []) ] ++ M3e.NavMenuItem.children [ M3e.NavMenuItem.view [] [ M3e.NavMenuItem.label (Kit.text "Overview"), M3e.NavMenuItem.icon (M3e.Icon.view [ M3e.Icon.name "widgets", M3e.Aria.hidden "true" ] []) ], M3e.NavMenuItem.view [] [ M3e.NavMenuItem.label (Kit.text "Installation"), M3e.NavMenuItem.icon (M3e.Icon.view [ M3e.Icon.name "package_2", M3e.Aria.hidden "true" ] []) ] ]), M3e.NavMenuItem.view [] ([ M3e.NavMenuItem.label (Kit.text "Actions") ] ++ M3e.NavMenuItem.children [ M3e.NavMenuItem.view [] [ M3e.NavMenuItem.label (Kit.text "Button") ], M3e.NavMenuItem.view [] [ M3e.NavMenuItem.label (Kit.text "Icon") ], M3e.NavMenuItem.view [] [ M3e.NavMenuItem.label (Kit.text "Icon Button") ] ]) ])
```

<!-- elm-cem:example title="Disabling" -->
```elm
M3e.NavMenu.view [] (M3e.NavMenu.children [ M3e.NavMenuItem.view [ M3e.NavMenuItem.open True, M3e.NavMenuItem.disabled True ] ([ M3e.NavMenuItem.label (Kit.text "Getting Started"), M3e.NavMenuItem.icon (M3e.Icon.view [ M3e.Icon.name "rocket_launch", M3e.Aria.hidden "true" ] []) ] ++ M3e.NavMenuItem.children [ M3e.NavMenuItem.view [] [ M3e.NavMenuItem.label (Kit.text "Overview"), M3e.NavMenuItem.icon (M3e.Icon.view [ M3e.Icon.name "widgets", M3e.Aria.hidden "true" ] []) ], M3e.NavMenuItem.view [] [ M3e.NavMenuItem.label (Kit.text "Installation"), M3e.NavMenuItem.icon (M3e.Icon.view [ M3e.Icon.name "package_2", M3e.Aria.hidden "true" ] []) ] ]), M3e.NavMenuItem.view [ M3e.NavMenuItem.open True ] ([ M3e.NavMenuItem.label (Kit.text "Actions") ] ++ M3e.NavMenuItem.children [ M3e.NavMenuItem.view [ M3e.NavMenuItem.disabled True ] [ M3e.NavMenuItem.label (Kit.text "Button") ], M3e.NavMenuItem.view [] [ M3e.NavMenuItem.label (Kit.text "Icon") ], M3e.NavMenuItem.view [] [ M3e.NavMenuItem.label (Kit.text "Icon Button") ] ]) ])
```

@docs view, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.NavMenu
import M3e.Content
import M3e.Content.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-nav-menu>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | navMenu : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.NavMenu.navMenu
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { navMenuItem : M3e.Value.Supported
    , navMenuItemGroup : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.Internal.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { navMenuItem : M3e.Value.Supported
    , navMenuItemGroup : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.Internal.slot "") els