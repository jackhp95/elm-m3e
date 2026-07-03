module M3e.StepPanel exposing ( view, child, actions, children )

{-|
A panel presented for a step in a wizard-like workflow.

**Component Info:**
- **Extends:** `LitElement`

**Slots:**
- `actions-`: Renders the actions bar of the panel.

@docs view, child, actions, children
-}


import M3e.Cem.Attr
import M3e.Cem.StepPanel
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-step-panel>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , actions : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | stepPanel : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.StepPanel.stepPanel
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place content in the `actions` slot. -}
actions :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | actions : M3e.Value.Supported } msg
actions el =
    M3e.Content.slot "actions" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element any msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els