module M3e.Cem.StepPanel exposing (stepPanel)

{-| 
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