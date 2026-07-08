module M3e.Cem.Html.PseudoRadio exposing ( pseudoRadio, checked, disabled )

{-|
Bottom layer for `<m3e-pseudo-radio>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs pseudoRadio, checked, disabled
-}


import Html
import Html.Attributes


{-| The raw `<m3e-pseudo-radio>` element — a partial application of `Html.node`. -}
pseudoRadio : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
pseudoRadio =
    Html.node "m3e-pseudo-radio"


{-| A value indicating whether the element is checked. (default: `false`) -}
checked : Bool -> Html.Attribute msg
checked val_ =
    if val_ then
        Html.Attributes.attribute "checked" ""
    
    else
        Html.Attributes.classList []


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""
    
    else
        Html.Attributes.classList []