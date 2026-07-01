module M3e.Dialog exposing (actions, alert, child, children, closeIcon, closeLabel, dialog, disableClose, dismissible, header, noFocusTrap, onCancel, onClosed, onClosing, onOpened, onOpening, open)

{-| 
@docs dialog, alert, closeLabel, disableClose, dismissible, noFocusTrap, open, onOpening, onOpened, onClosing, onClosed, onCancel, child, header, actions, closeIcon, children
-}


import M3e.Cem.Attr
import M3e.Cem.Dialog
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-dialog>` element (lazy IR). -}
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
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , header : M3e.Value.Supported
    , actions : M3e.Value.Supported
    , closeIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | dialog : M3e.Value.Supported } msg
dialog attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Dialog.dialog (List.map M3e.Cem.Attr.forget erased) ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


{-| Whether the dialog is an alert. (default: `false`) -}
alert : Bool -> M3e.Cem.Attr.Attr { c | alert : M3e.Value.Supported } msg
alert =
    M3e.Cem.Dialog.alert


{-| The accessible label given to the button used to dismiss the dialog. (default: `"Close"`) -}
closeLabel :
    String -> M3e.Cem.Attr.Attr { c | closeLabel : M3e.Value.Supported } msg
closeLabel =
    M3e.Cem.Dialog.closeLabel


{-| Whether users cannot click the backdrop or press ESC to dismiss the dialog. (default: `false`) -}
disableClose :
    Bool -> M3e.Cem.Attr.Attr { c | disableClose : M3e.Value.Supported } msg
disableClose =
    M3e.Cem.Dialog.disableClose


{-| Whether a button is presented that can be used to close the dialog. (default: `false`) -}
dismissible :
    Bool -> M3e.Cem.Attr.Attr { c | dismissible : M3e.Value.Supported } msg
dismissible =
    M3e.Cem.Dialog.dismissible


{-| Whether to disable focus trapping, which keeps keyboard `Tab` navigation within the dialog. (default: `false`) -}
noFocusTrap :
    Bool -> M3e.Cem.Attr.Attr { c | noFocusTrap : M3e.Value.Supported } msg
noFocusTrap =
    M3e.Cem.Dialog.noFocusTrap


{-| Whether the dialog is open. (default: `false`) -}
open : String -> M3e.Cem.Attr.Attr { c | open : M3e.Value.Supported } msg
open =
    M3e.Cem.Dialog.open


{-| Listen for `opening` events. -}
onOpening : msg -> M3e.Cem.Attr.Attr { c | onOpening : M3e.Value.Supported } msg
onOpening =
    M3e.Cem.Dialog.onOpening


{-| Listen for `opened` events. -}
onOpened : msg -> M3e.Cem.Attr.Attr { c | onOpened : M3e.Value.Supported } msg
onOpened =
    M3e.Cem.Dialog.onOpened


{-| Listen for `closing` events. -}
onClosing : msg -> M3e.Cem.Attr.Attr { c | onClosing : M3e.Value.Supported } msg
onClosing =
    M3e.Cem.Dialog.onClosing


{-| Listen for `closed` events. -}
onClosed : msg -> M3e.Cem.Attr.Attr { c | onClosed : M3e.Value.Supported } msg
onClosed =
    M3e.Cem.Dialog.onClosed


{-| Listen for `cancel` events. -}
onCancel : msg -> M3e.Cem.Attr.Attr { c | onCancel : M3e.Value.Supported } msg
onCancel =
    M3e.Cem.Dialog.onCancel


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place content in the `header` slot. -}
header :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | header : M3e.Value.Supported } msg
header el =
    M3e.Content.slot "header" el


{-| Place content in the `actions` slot. -}
actions :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | actions : M3e.Value.Supported } msg
actions el =
    M3e.Content.slot "actions" el


{-| Place content in the `close-icon` slot. -}
closeIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | closeIcon : M3e.Value.Supported } msg
closeIcon el =
    M3e.Content.slot "close-icon" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element any msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els