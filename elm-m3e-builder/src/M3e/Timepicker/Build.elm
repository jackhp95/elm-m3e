module M3e.Timepicker.Build exposing
    ( build, toElement, view
    , Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
    , withClass, withConfirmLabel, withDate, withDialLabel, withDismissLabel, withFor, withFormat, withHideModeToggle, withHourLabel, withId, withInputLabel, withMaxTime, withMinTime, withMinuteLabel, withMode, withModeToggleLabel, withOnBeforetoggle, withOnChange, withOnToggle, withOrientation, withPeriodToggleLabel, withSecondLabel, withShowSeconds, withSlot, withStyle, withVariant
    )

{-| The builder module for `m3e-timepicker` — seed, pipe, and close.

This module provides everything you need to BUILD with `Timepicker`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.Timepicker.view`.

@docs build, toElement, view
@docs Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
@docs withClass, withConfirmLabel, withDate, withDialLabel, withDismissLabel, withFor, withFormat, withHideModeToggle, withHourLabel, withId, withInputLabel, withMaxTime, withMinTime, withMinuteLabel, withMode, withModeToggleLabel, withOnBeforetoggle, withOnChange, withOnToggle, withOrientation, withPeriodToggleLabel, withSecondLabel, withShowSeconds, withSlot, withStyle, withVariant

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Internal.Types.Timepicker
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.Timepicker as Component
import M3e.Values


{-| The kind this element produces — a `Brand` that marks the phantom row.
-}
type alias Is s =
    M3e.Internal.Types.Timepicker.Is s


{-| The pipe-builder, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Internal.Types.Timepicker.Builder attrCaps slotCaps msg kind


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.Timepicker.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.Timepicker.ChildAdmittedBy childAdm


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-timepicker" [] []


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


{-| Pipe form of `class` — re-exported from `M3e.Timepicker`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.Timepicker`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.Timepicker`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.Timepicker`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `confirmLabel` — re-exported from `M3e.Timepicker`.
-}
withConfirmLabel : String -> Builder { a | confirmLabel : Available } slotCaps msg kind -> Builder { a | confirmLabel : Used } slotCaps msg kind
withConfirmLabel =
    Component.withConfirmLabel


{-| Pipe form of `date` — re-exported from `M3e.Timepicker`.
-}
withDate : String -> Builder { a | date : Available } slotCaps msg kind -> Builder { a | date : Used } slotCaps msg kind
withDate =
    Component.withDate


{-| Pipe form of `dialLabel` — re-exported from `M3e.Timepicker`.
-}
withDialLabel : String -> Builder { a | dialLabel : Available } slotCaps msg kind -> Builder { a | dialLabel : Used } slotCaps msg kind
withDialLabel =
    Component.withDialLabel


{-| Pipe form of `dismissLabel` — re-exported from `M3e.Timepicker`.
-}
withDismissLabel : String -> Builder { a | dismissLabel : Available } slotCaps msg kind -> Builder { a | dismissLabel : Used } slotCaps msg kind
withDismissLabel =
    Component.withDismissLabel


{-| Pipe form of `for` — re-exported from `M3e.Timepicker`.
-}
withFor : String -> Builder { a | for : Available } slotCaps msg kind -> Builder { a | for : Used } slotCaps msg kind
withFor =
    Component.withFor


{-| Pipe form of `format` — re-exported from `M3e.Timepicker`.
-}
withFormat : Value Component.Format -> Builder { a | format : Available } slotCaps msg kind -> Builder { a | format : Used } slotCaps msg kind
withFormat =
    Component.withFormat


{-| Pipe form of `hideModeToggle` — re-exported from `M3e.Timepicker`.
-}
withHideModeToggle : Bool -> Builder { a | hideModeToggle : Available } slotCaps msg kind -> Builder { a | hideModeToggle : Used } slotCaps msg kind
withHideModeToggle =
    Component.withHideModeToggle


{-| Pipe form of `hourLabel` — re-exported from `M3e.Timepicker`.
-}
withHourLabel : String -> Builder { a | hourLabel : Available } slotCaps msg kind -> Builder { a | hourLabel : Used } slotCaps msg kind
withHourLabel =
    Component.withHourLabel


