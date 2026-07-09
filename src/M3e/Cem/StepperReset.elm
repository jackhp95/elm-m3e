module M3e.Cem.StepperReset exposing ( stepperReset )

{-|
Middle layer for `<m3e-stepper-reset>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.StepperReset` module for everyday use.

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