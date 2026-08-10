module M3e.Card.Build exposing
    ( build, toElement, view
    , Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
    , withActionable, withClass, withDisabled, withDisabledInteractive, withDownload, withHref, withId, withInline, withName, withOnClick, withOrientation, withRel, withSlot, withStyle, withTarget, withType, withValue, withVariant
    , actions, content, footer, header
    , withActions, withContent, withFooter, withHeader, withChild
    )

{-| The builder module for `m3e-card` — seed, pipe, and close.

This module provides everything you need to BUILD with `Card`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.Card.view`.

@docs build, toElement, view
@docs Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
@docs withActionable, withClass, withDisabled, withDisabledInteractive, withDownload, withHref, withId, withInline, withName, withOnClick, withOrientation, withRel, withSlot, withStyle, withTarget, withType, withValue, withVariant
@docs actions, content, footer, header
@docs withActions, withContent, withFooter, withHeader, withChild

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Card as Component
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.Values


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


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-card" [] []


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


{-| Place a builder-built element into the named `actions` slot — calls `B.toElement` internally.
-}
actions :
    B.Builder childRow childAttrCaps childSlotCaps childAccepts msg
    -> Element free freeAdmittedBy msg
actions builder =
    Component.actions (B.toElement builder)


{-| Place a builder-built element into the named `content` slot — calls `B.toElement` internally.
-}
content :
    B.Builder childRow childAttrCaps childSlotCaps childAccepts msg
    -> Element free freeAdmittedBy msg
content builder =
    Component.content (B.toElement builder)


{-| Place a builder-built element into the named `footer` slot — calls `B.toElement` internally.
-}
footer :
    B.Builder childRow childAttrCaps childSlotCaps childAccepts msg
    -> Element free freeAdmittedBy msg
footer builder =
    Component.footer (B.toElement builder)


{-| Place a builder-built element into the named `header` slot — calls `B.toElement` internally.
-}
header :
    B.Builder childRow childAttrCaps childSlotCaps childAccepts msg
    -> Element free freeAdmittedBy msg
header builder =
    Component.header (B.toElement builder)


{-| Pipe form of the `actions` slot — accepts a builder directly (no `.toElement`).
-}
withActions :
    B.Builder childRow childAttrCaps childSlotCaps childAccepts msg
    -> Builder attrCaps { s | actions : Available } msg kind
    -> Builder attrCaps { s | actions : Used } msg kind
withActions slotBuilder builder_ =
    B.withChild (El.toNode (Component.actions (B.toElement slotBuilder))) builder_


{-| Pipe form of the `content` slot — accepts a builder directly (no `.toElement`).
-}
withContent :
    B.Builder childRow childAttrCaps childSlotCaps childAccepts msg
    -> Builder attrCaps { s | content : Available } msg kind
    -> Builder attrCaps { s | content : Used } msg kind
withContent slotBuilder builder_ =
    B.withChild (El.toNode (Component.content (B.toElement slotBuilder))) builder_


{-| Pipe form of the `footer` slot — accepts a builder directly (no `.toElement`).
-}
withFooter :
    B.Builder childRow childAttrCaps childSlotCaps childAccepts msg
    -> Builder attrCaps { s | footer : Available } msg kind
    -> Builder attrCaps { s | footer : Used } msg kind
withFooter slotBuilder builder_ =
    B.withChild (El.toNode (Component.footer (B.toElement slotBuilder))) builder_


{-| Pipe form of the `header` slot — accepts a builder directly (no `.toElement`).
-}
withHeader :
    B.Builder childRow childAttrCaps childSlotCaps childAccepts msg
    -> Builder attrCaps { s | header : Available } msg kind
    -> Builder attrCaps { s | header : Used } msg kind
withHeader slotBuilder builder_ =
    B.withChild (El.toNode (Component.header (B.toElement slotBuilder))) builder_


{-| Pipe form of a default-slot child (repeatable) — accepts a builder directly.
-}
withChild :
    B.Builder childRow childAttrCaps childSlotCaps accepts msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withChild childBuilder builder_ =
    B.withChild (El.toNode (B.toElement childBuilder)) builder_


{-| Pipe form of `class` — re-exported from `M3e.Card`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.Card`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.Card`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.Card`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `actionable` — re-exported from `M3e.Card`.
-}
withActionable : Bool -> Builder { a | actionable : Available } slotCaps msg kind -> Builder { a | actionable : Used } slotCaps msg kind
withActionable =
    Component.withActionable


