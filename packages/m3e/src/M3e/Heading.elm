module M3e.Heading exposing
    ( view, emphasized, level, size, variant, child
    , children
    )

{-|
A heading to a page or section.

**Component Info:**
- **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Layout & style -->

## Examples

### Examples

<!-- elm-cem:example title="Page header hierarchy with semantic levels" -->
```elm
Native.header [] [ M3e.Heading.view [ M3e.Heading.variant M3e.Value.headline, M3e.Heading.size M3e.Value.large, M3e.Heading.level 1 ] [ M3e.Heading.child (Kit.text "Quarterly report") ], M3e.Heading.view [ M3e.Heading.variant M3e.Value.title, M3e.Heading.size M3e.Value.medium, M3e.Heading.level 2 ] [ M3e.Heading.child (Kit.text "Revenue overview") ], Native.p [] [ Kit.text "A summary of performance across all regions for the quarter." ], M3e.Heading.view [ M3e.Heading.variant M3e.Value.label, M3e.Heading.size M3e.Value.small ] [ M3e.Heading.child (Kit.text "Updated 2 hours ago") ] ]
```

<!-- elm-cem:example title="Emphasized display heading for a hero section" -->
```elm
Native.section [] [ M3e.Heading.view [ M3e.Heading.variant M3e.Value.display, M3e.Heading.size M3e.Value.large, M3e.Heading.emphasized True, M3e.Heading.level 1 ] [ M3e.Heading.child (Kit.text "Build faster.") ], M3e.Heading.view [ M3e.Heading.variant M3e.Value.headline, M3e.Heading.size M3e.Value.small, M3e.Heading.level 2 ] [ M3e.Heading.child (Kit.text "Ship expressive interfaces with Material 3.") ] ]
```

@docs view, emphasized, level, size, variant, child
@docs children
-}


import M3e.Cem.Attr
import M3e.Cem.Heading
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-heading>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { emphasized : M3e.Value.Supported
    , level : M3e.Value.Supported
    , size : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | heading : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Heading.heading
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Content.toNode content_)
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


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { text : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els