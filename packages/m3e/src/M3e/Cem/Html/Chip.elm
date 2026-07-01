module M3e.Cem.Html.Chip exposing (chip, value, variant)

{-| 
@docs chip, value, variant
-}


import Html
import Html.Attributes


{-| The raw `<m3e-chip>` element — a partial application of `Html.node`. -}
chip : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
chip =
    Html.node "m3e-chip"


{-| A string representing the value of the chip. -}
value : String -> Html.Attribute msg
value =
    Html.Attributes.attribute "value"


{-| The appearance variant of the chip. (default: `"outlined"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"