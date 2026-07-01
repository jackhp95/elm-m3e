module M3e.Cem.Html.List exposing (list, variant)

{-| 
@docs list, variant
-}


import Html
import Html.Attributes


{-| The raw `<m3e-list>` element — a partial application of `Html.node`. -}
list : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
list =
    Html.node "m3e-list"


{-| The appearance variant of the list. (default: `"standard"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"