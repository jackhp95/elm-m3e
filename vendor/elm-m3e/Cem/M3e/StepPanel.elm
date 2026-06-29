module Cem.M3e.StepPanel exposing (component, actionsSlot)

{-| A panel presented for a step in a wizard-like workflow.

@docs component, actionsSlot

-}

import Html
import Html.Attributes


{-| A panel presented for a step in a wizard-like workflow.

**Slots:**

  - `actions-`: Renders the actions bar of the panel.

**CSS Custom Properties:**

  - `--m3e-step-panel-padding`: Padding inside the step panel container, defining internal spacing around content.
  - `--m3e-step-panel-spacing`: Vertical gap between stacked elements within the step panel.
  - `--m3e-step-panel-actions-height`: Minimum height of the slotted actions container.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-step-panel" attributes children


{-| Renders the actions bar of the panel.
-}
actionsSlot : Html.Attribute msg
actionsSlot =
    Html.Attributes.attribute "slot" "actions-"
