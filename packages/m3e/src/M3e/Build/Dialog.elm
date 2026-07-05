module M3e.Build.Dialog exposing
    ( Builder, AttrCaps, SlotCaps, dialog, alert, closeLabel
    , disableClose, dismissible, noFocusTrap, open, onOpening, onOpened, onClosing
    , onClosed, onCancel, build
    )

{-|
The ⑤ Build shape for `<m3e-dialog>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Dialog as Dialog`.

@docs Builder, AttrCaps, SlotCaps, dialog, alert, closeLabel
@docs disableClose, dismissible, noFocusTrap, open, onOpening, onOpened
@docs onClosing, onClosed, onCancel, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.Dialog
import M3e.Cem.Html.Dialog
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-dialog>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | dialog : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { alert : M3e.Build.Internal.Available
    , closeLabel : M3e.Build.Internal.Available
    , disableClose : M3e.Build.Internal.Available
    , dismissible : M3e.Build.Internal.Available
    , noFocusTrap : M3e.Build.Internal.Available
    , open : M3e.Build.Internal.Available
    , onOpening : M3e.Build.Internal.Available
    , onOpened : M3e.Build.Internal.Available
    , onClosing : M3e.Build.Internal.Available
    , onClosed : M3e.Build.Internal.Available
    , onCancel : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { header : M3e.Build.Internal.Available
    , actions : M3e.Build.Internal.Available
    , closeIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-dialog>`. -}
dialog : Builder AttrCaps SlotCaps msg kind
dialog =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Dialog.dialog
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether the dialog is an alert. (default: `false`) -}
alert :
    Bool
    -> Builder { a | alert : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | alert : M3e.Build.Internal.Used } s msg kind
alert v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Dialog.alert v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to dismiss the dialog. (default: `"Close"`) -}
closeLabel :
    String
    -> Builder { a | closeLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | closeLabel : M3e.Build.Internal.Used } s msg kind
closeLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Dialog.closeLabel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether users cannot click the backdrop or press ESC to dismiss the dialog. (default: `false`) -}
disableClose :
    Bool
    -> Builder { a | disableClose : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disableClose : M3e.Build.Internal.Used } s msg kind
disableClose v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Dialog.disableClose v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether a button is presented that can be used to close the dialog. (default: `false`) -}
dismissible :
    Bool
    -> Builder { a | dismissible : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | dismissible : M3e.Build.Internal.Used } s msg kind
dismissible v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Dialog.dismissible v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether to disable focus trapping, which keeps keyboard `Tab` navigation within the dialog. (default: `false`) -}
noFocusTrap :
    Bool
    -> Builder { a | noFocusTrap : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | noFocusTrap : M3e.Build.Internal.Used } s msg kind
noFocusTrap v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Dialog.noFocusTrap v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the dialog is open. (default: `false`) -}
open :
    Bool
    -> Builder { a | open : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | open : M3e.Build.Internal.Used } s msg kind
open v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Dialog.open v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the dialog begins to open. -}
onOpening :
    Json.Decode.Decoder msg
    -> Builder { a | onOpening : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onOpening : M3e.Build.Internal.Used } s msg kind
onOpening v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute
                       M3e.Cem.Html.Dialog.onOpening
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the dialog has opened. -}
onOpened :
    Json.Decode.Decoder msg
    -> Builder { a | onOpened : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onOpened : M3e.Build.Internal.Used } s msg kind
onOpened v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute
                       M3e.Cem.Html.Dialog.onOpened
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the dialog begins to close. -}
onClosing :
    Json.Decode.Decoder msg
    -> Builder { a | onClosing : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClosing : M3e.Build.Internal.Used } s msg kind
onClosing v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute
                       M3e.Cem.Html.Dialog.onClosing
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the dialog has closed. -}
onClosed :
    Json.Decode.Decoder msg
    -> Builder { a | onClosed : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClosed : M3e.Build.Internal.Used } s msg kind
onClosed v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute
                       M3e.Cem.Html.Dialog.onClosed
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the dialog is cancelled. -}
onCancel :
    Json.Decode.Decoder msg
    -> Builder { a | onCancel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onCancel : M3e.Build.Internal.Used } s msg kind
onCancel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.Attr.Internal.attribute
                       M3e.Cem.Html.Dialog.onCancel
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-dialog>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { dialog : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)