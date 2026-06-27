module Cem.M3e.StepPanel exposing
    ( component
    , actionsSlot
    )

{-| A panel presented for a step in a wizard-like workflow.


## Component

@docs component


### Slots

@docs actionsSlot

-}

import Html
import Html.Attributes


{-| A panel presented for a step in a wizard-like workflow.

**Slots:**

  - `actions`: Renders the actions bar of the panel.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-step-panel" attributes children


{-| Renders the actions bar of the panel.
-}
actionsSlot : Html.Attribute msg
actionsSlot =
    Html.Attributes.attribute "slot" "actions"
