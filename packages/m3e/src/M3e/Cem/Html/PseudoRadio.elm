module M3e.Cem.Html.PseudoRadio exposing (checked, disabled, pseudoRadio)

{-| 
@docs pseudoRadio, checked, disabled
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-pseudo-radio>` element — a partial application of `Html.node`. -}
pseudoRadio : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
pseudoRadio =
    Html.node "m3e-pseudo-radio"


{-| A value indicating whether the element is checked. (default: `false`) -}
checked : Bool -> Html.Attribute msg
checked val_ =
    Html.Attributes.property "checked" (Json.Encode.bool val_)


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)