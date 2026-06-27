module Cem.M3e.StepperReset exposing (component)

{-| An element, nested within a clickable element, used to reset a stepper to its initial state.


## Component

@docs component

-}

import Html


{-| An element, nested within a clickable element, used to reset a stepper to its initial state.

**Component Info:**

  - **Extends:** `StepperButtonElementBase` from `/src/stepper/StepperButtonElementBase`

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-stepper-reset" attributes children
