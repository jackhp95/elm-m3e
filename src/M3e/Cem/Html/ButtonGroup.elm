module M3e.Cem.Html.ButtonGroup exposing ( buttonGroup, multi, size, variant )

{-|
Bottom layer for `<m3e-button-group>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs buttonGroup, multi, size, variant
-}


import Html
import Html.Attributes


{-| The raw `<m3e-button-group>` element — a partial application of `Html.node`. -}
buttonGroup : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
buttonGroup =
    Html.node "m3e-button-group"


{-| Whether multiple toggle buttons can be selected. (default: `false`) -}
multi : Bool -> Html.Attribute msg
multi val_ =
    if val_ then
        Html.Attributes.attribute "multi" ""
    
    else
        Html.Attributes.classList []


{-| The size of the group. (default: `"small"`) -}
size : String -> Html.Attribute msg
size =
    Html.Attributes.attribute "size"


{-| The appearance variant of the group. (default: `"standard"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"