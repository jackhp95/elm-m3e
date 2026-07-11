module M3e.Html.StepPanel exposing (stepPanel)

{-| Middle layer for `<m3e-step-panel>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.StepPanel` module for everyday use.

@docs stepPanel

-}

import Html
import M3e.Html.Attr
import M3e.Raw.StepPanel
import M3e.Token


{-| A panel presented for a step in a wizard-like workflow.

**Component Info:**

  - **Extends:** `LitElement`

**Slots:**

  - `actions-`: Renders the actions bar of the panel.

-}
stepPanel :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
stepPanel attributes children =
    M3e.Raw.StepPanel.stepPanel
        (List.map M3e.Html.Attr.toAttribute attributes)
        children
