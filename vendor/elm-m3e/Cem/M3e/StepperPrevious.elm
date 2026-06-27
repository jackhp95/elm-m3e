module Cem.M3e.StepperPrevious exposing (component)

{-| An element, nested within a clickable element, used to move a stepper to the previous step.


## Component

@docs component

-}

import Html


{-| An element, nested within a clickable element, used to move a stepper to the previous step.

**Component Info:**

  - **Extends:** `StepperButtonElementBase` from `/src/stepper/StepperButtonElementBase`

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-stepper-previous" attributes children
