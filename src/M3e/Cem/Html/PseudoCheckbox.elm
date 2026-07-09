module M3e.Cem.Html.PseudoCheckbox exposing ( pseudoCheckbox, checked, disabled, indeterminate )

{-|
Bottom layer for `<m3e-pseudo-checkbox>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs pseudoCheckbox, checked, disabled, indeterminate
-}


import Html
import Html.Attributes


{-| The raw `<m3e-pseudo-checkbox>` element — a partial application of `Html.node`. -}
pseudoCheckbox :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
pseudoCheckbox =
    Html.node "m3e-pseudo-checkbox"


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


{-| A value indicating whether the element's checked state is indeterminate. (default: `false`) -}
indeterminate : Bool -> Html.Attribute msg
indeterminate val_ =
    if val_ then
        Html.Attributes.attribute "indeterminate" ""
    
    else
        Html.Attributes.classList []