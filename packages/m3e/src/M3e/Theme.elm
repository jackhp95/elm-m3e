module M3e.Theme exposing
    ( view, color, contrast, density, scheme, strongFocus
    , variant, motion, onChange, child, children
    )

{-|
A non-visual element responsible for application-level theming.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `change`: Dispatched when the theme changes.

<!-- elm-cem:docmeta category=Layout & style -->

## Examples

### Examples

<!-- elm-cem:example title="Theme with drawer, nav menu, and app bar shell" -->
```elm
M3e.Theme.view [ M3e.Theme.color "#8B6F47", M3e.Theme.scheme M3e.Value.auto, M3e.Theme.contrast M3e.Value.standard, M3e.Theme.motion M3e.Value.expressive, M3e.Theme.strongFocus True ] [ M3e.Theme.child (M3e.DrawerContainer.view [ M3e.DrawerContainer.startMode M3e.Value.over ] [ M3e.DrawerContainer.startSlot (Native.nav [] [ M3e.NavMenu.view [] [ M3e.NavMenu.child (M3e.NavMenuItem.view [ M3e.NavMenuItem.selected True ] [ M3e.NavMenuItem.child (Kit.link "/photos" [ Kit.text "Photos" ]), M3e.NavMenuItem.icon (M3e.Icon.view [ M3e.Icon.name "photo_library" ] []) ]) ] ]), M3e.DrawerContainer.child (M3e.AppBar.view [] [ M3e.AppBar.leading (M3e.IconButton.view [ M3e.Aria.label "Back" ] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "arrow_back" ] []) ]), M3e.AppBar.title (Kit.text "Title") ]) ]) ]
```

@docs view, color, contrast, density, scheme, strongFocus
@docs variant, motion, onChange, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Theme
import M3e.Content
import M3e.Content.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-theme>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { color : M3e.Value.Supported
    , contrast : M3e.Value.Supported
    , density : M3e.Value.Supported
    , scheme : M3e.Value.Supported
    , strongFocus : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , motion : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | theme : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Theme.theme
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| The hex color from which to derive dynamic color palettes. (default: `"#6750A4"`) -}
color : String -> M3e.Cem.Attr.Attr { c | color : M3e.Value.Supported } msg
color =
    M3e.Cem.Theme.color


{-| The contrast level of the theme. (default: `"standard"`) -}
contrast :
    M3e.Value.Value { high : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | contrast : M3e.Value.Supported } msg
contrast =
    M3e.Cem.Theme.contrast


{-| The density scale (0, -1, -2). (default: `0`) -}
density : Float -> M3e.Cem.Attr.Attr { c | density : M3e.Value.Supported } msg
density =
    M3e.Cem.Theme.density


{-| The color scheme of the theme. (default: `"auto"`) -}
scheme :
    M3e.Value.Value { auto : M3e.Value.Supported
    , dark : M3e.Value.Supported
    , light : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | scheme : M3e.Value.Supported } msg
scheme =
    M3e.Cem.Theme.scheme


{-| Whether to enable strong focus indicators. (default: `false`) -}
strongFocus :
    Bool -> M3e.Cem.Attr.Attr { c | strongFocus : M3e.Value.Supported } msg
strongFocus =
    M3e.Cem.Theme.strongFocus


{-| The color variant of the theme. (default: `"neutral"`) -}
variant :
    M3e.Value.Value { content : M3e.Value.Supported
    , expressive : M3e.Value.Supported
    , fidelity : M3e.Value.Supported
    , fruitSalad : M3e.Value.Supported
    , monochrome : M3e.Value.Supported
    , neutral : M3e.Value.Supported
    , rainbow : M3e.Value.Supported
    , tonalSpot : M3e.Value.Supported
    , vibrant : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.Theme.variant


{-| The motion scheme. (default: `"standard"`) -}
motion :
    M3e.Value.Value { expressive : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | motion : M3e.Value.Supported } msg
motion =
    M3e.Cem.Theme.motion


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.Theme.onChange


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.Internal.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element any msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.Internal.slot "") els