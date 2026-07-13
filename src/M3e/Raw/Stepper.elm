module M3e.Raw.Stepper exposing
    ( stepper, headerPosition, labelPosition, linear, orientation, onChange
    , onBeforeinput, onInput
    )

{-| Bottom layer for `<m3e-stepper>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs stepper, headerPosition, labelPosition, linear, orientation, onChange
@docs onBeforeinput, onInput

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-stepper>` element — a partial application of `Html.node`.
-}
stepper : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
stepper =
    Html.node "m3e-stepper"


{-| The position of the step header, when oriented horizontally. (default: `"above"`)
-}
headerPosition : String -> Html.Attribute msg
headerPosition =
    Html.Attributes.attribute "header-position"


{-| The position of the step labels, when oriented horizontally. (default: `"end"`)
-}
labelPosition : String -> Html.Attribute msg
labelPosition =
    Html.Attributes.attribute "label-position"


{-| Whether the validity of previous steps should be checked or not. (default: `false`)
-}
linear : Bool -> Html.Attribute msg
linear val_ =
    if val_ then
        Html.Attributes.attribute "linear" ""

    else
        Html.Attributes.classList []


{-| The orientation of the stepper. (default: `"horizontal"`)
-}
orientation : String -> Html.Attribute msg
orientation =
    Html.Attributes.attribute "orientation"


{-| Listen for `change` events.
-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange =
    Html.Events.on "change"


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
