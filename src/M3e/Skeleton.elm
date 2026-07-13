module M3e.Skeleton exposing (view, animation, shape, loaded)

{-| A visual placeholder that mimics the layout of content while it's still loading.

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
    , M3e.Skeleton.view [ M3e.Attributes.id "skeleton1" ] [ M3e.Card.view [] [ M3e.Card.header (M3e.Heading.view [ M3e.Heading.variant M3e.Token.display, M3e.Heading.size M3e.Token.small ] [ Kit.text "Card Header" ]), M3e.Card.content (Native.div [] [ Kit.text "Card Content" ]), M3e.Card.actions (Native.div [] [ M3e.Button.view [ M3e.Button.variant M3e.Token.filled ] [ Kit.text "Action" ] ]), M3e.Card.footer (Native.div [] [ Kit.text "Card Footer" ]) ] ]
    ]
```

<!-- elm-cem:example title="Card Header" -->
```elm
M3e.Skeleton.view [] [ M3e.Card.view [] [ M3e.Card.header (M3e.Heading.view [ M3e.Heading.variant M3e.Token.display, M3e.Heading.size M3e.Token.small ] [ Kit.text "Card Header" ]), M3e.Card.content (Native.div [] [ Kit.text "Card Content" ]), M3e.Card.actions (Native.div [] [ M3e.Button.view [ M3e.Button.variant M3e.Token.filled ] [ Kit.text "Action" ] ]), M3e.Card.footer (Native.div [] [ Kit.text "Card Footer" ]) ] ]
```

<!-- elm-cem:example title="Shape" -->
```elm
[ M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Token.circular ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px" ] [] ]
    , Native.br
    , M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Token.rounded ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px" ] [] ]
    , Native.br
    , M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Token.square ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px" ] [] ]
    , Native.br
    , M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Token.auto ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px; border-radius: 16px" ] [] ]
    ]
```

<!-- elm-cem:example title="Animation" -->
```elm
[ M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Token.circular, M3e.Skeleton.animation M3e.Token.pulse ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px" ] [] ]
    , Native.br
    , M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Token.rounded, M3e.Skeleton.animation M3e.Token.pulse ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px" ] [] ]
    , Native.br
    , M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Token.square, M3e.Skeleton.animation M3e.Token.pulse ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px" ] [] ]
    , Native.br
    , M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Token.auto, M3e.Skeleton.animation M3e.Token.pulse ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px; border-radius: 16px" ] [] ]
    ]
```

<!-- elm-cem:example title="Animation (2)" -->
```elm
[ M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Token.circular, M3e.Skeleton.animation M3e.Token.none ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px" ] [] ]
    , Native.br
    , M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Token.rounded, M3e.Skeleton.animation M3e.Token.none ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px" ] [] ]
    , Native.br
    , M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Token.square, M3e.Skeleton.animation M3e.Token.none ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px" ] [] ]
    , Native.br
    , M3e.Skeleton.view [ M3e.Skeleton.shape M3e.Token.auto, M3e.Skeleton.animation M3e.Token.none ] [ Native.div [ Native.attribute "style" "width: 100px; height: 100px; border-radius: 16px" ] [] ]
    ]
```

@docs view, animation, shape, loaded

-}

import M3e.Html.Skeleton
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-skeleton>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { animation : M3e.Token.Supported
            , shape : M3e.Token.Supported
            , loaded : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | skeleton : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Skeleton.skeleton
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| The animation effect of the skeleton. (default: `"wave"`)
-}
animation :
    M3e.Token.Value
        { none : M3e.Token.Supported
        , pulse : M3e.Token.Supported
        , wave : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | animation : M3e.Token.Supported } msg
animation =
    M3e.Html.Skeleton.animation


{-| The shape of the skeleton. (default: `"auto"`)
-}
shape :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , circular : M3e.Token.Supported
        , rounded : M3e.Token.Supported
        , square : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | shape : M3e.Token.Supported } msg
shape =
    M3e.Html.Skeleton.shape


{-| Whether the content of the skeleton has been loaded. (default: `false`)
-}
loaded : Bool -> Markup.Html.Attr.Attr { c | loaded : M3e.Token.Supported } msg
loaded =
    M3e.Html.Skeleton.loaded
