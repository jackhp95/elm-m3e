module M3e.Slide exposing ( view, selectedIndex )

{-|
A carousel-like container used to horizontally cycle through slotted items.

**Component Info:**
- **Extends:** `LitElement`

@docs view, selectedIndex
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Slide
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-slide>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { selectedIndex : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | slide : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Slide.slide
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| The zero-based index of the visible item. (default: `null`) -}
selectedIndex :
    Float -> M3e.Cem.Attr.Attr { c | selectedIndex : M3e.Value.Supported } msg
selectedIndex =
    M3e.Cem.Slide.selectedIndex