module M3e.Build.DateInput exposing
    ( build, toElement
    , Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
    , withClass, withDayLabel, withDisabled, withHourLabel, withId, withMaxDate, withMaxTime, withMinDate, withMinTime, withMinuteLabel, withMonthLabel, withName, withOnBeforeinput, withOnChange, withOnInput, withOnInvalid, withPeriodLabel, withReadonly, withRequired, withSecondLabel, withShowSeconds, withSlot, withStyle, withTimeFormat, withType, withValidationmessages, withValue, withYearLabel
    )

{-| The builder module for `m3e-date-input` — seed, pipe, and close.

This module provides everything you need to BUILD with `DateInput`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.Component.DateInput.view`.

@docs build, toElement
@docs Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
@docs withClass, withDayLabel, withDisabled, withHourLabel, withId, withMaxDate, withMaxTime, withMinDate, withMinTime, withMinuteLabel, withMonthLabel, withName, withOnBeforeinput, withOnChange, withOnInput, withOnInvalid, withPeriodLabel, withReadonly, withRequired, withSecondLabel, withShowSeconds, withSlot, withStyle, withTimeFormat, withType, withValidationmessages, withValue, withYearLabel

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Component.DateInput as Component
import M3e.Internal.Types.DateInput
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.Values


{-| The kind this element produces — a `Brand` that marks the phantom row.
-}
type alias Is s =
    M3e.Internal.Types.DateInput.Is s


{-| The pipe-builder, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Internal.Types.DateInput.Builder attrCaps slotCaps msg kind


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.DateInput.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.DateInput.ChildAdmittedBy childAdm


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-date-input" [] []


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg kind -> Element (Component.Is kind) admittedBy msg
toElement =
    B.toElement


{-| Alias for [`toElement`](#toElement) — close and convert to an element.
-}


{-| Pipe form of `class` — re-exported from `M3e.DateInput`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.DateInput`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.DateInput`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.DateInput`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `dayLabel` — re-exported from `M3e.DateInput`.
-}
withDayLabel : String -> Builder { a | dayLabel : Available } slotCaps msg kind -> Builder { a | dayLabel : Used } slotCaps msg kind
withDayLabel =
    Component.withDayLabel


