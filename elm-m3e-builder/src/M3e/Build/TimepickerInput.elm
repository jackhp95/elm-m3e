module M3e.Build.TimepickerInput exposing
    ( build, toElement
    , Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
    , withClass, withFor, withFormat, withHideLabels, withHour, withHourLabel, withId, withMaxTime, withMinTime, withMinute, withMinuteLabel, withOnChange, withOnViewChange, withOrientation, withPeriod, withPeriodToggleLabel, withSecond, withSecondLabel, withShowSeconds, withSlot, withStyle, withViewAttr
    )

{-| The builder module for `m3e-timepicker-input` — seed, pipe, and close.

This module provides everything you need to BUILD with `TimepickerInput`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.Component.TimepickerInput.view`.

@docs build, toElement
@docs Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
@docs withClass, withFor, withFormat, withHideLabels, withHour, withHourLabel, withId, withMaxTime, withMinTime, withMinute, withMinuteLabel, withOnChange, withOnViewChange, withOrientation, withPeriod, withPeriodToggleLabel, withSecond, withSecondLabel, withShowSeconds, withSlot, withStyle, withViewAttr

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Component.TimepickerInput as Component
import M3e.Internal.Types.TimepickerInput
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.Values


{-| The kind this element produces — a `Brand` that marks the phantom row.
-}
type alias Is s =
    M3e.Internal.Types.TimepickerInput.Is s


{-| The pipe-builder, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Internal.Types.TimepickerInput.Builder attrCaps slotCaps msg kind


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.TimepickerInput.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.TimepickerInput.ChildAdmittedBy childAdm


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-timepicker-input" [] []


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg kind -> Element (Component.Is kind) admittedBy msg
toElement =
    B.toElement


{-| Pipe form of `class` — re-exported from `M3e.TimepickerInput`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.TimepickerInput`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.TimepickerInput`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.TimepickerInput`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `for` — re-exported from `M3e.TimepickerInput`.
-}
withFor : String -> Builder { a | for : Available } slotCaps msg kind -> Builder { a | for : Used } slotCaps msg kind
withFor =
    Component.withFor


{-| Pipe form of `format` — re-exported from `M3e.TimepickerInput`.
-}
withFormat : Value Component.Format -> Builder { a | format : Available } slotCaps msg kind -> Builder { a | format : Used } slotCaps msg kind
withFormat =
    Component.withFormat


{-| Pipe form of `hideLabels` — re-exported from `M3e.TimepickerInput`.
-}
withHideLabels : Bool -> Builder { a | hideLabels : Available } slotCaps msg kind -> Builder { a | hideLabels : Used } slotCaps msg kind
withHideLabels =
    Component.withHideLabels


{-| Pipe form of `hour` — re-exported from `M3e.TimepickerInput`.
-}
withHour : Float -> Builder { a | hour : Available } slotCaps msg kind -> Builder { a | hour : Used } slotCaps msg kind
withHour =
    Component.withHour


{-| Pipe form of `hourLabel` — re-exported from `M3e.TimepickerInput`.
-}
withHourLabel : String -> Builder { a | hourLabel : Available } slotCaps msg kind -> Builder { a | hourLabel : Used } slotCaps msg kind
withHourLabel =
    Component.withHourLabel


{-| Pipe form of `maxTime` — re-exported from `M3e.TimepickerInput`.
-}
withMaxTime : String -> Builder { a | maxTime : Available } slotCaps msg kind -> Builder { a | maxTime : Used } slotCaps msg kind
withMaxTime =
    Component.withMaxTime


{-| Pipe form of `minTime` — re-exported from `M3e.TimepickerInput`.
-}
withMinTime : String -> Builder { a | minTime : Available } slotCaps msg kind -> Builder { a | minTime : Used } slotCaps msg kind
withMinTime =
    Component.withMinTime


{-| Pipe form of `minute` — re-exported from `M3e.TimepickerInput`.
-}
withMinute : Float -> Builder { a | minute : Available } slotCaps msg kind -> Builder { a | minute : Used } slotCaps msg kind
withMinute =
    Component.withMinute


{-| Pipe form of `minuteLabel` — re-exported from `M3e.TimepickerInput`.
-}
withMinuteLabel : String -> Builder { a | minuteLabel : Available } slotCaps msg kind -> Builder { a | minuteLabel : Used } slotCaps msg kind
withMinuteLabel =
    Component.withMinuteLabel


{-| Pipe form of `orientation` — re-exported from `M3e.TimepickerInput`.
-}
withOrientation : String -> Builder { a | orientation : Available } slotCaps msg kind -> Builder { a | orientation : Used } slotCaps msg kind
withOrientation =
    Component.withOrientation


{-| Pipe form of `period` — re-exported from `M3e.TimepickerInput`.
-}
withPeriod : Value Component.Period -> Builder { a | period : Available } slotCaps msg kind -> Builder { a | period : Used } slotCaps msg kind
withPeriod =
    Component.withPeriod


{-| Pipe form of `periodToggleLabel` — re-exported from `M3e.TimepickerInput`.
-}
withPeriodToggleLabel : String -> Builder { a | periodToggleLabel : Available } slotCaps msg kind -> Builder { a | periodToggleLabel : Used } slotCaps msg kind
withPeriodToggleLabel =
    Component.withPeriodToggleLabel


{-| Pipe form of `second` — re-exported from `M3e.TimepickerInput`.
-}
withSecond : Float -> Builder { a | second : Available } slotCaps msg kind -> Builder { a | second : Used } slotCaps msg kind
withSecond =
    Component.withSecond


{-| Pipe form of `secondLabel` — re-exported from `M3e.TimepickerInput`.
-}
withSecondLabel : String -> Builder { a | secondLabel : Available } slotCaps msg kind -> Builder { a | secondLabel : Used } slotCaps msg kind
withSecondLabel =
    Component.withSecondLabel


{-| Pipe form of `showSeconds` — re-exported from `M3e.TimepickerInput`.
-}
withShowSeconds : Bool -> Builder { a | showSeconds : Available } slotCaps msg kind -> Builder { a | showSeconds : Used } slotCaps msg kind
withShowSeconds =
    Component.withShowSeconds


{-| Pipe form of `viewAttr` — re-exported from `M3e.TimepickerInput`.
-}
withViewAttr : Value Component.ViewAttr -> Builder { a | viewAttr : Available } slotCaps msg kind -> Builder { a | viewAttr : Used } slotCaps msg kind
withViewAttr =
    Component.withViewAttr


{-| Pipe form of `onViewChange` — re-exported from `M3e.TimepickerInput`.
-}
withOnViewChange : msg -> Builder { a | onViewChange : Available } slotCaps msg kind -> Builder { a | onViewChange : Used } slotCaps msg kind
withOnViewChange =
    Component.withOnViewChange


{-| Pipe form of `onChange` — re-exported from `M3e.TimepickerInput`.
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg kind -> Builder { a | onChange : Used } slotCaps msg kind
withOnChange =
    Component.withOnChange
