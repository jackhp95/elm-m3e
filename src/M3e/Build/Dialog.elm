module M3e.Build.Dialog exposing
    ( Builder, AttrCaps, SlotCaps, dialog, attr, alert
    , closeLabel, disableClose, dismissible, noFocusTrap, open, onOpening
    , onOpened, onClosing, onClosed, onCancel, header, actions
    , closeIcon, build
    )

{-| The Build form for `<m3e-dialog>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Dialog as Dialog`.

@docs Builder, AttrCaps, SlotCaps, dialog, attr, alert
@docs closeLabel, disableClose, dismissible, noFocusTrap, open, onOpening
@docs onOpened, onClosing, onClosed, onCancel, header, actions
@docs closeIcon, build

-}

import M3e.Build.Internal
import M3e.Html.Dialog
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-dialog>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | dialog : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
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


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { header : M3e.Build.Internal.Available
    , actions : M3e.Build.Internal.Available
    , closeIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-dialog>`.
-}
dialog : Builder AttrCaps SlotCaps msg kind
dialog =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Dialog.dialog
                    (List.map Markup.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            []
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times.
-}
attr :
    Markup.Html.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget a_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the dialog is an alert. (default: `false`)
-}
alert :
    Bool
    -> Builder { a | alert : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | alert : M3e.Build.Internal.Used } s msg kind
alert v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Dialog.alert v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to dismiss the dialog. (default: `"Close"`)
-}
closeLabel :
    String
    -> Builder { a | closeLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | closeLabel : M3e.Build.Internal.Used } s msg kind
closeLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Dialog.closeLabel v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether users cannot click the backdrop or press ESC to dismiss the dialog. (default: `false`)
-}
disableClose :
    Bool
    -> Builder { a | disableClose : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disableClose : M3e.Build.Internal.Used } s msg kind
disableClose v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Dialog.disableClose v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether a button is presented that can be used to close the dialog. (default: `false`)
-}
dismissible :
    Bool
    -> Builder { a | dismissible : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | dismissible : M3e.Build.Internal.Used } s msg kind
dismissible v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Dialog.dismissible v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether to disable focus trapping, which keeps keyboard `Tab` navigation within the dialog. (default: `false`)
-}
noFocusTrap :
    Bool
    -> Builder { a | noFocusTrap : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | noFocusTrap : M3e.Build.Internal.Used } s msg kind
noFocusTrap v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Dialog.noFocusTrap v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the dialog is open. (default: `false`)
-}
open :
    Bool
    -> Builder { a | open : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | open : M3e.Build.Internal.Used } s msg kind
open v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Dialog.open v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the dialog begins to open.
-}
onOpening :
    msg
    -> Builder { a | onOpening : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onOpening : M3e.Build.Internal.Used } s msg kind
onOpening v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Dialog.onOpening v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the dialog has opened.
-}
onOpened :
    msg
    -> Builder { a | onOpened : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onOpened : M3e.Build.Internal.Used } s msg kind
onOpened v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Dialog.onOpened v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the dialog begins to close.
-}
onClosing :
    msg
    -> Builder { a | onClosing : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClosing : M3e.Build.Internal.Used } s msg kind
onClosing v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Dialog.onClosing v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the dialog has closed.
-}
onClosed :
    msg
    -> Builder { a | onClosed : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClosed : M3e.Build.Internal.Used } s msg kind
onClosed v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Dialog.onClosed v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the dialog is cancelled.
-}
onCancel :
    msg
    -> Builder { a | onCancel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onCancel : M3e.Build.Internal.Used } s msg kind
onCancel v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Dialog.onCancel v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `header` slot.
-}
header :
    Markup.Element.Element { text : Markup.Kind.Shared } msg
    -> Builder a { s | header : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | header : M3e.Build.Internal.Used } msg kind
header el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "header" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `actions` slot.
-}
actions :
    Markup.Element.Element any msg
    -> Builder a { s | actions : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | actions : M3e.Build.Internal.Used } msg kind
actions el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "actions" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `close-icon` slot.
-}
closeIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Builder a { s | closeIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | closeIcon : M3e.Build.Internal.Used } msg kind
closeIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "close-icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-dialog>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { dialog : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
