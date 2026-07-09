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


{-| The raw `<m3e-dialog>` element — a partial application of `Html.node`. -}
dialog : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
dialog =
    Html.node "m3e-dialog"


{-| Whether the dialog is an alert. (default: `false`) -}
alert : Bool -> Html.Attribute msg
alert val_ =
    if val_ then
        Html.Attributes.attribute "alert" ""
    
    else
        Html.Attributes.classList []


{-| The accessible label given to the button used to dismiss the dialog. (default: `"Close"`) -}
closeLabel : String -> Html.Attribute msg
closeLabel =
    Html.Attributes.attribute "close-label"


{-| Whether users cannot click the backdrop or press ESC to dismiss the dialog. (default: `false`) -}
disableClose : Bool -> Html.Attribute msg
disableClose val_ =
    if val_ then
        Html.Attributes.attribute "disable-close" ""
    
    else
        Html.Attributes.classList []


{-| Whether a button is presented that can be used to close the dialog. (default: `false`) -}
dismissible : Bool -> Html.Attribute msg
dismissible val_ =
    if val_ then
        Html.Attributes.attribute "dismissible" ""
    
    else
        Html.Attributes.classList []


{-| Whether to disable focus trapping, which keeps keyboard `Tab` navigation within the dialog. (default: `false`) -}
noFocusTrap : Bool -> Html.Attribute msg
noFocusTrap val_ =
    if val_ then
        Html.Attributes.attribute "no-focus-trap" ""
    
    else
        Html.Attributes.classList []


{-| Whether the dialog is open. (default: `false`) -}
open : Bool -> Html.Attribute msg
open val_ =
    if val_ then
        Html.Attributes.attribute "open" ""
    
    else
        Html.Attributes.classList []


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