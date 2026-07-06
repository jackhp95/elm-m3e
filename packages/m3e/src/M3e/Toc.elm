module M3e.Toc exposing
    ( view, for, maxDepth, child, overline, title
    , children
    )

{-|
A table of contents that provides in-page scroll navigation.

**Component Info:**
- **Extends:** `LitElement`

**Slots:**
- `overline`: Renders the overline of the table of contents.
- `title`: Renders the title of the table of contents.

<!-- elm-cem:docmeta category=Navigation -->

## Examples

### Examples

<!-- elm-cem:example title="Table of contents with overline slot" -->
```elm
M3e.Toc.view [ M3e.Toc.for "post-content", M3e.Toc.maxDepth 3 ] [ M3e.Toc.overline (Native.span [] [ Kit.text "Contents" ]) ]
```

@docs view, for, maxDepth, child, overline, title
@docs children
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Toc
import M3e.Content
import M3e.Content.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-toc>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { for : M3e.Value.Supported
    , maxDepth : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , overline : M3e.Value.Supported
    , title : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | toc : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Toc.toc
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Toc.for


{-| The maximum depth of the table of contents. (default: `2`) -}
maxDepth : Float -> M3e.Cem.Attr.Attr { c | maxDepth : M3e.Value.Supported } msg
maxDepth =
    M3e.Cem.Toc.maxDepth


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.Internal.slot "" el


{-| Place content in the `overline` slot. -}
overline :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | overline : M3e.Value.Supported } msg
overline el =
    M3e.Content.Internal.slot "overline" el


{-| Place content in the `title` slot. -}
title :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | title : M3e.Value.Supported } msg
title el =
    M3e.Content.Internal.slot "title" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element any msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.Internal.slot "") els