module M3e.Html.StepperNext exposing (stepperNext)

{-| Middle layer for `<m3e-stepper-next>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.StepperNext` module for everyday use.

@docs stepperNext

-}

import Html
import M3e.Html.Attr
import M3e.Raw.StepperNext
import M3e.Token


{-| An element, nested within a clickable element, used to move a stepper to the next step.

**Component Info:**

  - **Extends:** `StepperButtonElementBase` from `/src/stepper/StepperButtonElementBase`

-}
stepperNext :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
stepperNext attributes children =
    M3e.Raw.StepperNext.stepperNext
        (List.map M3e.Html.Attr.toAttribute attributes)
        children
