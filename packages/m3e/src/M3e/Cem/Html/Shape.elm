module M3e.Cem.Html.Shape exposing (name, shape)

{-| 
@docs shape, name
-}


import Html
import Html.Attributes


{-| The raw `<m3e-shape>` element — a partial application of `Html.node`. -}
shape : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
shape =
    Html.node "m3e-shape"


{-| The name of the shape. (default: `null`) -}
name : String -> Html.Attribute msg
name =
    Html.Attributes.attribute "name"