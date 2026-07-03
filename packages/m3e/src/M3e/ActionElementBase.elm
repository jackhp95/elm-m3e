module M3e.ActionElementBase exposing ( view )

{-|
A base implementation for an element, nested within a clickable element, used to
perform an action. This class must be inherited.

**Component Info:**
- **Extends:** `LitElement`

@docs view
-}


import M3e.Cem.ActionElementBase
import M3e.Cem.Attr
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<div>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | actionElementBase : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.ActionElementBase.actionElementBase
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Element.toNode children)
        )