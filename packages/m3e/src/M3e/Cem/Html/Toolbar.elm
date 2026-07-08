module M3e.Cem.Html.Toolbar exposing
    ( toolbar, elevated, shape, variant, vertical
    )

{-|
Bottom layer for `<m3e-toolbar>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs toolbar, elevated, shape, variant, vertical
-}


import Html
import Html.Attributes


{-| The raw `<m3e-toolbar>` element — a partial application of `Html.node`. -}
toolbar : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
toolbar =
    Html.node "m3e-toolbar"


{-| Whether the toolbar is elevated. (default: `false`) -}
elevated : Bool -> Html.Attribute msg
elevated val_ =
    if val_ then
        Html.Attributes.attribute "elevated" ""
    
    else
        Html.Attributes.classList []


{-| The shape of the toolbar. (default: `"square"`) -}
shape : String -> Html.Attribute msg
shape =
    Html.Attributes.attribute "shape"


{-| The appearance variant of the toolbar. (default: `"standard"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical : Bool -> Html.Attribute msg
vertical val_ =
    if val_ then
        Html.Attributes.attribute "vertical" ""
    
    else
        Html.Attributes.classList []