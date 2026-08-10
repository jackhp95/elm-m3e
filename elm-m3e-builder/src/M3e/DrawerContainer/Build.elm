module M3e.DrawerContainer.Build exposing
    ( build, toElement, view
    , Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
    , withClass, withEnd, withEndDivider, withEndMode, withId, withOnChange, withSlot, withStart, withStartDivider, withStartMode, withStyle
    , end, start
    , withEndSlot, withStartSlot, withChild
    )

{-| The builder module for `m3e-drawer-container` — seed, pipe, and close.

This module provides everything you need to BUILD with `DrawerContainer`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.DrawerContainer.view`.

@docs build, toElement, view
@docs Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
@docs withClass, withEnd, withEndDivider, withEndMode, withId, withOnChange, withSlot, withStart, withStartDivider, withStartMode, withStyle
@docs end, start
@docs withEndSlot, withStartSlot, withChild

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.DrawerContainer as Component
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
    B.init "m3e-drawer-container" [] []


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


{-| Place a builder-built element into the named `end` slot — calls `B.toElement` internally.
-}
end :
    B.Builder childRow childAttrCaps childSlotCaps childAccepts msg
    -> Element free freeAdmittedBy msg
end builder =
    Component.end (B.toElement builder)


{-| Place a builder-built element into the named `start` slot — calls `B.toElement` internally.
-}
start :
    B.Builder childRow childAttrCaps childSlotCaps childAccepts msg
    -> Element free freeAdmittedBy msg
start builder =
    Component.start (B.toElement builder)


{-| Pipe form of the `end` slot — accepts a builder directly (no `.toElement`).
-}
withEndSlot :
    B.Builder childRow childAttrCaps childSlotCaps childAccepts msg
    -> Builder attrCaps { s | end : Available } msg kind
    -> Builder attrCaps { s | end : Used } msg kind
withEndSlot slotBuilder builder_ =
    B.withChild (El.toNode (Component.end (B.toElement slotBuilder))) builder_


{-| Pipe form of the `start` slot — accepts a builder directly (no `.toElement`).
-}
withStartSlot :
    B.Builder childRow childAttrCaps childSlotCaps childAccepts msg
    -> Builder attrCaps { s | start : Available } msg kind
    -> Builder attrCaps { s | start : Used } msg kind
withStartSlot slotBuilder builder_ =
    B.withChild (El.toNode (Component.start (B.toElement slotBuilder))) builder_


{-| Pipe form of a default-slot child (repeatable) — accepts a builder directly.
-}
withChild :
    B.Builder childRow childAttrCaps childSlotCaps accepts msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withChild childBuilder builder_ =
    B.withChild (El.toNode (B.toElement childBuilder)) builder_


{-| Pipe form of `class` — re-exported from `M3e.DrawerContainer`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.DrawerContainer`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.DrawerContainer`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.DrawerContainer`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `end` — re-exported from `M3e.DrawerContainer`.
-}
withEnd : Bool -> Builder { a | end : Available } slotCaps msg kind -> Builder { a | end : Used } slotCaps msg kind
withEnd =
    Component.withEnd


{-| Pipe form of `endDivider` — re-exported from `M3e.DrawerContainer`.
-}
withEndDivider : Bool -> Builder { a | endDivider : Available } slotCaps msg kind -> Builder { a | endDivider : Used } slotCaps msg kind
withEndDivider =
    Component.withEndDivider


{-| Pipe form of `endMode` — re-exported from `M3e.DrawerContainer`.
-}
withEndMode : Value Component.EndMode -> Builder { a | endMode : Available } slotCaps msg kind -> Builder { a | endMode : Used } slotCaps msg kind
withEndMode =
    Component.withEndMode


{-| Pipe form of `start` — re-exported from `M3e.DrawerContainer`.
-}
withStart : Bool -> Builder { a | start : Available } slotCaps msg kind -> Builder { a | start : Used } slotCaps msg kind
withStart =
    Component.withStart


{-| Pipe form of `startDivider` — re-exported from `M3e.DrawerContainer`.
-}
withStartDivider : Bool -> Builder { a | startDivider : Available } slotCaps msg kind -> Builder { a | startDivider : Used } slotCaps msg kind
withStartDivider =
    Component.withStartDivider


{-| Pipe form of `startMode` — re-exported from `M3e.DrawerContainer`.
-}
withStartMode : Value Component.StartMode -> Builder { a | startMode : Available } slotCaps msg kind -> Builder { a | startMode : Used } slotCaps msg kind
withStartMode =
    Component.withStartMode


{-| Pipe form of `onChange` — re-exported from `M3e.DrawerContainer`.
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg kind -> Builder { a | onChange : Used } slotCaps msg kind
withOnChange =
    Component.withOnChange
