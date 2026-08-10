module M3e.Stepper.Build exposing
    ( build, toElement, view
    , Builder, AttrCaps, SlotCaps, Is, PanelSlot, StepSlot, ChildAdmittedBy
    , withClass, withHeaderPosition, withId, withLabelPosition, withLinear, withOnBeforeinput, withOnChange, withOnInput, withOrientation, withSlot, withStyle
    , panel, step
    , withPanel, withStep
    )

{-| The builder module for `m3e-stepper` — seed, pipe, and close.

This module provides everything you need to BUILD with `Stepper`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.Stepper.view`.

@docs build, toElement, view
@docs Builder, AttrCaps, SlotCaps, Is, PanelSlot, StepSlot, ChildAdmittedBy
@docs withClass, withHeaderPosition, withId, withLabelPosition, withLinear, withOnBeforeinput, withOnChange, withOnInput, withOrientation, withSlot, withStyle
@docs panel, step
@docs withPanel, withStep

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Internal.Types.Stepper
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.Stepper as Component
import M3e.Values


{-| The kind this element produces — a `Brand` that marks the phantom row.
-}
type alias Is s =
    M3e.Internal.Types.Stepper.Is s


{-| The pipe-builder, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Internal.Types.Stepper.Builder attrCaps slotCaps msg kind


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.Stepper.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.Stepper.ChildAdmittedBy childAdm


{-| The kinds the `panel` slot admits.
-}
type alias PanelSlot =
    M3e.Internal.Types.Stepper.PanelSlot


{-| The kinds the `step` slot admits.
-}
type alias StepSlot =
    M3e.Internal.Types.Stepper.StepSlot


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-stepper" [] []


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


{-| Place a builder-built element into the named `panel` slot — calls `B.toElement` internally.
-}
panel :
    B.Builder childRow childAttrCaps childSlotCaps Component.PanelSlot msg
    -> Element free freeAdmittedBy msg
panel builder =
    Component.panel (B.toElement builder)


{-| Place a builder-built element into the named `step` slot — calls `B.toElement` internally.
-}
step :
    B.Builder childRow childAttrCaps childSlotCaps Component.StepSlot msg
    -> Element free freeAdmittedBy msg
step builder =
    Component.step (B.toElement builder)


{-| Pipe form of the `panel` slot (repeatable) — accepts a builder directly.
-}
withPanel :
    B.Builder childRow childAttrCaps childSlotCaps Component.PanelSlot msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withPanel slotBuilder builder_ =
    B.withChild (El.toNode (Component.panel (B.toElement slotBuilder))) builder_


{-| Pipe form of the `step` slot (repeatable) — accepts a builder directly.
-}
withStep :
    B.Builder childRow childAttrCaps childSlotCaps Component.StepSlot msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withStep slotBuilder builder_ =
    B.withChild (El.toNode (Component.step (B.toElement slotBuilder))) builder_


{-| Pipe form of `class` — re-exported from `M3e.Stepper`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.Stepper`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.Stepper`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.Stepper`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `headerPosition` — re-exported from `M3e.Stepper`.
-}
withHeaderPosition : Value Component.HeaderPosition -> Builder { a | headerPosition : Available } slotCaps msg kind -> Builder { a | headerPosition : Used } slotCaps msg kind
withHeaderPosition =
    Component.withHeaderPosition


{-| Pipe form of `labelPosition` — re-exported from `M3e.Stepper`.
-}
withLabelPosition : Value Component.LabelPosition -> Builder { a | labelPosition : Available } slotCaps msg kind -> Builder { a | labelPosition : Used } slotCaps msg kind
withLabelPosition =
    Component.withLabelPosition


{-| Pipe form of `linear` — re-exported from `M3e.Stepper`.
-}
withLinear : Bool -> Builder { a | linear : Available } slotCaps msg kind -> Builder { a | linear : Used } slotCaps msg kind
withLinear =
    Component.withLinear


{-| Pipe form of `orientation` — re-exported from `M3e.Stepper`.
-}
withOrientation : Value Component.Orientation -> Builder { a | orientation : Available } slotCaps msg kind -> Builder { a | orientation : Used } slotCaps msg kind
withOrientation =
    Component.withOrientation


{-| Pipe form of `onChange` — re-exported from `M3e.Stepper`.
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg kind -> Builder { a | onChange : Used } slotCaps msg kind
withOnChange =
    Component.withOnChange


{-| Pipe form of `onBeforeinput` — re-exported from `M3e.Stepper`.
-}
withOnBeforeinput : msg -> Builder { a | onBeforeinput : Available } slotCaps msg kind -> Builder { a | onBeforeinput : Used } slotCaps msg kind
withOnBeforeinput =
    Component.withOnBeforeinput


{-| Pipe form of `onInput` — re-exported from `M3e.Stepper`.
-}
withOnInput : msg -> Builder { a | onInput : Available } slotCaps msg kind -> Builder { a | onInput : Used } slotCaps msg kind
withOnInput =
    Component.withOnInput
