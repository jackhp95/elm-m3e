module M3e.Theme exposing
    ( view, color, contrast, density, scheme, strongFocus
    , variant, motion, onChange
    )

{-| A non-visual element responsible for application-level theming.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `change`: Dispatched when the theme changes.

<!-- elm-cem:docmeta category=Layout & style -->


## Examples


### Examples

<!-- elm-cem:example title="Color" -->
```elm
M3e.Theme.view [ M3e.Theme.color "#4285F4" ] [ Native.div [ Native.attribute "class" "swatch-grid" ] [ Native.div [ Native.attribute "class" "swatch primary" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Primary" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-primary" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Primary" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch primary-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Primary Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-primary-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Primary Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch secondary" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Secondary" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-secondary" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Secondary" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch secondary-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Secondary Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-secondary-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Secondary Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch tertiary" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Tertiary" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-tertiary" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Tertiary" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch tertiary-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Tertiary Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-tertiary-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Tertiary Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch error" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Error" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-error" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Error" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch error-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Error Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-error-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Error Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch background" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Background" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-background" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Background" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch surface" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Surface" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-surface" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Surface" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch surface-variant" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Surface Variant" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-surface-variant" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Surface Variant" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch inverse-surface" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Inverse Surface" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch inverse-on-surface" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Inverse On Surface" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch outline" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Outline" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch outline-variant" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Outline Variant" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch shadow" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Shadow" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch scrim" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Scrim" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch surface-tint" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Surface Tint" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ] ] ]
```

<!-- elm-cem:example title="Schemes" -->
```elm
M3e.Theme.view [ M3e.Theme.color "#4285F4", M3e.Theme.scheme M3e.Token.dark ] [ Native.div [ Native.attribute "class" "dark-example" ] [ Native.div [ Native.attribute "class" "swatch-grid" ] [ Native.div [ Native.attribute "class" "swatch primary" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Primary" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-primary" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Primary" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch primary-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Primary Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-primary-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Primary Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch secondary" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Secondary" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-secondary" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Secondary" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch secondary-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Secondary Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-secondary-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Secondary Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch tertiary" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Tertiary" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-tertiary" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Tertiary" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch tertiary-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Tertiary Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-tertiary-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Tertiary Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch error" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Error" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-error" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Error" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch error-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Error Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-error-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Error Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch background" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Background" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-background" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Background" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch surface" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Surface" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-surface" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Surface" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch surface-variant" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Surface Variant" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-surface-variant" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Surface Variant" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch inverse-surface" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Inverse Surface" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch inverse-on-surface" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Inverse On Surface" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch outline" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Outline" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch outline-variant" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Outline Variant" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch shadow" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Shadow" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch scrim" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Scrim" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch surface-tint" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Surface Tint" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ] ] ] ]
```

<!-- elm-cem:example title="Contrast" -->
```elm
M3e.Theme.view [ M3e.Theme.color "#4285F4", M3e.Theme.contrast M3e.Token.high ] [ Native.div [ Native.attribute "class" "swatch-grid" ] [ Native.div [ Native.attribute "class" "swatch primary" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Primary" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-primary" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Primary" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch primary-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Primary Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-primary-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Primary Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch secondary" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Secondary" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-secondary" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Secondary" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch secondary-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Secondary Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-secondary-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Secondary Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch tertiary" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Tertiary" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-tertiary" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Tertiary" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch tertiary-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Tertiary Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-tertiary-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Tertiary Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch error" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Error" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-error" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Error" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch error-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Error Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-error-container" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Error Container" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch background" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Background" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-background" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Background" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch surface" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Surface" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-surface" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Surface" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch surface-variant" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Surface Variant" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch on-surface-variant" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "On Surface Variant" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch inverse-surface" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Inverse Surface" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch inverse-on-surface" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Inverse On Surface" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch outline" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Outline" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch outline-variant" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Outline Variant" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch shadow" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Shadow" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch scrim" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Scrim" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ], Native.div [ Native.attribute "class" "swatch surface-tint" ] [ Native.div [ Native.attribute "class" "swatch-label" ] [ Kit.text "Surface Tint" ], Native.div [ Native.attribute "class" "swatch-box" ] [] ] ] ]
```

<!-- elm-cem:example title="Density" -->
```elm
[ M3e.Theme.view [ M3e.Theme.strongFocus True, M3e.Theme.density -3 ] [ M3e.Button.view [ M3e.Button.variant M3e.Token.filled, M3e.Button.size M3e.Token.medium ] [ Kit.text "-3 density" ] ]
    , M3e.Theme.view [ M3e.Theme.strongFocus True, M3e.Theme.density -2 ] [ M3e.Button.view [ M3e.Button.variant M3e.Token.filled, M3e.Button.size M3e.Token.medium ] [ Kit.text "-2 density" ] ]
    , M3e.Theme.view [ M3e.Theme.strongFocus True, M3e.Theme.density -1 ] [ M3e.Button.view [ M3e.Button.variant M3e.Token.filled, M3e.Button.size M3e.Token.medium ] [ Kit.text "-1 density" ] ]
    , M3e.Theme.view [ M3e.Theme.strongFocus True, M3e.Theme.density 0 ] [ M3e.Button.view [ M3e.Button.variant M3e.Token.filled, M3e.Button.size M3e.Token.medium ] [ Kit.text "0 (default) density" ] ]
    , M3e.Theme.view [ M3e.Theme.strongFocus True, M3e.Theme.density 1 ] [ M3e.Button.view [ M3e.Button.variant M3e.Token.filled, M3e.Button.size M3e.Token.medium ] [ Kit.text "1 density" ] ]
    ]
```


### Motion

<!-- elm-cem:example title="Motion" -->
```elm
[ M3e.Theme.view [ M3e.Theme.strongFocus True, M3e.Theme.motion M3e.Token.standard ] [ Native.node Html.label [] [ Kit.text "Standard", M3e.Switch.view [] [] ] ]
    , M3e.Theme.view [ M3e.Theme.strongFocus True, M3e.Theme.motion M3e.Token.expressive ] [ Native.node Html.label [] [ Kit.text "Expressive", M3e.Switch.view [] [] ] ]
    ]
```

@docs view, color, contrast, density, scheme, strongFocus
@docs variant, motion, onChange

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.Theme
import M3e.Node
import M3e.Token


{-| Build the `<m3e-theme>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { color : M3e.Token.Supported
            , contrast : M3e.Token.Supported
            , density : M3e.Token.Supported
            , scheme : M3e.Token.Supported
            , strongFocus : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , motion : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | theme : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.Theme.theme
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| The hex color from which to derive dynamic color palettes. (default: `"#6750A4"`)
-}
color : String -> M3e.Html.Attr.Attr { c | color : M3e.Token.Supported } msg
color =
    M3e.Html.Theme.color


{-| The contrast level of the theme. (default: `"standard"`)
-}
contrast :
    M3e.Token.Value
        { high : M3e.Token.Supported
        , medium : M3e.Token.Supported
        , standard : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | contrast : M3e.Token.Supported } msg
contrast =
    M3e.Html.Theme.contrast


{-| The density scale (0, -1, -2). (default: `0`)
-}
density : Float -> M3e.Html.Attr.Attr { c | density : M3e.Token.Supported } msg
density =
    M3e.Html.Theme.density


{-| The color scheme of the theme. (default: `"auto"`)
-}
scheme :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , dark : M3e.Token.Supported
        , light : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | scheme : M3e.Token.Supported } msg
scheme =
    M3e.Html.Theme.scheme


{-| Whether to enable strong focus indicators. (default: `false`)
-}
strongFocus : Bool -> M3e.Html.Attr.Attr { c | strongFocus : M3e.Token.Supported } msg
strongFocus =
    M3e.Html.Theme.strongFocus


{-| The color variant of the theme. (default: `"neutral"`)
-}
variant :
    M3e.Token.Value
        { content : M3e.Token.Supported
        , expressive : M3e.Token.Supported
        , fidelity : M3e.Token.Supported
        , fruitSalad : M3e.Token.Supported
        , monochrome : M3e.Token.Supported
        , neutral : M3e.Token.Supported
        , rainbow : M3e.Token.Supported
        , tonalSpot : M3e.Token.Supported
        , vibrant : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.Theme.variant


{-| The motion scheme. (default: `"standard"`)
-}
motion :
    M3e.Token.Value
        { expressive : M3e.Token.Supported
        , standard : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | motion : M3e.Token.Supported } msg
motion =
    M3e.Html.Theme.motion


{-| Listen for `change` events.
-}
onChange : msg -> M3e.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.Theme.onChange
