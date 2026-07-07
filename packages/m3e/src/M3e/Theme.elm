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

<!-- elm-cem:example title="Color" -->
```elm
M3e.Theme.view [ M3e.Theme.color "#4285F4" ] [ M3e.Theme.child (Native.div [] [ Native.div [] [ Native.div [] [ Kit.text "Primary" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Primary" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Primary Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Primary Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Secondary" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Secondary" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Secondary Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Secondary Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Tertiary" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Tertiary" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Tertiary Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Tertiary Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Error" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Error" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Error Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Error Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Background" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Background" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Surface" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Surface" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Surface Variant" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Surface Variant" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Inverse Surface" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Inverse On Surface" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Outline" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Outline Variant" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Shadow" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Scrim" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Surface Tint" ], Native.div [] [] ] ]) ]
```

<!-- elm-cem:example title="Schemes" -->
```elm
M3e.Theme.view [ M3e.Theme.color "#4285F4", M3e.Theme.scheme M3e.Value.dark ] [ M3e.Theme.child (Native.div [] [ Native.div [] [ Native.div [] [ Native.div [] [ Kit.text "Primary" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Primary" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Primary Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Primary Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Secondary" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Secondary" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Secondary Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Secondary Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Tertiary" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Tertiary" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Tertiary Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Tertiary Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Error" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Error" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Error Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Error Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Background" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Background" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Surface" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Surface" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Surface Variant" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Surface Variant" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Inverse Surface" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Inverse On Surface" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Outline" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Outline Variant" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Shadow" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Scrim" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Surface Tint" ], Native.div [] [] ] ] ]) ]
```

<!-- elm-cem:example title="Contrast" -->
```elm
M3e.Theme.view [ M3e.Theme.color "#4285F4", M3e.Theme.contrast M3e.Value.high ] [ M3e.Theme.child (Native.div [] [ Native.div [] [ Native.div [] [ Kit.text "Primary" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Primary" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Primary Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Primary Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Secondary" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Secondary" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Secondary Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Secondary Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Tertiary" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Tertiary" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Tertiary Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Tertiary Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Error" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Error" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Error Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Error Container" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Background" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Background" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Surface" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Surface" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Surface Variant" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "On Surface Variant" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Inverse Surface" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Inverse On Surface" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Outline" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Outline Variant" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Shadow" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Scrim" ], Native.div [] [] ], Native.div [] [ Native.div [] [ Kit.text "Surface Tint" ], Native.div [] [] ] ]) ]
```

<!-- elm-cem:example title="Density" -->
```elm
[ M3e.Theme.view [ M3e.Theme.strongFocus True, M3e.Theme.density -3 ] [ M3e.Theme.child (M3e.Button.view [ M3e.Button.variant M3e.Value.filled, M3e.Button.size M3e.Value.medium ] [ M3e.Button.child (Kit.text "-3 density") ]) ]
    , M3e.Theme.view [ M3e.Theme.strongFocus True, M3e.Theme.density -2 ] [ M3e.Theme.child (M3e.Button.view [ M3e.Button.variant M3e.Value.filled, M3e.Button.size M3e.Value.medium ] [ M3e.Button.child (Kit.text "-2 density") ]) ]
    , M3e.Theme.view [ M3e.Theme.strongFocus True, M3e.Theme.density -1 ] [ M3e.Theme.child (M3e.Button.view [ M3e.Button.variant M3e.Value.filled, M3e.Button.size M3e.Value.medium ] [ M3e.Button.child (Kit.text "-1 density") ]) ]
    , M3e.Theme.view [ M3e.Theme.strongFocus True, M3e.Theme.density 0 ] [ M3e.Theme.child (M3e.Button.view [ M3e.Button.variant M3e.Value.filled, M3e.Button.size M3e.Value.medium ] [ M3e.Button.child (Kit.text "0 (default) density") ]) ]
    , M3e.Theme.view [ M3e.Theme.strongFocus True, M3e.Theme.density 1 ] [ M3e.Theme.child (M3e.Button.view [ M3e.Button.variant M3e.Value.filled, M3e.Button.size M3e.Value.medium ] [ M3e.Button.child (Kit.text "1 density") ]) ]
    ]
```

### Motion

<!-- elm-cem:example title="Motion" -->
```elm
[ M3e.Theme.view [ M3e.Theme.strongFocus True, M3e.Theme.motion M3e.Value.standard ] [ M3e.Theme.child (Native.node Html.label [] [ Kit.text "Standard", M3e.Switch.view [] [] ]) ]
    , M3e.Theme.view [ M3e.Theme.strongFocus True, M3e.Theme.motion M3e.Value.expressive ] [ M3e.Theme.child (Native.node Html.label [] [ Kit.text "Expressive", M3e.Switch.view [] [] ]) ]
    ]
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