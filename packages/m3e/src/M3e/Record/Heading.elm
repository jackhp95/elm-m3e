module M3e.Record.Heading exposing
    ( view, emphasized, level, size, variant
    )

{-|
A heading to a page or section.

**Component Info:**
- **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Layout & style -->

## Examples

### Examples

<!-- elm-cem:example title="Typescale variants and sizes" -->
```elm
[ M3e.Heading.view [ M3e.Heading.variant M3e.Value.display, M3e.Heading.size M3e.Value.large ] [ Kit.text "Display Large" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.display, M3e.Heading.size M3e.Value.medium ] [ Kit.text "Display Medium" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.display, M3e.Heading.size M3e.Value.small ] [ Kit.text "Display Small" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.headline, M3e.Heading.size M3e.Value.large ] [ Kit.text "Headline Large" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.headline, M3e.Heading.size M3e.Value.medium ] [ Kit.text "Headline Medium" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.headline, M3e.Heading.size M3e.Value.small ] [ Kit.text "Headline Small" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.title, M3e.Heading.size M3e.Value.large ] [ Kit.text "Title Large" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.title, M3e.Heading.size M3e.Value.medium ] [ Kit.text "Title Medium" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.title, M3e.Heading.size M3e.Value.small ] [ Kit.text "Title Small" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.label, M3e.Heading.size M3e.Value.large ] [ Kit.text "Label Large" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.label, M3e.Heading.size M3e.Value.medium ] [ Kit.text "Label Medium" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.label, M3e.Heading.size M3e.Value.small ] [ Kit.text "Label Small" ]
    ]
```

<!-- elm-cem:example title="Emphasized typescale" -->
```elm
[ M3e.Heading.view [ M3e.Heading.variant M3e.Value.display, M3e.Heading.size M3e.Value.large, M3e.Heading.emphasized True ] [ Kit.text "Display Large" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.display, M3e.Heading.size M3e.Value.medium, M3e.Heading.emphasized True ] [ Kit.text "Display Medium" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.display, M3e.Heading.size M3e.Value.small, M3e.Heading.emphasized True ] [ Kit.text "Display Small" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.headline, M3e.Heading.size M3e.Value.large, M3e.Heading.emphasized True ] [ Kit.text "Headline Large" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.headline, M3e.Heading.size M3e.Value.medium, M3e.Heading.emphasized True ] [ Kit.text "Headline Medium" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.headline, M3e.Heading.size M3e.Value.small, M3e.Heading.emphasized True ] [ Kit.text "Headline Small" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.title, M3e.Heading.size M3e.Value.large, M3e.Heading.emphasized True ] [ Kit.text "Title Large" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.title, M3e.Heading.size M3e.Value.medium, M3e.Heading.emphasized True ] [ Kit.text "Title Medium" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.title, M3e.Heading.size M3e.Value.small, M3e.Heading.emphasized True ] [ Kit.text "Title Small" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.label, M3e.Heading.size M3e.Value.large, M3e.Heading.emphasized True ] [ Kit.text "Label Large" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.label, M3e.Heading.size M3e.Value.medium, M3e.Heading.emphasized True ] [ Kit.text "Label Medium" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.label, M3e.Heading.size M3e.Value.small, M3e.Heading.emphasized True ] [ Kit.text "Label Small" ]
    ]
```

### Sizes

<!-- elm-cem:example title="Label Small" -->
```elm
[ M3e.Heading.view [ M3e.Heading.variant M3e.Value.display, M3e.Heading.size M3e.Value.large ] [ Kit.text "Display Large" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.display, M3e.Heading.size M3e.Value.medium ] [ Kit.text "Display Medium" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.display, M3e.Heading.size M3e.Value.small ] [ Kit.text "Display Small" ]
    ]
```

<!-- elm-cem:example title="Label Small (2)" -->
```elm
[ M3e.Heading.view [ M3e.Heading.variant M3e.Value.display, M3e.Heading.size M3e.Value.large, M3e.Heading.emphasized True ] [ Kit.text "Display Large" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.display, M3e.Heading.size M3e.Value.medium, M3e.Heading.emphasized True ] [ Kit.text "Display Medium" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Value.display, M3e.Heading.size M3e.Value.small, M3e.Heading.emphasized True ] [ Kit.text "Display Small" ]
    ]
```

@docs view, emphasized, level, size, variant
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Heading
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-heading>` element (lazy IR). -}
view :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { emphasized : M3e.Value.Supported
    , level : M3e.Value.Supported
    , size : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | heading : M3e.Value.Supported } msg
view req_ attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Heading.heading
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.append
                  [ M3e.Element.toNode req_.content ]
                  (List.map M3e.Element.toNode content_)
             )
        )


{-| Whether the heading uses an emphasized typescale. (default: `false`) -}
emphasized :
    Bool -> M3e.Cem.Attr.Attr { c | emphasized : M3e.Value.Supported } msg
emphasized =
    M3e.Cem.Heading.emphasized


{-| The accessibility level of the heading. -}
level : Int -> M3e.Cem.Attr.Attr { c | level : M3e.Value.Supported } msg
level =
    M3e.Cem.Heading.level


{-| The size of the heading. (default: `"medium"`) -}
size :
    M3e.Value.Value { large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
size =
    M3e.Cem.Heading.size


{-| The appearance variant of the heading. (default: `"display"`) -}
variant :
    M3e.Value.Value { display : M3e.Value.Supported
    , headline : M3e.Value.Supported
    , label : M3e.Value.Supported
    , title : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.Heading.variant