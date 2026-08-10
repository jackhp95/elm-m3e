module M3e.Collapsible.Build exposing
    ( build, toElement, view
    , Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
    , withClass, withId, withNoAnimate, withOnClosed, withOnClosing, withOnOpened, withOnOpening, withOpen, withOrientation, withSlot, withStyle
    , withChild
    )

{-| The builder module for `m3e-collapsible` — seed, pipe, and close.

This module provides everything you need to BUILD with `Collapsible`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.Collapsible.view`.

@docs build, toElement, view
@docs Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
@docs withClass, withId, withNoAnimate, withOnClosed, withOnClosing, withOnOpened, withOnOpening, withOpen, withOrientation, withSlot, withStyle
@docs withChild

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Collapsible as Component
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.Values


{-| The kind this element produces — a `Brand` that marks the phantom row.
-}
type alias Is s =
    Component.Is s


{-| The pipe-builder, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg kind =
    B.Builder Component.Attrs attrCaps slotCaps (Component.Is kind) msg


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    Component.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    Component.SlotCaps


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    Component.ChildAdmittedBy childAdm


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-collapsible" [] []


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg kind -> Element (Component.Is kind) admittedBy msg
toElement =
    B.toElement


{-| Alias for [`toElement`](#toElement) — close and convert to an element.
-}
view : Builder attrCaps slotCaps msg kind -> Element (Component.Is kind) admittedBy msg
view =
    B.toElement


{-| Pipe form of a default-slot child (repeatable) — accepts a builder directly.
-}
withChild :
    B.Builder childRow childAttrCaps childSlotCaps accepts msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withChild childBuilder builder_ =
    B.withChild (El.toNode (B.toElement childBuilder)) builder_


{-| Pipe form of `class` — re-exported from `M3e.Collapsible`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.Collapsible`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.Collapsible`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.Collapsible`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `noAnimate` — re-exported from `M3e.Collapsible`.
-}
withNoAnimate : Bool -> Builder { a | noAnimate : Available } slotCaps msg kind -> Builder { a | noAnimate : Used } slotCaps msg kind
withNoAnimate =
    Component.withNoAnimate


{-| Pipe form of `open` — re-exported from `M3e.Collapsible`.
-}
withOpen : Bool -> Builder { a | open : Available } slotCaps msg kind -> Builder { a | open : Used } slotCaps msg kind
withOpen =
    Component.withOpen


{-| Pipe form of `orientation` — re-exported from `M3e.Collapsible`.
-}
withOrientation : Value Component.Orientation -> Builder { a | orientation : Available } slotCaps msg kind -> Builder { a | orientation : Used } slotCaps msg kind
withOrientation =
    Component.withOrientation


{-| Pipe form of `onOpening` — re-exported from `M3e.Collapsible`.
-}
withOnOpening : msg -> Builder { a | onOpening : Available } slotCaps msg kind -> Builder { a | onOpening : Used } slotCaps msg kind
withOnOpening =
    Component.withOnOpening


{-| Pipe form of `onOpened` — re-exported from `M3e.Collapsible`.
-}
withOnOpened : msg -> Builder { a | onOpened : Available } slotCaps msg kind -> Builder { a | onOpened : Used } slotCaps msg kind
withOnOpened =
    Component.withOnOpened


{-| Pipe form of `onClosing` — re-exported from `M3e.Collapsible`.
-}
withOnClosing : msg -> Builder { a | onClosing : Available } slotCaps msg kind -> Builder { a | onClosing : Used } slotCaps msg kind
withOnClosing =
    Component.withOnClosing


{-| Pipe form of `onClosed` — re-exported from `M3e.Collapsible`.
-}
withOnClosed : msg -> Builder { a | onClosed : Available } slotCaps msg kind -> Builder { a | onClosed : Used } slotCaps msg kind
withOnClosed =
    Component.withOnClosed
