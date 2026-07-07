module M3e.Toc exposing
    ( view, for, maxDepth, overline, title
    )

{-|
A table of contents that provides in-page scroll navigation.

**Component Info:**
- **Extends:** `LitElement`

**Slots:**
- `overline`: Renders the overline of the table of contents.
- `title`: Renders the title of the table of contents.

@docs view, for, maxDepth, overline, title
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Toc
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | toc : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Toc.toc
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Toc.for


{-| The maximum depth of the table of contents. (default: `2`) -}
maxDepth : Float -> M3e.Cem.Attr.Attr { c | maxDepth : M3e.Value.Supported } msg
maxDepth =
    M3e.Cem.Toc.maxDepth


{-| Place content in the `overline` slot. -}
overline :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
overline el =
    M3e.Element.Internal.placeSlot "overline" el


{-| Place content in the `title` slot. -}
title :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
title el =
    M3e.Element.Internal.placeSlot "title" el