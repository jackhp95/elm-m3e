module M3e.Select.Build exposing
    ( build, toElement, view
    , Builder, AttrCaps, SlotCaps, Is, Content, ArrowSlot, ChildAdmittedBy
    , withClass, withDisabled, withHideSelectionIndicator, withId, withMulti, withName, withOnBeforeinput, withOnChange, withOnInput, withOnToggle, withPanelClass, withRequired, withSlot, withStyle, withValidationmessages
    , arrow, value
    , withArrow, withValue, withChild
    )

{-| The builder module for `m3e-select` — seed, pipe, and close.

This module provides everything you need to BUILD with `Select`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.Select.view`.

@docs build, toElement, view
@docs Builder, AttrCaps, SlotCaps, Is, Content, ArrowSlot, ChildAdmittedBy
@docs withClass, withDisabled, withHideSelectionIndicator, withId, withMulti, withName, withOnBeforeinput, withOnChange, withOnInput, withOnToggle, withPanelClass, withRequired, withSlot, withStyle, withValidationmessages
@docs arrow, value
@docs withArrow, withValue, withChild

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.Select as Component


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


type alias Content =
    Component.Content


type alias ArrowSlot =
    Component.ArrowSlot


{-| Seed the pipe-builder with required content (and action).
-}
build :
    { content : Element Component.Content (Component.ChildAdmittedBy childAdm) msg }
    -> Builder AttrCaps SlotCaps msg kind
build required_ =
    B.init "m3e-select" [] [ El.toNode required_.content ]


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


{-| Place a builder-built element into the named `arrow` slot — calls `B.toElement` internally.
-}
arrow :
    B.Builder childRow childAttrCaps childSlotCaps Component.ArrowSlot msg
    -> Element free freeAdmittedBy msg
arrow builder =
    Component.arrow (B.toElement builder)


{-| Place a builder-built element into the named `value` slot — calls `B.toElement` internally.
-}
value :
    B.Builder childRow childAttrCaps childSlotCaps childAccepts msg
    -> Element free freeAdmittedBy msg
value builder =
    Component.value (B.toElement builder)


{-| Pipe form of the `arrow` slot — accepts a builder directly (no `.toElement`).
-}
withArrow :
    B.Builder childRow childAttrCaps childSlotCaps Component.ArrowSlot msg
    -> Builder attrCaps { s | arrow : Available } msg kind
    -> Builder attrCaps { s | arrow : Used } msg kind
withArrow slotBuilder builder_ =
    B.withChild (El.toNode (Component.arrow (B.toElement slotBuilder))) builder_


{-| Pipe form of the `value` slot — accepts a builder directly (no `.toElement`).
-}
withValue :
    B.Builder childRow childAttrCaps childSlotCaps childAccepts msg
    -> Builder attrCaps { s | value : Available } msg kind
    -> Builder attrCaps { s | value : Used } msg kind
withValue slotBuilder builder_ =
    B.withChild (El.toNode (Component.value (B.toElement slotBuilder))) builder_


{-| Pipe form of a default-slot child (repeatable) — accepts a builder directly.
-}
withChild :
    B.Builder childRow childAttrCaps childSlotCaps accepts msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withChild childBuilder builder_ =
    B.withChild (El.toNode (B.toElement childBuilder)) builder_


{-| Pipe form of `class` — re-exported from `M3e.Select`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.Select`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.Select`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.Select`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `disabled` — re-exported from `M3e.Select`.
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg kind -> Builder { a | disabled : Used } slotCaps msg kind
withDisabled =
    Component.withDisabled


{-| Pipe form of `hideSelectionIndicator` — re-exported from `M3e.Select`.
-}
withHideSelectionIndicator : Bool -> Builder { a | hideSelectionIndicator : Available } slotCaps msg kind -> Builder { a | hideSelectionIndicator : Used } slotCaps msg kind
withHideSelectionIndicator =
    Component.withHideSelectionIndicator


{-| Pipe form of `multi` — re-exported from `M3e.Select`.
-}
withMulti : Bool -> Builder { a | multi : Available } slotCaps msg kind -> Builder { a | multi : Used } slotCaps msg kind
withMulti =
    Component.withMulti


{-| Pipe form of `name` — re-exported from `M3e.Select`.
-}
withName : String -> Builder { a | name : Available } slotCaps msg kind -> Builder { a | name : Used } slotCaps msg kind
withName =
    Component.withName


{-| Pipe form of `panelClass` — re-exported from `M3e.Select`.
-}
withPanelClass : String -> Builder { a | panelClass : Available } slotCaps msg kind -> Builder { a | panelClass : Used } slotCaps msg kind
withPanelClass =
    Component.withPanelClass


{-| Pipe form of `required` — re-exported from `M3e.Select`.
-}
withRequired : Bool -> Builder { a | required : Available } slotCaps msg kind -> Builder { a | required : Used } slotCaps msg kind
withRequired =
    Component.withRequired


{-| Pipe form of `validationmessages` — re-exported from `M3e.Select`.
-}
withValidationmessages : String -> Builder { a | validationmessages : Available } slotCaps msg kind -> Builder { a | validationmessages : Used } slotCaps msg kind
withValidationmessages =
    Component.withValidationmessages


{-| Pipe form of `onChange` — re-exported from `M3e.Select`.
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg kind -> Builder { a | onChange : Used } slotCaps msg kind
withOnChange =
    Component.withOnChange


{-| Pipe form of `onToggle` — re-exported from `M3e.Select`.
-}
withOnToggle : (String -> msg) -> Builder { a | onToggle : Available } slotCaps msg kind -> Builder { a | onToggle : Used } slotCaps msg kind
withOnToggle =
    Component.withOnToggle


{-| Pipe form of `onBeforeinput` — re-exported from `M3e.Select`.
-}
withOnBeforeinput : msg -> Builder { a | onBeforeinput : Available } slotCaps msg kind -> Builder { a | onBeforeinput : Used } slotCaps msg kind
withOnBeforeinput =
    Component.withOnBeforeinput


{-| Pipe form of `onInput` — re-exported from `M3e.Select`.
-}
withOnInput : msg -> Builder { a | onInput : Available } slotCaps msg kind -> Builder { a | onInput : Used } slotCaps msg kind
withOnInput =
    Component.withOnInput
