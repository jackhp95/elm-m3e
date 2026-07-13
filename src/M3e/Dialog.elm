module M3e.Dialog exposing
    ( view, alert, closeLabel, disableClose, dismissible, noFocusTrap
    , open, onOpening, onOpened, onClosing, onClosed, onCancel
    , header, actions, closeIcon
    )

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

<!-- elm-cem:docmeta category=Containment -->


## Examples


### Examples

<!-- elm-cem:example title="Opening" -->
```elm
[ M3e.Button.view [ M3e.Button.variant M3e.Token.filled ] [ M3e.DialogTrigger.view [ M3e.DialogTrigger.for "dlg" ] [ Kit.text "Open Dialog" ] ]
    , M3e.Dialog.view [ M3e.Attributes.id "dlg", M3e.Dialog.dismissible True ] []
    ]
```

<!-- elm-cem:example title="Actions" -->
```elm
M3e.Button.view [] [ M3e.DialogAction.view [ M3e.DialogAction.returnValue "ok" ] [ Kit.text "Close" ] ]
```

@docs view, alert, closeLabel, disableClose, dismissible, noFocusTrap
@docs open, onOpening, onOpened, onClosing, onClosed, onCancel
@docs header, actions, closeIcon

-}

import M3e.Html.Dialog
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-dialog>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | dialog : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Dialog.dialog
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether the dialog is an alert. (default: `false`)
-}
alert : Bool -> Markup.Html.Attr.Attr { c | alert : M3e.Token.Supported } msg
alert =
    M3e.Html.Dialog.alert


{-| The accessible label given to the button used to dismiss the dialog. (default: `"Close"`)
-}
closeLabel : String -> Markup.Html.Attr.Attr { c | closeLabel : M3e.Token.Supported } msg
closeLabel =
    M3e.Html.Dialog.closeLabel


{-| Whether users cannot click the backdrop or press ESC to dismiss the dialog. (default: `false`)
-}
disableClose : Bool -> Markup.Html.Attr.Attr { c | disableClose : M3e.Token.Supported } msg
disableClose =
    M3e.Html.Dialog.disableClose


{-| Whether a button is presented that can be used to close the dialog. (default: `false`)
-}
dismissible : Bool -> Markup.Html.Attr.Attr { c | dismissible : M3e.Token.Supported } msg
dismissible =
    M3e.Html.Dialog.dismissible


{-| Whether to disable focus trapping, which keeps keyboard `Tab` navigation within the dialog. (default: `false`)
-}
noFocusTrap : Bool -> Markup.Html.Attr.Attr { c | noFocusTrap : M3e.Token.Supported } msg
noFocusTrap =
    M3e.Html.Dialog.noFocusTrap


{-| Whether the dialog is open. (default: `false`)
-}
open : Bool -> Markup.Html.Attr.Attr { c | open : M3e.Token.Supported } msg
open =
    M3e.Html.Dialog.open


{-| Listen for `opening` events.
-}
onOpening : msg -> Markup.Html.Attr.Attr { c | onOpening : M3e.Token.Supported } msg
onOpening =
    M3e.Html.Dialog.onOpening


{-| Listen for `opened` events.
-}
onOpened : msg -> Markup.Html.Attr.Attr { c | onOpened : M3e.Token.Supported } msg
onOpened =
    M3e.Html.Dialog.onOpened


{-| Listen for `closing` events.
-}
onClosing : msg -> Markup.Html.Attr.Attr { c | onClosing : M3e.Token.Supported } msg
onClosing =
    M3e.Html.Dialog.onClosing


{-| Listen for `closed` events.
-}
onClosed : msg -> Markup.Html.Attr.Attr { c | onClosed : M3e.Token.Supported } msg
onClosed =
    M3e.Html.Dialog.onClosed


{-| Listen for `cancel` events.
-}
onCancel : msg -> Markup.Html.Attr.Attr { c | onCancel : M3e.Token.Supported } msg
onCancel =
    M3e.Html.Dialog.onCancel


{-| Place content in the `header` slot.
-}
header :
    Markup.Element.Element { text : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
header el =
    Markup.Element.Internal.placeSlot "header" el


{-| Place content in the `actions` slot.
-}
actions : Markup.Element.Element any msg -> Markup.Element.Element k msg
actions el =
    Markup.Element.Internal.placeSlot "actions" el


{-| Place content in the `close-icon` slot.
-}
closeIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
closeIcon el =
    Markup.Element.Internal.placeSlot "close-icon" el
