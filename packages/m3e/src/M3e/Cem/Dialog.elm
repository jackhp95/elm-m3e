module M3e.Cem.Dialog exposing
    ( dialog, alert, closeLabel, disableClose, dismissible, noFocusTrap
    , open, onOpening, onOpened, onClosing, onClosed, onCancel
    )

{-|
Middle layer for `<m3e-dialog>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Dialog` module for everyday use.

@docs dialog, alert, closeLabel, disableClose, dismissible, noFocusTrap
@docs open, onOpening, onOpened, onClosing, onClosed, onCancel
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.Dialog
import M3e.Value


{-| A dialog that provides important prompts in a user flow.

**Events:**
- `opening`: Dispatched when the dialog begins to open.
- `opened`: Dispatched when the dialog has opened.
- `closing`: Dispatched when the dialog begins to close.
- `closed`: Dispatched when the dialog has closed.
- `cancel`: Dispatched when the dialog is cancelled.

**Slots:**
- `header`: Renders the header of the dialog.
- `actions`: Renders the actions of the dialog.
- `close-icon`: Renders the icon of the button used to close the dialog.
-}
dialog :
    List (M3e.Cem.Attr.Attr { alert : M3e.Value.Supported
    , closeLabel : M3e.Value.Supported
    , disableClose : M3e.Value.Supported
    , dismissible : M3e.Value.Supported
    , noFocusTrap : M3e.Value.Supported
    , open : M3e.Value.Supported
    , onOpening : M3e.Value.Supported
    , onOpened : M3e.Value.Supported
    , onClosing : M3e.Value.Supported
    , onClosed : M3e.Value.Supported
    , onCancel : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
dialog attributes children =
    M3e.Cem.Html.Dialog.dialog
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the dialog is an alert. (default: `false`) -}
alert : Bool -> M3e.Cem.Attr.Attr { c | alert : M3e.Value.Supported } msg
alert =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Dialog.alert


{-| The accessible label given to the button used to dismiss the dialog. (default: `"Close"`) -}
closeLabel :
    String -> M3e.Cem.Attr.Attr { c | closeLabel : M3e.Value.Supported } msg
closeLabel =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Dialog.closeLabel


{-| Whether users cannot click the backdrop or press ESC to dismiss the dialog. (default: `false`) -}
disableClose :
    Bool -> M3e.Cem.Attr.Attr { c | disableClose : M3e.Value.Supported } msg
disableClose =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Dialog.disableClose


{-| Whether a button is presented that can be used to close the dialog. (default: `false`) -}
dismissible :
    Bool -> M3e.Cem.Attr.Attr { c | dismissible : M3e.Value.Supported } msg
dismissible =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Dialog.dismissible


{-| Whether to disable focus trapping, which keeps keyboard `Tab` navigation within the dialog. (default: `false`) -}
noFocusTrap :
    Bool -> M3e.Cem.Attr.Attr { c | noFocusTrap : M3e.Value.Supported } msg
noFocusTrap =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Dialog.noFocusTrap


{-| Whether the dialog is open. (default: `false`) -}
open : String -> M3e.Cem.Attr.Attr { c | open : M3e.Value.Supported } msg
open =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Dialog.open


{-| Listen for `opening` events. -}
onOpening : msg -> M3e.Cem.Attr.Attr { c | onOpening : M3e.Value.Supported } msg
onOpening f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.Dialog.onOpening
        (Json.Decode.succeed f_)


{-| Listen for `opened` events. -}
onOpened : msg -> M3e.Cem.Attr.Attr { c | onOpened : M3e.Value.Supported } msg
onOpened f_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Dialog.onOpened (Json.Decode.succeed f_)


{-| Listen for `closing` events. -}
onClosing : msg -> M3e.Cem.Attr.Attr { c | onClosing : M3e.Value.Supported } msg
onClosing f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.Dialog.onClosing
        (Json.Decode.succeed f_)


{-| Listen for `closed` events. -}
onClosed : msg -> M3e.Cem.Attr.Attr { c | onClosed : M3e.Value.Supported } msg
onClosed f_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Dialog.onClosed (Json.Decode.succeed f_)


{-| Listen for `cancel` events. -}
onCancel : msg -> M3e.Cem.Attr.Attr { c | onCancel : M3e.Value.Supported } msg
onCancel f_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Dialog.onCancel (Json.Decode.succeed f_)