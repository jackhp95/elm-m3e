module M3e.BottomSheet exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , detent, detents, handle, handleLabel, hideFriction, hideable, modal, open, overshootLimit, onOpening, onClosing, onCancel, onOpened, onClosed
    , header
    , withChild, withClass, withDetent, withDetents, withHandle, withHandleLabel, withHeader, withHideFriction, withHideable, withId, withModal, withOnCancel, withOnClosed, withOnClosing, withOnOpened, withOnOpening, withOpen, withOvershootLimit, withSlot, withStyle
    )

{-| The `m3e-bottom-sheet` component — strict per-component surface.

A sheet used to show secondary content anchored to the bottom of the screen.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs detent, detents, handle, handleLabel, hideFriction, hideable, modal, open, overshootLimit, onOpening, onClosing, onCancel, onOpened, onClosed
@docs header
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
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-bottom-sheet` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | bottomSheet : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , detent : Supported
    , detents : Supported
    , handle : Supported
    , handleLabel : Supported
    , hideFriction : Supported
    , hideable : Supported
    , id : Supported
    , modal : Supported
    , onCancel : Supported
    , onClosed : Supported
    , onClosing : Supported
    , onOpened : Supported
    , onOpening : Supported
    , open : Supported
    , overshootLimit : Supported
    , slot : Supported
    , style : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | bottomSheet : Ctx }


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


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable. Aliases the shared builder in
`Build.Internal`, closed over this component's `Attrs` row.
-}
type alias Builder attrCaps slotCaps msg =
    B.Builder Attrs attrCaps slotCaps msg


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { class : Available
    , detent : Available
    , detents : Available
    , handle : Available
    , handleLabel : Available
    , hideFriction : Available
    , hideable : Available
    , id : Available
    , modal : Available
    , onCancel : Available
    , onClosed : Available
    , onClosing : Available
    , onOpened : Available
    , onOpening : Available
    , open : Available
    , overshootLimit : Available
    , slot : Available
    , style : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { header : Available
    }


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-bottom-sheet" [] []


{-| Close the pipe-builder (`toElement` is defined once in `Build.Internal`).
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement =
    B.toElement


{-| Pipe form of `class` — consumes its capability (write-once).
-}
withClass : String -> Builder { a | class : Available } slotCaps msg -> Builder { a | class : Used } slotCaps msg
withClass value_ =
    B.withAttribute (A.class value_)


{-| Pipe form of `id` — consumes its capability (write-once).
-}
withId : String -> Builder { a | id : Available } slotCaps msg -> Builder { a | id : Used } slotCaps msg
withId value_ =
    B.withAttribute (A.id value_)


{-| Pipe form of `slot` — consumes its capability (write-once).
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg -> Builder { a | slot : Used } slotCaps msg
withSlot value_ =
    B.withAttribute (A.slot value_)


{-| Pipe form of `style` — consumes its capability (write-once).
-}
withStyle : String -> Builder { a | style : Available } slotCaps msg -> Builder { a | style : Used } slotCaps msg
withStyle value_ =
    B.withAttribute (A.style value_)


{-| Pipe form of `detent` — consumes its capability (write-once).
-}
withDetent : Float -> Builder { a | detent : Available } slotCaps msg -> Builder { a | detent : Used } slotCaps msg
withDetent value_ =
    B.withAttribute (A.detent value_)


{-| Pipe form of `detents` — consumes its capability (write-once).
-}
withDetents : String -> Builder { a | detents : Available } slotCaps msg -> Builder { a | detents : Used } slotCaps msg
withDetents value_ =
    B.withAttribute (A.detents value_)


{-| Pipe form of `handle` — consumes its capability (write-once).
-}
withHandle : Bool -> Builder { a | handle : Available } slotCaps msg -> Builder { a | handle : Used } slotCaps msg
withHandle value_ =
    B.withAttribute (A.handle value_)


{-| Pipe form of `handleLabel` — consumes its capability (write-once).
-}
withHandleLabel : String -> Builder { a | handleLabel : Available } slotCaps msg -> Builder { a | handleLabel : Used } slotCaps msg
withHandleLabel value_ =
    B.withAttribute (A.handleLabel value_)


{-| Pipe form of `hideFriction` — consumes its capability (write-once).
-}
withHideFriction : Float -> Builder { a | hideFriction : Available } slotCaps msg -> Builder { a | hideFriction : Used } slotCaps msg
withHideFriction value_ =
    B.withAttribute (A.hideFriction value_)


{-| Pipe form of `hideable` — consumes its capability (write-once).
-}
withHideable : Bool -> Builder { a | hideable : Available } slotCaps msg -> Builder { a | hideable : Used } slotCaps msg
withHideable value_ =
    B.withAttribute (A.hideable value_)


{-| Pipe form of `modal` — consumes its capability (write-once).
-}
withModal : Bool -> Builder { a | modal : Available } slotCaps msg -> Builder { a | modal : Used } slotCaps msg
withModal value_ =
    B.withAttribute (A.modal value_)


{-| Pipe form of `open` — consumes its capability (write-once).
-}
withOpen : Bool -> Builder { a | open : Available } slotCaps msg -> Builder { a | open : Used } slotCaps msg
withOpen value_ =
    B.withAttribute (A.open value_)


{-| Pipe form of `overshootLimit` — consumes its capability (write-once).
-}
withOvershootLimit : Float -> Builder { a | overshootLimit : Available } slotCaps msg -> Builder { a | overshootLimit : Used } slotCaps msg
withOvershootLimit value_ =
    B.withAttribute (A.overshootLimit value_)


{-| Pipe form of `onOpening` — consumes its capability (write-once).
-}
withOnOpening : msg -> Builder { a | onOpening : Available } slotCaps msg -> Builder { a | onOpening : Used } slotCaps msg
withOnOpening value_ =
    B.withAttribute (Ev.onOpening value_)


{-| Pipe form of `onClosing` — consumes its capability (write-once).
-}
withOnClosing : msg -> Builder { a | onClosing : Available } slotCaps msg -> Builder { a | onClosing : Used } slotCaps msg
withOnClosing value_ =
    B.withAttribute (Ev.onClosing value_)


{-| Pipe form of `onCancel` — consumes its capability (write-once).
-}
withOnCancel : msg -> Builder { a | onCancel : Available } slotCaps msg -> Builder { a | onCancel : Used } slotCaps msg
withOnCancel value_ =
    B.withAttribute (Ev.onCancel value_)


{-| Pipe form of `onOpened` — consumes its capability (write-once).
-}
withOnOpened : msg -> Builder { a | onOpened : Available } slotCaps msg -> Builder { a | onOpened : Used } slotCaps msg
withOnOpened value_ =
    B.withAttribute (Ev.onOpened value_)


{-| Pipe form of `onClosed` — consumes its capability (write-once).
-}
withOnClosed : msg -> Builder { a | onClosed : Available } slotCaps msg -> Builder { a | onClosed : Used } slotCaps msg
withOnClosed value_ =
    B.withAttribute (Ev.onClosed value_)


{-| Pipe form of the `header` slot — consumes its capability (write-once).
-}
withHeader : Element childAccepts admittedBy msg -> Builder attrCaps { s | header : Available } msg -> Builder attrCaps { s | header : Used } msg
withHeader element =
    B.withChild (El.toNode (header element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
