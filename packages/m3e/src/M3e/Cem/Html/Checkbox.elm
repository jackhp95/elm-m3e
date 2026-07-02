module M3e.Cem.Html.Checkbox exposing
    ( checkbox, checked, disabled, indeterminate, name, required
    , value, onBeforeinput, onInput, onChange, onInvalid, onClick
    )

{-|
Bottom layer for `<m3e-checkbox>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs checkbox, checked, disabled, indeterminate, name, required
@docs value, onBeforeinput, onInput, onChange, onInvalid, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-checkbox>` element — a partial application of `Html.node`. -}
checkbox : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
checkbox =
    Html.node "m3e-checkbox"


{-| Whether the element is checked. (default: `false`) -}
checked : Bool -> Html.Attribute msg
checked val_ =
    Html.Attributes.property "checked" (Json.Encode.bool val_)


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether the element's checked state is indeterminate. (default: `false`) -}
indeterminate : Bool -> Html.Attribute msg
indeterminate val_ =
    Html.Attributes.property "indeterminate" (Json.Encode.bool val_)


{-| The name that identifies the element when submitting the associated form. -}
name : String -> Html.Attribute msg
name =
    Html.Attributes.attribute "name"


{-| Whether the element is required. (default: `false`) -}
required : Bool -> Html.Attribute msg
required val_ =
    Html.Attributes.property "required" (Json.Encode.bool val_)


{-| A string representing the value of the checkbox. (default: `"on"`) -}
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


{-| Listen for `invalid` events. -}
onInvalid : Json.Decode.Decoder msg -> Html.Attribute msg
onInvalid =
    Html.Events.on "invalid"


{-| Listen for `click` events. -}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"