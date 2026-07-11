module M3e.Html.StepperReset exposing (stepperReset)

{-| Middle layer for `<m3e-stepper-reset>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.StepperReset` module for everyday use.

@docs stepperReset

-}

import Html
import M3e.Html.Attr
import M3e.Raw.StepperReset
import M3e.Token


{-| An element, nested within a clickable element, used to reset a stepper to its initial state.

**Component Info:**

  - **Extends:** `StepperButtonElementBase` from `/src/stepper/StepperButtonElementBase`

-}
stepperReset :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
stepperReset attributes children =
    M3e.Raw.StepperReset.stepperReset
        (List.map M3e.Html.Attr.toAttribute attributes)
        children
