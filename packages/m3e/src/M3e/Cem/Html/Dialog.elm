module M3e.Cem.Html.Dialog exposing
    ( dialog, alert, closeLabel, disableClose, dismissible, noFocusTrap
    , open, onOpening, onOpened, onClosing, onClosed, onCancel
    )

{-|
Bottom layer for `<m3e-dialog>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs dialog, alert, closeLabel, disableClose, dismissible, noFocusTrap
@docs open, onOpening, onOpened, onClosing, onClosed, onCancel
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-dialog>` element — a partial application of `Html.node`. -}
dialog : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
dialog =
    Html.node "m3e-dialog"


{-| Whether the dialog is an alert. (default: `false`) -}
alert : Bool -> Html.Attribute msg
alert val_ =
    Html.Attributes.property "alert" (Json.Encode.bool val_)


{-| The accessible label given to the button used to dismiss the dialog. (default: `"Close"`) -}
closeLabel : String -> Html.Attribute msg
closeLabel =
    Html.Attributes.attribute "close-label"


{-| Whether users cannot click the backdrop or press ESC to dismiss the dialog. (default: `false`) -}
disableClose : Bool -> Html.Attribute msg
disableClose val_ =
    Html.Attributes.property "disableClose" (Json.Encode.bool val_)


{-| Whether a button is presented that can be used to close the dialog. (default: `false`) -}
dismissible : Bool -> Html.Attribute msg
dismissible val_ =
    Html.Attributes.property "dismissible" (Json.Encode.bool val_)


{-| Whether to disable focus trapping, which keeps keyboard `Tab` navigation within the dialog. (default: `false`) -}
noFocusTrap : Bool -> Html.Attribute msg
noFocusTrap val_ =
    Html.Attributes.property "noFocusTrap" (Json.Encode.bool val_)


{-| Whether the dialog is open. (default: `false`) -}
open : String -> Html.Attribute msg
open =
    Html.Attributes.attribute "open"


{-| Listen for `opening` events. -}
onOpening : Json.Decode.Decoder msg -> Html.Attribute msg
onOpening =
    Html.Events.on "opening"


{-| Listen for `opened` events. -}
onOpened : Json.Decode.Decoder msg -> Html.Attribute msg
onOpened =
    Html.Events.on "opened"


{-| Listen for `closing` events. -}
onClosing : Json.Decode.Decoder msg -> Html.Attribute msg
onClosing =
    Html.Events.on "closing"


{-| Listen for `closed` events. -}
onClosed : Json.Decode.Decoder msg -> Html.Attribute msg
onClosed =
    Html.Events.on "closed"


{-| Listen for `cancel` events. -}
onCancel : Json.Decode.Decoder msg -> Html.Attribute msg
onCancel =
    Html.Events.on "cancel"