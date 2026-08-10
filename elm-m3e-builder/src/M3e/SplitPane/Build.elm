module M3e.SplitPane.Build exposing
    ( build, toElement, view
    , Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
    , withClass, withDetents, withDisabled, withId, withLabel, withMax, withMin, withName, withOnBeforeinput, withOnChange, withOnInput, withOrientation, withOvershootLimit, withSlot, withStep, withStyle, withValue, withWrapDetents
    , end, start
    , withEnd, withStart
    )

{-| The builder module for `m3e-split-pane` — seed, pipe, and close.

This module provides everything you need to BUILD with `SplitPane`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.SplitPane.view`.

@docs build, toElement, view
@docs Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
@docs withClass, withDetents, withDisabled, withId, withLabel, withMax, withMin, withName, withOnBeforeinput, withOnChange, withOnInput, withOrientation, withOvershootLimit, withSlot, withStep, withStyle, withValue, withWrapDetents
@docs end, start
@docs withEnd, withStart

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Internal.Types.SplitPane
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.SplitPane as Component
import M3e.Values


{-| The kind this element produces — a `Brand` that marks the phantom row.
-}
type alias Is s =
    M3e.Internal.Types.SplitPane.Is s


{-| The pipe-builder, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Internal.Types.SplitPane.Builder attrCaps slotCaps msg kind


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.SplitPane.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    M3e.Internal.Types.SplitPane.SlotCaps


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.SplitPane.ChildAdmittedBy childAdm


{-| Seed the pipe-builder with required content (and action).
-}
build :
    { end : Element childAccepts (Component.ChildAdmittedBy childAdm) msg
    , start : Element childAccepts (Component.ChildAdmittedBy childAdm) msg
    }
    -> Builder AttrCaps SlotCaps msg kind
build required_ =
    B.init "m3e-split-pane" [] [ El.toNode (Component.end required_.end), El.toNode (Component.start required_.start) ]


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
withEnd :
    B.Builder childRow childAttrCaps childSlotCaps childAccepts msg
    -> Builder attrCaps { s | end : Available } msg kind
    -> Builder attrCaps { s | end : Used } msg kind
withEnd slotBuilder builder_ =
    B.withChild (El.toNode (Component.end (B.toElement slotBuilder))) builder_


{-| Pipe form of the `start` slot — accepts a builder directly (no `.toElement`).
-}
withStart :
    B.Builder childRow childAttrCaps childSlotCaps childAccepts msg
    -> Builder attrCaps { s | start : Available } msg kind
    -> Builder attrCaps { s | start : Used } msg kind
withStart slotBuilder builder_ =
    B.withChild (El.toNode (Component.start (B.toElement slotBuilder))) builder_


{-| Pipe form of `class` — re-exported from `M3e.SplitPane`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.SplitPane`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.SplitPane`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.SplitPane`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `detents` — re-exported from `M3e.SplitPane`.
-}
withDetents : String -> Builder { a | detents : Available } slotCaps msg kind -> Builder { a | detents : Used } slotCaps msg kind
withDetents =
    Component.withDetents


{-| Pipe form of `disabled` — re-exported from `M3e.SplitPane`.
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg kind -> Builder { a | disabled : Used } slotCaps msg kind
withDisabled =
    Component.withDisabled


{-| Pipe form of `label` — re-exported from `M3e.SplitPane`.
-}
withLabel : String -> Builder { a | label : Available } slotCaps msg kind -> Builder { a | label : Used } slotCaps msg kind
withLabel =
    Component.withLabel


{-| Pipe form of `max` — re-exported from `M3e.SplitPane`.
-}
withMax : Float -> Builder { a | max : Available } slotCaps msg kind -> Builder { a | max : Used } slotCaps msg kind
withMax =
    Component.withMax


{-| Pipe form of `min` — re-exported from `M3e.SplitPane`.
-}
withMin : Float -> Builder { a | min : Available } slotCaps msg kind -> Builder { a | min : Used } slotCaps msg kind
withMin =
    Component.withMin


{-| Pipe form of `name` — re-exported from `M3e.SplitPane`.
-}
withName : String -> Builder { a | name : Available } slotCaps msg kind -> Builder { a | name : Used } slotCaps msg kind
withName =
    Component.withName


{-| Pipe form of `orientation` — re-exported from `M3e.SplitPane`.
-}
withOrientation : Value Component.Orientation -> Builder { a | orientation : Available } slotCaps msg kind -> Builder { a | orientation : Used } slotCaps msg kind
withOrientation =
    Component.withOrientation


{-| Pipe form of `overshootLimit` — re-exported from `M3e.SplitPane`.
-}
withOvershootLimit : Float -> Builder { a | overshootLimit : Available } slotCaps msg kind -> Builder { a | overshootLimit : Used } slotCaps msg kind
withOvershootLimit =
    Component.withOvershootLimit


{-| Pipe form of `step` — re-exported from `M3e.SplitPane`.
-}
withStep : Float -> Builder { a | step : Available } slotCaps msg kind -> Builder { a | step : Used } slotCaps msg kind
withStep =
    Component.withStep


{-| Pipe form of `value` — re-exported from `M3e.SplitPane`.
-}
withValue : Float -> Builder { a | value : Available } slotCaps msg kind -> Builder { a | value : Used } slotCaps msg kind
withValue =
    Component.withValue


{-| Pipe form of `wrapDetents` — re-exported from `M3e.SplitPane`.
-}
withWrapDetents : Bool -> Builder { a | wrapDetents : Available } slotCaps msg kind -> Builder { a | wrapDetents : Used } slotCaps msg kind
withWrapDetents =
    Component.withWrapDetents


{-| Pipe form of `onChange` — re-exported from `M3e.SplitPane`.
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg kind -> Builder { a | onChange : Used } slotCaps msg kind
withOnChange =
    Component.withOnChange


{-| Pipe form of `onBeforeinput` — re-exported from `M3e.SplitPane`.
-}
withOnBeforeinput : msg -> Builder { a | onBeforeinput : Available } slotCaps msg kind -> Builder { a | onBeforeinput : Used } slotCaps msg kind
withOnBeforeinput =
    Component.withOnBeforeinput


{-| Pipe form of `onInput` — re-exported from `M3e.SplitPane`.
-}
withOnInput : msg -> Builder { a | onInput : Available } slotCaps msg kind -> Builder { a | onInput : Used } slotCaps msg kind
withOnInput =
    Component.withOnInput
