module M3e.Cem.Html.StepperNext exposing ( stepperNext )

{-|
Bottom layer for `<m3e-stepper-next>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs stepperNext
-}


import Html


{-| The raw `<m3e-stepper-next>` element — a partial application of `Html.node`. -}
stepperNext : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
stepperNext =
    Html.node "m3e-stepper-next"