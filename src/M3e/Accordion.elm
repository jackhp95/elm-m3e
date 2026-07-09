module M3e.Accordion exposing ( view, multi )

{-|
Combines multiple expansion panels in to an accordion.

**Component Info:**
- **Extends:** `LitElement`

@docs view, multi
-}


import M3e.Cem.Accordion
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-accordion>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { multi : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element { expansionPanel : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | accordion : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Accordion.accordion
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Whether multiple expansion panels can be open at the same time. (default: `false`) -}
multi : Bool -> M3e.Cem.Attr.Attr { c | multi : M3e.Value.Supported } msg
multi =
    M3e.Cem.Accordion.multi