module M3e.Datepicker.Build exposing
    ( build, toElement, view
    , Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
    , withClass, withClearLabel, withClearable, withConfirmLabel, withDate, withDismissLabel, withFor, withId, withLabel, withMaxDate, withMinDate, withNextMonthLabel, withNextMultiYearLabel, withNextYearLabel, withOnBeforetoggle, withOnChange, withOnToggle, withPreviousMonthLabel, withPreviousMultiYearLabel, withPreviousYearLabel, withRange, withRangeEnd, withRangeStart, withSlot, withStartAt, withStartView, withStyle, withVariant
    )

{-| The builder module for `m3e-datepicker` — seed, pipe, and close.

This module provides everything you need to BUILD with `Datepicker`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.Datepicker.view`.

@docs build, toElement, view
@docs Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
@docs withClass, withClearLabel, withClearable, withConfirmLabel, withDate, withDismissLabel, withFor, withId, withLabel, withMaxDate, withMinDate, withNextMonthLabel, withNextMultiYearLabel, withNextYearLabel, withOnBeforetoggle, withOnChange, withOnToggle, withPreviousMonthLabel, withPreviousMultiYearLabel, withPreviousYearLabel, withRange, withRangeEnd, withRangeStart, withSlot, withStartAt, withStartView, withStyle, withVariant

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Datepicker as Component
import M3e.Internal.Types.Datepicker
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.Values


{-| The kind this element produces — a `Brand` that marks the phantom row.
-}
type alias Is s =
    M3e.Internal.Types.Datepicker.Is s


{-| The pipe-builder, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Internal.Types.Datepicker.Builder attrCaps slotCaps msg kind


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.Datepicker.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.Datepicker.ChildAdmittedBy childAdm


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-datepicker" [] []


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


{-| Pipe form of `class` — re-exported from `M3e.Datepicker`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.Datepicker`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.Datepicker`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.Datepicker`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `clearLabel` — re-exported from `M3e.Datepicker`.
-}
withClearLabel : String -> Builder { a | clearLabel : Available } slotCaps msg kind -> Builder { a | clearLabel : Used } slotCaps msg kind
withClearLabel =
    Component.withClearLabel


{-| Pipe form of `clearable` — re-exported from `M3e.Datepicker`.
-}
withClearable : Bool -> Builder { a | clearable : Available } slotCaps msg kind -> Builder { a | clearable : Used } slotCaps msg kind
withClearable =
    Component.withClearable


{-| Pipe form of `confirmLabel` — re-exported from `M3e.Datepicker`.
-}
withConfirmLabel : String -> Builder { a | confirmLabel : Available } slotCaps msg kind -> Builder { a | confirmLabel : Used } slotCaps msg kind
withConfirmLabel =
    Component.withConfirmLabel


{-| Pipe form of `date` — re-exported from `M3e.Datepicker`.
-}
withDate : String -> Builder { a | date : Available } slotCaps msg kind -> Builder { a | date : Used } slotCaps msg kind
withDate =
    Component.withDate


{-| Pipe form of `dismissLabel` — re-exported from `M3e.Datepicker`.
-}
withDismissLabel : String -> Builder { a | dismissLabel : Available } slotCaps msg kind -> Builder { a | dismissLabel : Used } slotCaps msg kind
withDismissLabel =
    Component.withDismissLabel


{-| Pipe form of `for` — re-exported from `M3e.Datepicker`.
-}
withFor : String -> Builder { a | for : Available } slotCaps msg kind -> Builder { a | for : Used } slotCaps msg kind
withFor =
    Component.withFor


{-| Pipe form of `label` — re-exported from `M3e.Datepicker`.
-}
withLabel : String -> Builder { a | label : Available } slotCaps msg kind -> Builder { a | label : Used } slotCaps msg kind
withLabel =
    Component.withLabel


{-| Pipe form of `maxDate` — re-exported from `M3e.Datepicker`.
-}
withMaxDate : String -> Builder { a | maxDate : Available } slotCaps msg kind -> Builder { a | maxDate : Used } slotCaps msg kind
withMaxDate =
    Component.withMaxDate


{-| Pipe form of `minDate` — re-exported from `M3e.Datepicker`.
-}
withMinDate : String -> Builder { a | minDate : Available } slotCaps msg kind -> Builder { a | minDate : Used } slotCaps msg kind
withMinDate =
    Component.withMinDate


{-| Pipe form of `nextMonthLabel` — re-exported from `M3e.Datepicker`.
-}
withNextMonthLabel : String -> Builder { a | nextMonthLabel : Available } slotCaps msg kind -> Builder { a | nextMonthLabel : Used } slotCaps msg kind
withNextMonthLabel =
    Component.withNextMonthLabel