{-| Pipe form of `inputLabel` — re-exported from `M3e.Timepicker`.
-}
withInputLabel : String -> Builder { a | inputLabel : Available } slotCaps msg kind -> Builder { a | inputLabel : Used } slotCaps msg kind
withInputLabel =
    Component.withInputLabel


{-| Pipe form of `maxTime` — re-exported from `M3e.Timepicker`.
-}
withMaxTime : String -> Builder { a | maxTime : Available } slotCaps msg kind -> Builder { a | maxTime : Used } slotCaps msg kind
withMaxTime =
    Component.withMaxTime


{-| Pipe form of `minTime` — re-exported from `M3e.Timepicker`.
-}
withMinTime : String -> Builder { a | minTime : Available } slotCaps msg kind -> Builder { a | minTime : Used } slotCaps msg kind
withMinTime =
    Component.withMinTime


{-| Pipe form of `minuteLabel` — re-exported from `M3e.Timepicker`.
-}
withMinuteLabel : String -> Builder { a | minuteLabel : Available } slotCaps msg kind -> Builder { a | minuteLabel : Used } slotCaps msg kind
withMinuteLabel =
    Component.withMinuteLabel


{-| Pipe form of `mode` — re-exported from `M3e.Timepicker`.
-}
withMode : Value Component.Mode -> Builder { a | mode : Available } slotCaps msg kind -> Builder { a | mode : Used } slotCaps msg kind
withMode =
    Component.withMode


{-| Pipe form of `modeToggleLabel` — re-exported from `M3e.Timepicker`.
-}
withModeToggleLabel : String -> Builder { a | modeToggleLabel : Available } slotCaps msg kind -> Builder { a | modeToggleLabel : Used } slotCaps msg kind
withModeToggleLabel =
    Component.withModeToggleLabel


{-| Pipe form of `orientation` — re-exported from `M3e.Timepicker`.
-}
withOrientation : Value Component.Orientation -> Builder { a | orientation : Available } slotCaps msg kind -> Builder { a | orientation : Used } slotCaps msg kind
withOrientation =
    Component.withOrientation


{-| Pipe form of `periodToggleLabel` — re-exported from `M3e.Timepicker`.
-}
withPeriodToggleLabel : String -> Builder { a | periodToggleLabel : Available } slotCaps msg kind -> Builder { a | periodToggleLabel : Used } slotCaps msg kind
withPeriodToggleLabel =
    Component.withPeriodToggleLabel


{-| Pipe form of `secondLabel` — re-exported from `M3e.Timepicker`.
-}
withSecondLabel : String -> Builder { a | secondLabel : Available } slotCaps msg kind -> Builder { a | secondLabel : Used } slotCaps msg kind
withSecondLabel =
    Component.withSecondLabel


{-| Pipe form of `showSeconds` — re-exported from `M3e.Timepicker`.
-}
withShowSeconds : Bool -> Builder { a | showSeconds : Available } slotCaps msg kind -> Builder { a | showSeconds : Used } slotCaps msg kind
withShowSeconds =
    Component.withShowSeconds


{-| Pipe form of `variant` — re-exported from `M3e.Timepicker`.
-}
withVariant : Value Component.Variant -> Builder { a | variant : Available } slotCaps msg kind -> Builder { a | variant : Used } slotCaps msg kind
withVariant =
    Component.withVariant


{-| Pipe form of `onChange` — re-exported from `M3e.Timepicker`.
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg kind -> Builder { a | onChange : Used } slotCaps msg kind
withOnChange =
    Component.withOnChange


{-| Pipe form of `onBeforetoggle` — re-exported from `M3e.Timepicker`.
-}
withOnBeforetoggle : msg -> Builder { a | onBeforetoggle : Available } slotCaps msg kind -> Builder { a | onBeforetoggle : Used } slotCaps msg kind
withOnBeforetoggle =
    Component.withOnBeforetoggle


{-| Pipe form of `onToggle` — re-exported from `M3e.Timepicker`.
-}
withOnToggle : msg -> Builder { a | onToggle : Available } slotCaps msg kind -> Builder { a | onToggle : Used } slotCaps msg kind
withOnToggle =
    Component.withOnToggle
