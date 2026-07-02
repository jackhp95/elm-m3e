module M3e.Cem.Html.FormField exposing
    ( formField, floatLabel, hideRequiredMarker, hideSubscript, variant
    )

{-|
Bottom layer for `<m3e-form-field>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs formField, floatLabel, hideRequiredMarker, hideSubscript, variant
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-form-field>` element — a partial application of `Html.node`. -}
formField : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
formField =
    Html.node "m3e-form-field"


{-| Specifies whether the label should float always or only when necessary. (default: `"auto"`) -}
floatLabel : String -> Html.Attribute msg
floatLabel =
    Html.Attributes.attribute "float-label"


{-| Whether the required marker should be hidden. (default: `false`) -}
hideRequiredMarker : Bool -> Html.Attribute msg
hideRequiredMarker val_ =
    Html.Attributes.property "hideRequiredMarker" (Json.Encode.bool val_)


{-| Whether subscript content is hidden. (default: `"auto"`) -}
hideSubscript : String -> Html.Attribute msg
hideSubscript =
    Html.Attributes.attribute "hide-subscript"


{-| The appearance variant of the field. (default: `"outlined"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"