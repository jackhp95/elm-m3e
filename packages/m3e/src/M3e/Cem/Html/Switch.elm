module M3e.Cem.Html.Switch exposing (checked, disabled, icons, name, onBeforeinput, onChange, onClick, onInput, switch, value)

{-| 
@docs switch, checked, disabled, icons, name, value, onBeforeinput, onInput, onChange, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-switch>` element — a partial application of `Html.node`. -}
switch : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
switch =
    Html.node "m3e-switch"


{-| Whether the element is checked. (default: `false`) -}
checked : Bool -> Html.Attribute msg
checked val_ =
    Html.Attributes.property "checked" (Json.Encode.bool val_)


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| The icons to present. (default: `"none"`) -}
icons : String -> Html.Attribute msg
icons =
    Html.Attributes.attribute "icons"


{-| The name that identifies the element when submitting the associated form. -}
name : String -> Html.Attribute msg
name =
    Html.Attributes.attribute "name"


{-| A string representing the value of the switch. (default: `"on"`) -}
value : String -> Html.Attribute msg
value =
    Html.Attributes.attribute "value"


{-| Listen for `beforeinput` events. -}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput =
    Html.Events.on "beforeinput"


{-| Listen for `input` events. -}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput =
    Html.Events.on "input"


{-| Listen for `change` events. -}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange =
    Html.Events.on "change"


{-| Listen for `click` events. -}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"