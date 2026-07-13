module M3e.Toolbar exposing (view, elevated, shape, variant, vertical)

{-| Presents frequently used actions relevant to the current page.

**Component Info:**

  - **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Containment -->


## Examples


### Variants

<!-- elm-cem:example title="Variants" -->
```elm
[ M3e.Toolbar.view [ M3e.Toolbar.variant M3e.Token.standard ] [ M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "arrow_back" ] [] ], M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "arrow_forward" ] [] ], M3e.IconButton.view [ M3e.IconButton.width M3e.Token.wide, M3e.IconButton.variant M3e.Token.filled ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ], M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "picture_in_picture" ] [] ], M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "more_vert" ] [] ] ]
    , M3e.Toolbar.view [ M3e.Toolbar.variant M3e.Token.vibrant ] [ M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "arrow_back" ] [] ], M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "arrow_forward" ] [] ], M3e.IconButton.view [ M3e.IconButton.width M3e.Token.wide, M3e.IconButton.variant M3e.Token.filled ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ], M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "picture_in_picture" ] [] ], M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "more_vert" ] [] ] ]
    ]
```


### Examples

<!-- elm-cem:example title="Shapes" -->
```elm
M3e.Toolbar.view [ M3e.Toolbar.variant M3e.Token.vibrant, M3e.Toolbar.shape M3e.Token.rounded ] [ M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "arrow_back" ] [] ], M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "arrow_forward" ] [] ], M3e.IconButton.view [ M3e.IconButton.width M3e.Token.wide, M3e.IconButton.variant M3e.Token.filled ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ], M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "picture_in_picture" ] [] ], M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "more_vert" ] [] ] ]
```

<!-- elm-cem:example title="Elevation" -->
```elm
M3e.Toolbar.view [ M3e.Toolbar.variant M3e.Token.vibrant, M3e.Toolbar.shape M3e.Token.rounded, M3e.Toolbar.elevated True ] [ M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "arrow_back" ] [] ], M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "arrow_forward" ] [] ], M3e.IconButton.view [ M3e.IconButton.width M3e.Token.wide, M3e.IconButton.variant M3e.Token.filled ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ], M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "picture_in_picture" ] [] ], M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "more_vert" ] [] ] ]
```

<!-- elm-cem:example title="Orientation" -->
```elm
M3e.Toolbar.view [ M3e.Toolbar.variant M3e.Token.vibrant, M3e.Toolbar.shape M3e.Token.rounded, M3e.Toolbar.vertical True ] [ M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "arrow_back" ] [] ], M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "arrow_forward" ] [] ], M3e.IconButton.view [ M3e.IconButton.width M3e.Token.wide, M3e.IconButton.variant M3e.Token.filled ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ], M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "picture_in_picture" ] [] ], M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "more_vert" ] [] ] ]
```

<!-- elm-cem:example title="Density" -->
```elm
M3e.Toolbar.view [ M3e.Attributes.class "density-3" ] [ M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "arrow_back" ] [] ], M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "arrow_forward" ] [] ], M3e.IconButton.view [ M3e.IconButton.width M3e.Token.wide, M3e.IconButton.variant M3e.Token.filled ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ], M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "picture_in_picture" ] [] ], M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "more_vert" ] [] ] ]
```

@docs view, elevated, shape, variant, vertical

-}

import M3e.Html.Toolbar
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-toolbar>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { elevated : M3e.Token.Supported
            , shape : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , vertical : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | toolbar : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Toolbar.toolbar
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether the toolbar is elevated. (default: `false`)
-}
elevated : Bool -> Markup.Html.Attr.Attr { c | elevated : M3e.Token.Supported } msg
elevated =
    M3e.Html.Toolbar.elevated


{-| The shape of the toolbar. (default: `"square"`)
-}
shape :
    M3e.Token.Value
        { rounded : M3e.Token.Supported
        , square : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | shape : M3e.Token.Supported } msg
shape =
    M3e.Html.Toolbar.shape


{-| The appearance variant of the toolbar. (default: `"standard"`)
-}
variant :
    M3e.Token.Value
        { standard : M3e.Token.Supported
        , vibrant : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.Toolbar.variant


{-| Whether the element is oriented vertically. (default: `false`)
-}
vertical : Bool -> Markup.Html.Attr.Attr { c | vertical : M3e.Token.Supported } msg
vertical =
    M3e.Html.Toolbar.vertical
