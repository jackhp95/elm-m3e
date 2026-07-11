module M3e.Raw.Shape exposing (shape, name)

{-| Bottom layer for `<m3e-shape>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs shape, name

-}

import Html
import Html.Attributes


{-| The raw `<m3e-shape>` element — a partial application of `Html.node`.
-}
shape : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
shape =
    Html.node "m3e-shape"


{-| The name of the shape. (default: `null`)
-}
name : String -> Html.Attribute msg
name =
    Html.Attributes.attribute "name"
