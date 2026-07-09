module M3e.StepPanel exposing ( view, actions )

{-|
A panel presented for a step in a wizard-like workflow.

**Component Info:**
- **Extends:** `LitElement`

**Slots:**
- `actions-`: Renders the actions bar of the panel.

@docs view, actions
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.StepPanel
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-step-panel>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | stepPanel : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.StepPanel.stepPanel
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Place content in the `actions` slot. -}
actions : M3e.Element.Element any msg -> M3e.Element.Element k msg
actions el =
    M3e.Element.Internal.placeSlot "actions" el