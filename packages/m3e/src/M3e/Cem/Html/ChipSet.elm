module M3e.Cem.Html.ChipSet exposing (chipSet, vertical)

{-| 
@docs chipSet, vertical
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-chip-set>` element — a partial application of `Html.node`. -}
chipSet : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
chipSet =
    Html.node "m3e-chip-set"


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical : Bool -> Html.Attribute msg
vertical val_ =
    Html.Attributes.property "vertical" (Json.Encode.bool val_)