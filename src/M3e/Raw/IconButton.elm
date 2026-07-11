module M3e.Raw.IconButton exposing
    ( iconButton, disabled, disabledInteractive, download, href, name
    , rel, selected, shape, size, target, toggle
    , type_, value, variant, width, onBeforeinput, onInput
    , onChange, onClick
    )

{-| Bottom layer for `<m3e-icon-button>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs iconButton, disabled, disabledInteractive, download, href, name
@docs rel, selected, shape, size, target, toggle
@docs type_, value, variant, width, onBeforeinput, onInput
@docs onChange, onClick

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-icon-button>` element — a partial application of `Html.node`.
-}
iconButton : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
iconButton =
    Html.node "m3e-icon-button"


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""

    else
        Html.Attributes.classList []


{-| Whether the element is disabled and interactive. (default: `false`)
-}
disabledInteractive : Bool -> Html.Attribute msg
disabledInteractive val_ =
    if val_ then
        Html.Attributes.attribute "disabled-interactive" ""

    else
        Html.Attributes.classList []


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`)
-}
download : String -> Html.Attribute msg
download =
    Html.Attributes.attribute "download"


{-| The URL to which the link button points. (default: `""`)
-}
href : String -> Html.Attribute msg
href =
    Html.Attributes.attribute "href"


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form.
-}
name : String -> Html.Attribute msg
name =
    Html.Attributes.attribute "name"


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel : String -> Html.Attribute msg
rel =
    Html.Attributes.attribute "rel"


{-| Whether the toggle button is selected. (default: `false`)
-}
selected : Bool -> Html.Attribute msg
selected val_ =
    if val_ then
        Html.Attributes.attribute "selected" ""

    else
        Html.Attributes.classList []


{-| The shape of the button. (default: `"rounded"`)
-}
shape : String -> Html.Attribute msg
shape =
    Html.Attributes.attribute "shape"


{-| The size of the button. (default: `"small"`)
-}
size : String -> Html.Attribute msg
size =
    Html.Attributes.attribute "size"


{-| The target of the link button. (default: `""`)
-}
target : String -> Html.Attribute msg
target =
    Html.Attributes.attribute "target"


{-| Whether the button will toggle between selected and unselected states. (default: `false`)
-}
toggle : Bool -> Html.Attribute msg
toggle val_ =
    if val_ then
        Html.Attributes.attribute "toggle" ""

    else
        Html.Attributes.classList []


{-| The type of the element. (default: `"button"`)
-}
type_ : String -> Html.Attribute msg
type_ =
    Html.Attributes.attribute "type"


{-| The value associated with the element's name when it's submitted with form data.
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.attribute "value"


{-| The appearance variant of the button. (default: `"standard"`)
-}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"


{-| The width of the button. (default: `"default"`)
-}
width : String -> Html.Attribute msg
width =
    Html.Attributes.attribute "width"


{-| Listen for `beforeinput` events.
-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput =
    Html.Events.on "beforeinput"


{-| Listen for `input` events.
-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput =
    Html.Events.on "input"


{-| Listen for `change` events.
-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange =
    Html.Events.on "change"


{-| Listen for `click` events.
-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"
