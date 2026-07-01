module M3e.Cem.Html.Button exposing (button, disabled, disabledInteractive, download, href, name, onBeforeinput, onChange, onClick, onInput, rel, selected, shape, size, target, toggle, type_, value, variant)

{-| 
@docs button, disabled, disabledInteractive, download, href, name, rel, selected, shape, size, target, toggle, type_, value, variant, onBeforeinput, onInput, onChange, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-button>` element — a partial application of `Html.node`. -}
button : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
button =
    Html.node "m3e-button"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive : Bool -> Html.Attribute msg
disabledInteractive val_ =
    Html.Attributes.property "disabledInteractive" (Json.Encode.bool val_)


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`) -}
download : String -> Html.Attribute msg
download =
    Html.Attributes.attribute "download"


{-| The URL to which the link button points. (default: `""`) -}
href : String -> Html.Attribute msg
href =
    Html.Attributes.attribute "href"


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form. -}
name : String -> Html.Attribute msg
name =
    Html.Attributes.attribute "name"


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel : String -> Html.Attribute msg
rel =
    Html.Attributes.attribute "rel"


{-| Whether the toggle button is selected. (default: `false`) -}
selected : Bool -> Html.Attribute msg
selected val_ =
    Html.Attributes.property "selected" (Json.Encode.bool val_)


{-| The shape of the button. (default: `"rounded"`) -}
shape : String -> Html.Attribute msg
shape =
    Html.Attributes.attribute "shape"


{-| The size of the button. (default: `"small"`) -}
size : String -> Html.Attribute msg
size =
    Html.Attributes.attribute "size"


{-| The target of the link button. (default: `""`) -}
target : String -> Html.Attribute msg
target =
    Html.Attributes.attribute "target"


{-| Whether the button will toggle between selected and unselected states. (default: `false`) -}
toggle : Bool -> Html.Attribute msg
toggle val_ =
    Html.Attributes.property "toggle" (Json.Encode.bool val_)


{-| The type of the element. (default: `"button"`) -}
type_ : String -> Html.Attribute msg
type_ =
    Html.Attributes.attribute "type"


{-| The value associated with the element's name when it's submitted with form data. -}
value : String -> Html.Attribute msg
value =
    Html.Attributes.attribute "value"


{-| The appearance variant of the button. (default: `"text"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"


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