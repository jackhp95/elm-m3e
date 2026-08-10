module M3e.SlideGroup.Build exposing
    ( build, toElement, view
    , Builder, AttrCaps, SlotCaps, Is, NextIconSlot, PrevIconSlot, ChildAdmittedBy
    , withClass, withDisabled, withId, withNextPageLabel, withPreviousPageLabel, withSlot, withStyle, withThreshold, withVertical
    , nextIcon, prevIcon
    , withNextIcon, withPrevIcon, withChild
    )

{-| The builder module for `m3e-slide-group` — seed, pipe, and close.

This module provides everything you need to BUILD with `SlideGroup`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.SlideGroup.view`.

@docs build, toElement, view
@docs Builder, AttrCaps, SlotCaps, Is, NextIconSlot, PrevIconSlot, ChildAdmittedBy
@docs withClass, withDisabled, withId, withNextPageLabel, withPreviousPageLabel, withSlot, withStyle, withThreshold, withVertical
@docs nextIcon, prevIcon
@docs withNextIcon, withPrevIcon, withChild

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.SlideGroup as Component


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


{-| The kinds the `next-icon` slot admits.
-}
type alias NextIconSlot =
    Component.NextIconSlot


{-| The kinds the `prev-icon` slot admits.
-}
type alias PrevIconSlot =
    Component.PrevIconSlot


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-slide-group" [] []


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


{-| Place a builder-built element into the named `next-icon` slot — calls `B.toElement` internally.
-}
nextIcon :
    B.Builder childRow childAttrCaps childSlotCaps Component.NextIconSlot msg
    -> Element free freeAdmittedBy msg
nextIcon builder =
    Component.nextIcon (B.toElement builder)


{-| Place a builder-built element into the named `prev-icon` slot — calls `B.toElement` internally.
-}
prevIcon :
    B.Builder childRow childAttrCaps childSlotCaps Component.PrevIconSlot msg
    -> Element free freeAdmittedBy msg
prevIcon builder =
    Component.prevIcon (B.toElement builder)


{-| Pipe form of the `next-icon` slot — accepts a builder directly (no `.toElement`).
-}
withNextIcon :
    B.Builder childRow childAttrCaps childSlotCaps Component.NextIconSlot msg
    -> Builder attrCaps { s | nextIcon : Available } msg kind
    -> Builder attrCaps { s | nextIcon : Used } msg kind
withNextIcon slotBuilder builder_ =
    B.withChild (El.toNode (Component.nextIcon (B.toElement slotBuilder))) builder_


{-| Pipe form of the `prev-icon` slot — accepts a builder directly (no `.toElement`).
-}
withPrevIcon :
    B.Builder childRow childAttrCaps childSlotCaps Component.PrevIconSlot msg
    -> Builder attrCaps { s | prevIcon : Available } msg kind
    -> Builder attrCaps { s | prevIcon : Used } msg kind
withPrevIcon slotBuilder builder_ =
    B.withChild (El.toNode (Component.prevIcon (B.toElement slotBuilder))) builder_


{-| Pipe form of a default-slot child (repeatable) — accepts a builder directly.
-}
withChild :
    B.Builder childRow childAttrCaps childSlotCaps accepts msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withChild childBuilder builder_ =
    B.withChild (El.toNode (B.toElement childBuilder)) builder_


{-| Pipe form of `class` — re-exported from `M3e.SlideGroup`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.SlideGroup`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.SlideGroup`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.SlideGroup`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `disabled` — re-exported from `M3e.SlideGroup`.
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg kind -> Builder { a | disabled : Used } slotCaps msg kind
withDisabled =
    Component.withDisabled


{-| Pipe form of `nextPageLabel` — re-exported from `M3e.SlideGroup`.
-}
withNextPageLabel : String -> Builder { a | nextPageLabel : Available } slotCaps msg kind -> Builder { a | nextPageLabel : Used } slotCaps msg kind
withNextPageLabel =
    Component.withNextPageLabel


{-| Pipe form of `previousPageLabel` — re-exported from `M3e.SlideGroup`.
-}
withPreviousPageLabel : String -> Builder { a | previousPageLabel : Available } slotCaps msg kind -> Builder { a | previousPageLabel : Used } slotCaps msg kind
withPreviousPageLabel =
    Component.withPreviousPageLabel


{-| Pipe form of `threshold` — re-exported from `M3e.SlideGroup`.
-}
withThreshold : Float -> Builder { a | threshold : Available } slotCaps msg kind -> Builder { a | threshold : Used } slotCaps msg kind
withThreshold =
    Component.withThreshold


{-| Pipe form of `vertical` — re-exported from `M3e.SlideGroup`.
-}
withVertical : Bool -> Builder { a | vertical : Available } slotCaps msg kind -> Builder { a | vertical : Used } slotCaps msg kind
withVertical =
    Component.withVertical
