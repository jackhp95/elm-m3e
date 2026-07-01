module M3e.Cem.Html.StepperPrevious exposing (stepperPrevious)

{-| 
@docs stepperPrevious
-}


import Html


{-| The raw `<m3e-stepper-previous>` element — a partial application of `Html.node`. -}
stepperPrevious :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
stepperPrevious =
    Html.node "m3e-stepper-previous"