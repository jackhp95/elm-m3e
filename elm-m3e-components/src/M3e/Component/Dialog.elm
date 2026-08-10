module M3e.Component.Dialog exposing
    ( view, build, toElement
    , Is, Attrs, CloseIconSlot, HeaderSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , alert, closeLabel, disableClose, dismissible, noFocusTrap, open, onOpening, onOpened, onClosing, onClosed, onCancel
    , actions, closeIcon, header, child
    , withActions, withAlert, withChild, withClass, withCloseIcon, withCloseLabel, withDisableClose, withDismissible, withHeader, withId, withNoFocusTrap, withOnCancel, withOnClosed, withOnClosing, withOnOpened, withOnOpening, withOpen, withSlot, withStyle
    )

{-| The `m3e-dialog` component — strict per-component surface.

A dialog that provides important prompts in a user flow.

@docs view, build, toElement
@docs Is, Attrs, CloseIconSlot, HeaderSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs alert, closeLabel, disableClose, dismissible, noFocusTrap, open, onOpening, onOpened, onClosing, onClosed, onCancel
@docs actions, closeIcon, header, child
@docs withActions, withAlert, withChild, withClass, withCloseIcon, withCloseLabel, withDisableClose, withDismissible, withHeader, withId, withNoFocusTrap, withOnCancel, withOnClosed, withOnClosing, withOnOpened, withOnOpening, withOpen, withSlot, withStyle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
import M3e.Internal.Types.Dialog
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-dialog` produces (open — composes into any slot naming it).
-}
type alias Is s =
    M3e.Internal.Types.Dialog.Is s


{-| The closed attribute-capability row.
-}
type alias Attrs =
    M3e.Internal.Types.Dialog.Attrs


{-| The kinds the `close-icon` slot admits.
-}
type alias CloseIconSlot =
    M3e.Internal.Types.Dialog.CloseIconSlot


{-| The kinds the `header` slot admits.
-}
type alias HeaderSlot =
    M3e.Internal.Types.Dialog.HeaderSlot


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.Dialog.ChildAdmittedBy childAdm


{-| Standard constructor: `[attributes] [children]`. The default slot is
kind-permissive (`any`): children of any kind compose, but each child's OWN
admittedBy must still admit this context — a restricted-parent element is
rejected here at compile time.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.dialog


{-| See `M3e.Attributes.alert`.
-}
alert : Bool -> Attr { c | alert : Supported } msg
alert =
    A.alert


{-| See `M3e.Attributes.closeLabel`.
-}
closeLabel : String -> Attr { c | closeLabel : Supported } msg
closeLabel =
    A.closeLabel


{-| See `M3e.Attributes.disableClose`.
-}
disableClose : Bool -> Attr { c | disableClose : Supported } msg
disableClose =
    A.disableClose


{-| See `M3e.Attributes.dismissible`.
-}
dismissible : Bool -> Attr { c | dismissible : Supported } msg
dismissible =
    A.dismissible


{-| See `M3e.Attributes.noFocusTrap`.
-}
noFocusTrap : Bool -> Attr { c | noFocusTrap : Supported } msg
noFocusTrap =
    A.noFocusTrap


{-| See `M3e.Attributes.open`.
-}
open : Bool -> Attr { c | open : Supported } msg
open =
    A.open


{-| See `M3e.Events.onOpening`.
-}
onOpening : msg -> Attr { c | onOpening : Supported } msg
onOpening =
    Ev.onOpening


{-| See `M3e.Events.onOpened`.
-}
onOpened : msg -> Attr { c | onOpened : Supported } msg
onOpened =
    Ev.onOpened


{-| See `M3e.Events.onClosing`.
-}
onClosing : msg -> Attr { c | onClosing : Supported } msg
onClosing =
    Ev.onClosing


{-| See `M3e.Events.onClosed`.
-}
onClosed : msg -> Attr { c | onClosed : Supported } msg
onClosed =
    Ev.onClosed


{-| See `M3e.Events.onCancel`.
-}
onCancel : msg -> Attr { c | onCancel : Supported } msg
onCancel =
    Ev.onCancel


{-| Place an element into the named `actions` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
actions : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
actions element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "actions") (El.toNode element))


{-| Place an element into the named `close-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
closeIcon : Element CloseIconSlot admittedBy msg -> Element free freeAdmittedBy msg
closeIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "close-icon") (El.toNode element))


{-| Place an element into the named `header` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
header : Element HeaderSlot admittedBy msg -> Element free freeAdmittedBy msg
header element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "header") (El.toNode element))


{-| Place a pre-built element into the default (unnamed) slot (input
constrained to the slot's kinds; output row free so it composes into the
child list). The list-form sibling of the builder's `withChild`.
-}
child : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
child element =
    Ir.fromNode (El.toNode element)


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable. Aliases the shared builder in
`Build.Internal`, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg s =
    M3e.Internal.Types.Dialog.Builder attrCaps slotCaps msg s


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.Dialog.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    M3e.Internal.Types.Dialog.SlotCaps


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-dialog" [] []


