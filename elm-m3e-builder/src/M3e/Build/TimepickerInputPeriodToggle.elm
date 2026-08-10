module M3e.Build.TimepickerInputPeriodToggle exposing
    ( build, toElement
    , Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
    , withClass, withId, withOnChange, withOrientation, withPeriod, withSlot, withStyle
    )

{-| The builder module for `m3e-timepicker-input-period-toggle` — seed, pipe, and close.

This module provides everything you need to BUILD with `TimepickerInputPeriodToggle`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.Component.TimepickerInputPeriodToggle.view`.

@docs build, toElement
@docs Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
@docs withClass, withId, withOnChange, withOrientation, withPeriod, withSlot, withStyle

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Component.TimepickerInputPeriodToggle as Component
import M3e.Internal.Types.TimepickerInputPeriodToggle
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.Values


{-| The kind this element produces — a `Brand` that marks the phantom row.
-}
type alias Is s =
    M3e.Internal.Types.TimepickerInputPeriodToggle.Is s


{-| The pipe-builder, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Internal.Types.TimepickerInputPeriodToggle.Builder attrCaps slotCaps msg kind


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.TimepickerInputPeriodToggle.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.TimepickerInputPeriodToggle.ChildAdmittedBy childAdm


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-timepicker-input-period-toggle" [] []


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg kind -> Element (Component.Is kind) admittedBy msg
toElement =
    B.toElement


{-| Alias for [`toElement`](#toElement) — close and convert to an element.
-}


{-| Pipe form of `class` — re-exported from `M3e.TimepickerInputPeriodToggle`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.TimepickerInputPeriodToggle`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.TimepickerInputPeriodToggle`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.TimepickerInputPeriodToggle`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `orientation` — re-exported from `M3e.TimepickerInputPeriodToggle`.
-}
withOrientation : String -> Builder { a | orientation : Available } slotCaps msg kind -> Builder { a | orientation : Used } slotCaps msg kind
withOrientation =
    Component.withOrientation


{-| Pipe form of `period` — re-exported from `M3e.TimepickerInputPeriodToggle`.
-}
withPeriod : Value Component.Period -> Builder { a | period : Available } slotCaps msg kind -> Builder { a | period : Used } slotCaps msg kind
withPeriod =
    Component.withPeriod


{-| Pipe form of `onChange` — re-exported from `M3e.TimepickerInputPeriodToggle`.
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg kind -> Builder { a | onChange : Used } slotCaps msg kind
withOnChange =
    Component.withOnChange
