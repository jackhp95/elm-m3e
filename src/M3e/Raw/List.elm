module M3e.Raw.List exposing (list, variant)

{-| Bottom layer for `<m3e-list>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs list, variant

-}

import Html
import Html.Attributes


{-| The raw `<m3e-list>` element — a partial application of `Html.node`.
-}
list : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
list =
    Html.node "m3e-list"


{-| The appearance variant of the list. (default: `"standard"`)
-}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"
