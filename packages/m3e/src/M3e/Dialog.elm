module M3e.Dialog exposing
    ( view, alert, closeLabel, disableClose, dismissible, noFocusTrap
    , open, onOpening, onOpened, onClosing, onClosed, onCancel, header
    , actions, closeIcon
    )

{-|
A dialog that provides important prompts in a user flow.

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
[ M3e.Button.view [ M3e.Button.variant M3e.Value.filled ] [ M3e.DialogTrigger.view [ M3e.DialogTrigger.for "dlg" ] [ Kit.text "Open Dialog" ] ]
    , M3e.Dialog.view [ M3e.Dialog.dismissible True ] []
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


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Dialog
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-dialog>` element (lazy IR). -}
view :
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | dialog : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Dialog.dialog
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
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
open : Bool -> M3e.Cem.Attr.Attr { c | open : M3e.Value.Supported } msg
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


{-| Place content in the `header` slot. -}
header :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
header el =
    M3e.Element.Internal.placeSlot "header" el


{-| Place content in the `actions` slot. -}
actions : M3e.Element.Element any msg -> M3e.Element.Element k msg
actions el =
    M3e.Element.Internal.placeSlot "actions" el


{-| Place content in the `close-icon` slot. -}
closeIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
closeIcon el =
    M3e.Element.Internal.placeSlot "close-icon" el