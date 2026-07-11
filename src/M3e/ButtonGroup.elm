module M3e.ButtonGroup exposing (view, multi, size, variant)

{-| Organizes buttons and adds interactions between them.

**Component Info:**

  - **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Actions -->


## Examples


### Examples

<!-- elm-cem:example title="Standard" -->
```elm
M3e.ButtonGroup.view [] [ M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "arrow_back" ] [] ], M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "arrow_forward" ] [] ], M3e.IconButton.view [ M3e.IconButton.width M3e.Token.wide, M3e.IconButton.variant M3e.Token.filled ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ], M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "picture_in_picture" ] [] ], M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "more_vert" ] [] ] ]
```

<!-- elm-cem:example title="Standard (2)" -->
```elm
M3e.ButtonGroup.view [] [ M3e.Button.view [ M3e.Button.variant M3e.Token.tonal ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "play_arrow" ] []), Kit.text "Start" ], M3e.Button.view [ M3e.Button.variant M3e.Token.tonal ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "directions_car" ] []), Kit.text "Directions" ], M3e.Button.view [ M3e.Button.variant M3e.Token.tonal ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "share" ] []), Kit.text "Share" ] ]
```

<!-- elm-cem:example title="Standard (3)" -->
```elm
M3e.ButtonGroup.view [] [ M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.filled, M3e.IconButton.width M3e.Token.wide ] [ M3e.Icon.view [ M3e.Icon.name "fast_rewind" ] [] ], M3e.Button.view [ M3e.Button.variant M3e.Token.filled ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "play_arrow" ] []), Kit.text "Play" ], M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.filled, M3e.IconButton.width M3e.Token.wide ] [ M3e.Icon.view [ M3e.Icon.name "fast_forward" ] [] ] ]
```

<!-- elm-cem:example title="Connected" -->
```elm
M3e.ButtonGroup.view [ M3e.ButtonGroup.variant M3e.Token.connected ] [ M3e.Button.view [ M3e.Button.variant M3e.Token.tonal, M3e.Button.toggle True ] [ Kit.text "Start" ], M3e.Button.view [ M3e.Button.variant M3e.Token.tonal, M3e.Button.toggle True ] [ Kit.text "Directions" ], M3e.Button.view [ M3e.Button.variant M3e.Token.tonal, M3e.Button.toggle True ] [ Kit.text "Share" ] ]
```

<!-- elm-cem:example title="Sizes" -->
```elm
M3e.ButtonGroup.view [ M3e.ButtonGroup.size M3e.Token.large ] [ M3e.IconButton.view [ M3e.IconButton.size M3e.Token.large ] [ M3e.Icon.view [ M3e.Icon.name "arrow_back" ] [] ], M3e.IconButton.view [ M3e.IconButton.size M3e.Token.large ] [ M3e.Icon.view [ M3e.Icon.name "arrow_forward" ] [] ], M3e.IconButton.view [ M3e.IconButton.size M3e.Token.large, M3e.IconButton.width M3e.Token.wide, M3e.IconButton.variant M3e.Token.filled ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ], M3e.IconButton.view [ M3e.IconButton.size M3e.Token.large ] [ M3e.Icon.view [ M3e.Icon.name "picture_in_picture" ] [] ], M3e.IconButton.view [ M3e.IconButton.size M3e.Token.large ] [ M3e.Icon.view [ M3e.Icon.name "more_vert" ] [] ] ]
```

<!-- elm-cem:example title="Sizes (2)" -->
```elm
M3e.ButtonGroup.view [ M3e.ButtonGroup.size M3e.Token.large, M3e.ButtonGroup.variant M3e.Token.connected ] [ M3e.Button.view [ M3e.Button.variant M3e.Token.tonal, M3e.Button.size M3e.Token.large, M3e.Button.toggle True ] [ Kit.text "Start" ], M3e.Button.view [ M3e.Button.variant M3e.Token.tonal, M3e.Button.size M3e.Token.large, M3e.Button.toggle True ] [ Kit.text "Directions" ], M3e.Button.view [ M3e.Button.variant M3e.Token.tonal, M3e.Button.size M3e.Token.large, M3e.Button.toggle True ] [ Kit.text "Share" ] ]
```

<!-- elm-cem:example title="Selection" -->
```elm
M3e.ButtonGroup.view [ M3e.ButtonGroup.multi True ] [ M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.tonal, M3e.IconButton.toggle True ] [ M3e.Icon.view [ M3e.Icon.name "format_bold" ] [] ], M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.tonal, M3e.IconButton.toggle True ] [ M3e.Icon.view [ M3e.Icon.name "format_italic" ] [] ], M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.tonal, M3e.IconButton.toggle True ] [ M3e.Icon.view [ M3e.Icon.name "format_underlined" ] [] ] ]
```

<!-- elm-cem:example title="Density" -->
```elm
[ M3e.ButtonGroup.view [ M3e.Attributes.class "density-3" ] [ M3e.Button.view [ M3e.Button.variant M3e.Token.tonal ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "play_arrow" ] []), Kit.text "Start" ], M3e.Button.view [ M3e.Button.variant M3e.Token.tonal ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "directions_car" ] []), Kit.text "Directions" ], M3e.Button.view [ M3e.Button.variant M3e.Token.tonal ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "share" ] []), Kit.text "Share" ] ]
    , Native.br
    , M3e.ButtonGroup.view [ M3e.Attributes.class "density-2" ] [ M3e.Button.view [ M3e.Button.variant M3e.Token.tonal ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "play_arrow" ] []), Kit.text "Start" ], M3e.Button.view [ M3e.Button.variant M3e.Token.tonal ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "directions_car" ] []), Kit.text "Directions" ], M3e.Button.view [ M3e.Button.variant M3e.Token.tonal ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "share" ] []), Kit.text "Share" ] ]
    , Native.br
    , M3e.ButtonGroup.view [ M3e.Attributes.class "density-1" ] [ M3e.Button.view [ M3e.Button.variant M3e.Token.tonal ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "play_arrow" ] []), Kit.text "Start" ], M3e.Button.view [ M3e.Button.variant M3e.Token.tonal ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "directions_car" ] []), Kit.text "Directions" ], M3e.Button.view [ M3e.Button.variant M3e.Token.tonal ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "share" ] []), Kit.text "Share" ] ]
    , Native.br
    , M3e.ButtonGroup.view [ M3e.Attributes.class "density-0" ] [ M3e.Button.view [ M3e.Button.variant M3e.Token.tonal ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "play_arrow" ] []), Kit.text "Start" ], M3e.Button.view [ M3e.Button.variant M3e.Token.tonal ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "directions_car" ] []), Kit.text "Directions" ], M3e.Button.view [ M3e.Button.variant M3e.Token.tonal ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "share" ] []), Kit.text "Share" ] ]
    ]
```

<!-- elm-cem:example title="Density (2)" -->
```elm
[ M3e.ButtonGroup.view [ M3e.ButtonGroup.variant M3e.Token.connected, M3e.Attributes.class "density-3" ] [ M3e.Button.view [ M3e.Button.variant M3e.Token.tonal, M3e.Button.toggle True ] [ Kit.text "Start" ], M3e.Button.view [ M3e.Button.variant M3e.Token.tonal, M3e.Button.toggle True ] [ Kit.text "Directions" ], M3e.Button.view [ M3e.Button.variant M3e.Token.tonal, M3e.Button.toggle True ] [ Kit.text "Share" ] ]
    , Native.br
    , M3e.ButtonGroup.view [ M3e.ButtonGroup.variant M3e.Token.connected, M3e.Attributes.class "density-2" ] [ M3e.Button.view [ M3e.Button.variant M3e.Token.tonal, M3e.Button.toggle True ] [ Kit.text "Start" ], M3e.Button.view [ M3e.Button.variant M3e.Token.tonal, M3e.Button.toggle True ] [ Kit.text "Directions" ], M3e.Button.view [ M3e.Button.variant M3e.Token.tonal, M3e.Button.toggle True ] [ Kit.text "Share" ] ]
    , Native.br
    , M3e.ButtonGroup.view [ M3e.ButtonGroup.variant M3e.Token.connected, M3e.Attributes.class "density-1" ] [ M3e.Button.view [ M3e.Button.variant M3e.Token.tonal, M3e.Button.toggle True ] [ Kit.text "Start" ], M3e.Button.view [ M3e.Button.variant M3e.Token.tonal, M3e.Button.toggle True ] [ Kit.text "Directions" ], M3e.Button.view [ M3e.Button.variant M3e.Token.tonal, M3e.Button.toggle True ] [ Kit.text "Share" ] ]
    , Native.br
    , M3e.ButtonGroup.view [ M3e.ButtonGroup.variant M3e.Token.connected, M3e.Attributes.class "density-0" ] [ M3e.Button.view [ M3e.Button.variant M3e.Token.tonal, M3e.Button.toggle True ] [ Kit.text "Start" ], M3e.Button.view [ M3e.Button.variant M3e.Token.tonal, M3e.Button.toggle True ] [ Kit.text "Directions" ], M3e.Button.view [ M3e.Button.variant M3e.Token.tonal, M3e.Button.toggle True ] [ Kit.text "Share" ] ]
    ]
```

@docs view, multi, size, variant

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.ButtonGroup
import M3e.Node
import M3e.Token


{-| Build the `<m3e-button-group>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { multi : M3e.Token.Supported
            , size : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (M3e.Element.Element
                { button : M3e.Token.Supported
                , iconButton : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | buttonGroup : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.ButtonGroup.buttonGroup
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| Whether multiple toggle buttons can be selected. (default: `false`)
-}
multi : Bool -> M3e.Html.Attr.Attr { c | multi : M3e.Token.Supported } msg
multi =
    M3e.Html.ButtonGroup.multi


{-| The size of the group. (default: `"small"`)
-}
size :
    M3e.Token.Value
        { extraLarge : M3e.Token.Supported
        , extraSmall : M3e.Token.Supported
        , large : M3e.Token.Supported
        , medium : M3e.Token.Supported
        , small : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
size =
    M3e.Html.ButtonGroup.size


{-| The appearance variant of the group. (default: `"standard"`)
-}
variant :
    M3e.Token.Value
        { connected : M3e.Token.Supported
        , standard : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.ButtonGroup.variant