{-| Close the pipe-builder (`toElement` is defined once in `Build.Internal`).
-}
toElement : Builder attrCaps slotCaps msg kind -> Element (Is kind) admittedBy msg
toElement =
    B.toElement


{-| Pipe form of `class` — consumes its capability (write-once).
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass value_ =
    B.withAttribute (A.class value_)


{-| Pipe form of `id` — consumes its capability (write-once).
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId value_ =
    B.withAttribute (A.id value_)


{-| Pipe form of `slot` — consumes its capability (write-once).
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot value_ =
    B.withAttribute (A.slot value_)


{-| Pipe form of `style` — consumes its capability (write-once).
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle property value_ =
    B.withAttribute (A.style property value_)


{-| Pipe form of `alert` — consumes its capability (write-once).
-}
withAlert : Bool -> Builder { a | alert : Available } slotCaps msg kind -> Builder { a | alert : Used } slotCaps msg kind
withAlert value_ =
    B.withAttribute (A.alert value_)


{-| Pipe form of `closeLabel` — consumes its capability (write-once).
-}
withCloseLabel : String -> Builder { a | closeLabel : Available } slotCaps msg kind -> Builder { a | closeLabel : Used } slotCaps msg kind
withCloseLabel value_ =
    B.withAttribute (A.closeLabel value_)


{-| Pipe form of `disableClose` — consumes its capability (write-once).
-}
withDisableClose : Bool -> Builder { a | disableClose : Available } slotCaps msg kind -> Builder { a | disableClose : Used } slotCaps msg kind
withDisableClose value_ =
    B.withAttribute (A.disableClose value_)


{-| Pipe form of `dismissible` — consumes its capability (write-once).
-}
withDismissible : Bool -> Builder { a | dismissible : Available } slotCaps msg kind -> Builder { a | dismissible : Used } slotCaps msg kind
withDismissible value_ =
    B.withAttribute (A.dismissible value_)


{-| Pipe form of `noFocusTrap` — consumes its capability (write-once).
-}
withNoFocusTrap : Bool -> Builder { a | noFocusTrap : Available } slotCaps msg kind -> Builder { a | noFocusTrap : Used } slotCaps msg kind
withNoFocusTrap value_ =
    B.withAttribute (A.noFocusTrap value_)


{-| Pipe form of `open` — consumes its capability (write-once).
-}
withOpen : Bool -> Builder { a | open : Available } slotCaps msg kind -> Builder { a | open : Used } slotCaps msg kind
withOpen value_ =
    B.withAttribute (A.open value_)


{-| Pipe form of `onOpening` — consumes its capability (write-once).
-}
withOnOpening : msg -> Builder { a | onOpening : Available } slotCaps msg kind -> Builder { a | onOpening : Used } slotCaps msg kind
withOnOpening value_ =
    B.withAttribute (Ev.onOpening value_)


{-| Pipe form of `onOpened` — consumes its capability (write-once).
-}
withOnOpened : msg -> Builder { a | onOpened : Available } slotCaps msg kind -> Builder { a | onOpened : Used } slotCaps msg kind
withOnOpened value_ =
    B.withAttribute (Ev.onOpened value_)


{-| Pipe form of `onClosing` — consumes its capability (write-once).
-}
withOnClosing : msg -> Builder { a | onClosing : Available } slotCaps msg kind -> Builder { a | onClosing : Used } slotCaps msg kind
withOnClosing value_ =
    B.withAttribute (Ev.onClosing value_)


{-| Pipe form of `onClosed` — consumes its capability (write-once).
-}
withOnClosed : msg -> Builder { a | onClosed : Available } slotCaps msg kind -> Builder { a | onClosed : Used } slotCaps msg kind
withOnClosed value_ =
    B.withAttribute (Ev.onClosed value_)


{-| Pipe form of `onCancel` — consumes its capability (write-once).
-}
withOnCancel : msg -> Builder { a | onCancel : Available } slotCaps msg kind -> Builder { a | onCancel : Used } slotCaps msg kind
withOnCancel value_ =
    B.withAttribute (Ev.onCancel value_)


{-| Pipe form of the `actions` slot — consumes its capability (write-once).
-}
withActions : Element childAccepts admittedBy msg -> Builder attrCaps { s | actions : Available } msg kind -> Builder attrCaps { s | actions : Used } msg kind
withActions element =
    B.withChild (El.toNode (actions element))


{-| Pipe form of the `close-icon` slot — consumes its capability (write-once).
-}
withCloseIcon : Element CloseIconSlot admittedBy msg -> Builder attrCaps { s | closeIcon : Available } msg kind -> Builder attrCaps { s | closeIcon : Used } msg kind
withCloseIcon element =
    B.withChild (El.toNode (closeIcon element))


{-| Pipe form of the `header` slot — consumes its capability (write-once).
-}
withHeader : Element HeaderSlot admittedBy msg -> Builder attrCaps { s | header : Available } msg kind -> Builder attrCaps { s | header : Used } msg kind
withHeader element =
    B.withChild (El.toNode (header element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg kind -> Builder attrCaps slotCaps msg kind
withChild element =
    B.withChild (El.toNode element)
