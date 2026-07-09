module M3e.Cem.Html.StepperPrevious exposing ( stepperPrevious )

{-|
Bottom layer for `<m3e-stepper-previous>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs stepperPrevious
-}


import Html


{-| The raw `<m3e-stepper-previous>` element — a partial application of `Html.node`. -}
stepperPrevious :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
stepperPrevious =
    Html.node "m3e-stepper-previous"