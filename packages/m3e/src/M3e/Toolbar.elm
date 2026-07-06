module M3e.Toolbar exposing
    ( view, elevated, shape, variant, vertical, child
    , children
    )

{-|
Presents frequently used actions relevant to the current page.

**Component Info:**
- **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Containment -->

## Examples

### Examples

<!-- elm-cem:example title="Vibrant rounded media controls toolbar" -->
```elm
M3e.Toolbar.view [ M3e.Toolbar.variant M3e.Value.vibrant, M3e.Toolbar.shape M3e.Value.rounded ] (M3e.Toolbar.children [ M3e.Button.view [ M3e.Button.variant M3e.Value.text ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "skip_previous" ] []) ], M3e.Button.view [ M3e.Button.variant M3e.Value.filled ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "play_arrow" ] []) ], M3e.Button.view [ M3e.Button.variant M3e.Value.text ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "skip_next" ] []) ] ])
```

<!-- elm-cem:example title="Elevated vertical editing toolbar" -->
```elm
M3e.Toolbar.view [ M3e.Toolbar.vertical True, M3e.Toolbar.elevated True, M3e.Toolbar.shape M3e.Value.square ] (M3e.Toolbar.children [ M3e.Button.view [ M3e.Button.variant M3e.Value.text ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "format_bold" ] []) ], M3e.Button.view [ M3e.Button.variant M3e.Value.text ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "format_italic" ] []) ], M3e.Button.view [ M3e.Button.variant M3e.Value.text ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "format_underlined" ] []) ] ])
```

@docs view, elevated, shape, variant, vertical, child
@docs children
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Toolbar
import M3e.Content
import M3e.Content.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-toolbar>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { elevated : M3e.Value.Supported
    , shape : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | toolbar : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Toolbar.toolbar
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| Whether the toolbar is elevated. (default: `false`) -}
elevated : Bool -> M3e.Cem.Attr.Attr { c | elevated : M3e.Value.Supported } msg
elevated =
    M3e.Cem.Toolbar.elevated


{-| The shape of the toolbar. (default: `"square"`) -}
shape :
    M3e.Value.Value { rounded : M3e.Value.Supported
    , square : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | shape : M3e.Value.Supported } msg
shape =
    M3e.Cem.Toolbar.shape


{-| The appearance variant of the toolbar. (default: `"standard"`) -}
variant :
    M3e.Value.Value { standard : M3e.Value.Supported
    , vibrant : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.Toolbar.variant


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical : Bool -> M3e.Cem.Attr.Attr { c | vertical : M3e.Value.Supported } msg
vertical =
    M3e.Cem.Toolbar.vertical


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