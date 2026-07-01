module M3e.Cem.Html.PseudoCheckbox exposing (checked, disabled, indeterminate, pseudoCheckbox)

{-| 
@docs pseudoCheckbox, checked, disabled, indeterminate
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-pseudo-checkbox>` element — a partial application of `Html.node`. -}
pseudoCheckbox :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
pseudoCheckbox =
    Html.node "m3e-pseudo-checkbox"


{-| A value indicating whether the element is checked. (default: `false`) -}
checked : Bool -> Html.Attribute msg
checked val_ =
    Html.Attributes.property "checked" (Json.Encode.bool val_)


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| A value indicating whether the element's checked state is indeterminate. (default: `false`) -}
indeterminate : Bool -> Html.Attribute msg
indeterminate val_ =
    Html.Attributes.property "indeterminate" (Json.Encode.bool val_)