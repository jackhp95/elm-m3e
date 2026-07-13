module M3e.Html.StepperPrevious exposing (stepperPrevious)

{-| Middle layer for `<m3e-stepper-previous>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.StepperPrevious` module for everyday use.

@docs stepperPrevious

-}

import Html
import M3e.Raw.StepperPrevious
import M3e.Token
import Markup.Html.Attr


{-| An element, nested within a clickable element, used to move a stepper to the previous step.

**Component Info:**

  - **Extends:** `StepperButtonElementBase` from `/src/stepper/StepperButtonElementBase`

-}
stepperPrevious :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
stepperPrevious attributes children =
    M3e.Raw.StepperPrevious.stepperPrevious
        (List.map Markup.Html.Attr.toAttribute attributes)
        children