{-| Pipe form of `disabled` — re-exported from `M3e.Card`.
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg kind -> Builder { a | disabled : Used } slotCaps msg kind
withDisabled =
    Component.withDisabled


{-| Pipe form of `disabledInteractive` — re-exported from `M3e.Card`.
-}
withDisabledInteractive : Bool -> Builder { a | disabledInteractive : Available } slotCaps msg kind -> Builder { a | disabledInteractive : Used } slotCaps msg kind
withDisabledInteractive =
    Component.withDisabledInteractive


{-| Pipe form of `download` — re-exported from `M3e.Card`.
-}
withDownload : String -> Builder { a | download : Available } slotCaps msg kind -> Builder { a | download : Used } slotCaps msg kind
withDownload =
    Component.withDownload


{-| Pipe form of `href` — re-exported from `M3e.Card`.
-}
withHref : String -> Builder { a | href : Available } slotCaps msg kind -> Builder { a | href : Used } slotCaps msg kind
withHref =
    Component.withHref


{-| Pipe form of `inline` — re-exported from `M3e.Card`.
-}
withInline : Bool -> Builder { a | inline : Available } slotCaps msg kind -> Builder { a | inline : Used } slotCaps msg kind
withInline =
    Component.withInline


{-| Pipe form of `name` — re-exported from `M3e.Card`.
-}
withName : String -> Builder { a | name : Available } slotCaps msg kind -> Builder { a | name : Used } slotCaps msg kind
withName =
    Component.withName


{-| Pipe form of `orientation` — re-exported from `M3e.Card`.
-}
withOrientation : Value Component.Orientation -> Builder { a | orientation : Available } slotCaps msg kind -> Builder { a | orientation : Used } slotCaps msg kind
withOrientation =
    Component.withOrientation


{-| Pipe form of `rel` — re-exported from `M3e.Card`.
-}
withRel : String -> Builder { a | rel : Available } slotCaps msg kind -> Builder { a | rel : Used } slotCaps msg kind
withRel =
    Component.withRel


{-| Pipe form of `target` — re-exported from `M3e.Card`.
-}
withTarget : String -> Builder { a | target : Available } slotCaps msg kind -> Builder { a | target : Used } slotCaps msg kind
withTarget =
    Component.withTarget


{-| Pipe form of `type_` — re-exported from `M3e.Card`.
-}
withType : Value Component.Type -> Builder { a | type_ : Available } slotCaps msg kind -> Builder { a | type_ : Used } slotCaps msg kind
withType =
    Component.withType


{-| Pipe form of `value` — re-exported from `M3e.Card`.
-}
withValue : String -> Builder { a | value : Available } slotCaps msg kind -> Builder { a | value : Used } slotCaps msg kind
withValue =
    Component.withValue


{-| Pipe form of `variant` — re-exported from `M3e.Card`.
-}
withVariant : Value Component.Variant -> Builder { a | variant : Available } slotCaps msg kind -> Builder { a | variant : Used } slotCaps msg kind
withVariant =
    Component.withVariant


{-| Pipe form of `onClick` — re-exported from `M3e.Card`.
-}
withOnClick : msg -> Builder { a | onClick : Available } slotCaps msg kind -> Builder { a | onClick : Used } slotCaps msg kind
withOnClick =
    Component.withOnClick
