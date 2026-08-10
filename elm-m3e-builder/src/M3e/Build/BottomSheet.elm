module M3e.Build.BottomSheet exposing
    ( build, toElement
    , Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
    , withClass, withDetent, withDetents, withHandle, withHandleLabel, withHideFriction, withHideable, withId, withModal, withOnCancel, withOnClosed, withOnClosing, withOnOpened, withOnOpening, withOpen, withOvershootLimit, withSlot, withStyle
    , header
    , withHeader, withChild
    )

{-| The builder module for `m3e-bottom-sheet` — seed, pipe, and close.

This module provides everything you need to BUILD with `BottomSheet`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.Component.BottomSheet.view`.

@docs build, toElement
@docs Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
@docs withClass, withDetent, withDetents, withHandle, withHandleLabel, withHideFriction, withHideable, withId, withModal, withOnCancel, withOnClosed, withOnClosing, withOnOpened, withOnOpening, withOpen, withOvershootLimit, withSlot, withStyle
@docs header
@docs withHeader, withChild

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Component.BottomSheet as Component
import M3e.Internal.Types.BottomSheet
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind this element produces — a `Brand` that marks the phantom row.
-}
type alias Is s =
    M3e.Internal.Types.BottomSheet.Is s


{-| The pipe-builder, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Internal.Types.BottomSheet.Builder attrCaps slotCaps msg kind


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.BottomSheet.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    M3e.Internal.Types.BottomSheet.SlotCaps


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.BottomSheet.ChildAdmittedBy childAdm


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-bottom-sheet" [] []


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg kind -> Element (Component.Is kind) admittedBy msg
toElement =
    B.toElement


{-| Place a builder-built element into the named `header` slot — calls `B.toElement` internally.
-}
header :
    B.Builder childRow childAttrCaps childSlotCaps (childAccepts) msg
    -> Element free freeAdmittedBy msg
header builder =
    Component.header (B.toElement builder)


{-| Pipe form of the `header` slot — accepts a builder directly (no `.toElement`).
-}
withHeader :
    B.Builder childRow childAttrCaps childSlotCaps (childAccepts) msg
    -> Builder attrCaps { s | header : Available } msg kind
    -> Builder attrCaps { s | header : Used } msg kind
withHeader slotBuilder builder_ =
    B.withChild (El.toNode (Component.header (B.toElement slotBuilder))) builder_


{-| Pipe form of a default-slot child (repeatable) — accepts a builder directly.
-}
withChild :
    B.Builder childRow childAttrCaps childSlotCaps accepts msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withChild childBuilder builder_ =
    B.withChild (El.toNode (B.toElement childBuilder)) builder_


{-| Pipe form of `class` — re-exported from `M3e.BottomSheet`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.BottomSheet`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.BottomSheet`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.BottomSheet`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `detent` — re-exported from `M3e.BottomSheet`.
-}
withDetent : Float -> Builder { a | detent : Available } slotCaps msg kind -> Builder { a | detent : Used } slotCaps msg kind
withDetent =
    Component.withDetent


{-| Pipe form of `detents` — re-exported from `M3e.BottomSheet`.
-}
withDetents : String -> Builder { a | detents : Available } slotCaps msg kind -> Builder { a | detents : Used } slotCaps msg kind
withDetents =
    Component.withDetents


{-| Pipe form of `handle` — re-exported from `M3e.BottomSheet`.
-}
withHandle : Bool -> Builder { a | handle : Available } slotCaps msg kind -> Builder { a | handle : Used } slotCaps msg kind
withHandle =
    Component.withHandle


{-| Pipe form of `handleLabel` — re-exported from `M3e.BottomSheet`.
-}
withHandleLabel : String -> Builder { a | handleLabel : Available } slotCaps msg kind -> Builder { a | handleLabel : Used } slotCaps msg kind
withHandleLabel =
    Component.withHandleLabel


{-| Pipe form of `hideFriction` — re-exported from `M3e.BottomSheet`.
-}
withHideFriction : Float -> Builder { a | hideFriction : Available } slotCaps msg kind -> Builder { a | hideFriction : Used } slotCaps msg kind
withHideFriction =
    Component.withHideFriction


{-| Pipe form of `hideable` — re-exported from `M3e.BottomSheet`.
-}
withHideable : Bool -> Builder { a | hideable : Available } slotCaps msg kind -> Builder { a | hideable : Used } slotCaps msg kind
withHideable =
    Component.withHideable


{-| Pipe form of `modal` — re-exported from `M3e.BottomSheet`.
-}
withModal : Bool -> Builder { a | modal : Available } slotCaps msg kind -> Builder { a | modal : Used } slotCaps msg kind
withModal =
    Component.withModal


{-| Pipe form of `open` — re-exported from `M3e.BottomSheet`.
-}
withOpen : Bool -> Builder { a | open : Available } slotCaps msg kind -> Builder { a | open : Used } slotCaps msg kind
withOpen =
    Component.withOpen


{-| Pipe form of `overshootLimit` — re-exported from `M3e.BottomSheet`.
-}
withOvershootLimit : Float -> Builder { a | overshootLimit : Available } slotCaps msg kind -> Builder { a | overshootLimit : Used } slotCaps msg kind
withOvershootLimit =
    Component.withOvershootLimit


{-| Pipe form of `onOpening` — re-exported from `M3e.BottomSheet`.
-}
withOnOpening : msg -> Builder { a | onOpening : Available } slotCaps msg kind -> Builder { a | onOpening : Used } slotCaps msg kind
withOnOpening =
    Component.withOnOpening


{-| Pipe form of `onClosing` — re-exported from `M3e.BottomSheet`.
-}
withOnClosing : msg -> Builder { a | onClosing : Available } slotCaps msg kind -> Builder { a | onClosing : Used } slotCaps msg kind
withOnClosing =
    Component.withOnClosing


{-| Pipe form of `onCancel` — re-exported from `M3e.BottomSheet`.
-}
withOnCancel : msg -> Builder { a | onCancel : Available } slotCaps msg kind -> Builder { a | onCancel : Used } slotCaps msg kind
withOnCancel =
    Component.withOnCancel


{-| Pipe form of `onOpened` — re-exported from `M3e.BottomSheet`.
-}
withOnOpened : msg -> Builder { a | onOpened : Available } slotCaps msg kind -> Builder { a | onOpened : Used } slotCaps msg kind
withOnOpened =
    Component.withOnOpened


{-| Pipe form of `onClosed` — re-exported from `M3e.BottomSheet`.
-}
withOnClosed : msg -> Builder { a | onClosed : Available } slotCaps msg kind -> Builder { a | onClosed : Used } slotCaps msg kind
withOnClosed =
    Component.withOnClosed