{-| Pipe form of `disabled` — re-exported from `M3e.DateInput`.
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg kind -> Builder { a | disabled : Used } slotCaps msg kind
withDisabled =
    Component.withDisabled


{-| Pipe form of `hourLabel` — re-exported from `M3e.DateInput`.
-}
withHourLabel : String -> Builder { a | hourLabel : Available } slotCaps msg kind -> Builder { a | hourLabel : Used } slotCaps msg kind
withHourLabel =
    Component.withHourLabel


{-| Pipe form of `maxDate` — re-exported from `M3e.DateInput`.
-}
withMaxDate : String -> Builder { a | maxDate : Available } slotCaps msg kind -> Builder { a | maxDate : Used } slotCaps msg kind
withMaxDate =
    Component.withMaxDate


{-| Pipe form of `maxTime` — re-exported from `M3e.DateInput`.
-}
withMaxTime : String -> Builder { a | maxTime : Available } slotCaps msg kind -> Builder { a | maxTime : Used } slotCaps msg kind
withMaxTime =
    Component.withMaxTime


{-| Pipe form of `minDate` — re-exported from `M3e.DateInput`.
-}
withMinDate : String -> Builder { a | minDate : Available } slotCaps msg kind -> Builder { a | minDate : Used } slotCaps msg kind
withMinDate =
    Component.withMinDate


{-| Pipe form of `minTime` — re-exported from `M3e.DateInput`.
-}
withMinTime : String -> Builder { a | minTime : Available } slotCaps msg kind -> Builder { a | minTime : Used } slotCaps msg kind
withMinTime =
    Component.withMinTime


{-| Pipe form of `minuteLabel` — re-exported from `M3e.DateInput`.
-}
withMinuteLabel : String -> Builder { a | minuteLabel : Available } slotCaps msg kind -> Builder { a | minuteLabel : Used } slotCaps msg kind
withMinuteLabel =
    Component.withMinuteLabel


{-| Pipe form of `monthLabel` — re-exported from `M3e.DateInput`.
-}
withMonthLabel : String -> Builder { a | monthLabel : Available } slotCaps msg kind -> Builder { a | monthLabel : Used } slotCaps msg kind
withMonthLabel =
    Component.withMonthLabel


{-| Pipe form of `name` — re-exported from `M3e.DateInput`.
-}
withName : String -> Builder { a | name : Available } slotCaps msg kind -> Builder { a | name : Used } slotCaps msg kind
withName =
    Component.withName


{-| Pipe form of `periodLabel` — re-exported from `M3e.DateInput`.
-}
withPeriodLabel : String -> Builder { a | periodLabel : Available } slotCaps msg kind -> Builder { a | periodLabel : Used } slotCaps msg kind
withPeriodLabel =
    Component.withPeriodLabel


{-| Pipe form of `readonly` — re-exported from `M3e.DateInput`.
-}
withReadonly : Bool -> Builder { a | readonly : Available } slotCaps msg kind -> Builder { a | readonly : Used } slotCaps msg kind
withReadonly =
    Component.withReadonly


{-| Pipe form of `required` — re-exported from `M3e.DateInput`.
-}
withRequired : Bool -> Builder { a | required : Available } slotCaps msg kind -> Builder { a | required : Used } slotCaps msg kind
withRequired =
    Component.withRequired


{-| Pipe form of `secondLabel` — re-exported from `M3e.DateInput`.
-}
withSecondLabel : String -> Builder { a | secondLabel : Available } slotCaps msg kind -> Builder { a | secondLabel : Used } slotCaps msg kind
withSecondLabel =
    Component.withSecondLabel


{-| Pipe form of `showSeconds` — re-exported from `M3e.DateInput`.
-}
withShowSeconds : Bool -> Builder { a | showSeconds : Available } slotCaps msg kind -> Builder { a | showSeconds : Used } slotCaps msg kind
withShowSeconds =
    Component.withShowSeconds


{-| Pipe form of `timeFormat` — re-exported from `M3e.DateInput`.
-}
withTimeFormat : Value Component.TimeFormat -> Builder { a | timeFormat : Available } slotCaps msg kind -> Builder { a | timeFormat : Used } slotCaps msg kind
withTimeFormat =
    Component.withTimeFormat


{-| Pipe form of `type_` — re-exported from `M3e.DateInput`.
-}
withType : Value Component.Type -> Builder { a | type_ : Available } slotCaps msg kind -> Builder { a | type_ : Used } slotCaps msg kind
withType =
    Component.withType


{-| Pipe form of `validationmessages` — re-exported from `M3e.DateInput`.
-}
withValidationmessages : String -> Builder { a | validationmessages : Available } slotCaps msg kind -> Builder { a | validationmessages : Used } slotCaps msg kind
withValidationmessages =
    Component.withValidationmessages


{-| Pipe form of `value` — re-exported from `M3e.DateInput`.
-}
withValue : String -> Builder { a | value : Available } slotCaps msg kind -> Builder { a | value : Used } slotCaps msg kind
withValue =
    Component.withValue


{-| Pipe form of `yearLabel` — re-exported from `M3e.DateInput`.
-}
withYearLabel : String -> Builder { a | yearLabel : Available } slotCaps msg kind -> Builder { a | yearLabel : Used } slotCaps msg kind
withYearLabel =
    Component.withYearLabel


{-| Pipe form of `onChange` — re-exported from `M3e.DateInput`.
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg kind -> Builder { a | onChange : Used } slotCaps msg kind
withOnChange =
    Component.withOnChange


{-| Pipe form of `onBeforeinput` — re-exported from `M3e.DateInput`.
-}
withOnBeforeinput : msg -> Builder { a | onBeforeinput : Available } slotCaps msg kind -> Builder { a | onBeforeinput : Used } slotCaps msg kind
withOnBeforeinput =
    Component.withOnBeforeinput


{-| Pipe form of `onInput` — re-exported from `M3e.DateInput`.
-}
withOnInput : msg -> Builder { a | onInput : Available } slotCaps msg kind -> Builder { a | onInput : Used } slotCaps msg kind
withOnInput =
    Component.withOnInput


{-| Pipe form of `onInvalid` — re-exported from `M3e.DateInput`.
-}
withOnInvalid : msg -> Builder { a | onInvalid : Available } slotCaps msg kind -> Builder { a | onInvalid : Used } slotCaps msg kind
withOnInvalid =
    Component.withOnInvalid
