module M3e.Cem.Html.Snackbar exposing (action, closeLabel, dismissible, duration, onBeforetoggle, onToggle, snackbar)

{-| 
@docs snackbar, action, closeLabel, dismissible, duration, onBeforetoggle, onToggle
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-snackbar>` element — a partial application of `Html.node`. -}
snackbar : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
snackbar =
    Html.node "m3e-snackbar"


{-| The label of the snackbar's action. (default: `""`) -}
action : String -> Html.Attribute msg
action =
    Html.Attributes.attribute "action"


{-| The accessible label given to the button used to dismiss the snackbar. (default: `"Close"`) -}
closeLabel : String -> Html.Attribute msg
closeLabel =
    Html.Attributes.attribute "close-label"


{-| Whether a button is presented that can be used to close the snackbar. (default: `false`) -}
dismissible : Bool -> Html.Attribute msg
dismissible val_ =
    Html.Attributes.property "dismissible" (Json.Encode.bool val_)


{-| The length of time, in milliseconds, to wait before automatically dismissing the snackbar. (default: `3000`) -}
duration : Float -> Html.Attribute msg
duration val_ =
    Html.Attributes.property "duration" (Json.Encode.float val_)


{-| Listen for `beforetoggle` events. -}
onBeforetoggle : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforetoggle =
    Html.Events.on "beforetoggle"


{-| Listen for `toggle` events. -}
onToggle : Json.Decode.Decoder msg -> Html.Attribute msg
onToggle =
    Html.Events.on "toggle"