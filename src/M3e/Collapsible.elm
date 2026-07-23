module M3e.Collapsible exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Orientation, orientation
    , noAnimate, open, onOpening, onOpened, onClosing, onClosed
    , withChild, withClass, withId, withNoAnimate, withOnClosed, withOnClosing, withOnOpened, withOnOpening, withOpen, withOrientation, withSlot, withStyle
    )

{-| The `m3e-collapsible` component — strict per-component surface.

A container used to expand and collapse content.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Orientation, orientation
@docs noAnimate, open, onOpening, onOpened, onClosing, onClosed
@docs withChild, withClass, withId, withNoAnimate, withOnClosed, withOnClosing, withOnOpened, withOnOpening, withOpen, withOrientation, withSlot, withStyle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-collapsible` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | collapsible : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , id : Supported
    , noAnimate : Supported
    , onClosed : Supported
    , onClosing : Supported
    , onOpened : Supported
    , onOpening : Supported
    , open : Supported
    , orientation : Supported
    , slot : Supported
    , style : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | collapsible : Ctx }


{-| The `orientation` values valid on this component (compile-tight narrowing).
-}
type alias Orientation =
    { horizontal : Supported
    , vertical : Supported
    }


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
    H.collapsible


{-| Orientation of collapsible content. (default: `"vertical"`)
-}
orientation : Value Orientation -> Attr { c | orientation : Supported } msg
orientation value_ =
    Ir.attribute "orientation" (Val.toString value_)


{-| See `M3e.Attributes.noAnimate`.
-}
noAnimate : Bool -> Attr { c | noAnimate : Supported } msg
noAnimate =
    A.noAnimate


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
    , id : Available
    , noAnimate : Available
    , onClosed : Available
    , onClosing : Available
    , onOpened : Available
    , onOpening : Available
    , open : Available
    , orientation : Available
    , slot : Available
    , style : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-collapsible" [] []


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


{-| Pipe form of `noAnimate` — consumes its capability (write-once).
-}
withNoAnimate : Bool -> Builder { a | noAnimate : Available } slotCaps msg -> Builder { a | noAnimate : Used } slotCaps msg
withNoAnimate value_ =
    B.withAttribute (A.noAnimate value_)


{-| Pipe form of `open` — consumes its capability (write-once).
-}
withOpen : Bool -> Builder { a | open : Available } slotCaps msg -> Builder { a | open : Used } slotCaps msg
withOpen value_ =
    B.withAttribute (A.open value_)


{-| Pipe form of `orientation` — consumes its capability (write-once).
-}
withOrientation : Value Orientation -> Builder { a | orientation : Available } slotCaps msg -> Builder { a | orientation : Used } slotCaps msg
withOrientation value_ =
    B.withAttribute (orientation value_)


{-| Pipe form of `onOpening` — consumes its capability (write-once).
-}
withOnOpening : msg -> Builder { a | onOpening : Available } slotCaps msg -> Builder { a | onOpening : Used } slotCaps msg
withOnOpening value_ =
    B.withAttribute (Ev.onOpening value_)


{-| Pipe form of `onOpened` — consumes its capability (write-once).
-}
withOnOpened : msg -> Builder { a | onOpened : Available } slotCaps msg -> Builder { a | onOpened : Used } slotCaps msg
withOnOpened value_ =
    B.withAttribute (Ev.onOpened value_)


{-| Pipe form of `onClosing` — consumes its capability (write-once).
-}
withOnClosing : msg -> Builder { a | onClosing : Available } slotCaps msg -> Builder { a | onClosing : Used } slotCaps msg
withOnClosing value_ =
    B.withAttribute (Ev.onClosing value_)


{-| Pipe form of `onClosed` — consumes its capability (write-once).
-}
withOnClosed : msg -> Builder { a | onClosed : Available } slotCaps msg -> Builder { a | onClosed : Used } slotCaps msg
withOnClosed value_ =
    B.withAttribute (Ev.onClosed value_)


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
