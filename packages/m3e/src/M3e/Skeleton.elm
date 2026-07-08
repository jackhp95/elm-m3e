module M3e.Skeleton exposing ( view, animation, shape, loaded )

{-|
A visual placeholder that mimics the layout of content while it's still loading.

**Component Info:**
- **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Communication -->

## Examples

### Examples

<!-- elm-cem:example title="Basic usage" -->
```elm
[ Native.node Html.label [] [ M3e.Checkbox.view [ M3e.Attributes.id "toggle1" ] [], Kit.text "Loaded" ]
    , Native.br
    , Native.br
    , M3e.Skeleton.view [ M3e.Attributes.id "skeleton1" ] [ M3e.Card.view [] [ M3e.Card.header (M3e.Heading.view [ M3e.Heading.variant M3e.Value.display, M3e.Heading.size M3e.Value.small ] [ Kit.text "Card Header" ]), M3e.Card.content (Native.div [] [ Kit.text "Card Content" ]), M3e.Card.actions (Native.div [] [ M3e.Button.view [ M3e.Button.variant M3e.Value.filled ] [ Kit.text "Action" ] ]), M3e.Card.footer (Native.div [] [ Kit.text "Card Footer" ]) ] ]
    ]
```

<!-- elm-cem:example title="Card Header" -->
```elm
M3e.Skeleton.view [] [ M3e.Card.view [] [ M3e.Card.header (M3e.Heading.view [ M3e.Heading.variant M3e.Value.display, M3e.Heading.size M3e.Value.small ] [ Kit.text "Card Header" ]), M3e.Card.content (Native.div [] [ Kit.text "Card Content" ]), M3e.Card.actions (Native.div [] [ M3e.Button.view [ M3e.Button.variant M3e.Value.filled ] [ Kit.text "Action" ] ]), M3e.Card.footer (Native.div [] [ Kit.text "Card Footer" ]) ] ]
```

<!-- elm-cem:example title="Shape" -->
```elm
[ M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Value.circular ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px" ] [] ]
    , Native.br
    , M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Value.rounded ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px" ] [] ]
    , Native.br
    , M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Value.square ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px" ] [] ]
    , Native.br
    , M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Value.auto ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px; border-radius: 16px" ] [] ]
    ]
```

<!-- elm-cem:example title="Animation" -->
```elm
[ M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Value.circular, M3e.Skeleton.animation M3e.Value.pulse ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px" ] [] ]
    , Native.br
    , M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Value.rounded, M3e.Skeleton.animation M3e.Value.pulse ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px" ] [] ]
    , Native.br
    , M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Value.square, M3e.Skeleton.animation M3e.Value.pulse ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px" ] [] ]
    , Native.br
    , M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Value.auto, M3e.Skeleton.animation M3e.Value.pulse ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px; border-radius: 16px" ] [] ]
    ]
```

<!-- elm-cem:example title="Animation (2)" -->
```elm
[ M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Value.circular, M3e.Skeleton.animation M3e.Value.none ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px" ] [] ]
    , Native.br
    , M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Value.rounded, M3e.Skeleton.animation M3e.Value.none ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px" ] [] ]
    , Native.br
    , M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Value.square, M3e.Skeleton.animation M3e.Value.none ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px" ] [] ]
    , Native.br
    , M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Value.auto, M3e.Skeleton.animation M3e.Value.none ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px; border-radius: 16px" ] [] ]
    ]
```

@docs view, animation, shape, loaded
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Skeleton
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-skeleton>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { animation : M3e.Value.Supported
    , shape : M3e.Value.Supported
    , loaded : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | skeleton : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Skeleton.skeleton
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| The animation effect of the skeleton. (default: `"wave"`) -}
animation :
    M3e.Value.Value { none : M3e.Value.Supported
    , pulse : M3e.Value.Supported
    , wave : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | animation : M3e.Value.Supported } msg
animation =
    M3e.Cem.Skeleton.animation


{-| The shape of the skeleton. (default: `"auto"`) -}
shape :
    M3e.Value.Value { auto : M3e.Value.Supported
    , circular : M3e.Value.Supported
    , rounded : M3e.Value.Supported
    , square : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | shape : M3e.Value.Supported } msg
shape =
    M3e.Cem.Skeleton.shape


{-| Whether the content of the skeleton has been loaded. (default: `false`) -}
loaded : Bool -> M3e.Cem.Attr.Attr { c | loaded : M3e.Value.Supported } msg
loaded =
    M3e.Cem.Skeleton.loaded