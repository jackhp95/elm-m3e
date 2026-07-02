module M3e.Cem.Html.StepperReset exposing ( stepperReset )

{-|
Bottom layer for `<m3e-stepper-reset>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs stepperReset
-}


import Html


{-| The raw `<m3e-stepper-reset>` element — a partial application of `Html.node`. -}
stepperReset :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
stepperReset =
    Html.node "m3e-stepper-reset"