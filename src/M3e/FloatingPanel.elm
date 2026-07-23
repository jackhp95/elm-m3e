module M3e.FloatingPanel exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , ScrollStrategy, scrollStrategy
    , anchorOffset, fitAnchorWidth, onBeforetoggle, onToggle
    , withAnchorOffset, withChild, withClass, withFitAnchorWidth, withId, withOnBeforetoggle, withOnToggle, withScrollStrategy, withSlot, withStyle
    )

{-| The `m3e-floating-panel` component — strict per-component surface.

A lightweight, generic floating surface used to present content above the page.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs ScrollStrategy, scrollStrategy
@docs anchorOffset, fitAnchorWidth, onBeforetoggle, onToggle
@docs withAnchorOffset, withChild, withClass, withFitAnchorWidth, withId, withOnBeforetoggle, withOnToggle, withScrollStrategy, withSlot, withStyle

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


{-| The kind row `m3e-floating-panel` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | floatingPanel : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { anchorOffset : Supported
    , class : Supported
    , fitAnchorWidth : Supported
    , id : Supported
    , onBeforetoggle : Supported
    , onToggle : Supported
    , scrollStrategy : Supported
    , slot : Supported
    , style : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | floatingPanel : Ctx }


{-| The `scrollStrategy` values valid on this component (compile-tight narrowing).
-}
type alias ScrollStrategy =
    { hide : Supported
    , reposition : Supported
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
    H.floatingPanel


{-| The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`)
-}
scrollStrategy : Value ScrollStrategy -> Attr { c | scrollStrategy : Supported } msg
scrollStrategy value_ =
    Ir.attribute "scroll-strategy" (Val.toString value_)


{-| See `M3e.Attributes.anchorOffset`.
-}
anchorOffset : Float -> Attr { c | anchorOffset : Supported } msg
anchorOffset =
    A.anchorOffset


{-| See `M3e.Attributes.fitAnchorWidth`.
-}
fitAnchorWidth : Bool -> Attr { c | fitAnchorWidth : Supported } msg
fitAnchorWidth =
    A.fitAnchorWidth


{-| See `M3e.Events.onBeforetoggle`.
-}
onBeforetoggle : msg -> Attr { c | onBeforetoggle : Supported } msg
onBeforetoggle =
    Ev.onBeforetoggle


{-| See `M3e.Events.onToggle`.
-}
onToggle : msg -> Attr { c | onToggle : Supported } msg
onToggle =
    Ev.onToggle


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable. Aliases the shared builder in
`Build.Internal`, closed over this component's `Attrs` row.
-}
type alias Builder attrCaps slotCaps msg =
    B.Builder Attrs attrCaps slotCaps msg


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { anchorOffset : Available
    , class : Available
    , fitAnchorWidth : Available
    , id : Available
    , onBeforetoggle : Available
    , onToggle : Available
    , scrollStrategy : Available
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
    B.init "m3e-floating-panel" [] []


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


{-| Pipe form of `anchorOffset` — consumes its capability (write-once).
-}
withAnchorOffset : Float -> Builder { a | anchorOffset : Available } slotCaps msg -> Builder { a | anchorOffset : Used } slotCaps msg
withAnchorOffset value_ =
    B.withAttribute (A.anchorOffset value_)


{-| Pipe form of `fitAnchorWidth` — consumes its capability (write-once).
-}
withFitAnchorWidth : Bool -> Builder { a | fitAnchorWidth : Available } slotCaps msg -> Builder { a | fitAnchorWidth : Used } slotCaps msg
withFitAnchorWidth value_ =
    B.withAttribute (A.fitAnchorWidth value_)


{-| Pipe form of `scrollStrategy` — consumes its capability (write-once).
-}
withScrollStrategy : Value ScrollStrategy -> Builder { a | scrollStrategy : Available } slotCaps msg -> Builder { a | scrollStrategy : Used } slotCaps msg
withScrollStrategy value_ =
    B.withAttribute (scrollStrategy value_)


{-| Pipe form of `onBeforetoggle` — consumes its capability (write-once).
-}
withOnBeforetoggle : msg -> Builder { a | onBeforetoggle : Available } slotCaps msg -> Builder { a | onBeforetoggle : Used } slotCaps msg
withOnBeforetoggle value_ =
    B.withAttribute (Ev.onBeforetoggle value_)


{-| Pipe form of `onToggle` — consumes its capability (write-once).
-}
withOnToggle : msg -> Builder { a | onToggle : Available } slotCaps msg -> Builder { a | onToggle : Used } slotCaps msg
withOnToggle value_ =
    B.withAttribute (Ev.onToggle value_)


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
