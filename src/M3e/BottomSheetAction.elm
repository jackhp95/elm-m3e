module M3e.BottomSheetAction exposing ( view )

{-|
An element, nested within a clickable element, used to close a parenting bottom sheet.

**Component Info:**
- **Extends:** `ActionElementBase`

@docs view
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.BottomSheetAction
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-bottom-sheet-action>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Element.Element { text : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | bottomSheetAction : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.BottomSheetAction.bottomSheetAction
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )