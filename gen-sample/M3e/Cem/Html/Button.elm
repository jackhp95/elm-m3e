module M3e.Cem.Html.Button exposing (button, variant, disabled, slot)

import Html exposing (Html)
import Html.Attributes
import Json.Encode

button : List (Html.Attribute msg) -> List (Html msg) -> Html msg
button = Html.node "m3e-button"

variant : String -> Html.Attribute msg
variant = Html.Attributes.attribute "variant"

disabled : Bool -> Html.Attribute msg
disabled b = Html.Attributes.property "disabled" (Json.Encode.bool b)

slot : String -> Html.Attribute msg
slot = Html.Attributes.attribute "slot"
