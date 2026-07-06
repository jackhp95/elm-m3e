module M3e.ButtonGroup exposing
    ( view, multi, size, variant, child, children
    )

{-|
Organizes buttons and adds interactions between them.

**Component Info:**
- **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Actions -->

## Examples

### Examples

<!-- elm-cem:example title="Standard" -->
```elm
M3e.ButtonGroup.view [] (M3e.ButtonGroup.children [ M3e.IconButton.view [] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "arrow_back" ] []) ], M3e.IconButton.view [] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "arrow_forward" ] []) ], M3e.IconButton.view [ M3e.IconButton.width M3e.Value.wide, M3e.IconButton.variant M3e.Value.filled ] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ], M3e.IconButton.view [] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "picture_in_picture" ] []) ], M3e.IconButton.view [] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "more_vert" ] []) ] ])
```

<!-- elm-cem:example title="Standard (2)" -->
```elm
M3e.ButtonGroup.view [] (M3e.ButtonGroup.children [ M3e.Button.view [ M3e.Button.variant M3e.Value.tonal ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "play_arrow" ] []), M3e.Button.child (Kit.text "Start") ], M3e.Button.view [ M3e.Button.variant M3e.Value.tonal ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "directions_car" ] []), M3e.Button.child (Kit.text "Directions") ], M3e.Button.view [ M3e.Button.variant M3e.Value.tonal ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "share" ] []), M3e.Button.child (Kit.text "Share") ] ])
```

<!-- elm-cem:example title="Standard (3)" -->
```elm
M3e.ButtonGroup.view [] (M3e.ButtonGroup.children [ M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.filled, M3e.IconButton.width M3e.Value.wide ] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "fast_rewind" ] []) ], M3e.Button.view [ M3e.Button.variant M3e.Value.filled ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "play_arrow" ] []), M3e.Button.child (Kit.text "Play") ], M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.filled, M3e.IconButton.width M3e.Value.wide ] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "fast_forward" ] []) ] ])
```

<!-- elm-cem:example title="Connected" -->
```elm
M3e.ButtonGroup.view [ M3e.ButtonGroup.variant M3e.Value.connected ] (M3e.ButtonGroup.children [ M3e.Button.view [ M3e.Button.variant M3e.Value.tonal, M3e.Button.toggle True ] [ M3e.Button.child (Kit.text "Start") ], M3e.Button.view [ M3e.Button.variant M3e.Value.tonal, M3e.Button.toggle True ] [ M3e.Button.child (Kit.text "Directions") ], M3e.Button.view [ M3e.Button.variant M3e.Value.tonal, M3e.Button.toggle True ] [ M3e.Button.child (Kit.text "Share") ] ])
```

<!-- elm-cem:example title="Sizes" -->
```elm
M3e.ButtonGroup.view [ M3e.ButtonGroup.size M3e.Value.large ] (M3e.ButtonGroup.children [ M3e.IconButton.view [ M3e.IconButton.size M3e.Value.large ] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "arrow_back" ] []) ], M3e.IconButton.view [ M3e.IconButton.size M3e.Value.large ] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "arrow_forward" ] []) ], M3e.IconButton.view [ M3e.IconButton.size M3e.Value.large, M3e.IconButton.width M3e.Value.wide, M3e.IconButton.variant M3e.Value.filled ] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "add" ] []) ], M3e.IconButton.view [ M3e.IconButton.size M3e.Value.large ] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "picture_in_picture" ] []) ], M3e.IconButton.view [ M3e.IconButton.size M3e.Value.large ] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "more_vert" ] []) ] ])
```

<!-- elm-cem:example title="Sizes (2)" -->
```elm
M3e.ButtonGroup.view [ M3e.ButtonGroup.size M3e.Value.large, M3e.ButtonGroup.variant M3e.Value.connected ] (M3e.ButtonGroup.children [ M3e.Button.view [ M3e.Button.variant M3e.Value.tonal, M3e.Button.size M3e.Value.large, M3e.Button.toggle True ] [ M3e.Button.child (Kit.text "Start") ], M3e.Button.view [ M3e.Button.variant M3e.Value.tonal, M3e.Button.size M3e.Value.large, M3e.Button.toggle True ] [ M3e.Button.child (Kit.text "Directions") ], M3e.Button.view [ M3e.Button.variant M3e.Value.tonal, M3e.Button.size M3e.Value.large, M3e.Button.toggle True ] [ M3e.Button.child (Kit.text "Share") ] ])
```

<!-- elm-cem:example title="Selection" -->
```elm
M3e.ButtonGroup.view [ M3e.ButtonGroup.multi True ] (M3e.ButtonGroup.children [ M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.tonal, M3e.IconButton.toggle True ] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "format_bold" ] []) ], M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.tonal, M3e.IconButton.toggle True ] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "format_italic" ] []) ], M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.tonal, M3e.IconButton.toggle True ] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "format_underlined" ] []) ] ])
```

<!-- elm-cem:example title="Density" -->
```elm
M3e.ButtonGroup.view [] []
```

@docs view, multi, size, variant, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.ButtonGroup
import M3e.Content
import M3e.Content.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-button-group>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { multi : M3e.Value.Supported
    , size : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | buttonGroup : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.ButtonGroup.buttonGroup
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| Whether multiple toggle buttons can be selected. (default: `false`) -}
multi : Bool -> M3e.Cem.Attr.Attr { c | multi : M3e.Value.Supported } msg
multi =
    M3e.Cem.ButtonGroup.multi


{-| The size of the group. (default: `"small"`) -}
size :
    M3e.Value.Value { extraLarge : M3e.Value.Supported
    , extraSmall : M3e.Value.Supported
    , large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
size =
    M3e.Cem.ButtonGroup.size


{-| The appearance variant of the group. (default: `"standard"`) -}
variant :
    M3e.Value.Value { connected : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.ButtonGroup.variant


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { button : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.Internal.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { button : M3e.Value.Supported
    , iconButton : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.Internal.slot "") els