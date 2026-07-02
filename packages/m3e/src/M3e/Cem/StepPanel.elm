module M3e.Cem.StepPanel exposing ( stepPanel )

{-|
Middle layer for `<m3e-step-panel>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.StepPanel` module for everyday use.

@docs stepPanel
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.StepPanel
import M3e.Value


{-| A panel presented for a step in a wizard-like workflow.

**Slots:**
- `actions-`: Renders the actions bar of the panel.
-}
stepPanel :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
stepPanel attributes children =
    M3e.Cem.Html.StepPanel.stepPanel
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children