module M3e.Cem.StepperReset exposing (stepperReset)

{-| 
@docs stepperReset
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.StepperReset
import M3e.Value


{-| An element, nested within a clickable element, used to reset a stepper to its initial state.

**Component Info:**
- **Extends:** `StepperButtonElementBase` from `/src/stepper/StepperButtonElementBase`
-}
stepperReset :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
stepperReset attributes children =
    M3e.Cem.Html.StepperReset.stepperReset
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children