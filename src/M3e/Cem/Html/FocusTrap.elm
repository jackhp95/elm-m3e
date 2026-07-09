module M3e.Cem.Html.FocusTrap exposing ( focusTrap, disabled )

{-|
Bottom layer for `<m3e-focus-trap>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs focusTrap, disabled
-}


import Html
import Html.Attributes


{-| The raw `<m3e-focus-trap>` element — a partial application of `Html.node`. -}
focusTrap : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
focusTrap =
    Html.node "m3e-focus-trap"


{-| Disables the focus trap. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""
    
    else
        Html.Attributes.classList []