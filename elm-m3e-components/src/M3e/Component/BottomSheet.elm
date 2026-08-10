module M3e.Component.BottomSheet exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , detent, detents, handle, handleLabel, hideFriction, hideable, modal, open, overshootLimit, onOpening, onClosing, onCancel, onOpened, onClosed
    , header, child
    , withChild, withClass, withDetent, withDetents, withHandle, withHandleLabel, withHeader, withHideFriction, withHideable, withId, withModal, withOnCancel, withOnClosed, withOnClosing, withOnOpened, withOnOpening, withOpen, withOvershootLimit, withSlot, withStyle
    )

{-| The `m3e-bottom-sheet` component — strict per-component surface.

A sheet used to show secondary content anchored to the bottom of the screen.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs detent, detents, handle, handleLabel, hideFriction, hideable, modal, open, overshootLimit, onOpening, onClosing, onCancel, onOpened, onClosed
@docs header, child
@docs withChild, withClass, withDetent, withDetents, withHandle, withHandleLabel, withHeader, withHideFriction, withHideable, withId, withModal, withOnCancel, withOnClosed, withOnClosing, withOnOpened, withOnOpening, withOpen, withOvershootLimit, withSlot, withStyle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
import M3e.Internal.Types.BottomSheet
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-bottom-sheet` produces (open — composes into any slot naming it).
-}
type alias Is s =
    M3e.Internal.Types.BottomSheet.Is s


{-| The closed attribute-capability row.
-}
type alias Attrs =
    M3e.Internal.Types.BottomSheet.Attrs


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.BottomSheet.ChildAdmittedBy childAdm


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
    H.bottomSheet


{-| See `M3e.Attributes.detent`.
-}
detent : Float -> Attr { c | detent : Supported } msg
detent =
    A.detent


{-| See `M3e.Attributes.detents`.
-}
detents : String -> Attr { c | detents : Supported } msg
detents =
    A.detents


{-| See `M3e.Attributes.handle`.
-}
handle : Bool -> Attr { c | handle : Supported } msg
handle =
    A.handle


{-| See `M3e.Attributes.handleLabel`.
-}
handleLabel : String -> Attr { c | handleLabel : Supported } msg
handleLabel =
    A.handleLabel


{-| See `M3e.Attributes.hideFriction`.
-}
hideFriction : Float -> Attr { c | hideFriction : Supported } msg
hideFriction =
    A.hideFriction


{-| See `M3e.Attributes.hideable`.
-}
hideable : Bool -> Attr { c | hideable : Supported } msg
hideable =
    A.hideable


{-| See `M3e.Attributes.modal`.
-}
modal : Bool -> Attr { c | modal : Supported } msg
modal =
    A.modal


{-| See `M3e.Attributes.open`.
-}
open : Bool -> Attr { c | open : Supported } msg
open =
    A.open


{-| See `M3e.Attributes.overshootLimit`.
-}
overshootLimit : Float -> Attr { c | overshootLimit : Supported } msg
overshootLimit =
    A.overshootLimit


{-| See `M3e.Events.onOpening`.
-}
onOpening : msg -> Attr { c | onOpening : Supported } msg
onOpening =
    Ev.onOpening


{-| See `M3e.Events.onClosing`.
-}
onClosing : msg -> Attr { c | onClosing : Supported } msg
onClosing =
    Ev.onClosing


{-| See `M3e.Events.onCancel`.
-}
onCancel : msg -> Attr { c | onCancel : Supported } msg
onCancel =
    Ev.onCancel


{-| See `M3e.Events.onOpened`.
-}
onOpened : msg -> Attr { c | onOpened : Supported } msg
onOpened =
    Ev.onOpened


{-| See `M3e.Events.onClosed`.
-}
onClosed : msg -> Attr { c | onClosed : Supported } msg
onClosed =
    Ev.onClosed


{-| Place an element into the named `header` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
header : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
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
    M3e.Internal.Types.BottomSheet.Builder attrCaps slotCaps msg s


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.BottomSheet.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    M3e.Internal.Types.BottomSheet.SlotCaps


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-bottom-sheet" [] []


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


{-| Pipe form of `detent` — consumes its capability (write-once).
-}
withDetent : Float -> Builder { a | detent : Available } slotCaps msg kind -> Builder { a | detent : Used } slotCaps msg kind
withDetent value_ =
    B.withAttribute (A.detent value_)


{-| Pipe form of `detents` — consumes its capability (write-once).
-}
withDetents : String -> Builder { a | detents : Available } slotCaps msg kind -> Builder { a | detents : Used } slotCaps msg kind
withDetents value_ =
    B.withAttribute (A.detents value_)


{-| Pipe form of `handle` — consumes its capability (write-once).
-}
withHandle : Bool -> Builder { a | handle : Available } slotCaps msg kind -> Builder { a | handle : Used } slotCaps msg kind
withHandle value_ =
    B.withAttribute (A.handle value_)


{-| Pipe form of `handleLabel` — consumes its capability (write-once).
-}
withHandleLabel : String -> Builder { a | handleLabel : Available } slotCaps msg kind -> Builder { a | handleLabel : Used } slotCaps msg kind
withHandleLabel value_ =
    B.withAttribute (A.handleLabel value_)


{-| Pipe form of `hideFriction` — consumes its capability (write-once).
-}
withHideFriction : Float -> Builder { a | hideFriction : Available } slotCaps msg kind -> Builder { a | hideFriction : Used } slotCaps msg kind
withHideFriction value_ =
    B.withAttribute (A.hideFriction value_)


{-| Pipe form of `hideable` — consumes its capability (write-once).
-}
withHideable : Bool -> Builder { a | hideable : Available } slotCaps msg kind -> Builder { a | hideable : Used } slotCaps msg kind
withHideable value_ =
    B.withAttribute (A.hideable value_)


{-| Pipe form of `modal` — consumes its capability (write-once).
-}
withModal : Bool -> Builder { a | modal : Available } slotCaps msg kind -> Builder { a | modal : Used } slotCaps msg kind
withModal value_ =
    B.withAttribute (A.modal value_)


{-| Pipe form of `open` — consumes its capability (write-once).
-}
withOpen : Bool -> Builder { a | open : Available } slotCaps msg kind -> Builder { a | open : Used } slotCaps msg kind
withOpen value_ =
    B.withAttribute (A.open value_)


{-| Pipe form of `overshootLimit` — consumes its capability (write-once).
-}
withOvershootLimit : Float -> Builder { a | overshootLimit : Available } slotCaps msg kind -> Builder { a | overshootLimit : Used } slotCaps msg kind
withOvershootLimit value_ =
    B.withAttribute (A.overshootLimit value_)


{-| Pipe form of `onOpening` — consumes its capability (write-once).
-}
withOnOpening : msg -> Builder { a | onOpening : Available } slotCaps msg kind -> Builder { a | onOpening : Used } slotCaps msg kind
withOnOpening value_ =
    B.withAttribute (Ev.onOpening value_)


{-| Pipe form of `onClosing` — consumes its capability (write-once).
-}
withOnClosing : msg -> Builder { a | onClosing : Available } slotCaps msg kind -> Builder { a | onClosing : Used } slotCaps msg kind
withOnClosing value_ =
    B.withAttribute (Ev.onClosing value_)


{-| Pipe form of `onCancel` — consumes its capability (write-once).
-}
withOnCancel : msg -> Builder { a | onCancel : Available } slotCaps msg kind -> Builder { a | onCancel : Used } slotCaps msg kind
withOnCancel value_ =
    B.withAttribute (Ev.onCancel value_)


{-| Pipe form of `onOpened` — consumes its capability (write-once).
-}
withOnOpened : msg -> Builder { a | onOpened : Available } slotCaps msg kind -> Builder { a | onOpened : Used } slotCaps msg kind
withOnOpened value_ =
    B.withAttribute (Ev.onOpened value_)


{-| Pipe form of `onClosed` — consumes its capability (write-once).
-}
withOnClosed : msg -> Builder { a | onClosed : Available } slotCaps msg kind -> Builder { a | onClosed : Used } slotCaps msg kind
withOnClosed value_ =
    B.withAttribute (Ev.onClosed value_)


{-| Pipe form of the `header` slot — consumes its capability (write-once).
-}
withHeader : Element childAccepts admittedBy msg -> Builder attrCaps { s | header : Available } msg kind -> Builder attrCaps { s | header : Used } msg kind
withHeader element =
    B.withChild (El.toNode (header element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg kind -> Builder attrCaps slotCaps msg kind
withChild element =
    B.withChild (El.toNode element)
