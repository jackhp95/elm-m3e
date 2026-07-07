module M3e.ChipSet exposing ( view, vertical )

{-|
A container used to organize chips into a cohesive unit.

**Component Info:**
- **Extends:** `LitElement`

@docs view, vertical
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.ChipSet
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-chip-set>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { vertical : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element { assistChip : M3e.Value.Supported
    , chip : M3e.Value.Supported
    , filterChip : M3e.Value.Supported
    , inputChip : M3e.Value.Supported
    , suggestionChip : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | chipSet : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.ChipSet.chipSet
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical : Bool -> M3e.Cem.Attr.Attr { c | vertical : M3e.Value.Supported } msg
vertical =
    M3e.Cem.ChipSet.vertical