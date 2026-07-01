module M3e.Cem.Html.StepperReset exposing (stepperReset)

{-| 
@docs stepperReset
-}


import Html


{-| The raw `<m3e-stepper-reset>` element — a partial application of `Html.node`. -}
stepperReset :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
stepperReset =
    Html.node "m3e-stepper-reset"