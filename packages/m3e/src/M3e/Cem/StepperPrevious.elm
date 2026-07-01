module M3e.Cem.StepperPrevious exposing (stepperPrevious)

{-| 
@docs stepperPrevious
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.StepperPrevious
import M3e.Value


{-| An element, nested within a clickable element, used to move a stepper to the previous step.

**Component Info:**
- **Extends:** `StepperButtonElementBase` from `/src/stepper/StepperButtonElementBase`
-}
stepperPrevious :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
stepperPrevious attributes children =
    M3e.Cem.Html.StepperPrevious.stepperPrevious
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children