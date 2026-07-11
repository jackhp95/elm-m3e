module M3e.Html.Dialog exposing
    ( dialog, alert, closeLabel, disableClose, dismissible, noFocusTrap
    , open, onOpening, onOpened, onClosing, onClosed, onCancel
    )

{-| Middle layer for `<m3e-dialog>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Dialog` module for everyday use.

@docs dialog, alert, closeLabel, disableClose, dismissible, noFocusTrap
@docs open, onOpening, onOpened, onClosing, onClosed, onCancel

-}

import Html
import Json.Decode
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.Dialog
import M3e.Token


{-| A dialog that provides important prompts in a user flow.

**Component Info:**

  - **Extends:** `LitElement`

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
    List
        (M3e.Html.Attr.Attr
            { alert : M3e.Token.Supported
            , closeLabel : M3e.Token.Supported
            , disableClose : M3e.Token.Supported
            , dismissible : M3e.Token.Supported
            , noFocusTrap : M3e.Token.Supported
            , open : M3e.Token.Supported
            , onOpening : M3e.Token.Supported
            , onOpened : M3e.Token.Supported
            , onClosing : M3e.Token.Supported
            , onClosed : M3e.Token.Supported
            , onCancel : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
dialog attributes children =
    M3e.Raw.Dialog.dialog
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| Whether the dialog is an alert. (default: `false`)
-}
alert : Bool -> M3e.Html.Attr.Attr { c | alert : M3e.Token.Supported } msg
alert =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Dialog.alert


{-| The accessible label given to the button used to dismiss the dialog. (default: `"Close"`)
-}
closeLabel : String -> M3e.Html.Attr.Attr { c | closeLabel : M3e.Token.Supported } msg
closeLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Dialog.closeLabel


{-| Whether users cannot click the backdrop or press ESC to dismiss the dialog. (default: `false`)
-}
disableClose : Bool -> M3e.Html.Attr.Attr { c | disableClose : M3e.Token.Supported } msg
disableClose =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Dialog.disableClose


{-| Whether a button is presented that can be used to close the dialog. (default: `false`)
-}
dismissible : Bool -> M3e.Html.Attr.Attr { c | dismissible : M3e.Token.Supported } msg
dismissible =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Dialog.dismissible


{-| Whether to disable focus trapping, which keeps keyboard `Tab` navigation within the dialog. (default: `false`)
-}
noFocusTrap : Bool -> M3e.Html.Attr.Attr { c | noFocusTrap : M3e.Token.Supported } msg
noFocusTrap =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Dialog.noFocusTrap


{-| Whether the dialog is open. (default: `false`)
-}
open : Bool -> M3e.Html.Attr.Attr { c | open : M3e.Token.Supported } msg
open =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Dialog.open


{-| Listen for `opening` events.
-}
onOpening : msg -> M3e.Html.Attr.Attr { c | onOpening : M3e.Token.Supported } msg
onOpening f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Dialog.onOpening
        (Json.Decode.succeed f_)


{-| Listen for `opened` events.
-}
onOpened : msg -> M3e.Html.Attr.Attr { c | onOpened : M3e.Token.Supported } msg
onOpened f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Dialog.onOpened
        (Json.Decode.succeed f_)


{-| Listen for `closing` events.
-}
onClosing : msg -> M3e.Html.Attr.Attr { c | onClosing : M3e.Token.Supported } msg
onClosing f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Dialog.onClosing
        (Json.Decode.succeed f_)


{-| Listen for `closed` events.
-}
onClosed : msg -> M3e.Html.Attr.Attr { c | onClosed : M3e.Token.Supported } msg
onClosed f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Dialog.onClosed
        (Json.Decode.succeed f_)


{-| Listen for `cancel` events.
-}
onCancel : msg -> M3e.Html.Attr.Attr { c | onCancel : M3e.Token.Supported } msg
onCancel f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Dialog.onCancel
        (Json.Decode.succeed f_)
