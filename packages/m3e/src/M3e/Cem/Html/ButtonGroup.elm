module M3e.Cem.Html.ButtonGroup exposing (buttonGroup, multi, size, variant)

{-| 
@docs buttonGroup, multi, size, variant
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-button-group>` element — a partial application of `Html.node`. -}
buttonGroup : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
buttonGroup =
    Html.node "m3e-button-group"


{-| Whether multiple toggle buttons can be selected. (default: `false`) -}
multi : Bool -> Html.Attribute msg
multi val_ =
    Html.Attributes.property "multi" (Json.Encode.bool val_)


{-| The size of the group. (default: `"small"`) -}
size : String -> Html.Attribute msg
size =
    Html.Attributes.attribute "size"


{-| The appearance variant of the group. (default: `"standard"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"