module M3e.Raw.Snackbar exposing
    ( snackbar, action, closeLabel, dismissible, duration, onBeforetoggle
    , onToggle
    )

{-| Bottom layer for `<m3e-snackbar>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs snackbar, action, closeLabel, dismissible, duration, onBeforetoggle
@docs onToggle

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-snackbar>` element — a partial application of `Html.node`.
-}
snackbar : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
snackbar =
    Html.node "m3e-snackbar"


{-| The label of the snackbar's action. (default: `""`)
-}
action : String -> Html.Attribute msg
action =
    Html.Attributes.attribute "action"


{-| The accessible label given to the button used to dismiss the snackbar. (default: `"Close"`)
-}
closeLabel : String -> Html.Attribute msg
closeLabel =
    Html.Attributes.attribute "close-label"


{-| Whether a button is presented that can be used to close the snackbar. (default: `false`)
-}
dismissible : Bool -> Html.Attribute msg
dismissible val_ =
    if val_ then
        Html.Attributes.attribute "dismissible" ""

    else
        Html.Attributes.classList []


{-| The length of time, in milliseconds, to wait before automatically dismissing the snackbar. (default: `3000`)
-}
duration : Float -> Html.Attribute msg
duration val_ =
    Html.Attributes.attribute "duration" (String.fromFloat val_)


{-| Listen for `beforetoggle` events.
-}
onBeforetoggle : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforetoggle =
    Html.Events.on "beforetoggle"


{-| Listen for `toggle` events.
-}
onToggle : Json.Decode.Decoder msg -> Html.Attribute msg
onToggle =
    Html.Events.on "toggle"
