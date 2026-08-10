module M3e.InputChipSet.Build exposing
    ( build, toElement, view
    , Builder, AttrCaps, SlotCaps, Is, Content, ChildAdmittedBy
    , withClass, withDisabled, withId, withName, withOnChange, withRequired, withSlot, withStyle, withValidationmessages, withVertical
    , input
    , withInput, withChild
    )

{-| The builder module for `m3e-input-chip-set` — seed, pipe, and close.

This module provides everything you need to BUILD with `InputChipSet`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.InputChipSet.view`.

@docs build, toElement, view
@docs Builder, AttrCaps, SlotCaps, Is, Content, ChildAdmittedBy
@docs withClass, withDisabled, withId, withName, withOnChange, withRequired, withSlot, withStyle, withValidationmessages, withVertical
@docs input
@docs withInput, withChild

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.InputChipSet as Component
import M3e.Kind exposing (Available, Brand, Ctx, Used)


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


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-input-chip-set" [] []


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


{-| Place a builder-built element into the named `input` slot — calls `B.toElement` internally.
-}
input :
    B.Builder childRow childAttrCaps childSlotCaps childAccepts msg
    -> Element free freeAdmittedBy msg
input builder =
    Component.input (B.toElement builder)


{-| Pipe form of the `input` slot — accepts a builder directly (no `.toElement`).
-}
withInput :
    B.Builder childRow childAttrCaps childSlotCaps childAccepts msg
    -> Builder attrCaps { s | input : Available } msg kind
    -> Builder attrCaps { s | input : Used } msg kind
withInput slotBuilder builder_ =
    B.withChild (El.toNode (Component.input (B.toElement slotBuilder))) builder_


{-| Pipe form of a default-slot child (repeatable) — accepts a builder directly.
-}
withChild :
    B.Builder childRow childAttrCaps childSlotCaps accepts msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withChild childBuilder builder_ =
    B.withChild (El.toNode (B.toElement childBuilder)) builder_


{-| Pipe form of `class` — re-exported from `M3e.InputChipSet`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.InputChipSet`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.InputChipSet`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.InputChipSet`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `disabled` — re-exported from `M3e.InputChipSet`.
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg kind -> Builder { a | disabled : Used } slotCaps msg kind
withDisabled =
    Component.withDisabled


{-| Pipe form of `name` — re-exported from `M3e.InputChipSet`.
-}
withName : String -> Builder { a | name : Available } slotCaps msg kind -> Builder { a | name : Used } slotCaps msg kind
withName =
    Component.withName


{-| Pipe form of `required` — re-exported from `M3e.InputChipSet`.
-}
withRequired : Bool -> Builder { a | required : Available } slotCaps msg kind -> Builder { a | required : Used } slotCaps msg kind
withRequired =
    Component.withRequired


{-| Pipe form of `validationmessages` — re-exported from `M3e.InputChipSet`.
-}
withValidationmessages : String -> Builder { a | validationmessages : Available } slotCaps msg kind -> Builder { a | validationmessages : Used } slotCaps msg kind
withValidationmessages =
    Component.withValidationmessages


{-| Pipe form of `vertical` — re-exported from `M3e.InputChipSet`.
-}
withVertical : Bool -> Builder { a | vertical : Available } slotCaps msg kind -> Builder { a | vertical : Used } slotCaps msg kind
withVertical =
    Component.withVertical


{-| Pipe form of `onChange` — re-exported from `M3e.InputChipSet`.
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg kind -> Builder { a | onChange : Used } slotCaps msg kind
withOnChange =
    Component.withOnChange
