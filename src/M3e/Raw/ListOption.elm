module M3e.Raw.ListOption exposing
    ( listOption, disabled, selected, value, onBeforeinput, onInput
    , onChange, onClick
    )

{-| Bottom layer for `<m3e-list-option>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs listOption, disabled, selected, value, onBeforeinput, onInput
@docs onChange, onClick

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-list-option>` element — a partial application of `Html.node`.
-}
listOption : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
listOption =
    Html.node "m3e-list-option"


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""

    else
        Html.Attributes.classList []


{-| Whether the element is selected. (default: `false`)
-}
selected : Bool -> Html.Attribute msg
selected val_ =
    if val_ then
        Html.Attributes.attribute "selected" ""

    else
        Html.Attributes.classList []


{-| A string representing the value of the option.
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.attribute "value"


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
