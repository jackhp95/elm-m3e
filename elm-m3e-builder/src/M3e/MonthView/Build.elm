module M3e.MonthView.Build exposing
    ( build, toElement, view
    , Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
    , withActive, withActiveDate, withClass, withDate, withId, withMaxDate, withMinDate, withOnActiveChange, withOnChange, withRangeEnd, withRangeStart, withSlot, withStyle, withToday
    )

{-| The builder module for `m3e-month-view` — seed, pipe, and close.

This module provides everything you need to BUILD with `MonthView`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.MonthView.view`.

@docs build, toElement, view
@docs Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
@docs withActive, withActiveDate, withClass, withDate, withId, withMaxDate, withMinDate, withOnActiveChange, withOnChange, withRangeEnd, withRangeStart, withSlot, withStyle, withToday

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Internal.Types.MonthView
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.MonthView as Component


{-| The kind this element produces — a `Brand` that marks the phantom row.
-}
type alias Is s =
    M3e.Internal.Types.MonthView.Is s


{-| The pipe-builder, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Internal.Types.MonthView.Builder attrCaps slotCaps msg kind


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.MonthView.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.MonthView.ChildAdmittedBy childAdm


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-month-view" [] []


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


{-| Pipe form of `class` — re-exported from `M3e.MonthView`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.MonthView`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.MonthView`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.MonthView`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `active` — re-exported from `M3e.MonthView`.
-}
withActive : Bool -> Builder { a | active : Available } slotCaps msg kind -> Builder { a | active : Used } slotCaps msg kind
withActive =
    Component.withActive


{-| Pipe form of `activeDate` — re-exported from `M3e.MonthView`.
-}
withActiveDate : String -> Builder { a | activeDate : Available } slotCaps msg kind -> Builder { a | activeDate : Used } slotCaps msg kind
withActiveDate =
    Component.withActiveDate


{-| Pipe form of `date` — re-exported from `M3e.MonthView`.
-}
withDate : String -> Builder { a | date : Available } slotCaps msg kind -> Builder { a | date : Used } slotCaps msg kind
withDate =
    Component.withDate


{-| Pipe form of `maxDate` — re-exported from `M3e.MonthView`.
-}
withMaxDate : String -> Builder { a | maxDate : Available } slotCaps msg kind -> Builder { a | maxDate : Used } slotCaps msg kind
withMaxDate =
    Component.withMaxDate


{-| Pipe form of `minDate` — re-exported from `M3e.MonthView`.
-}
withMinDate : String -> Builder { a | minDate : Available } slotCaps msg kind -> Builder { a | minDate : Used } slotCaps msg kind
withMinDate =
    Component.withMinDate


{-| Pipe form of `rangeEnd` — re-exported from `M3e.MonthView`.
-}
withRangeEnd : String -> Builder { a | rangeEnd : Available } slotCaps msg kind -> Builder { a | rangeEnd : Used } slotCaps msg kind
withRangeEnd =
    Component.withRangeEnd


{-| Pipe form of `rangeStart` — re-exported from `M3e.MonthView`.
-}
withRangeStart : String -> Builder { a | rangeStart : Available } slotCaps msg kind -> Builder { a | rangeStart : Used } slotCaps msg kind
withRangeStart =
    Component.withRangeStart


{-| Pipe form of `today` — re-exported from `M3e.MonthView`.
-}
withToday : String -> Builder { a | today : Available } slotCaps msg kind -> Builder { a | today : Used } slotCaps msg kind
withToday =
    Component.withToday


{-| Pipe form of `onChange` — re-exported from `M3e.MonthView`.
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg kind -> Builder { a | onChange : Used } slotCaps msg kind
withOnChange =
    Component.withOnChange


{-| Pipe form of `onActiveChange` — re-exported from `M3e.MonthView`.
-}
withOnActiveChange : msg -> Builder { a | onActiveChange : Available } slotCaps msg kind -> Builder { a | onActiveChange : Used } slotCaps msg kind
withOnActiveChange =
    Component.withOnActiveChange