{-| Pipe form of `nextMultiYearLabel` — re-exported from `M3e.Datepicker`.
-}
withNextMultiYearLabel : String -> Builder { a | nextMultiYearLabel : Available } slotCaps msg kind -> Builder { a | nextMultiYearLabel : Used } slotCaps msg kind
withNextMultiYearLabel =
    Component.withNextMultiYearLabel


{-| Pipe form of `nextYearLabel` — re-exported from `M3e.Datepicker`.
-}
withNextYearLabel : String -> Builder { a | nextYearLabel : Available } slotCaps msg kind -> Builder { a | nextYearLabel : Used } slotCaps msg kind
withNextYearLabel =
    Component.withNextYearLabel


{-| Pipe form of `previousMonthLabel` — re-exported from `M3e.Datepicker`.
-}
withPreviousMonthLabel : String -> Builder { a | previousMonthLabel : Available } slotCaps msg kind -> Builder { a | previousMonthLabel : Used } slotCaps msg kind
withPreviousMonthLabel =
    Component.withPreviousMonthLabel


{-| Pipe form of `previousMultiYearLabel` — re-exported from `M3e.Datepicker`.
-}
withPreviousMultiYearLabel : String -> Builder { a | previousMultiYearLabel : Available } slotCaps msg kind -> Builder { a | previousMultiYearLabel : Used } slotCaps msg kind
withPreviousMultiYearLabel =
    Component.withPreviousMultiYearLabel


{-| Pipe form of `previousYearLabel` — re-exported from `M3e.Datepicker`.
-}
withPreviousYearLabel : String -> Builder { a | previousYearLabel : Available } slotCaps msg kind -> Builder { a | previousYearLabel : Used } slotCaps msg kind
withPreviousYearLabel =
    Component.withPreviousYearLabel


{-| Pipe form of `range` — re-exported from `M3e.Datepicker`.
-}
withRange : Bool -> Builder { a | range : Available } slotCaps msg kind -> Builder { a | range : Used } slotCaps msg kind
withRange =
    Component.withRange


{-| Pipe form of `rangeEnd` — re-exported from `M3e.Datepicker`.
-}
withRangeEnd : String -> Builder { a | rangeEnd : Available } slotCaps msg kind -> Builder { a | rangeEnd : Used } slotCaps msg kind
withRangeEnd =
    Component.withRangeEnd


{-| Pipe form of `rangeStart` — re-exported from `M3e.Datepicker`.
-}
withRangeStart : String -> Builder { a | rangeStart : Available } slotCaps msg kind -> Builder { a | rangeStart : Used } slotCaps msg kind
withRangeStart =
    Component.withRangeStart


{-| Pipe form of `startAt` — re-exported from `M3e.Datepicker`.
-}
withStartAt : String -> Builder { a | startAt : Available } slotCaps msg kind -> Builder { a | startAt : Used } slotCaps msg kind
withStartAt =
    Component.withStartAt


{-| Pipe form of `startView` — re-exported from `M3e.Datepicker`.
-}
withStartView : Value Component.StartView -> Builder { a | startView : Available } slotCaps msg kind -> Builder { a | startView : Used } slotCaps msg kind
withStartView =
    Component.withStartView


{-| Pipe form of `variant` — re-exported from `M3e.Datepicker`.
-}
withVariant : Value Component.Variant -> Builder { a | variant : Available } slotCaps msg kind -> Builder { a | variant : Used } slotCaps msg kind
withVariant =
    Component.withVariant


{-| Pipe form of `onChange` — re-exported from `M3e.Datepicker`.
-}
withOnChange : (String -> msg) -> Builder { a | onChange : Available } slotCaps msg kind -> Builder { a | onChange : Used } slotCaps msg kind
withOnChange =
    Component.withOnChange


{-| Pipe form of `onBeforetoggle` — re-exported from `M3e.Datepicker`.
-}
withOnBeforetoggle : msg -> Builder { a | onBeforetoggle : Available } slotCaps msg kind -> Builder { a | onBeforetoggle : Used } slotCaps msg kind
withOnBeforetoggle =
    Component.withOnBeforetoggle


{-| Pipe form of `onToggle` — re-exported from `M3e.Datepicker`.
-}
withOnToggle : msg -> Builder { a | onToggle : Available } slotCaps msg kind -> Builder { a | onToggle : Used } slotCaps msg kind
withOnToggle =
    Component.withOnToggle
