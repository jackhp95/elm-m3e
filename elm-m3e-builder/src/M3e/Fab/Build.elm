module M3e.Fab.Build exposing
    ( build, toElement, view
    , Builder, AttrCaps, SlotCaps, Is, Content, CloseIconSlot, LabelSlot, ChildAdmittedBy, ActionCaps
    , withClass, withDisabled, withDisabledInteractive, withDownload, withExtended, withHref, withId, withLowered, withName, withOnClick, withRel, withSize, withSlot, withStyle, withTarget, withType, withValue, withVariant
    , closeIcon, label
    , withCloseIcon, withLabel, withChild
    )

{-| The builder module for `m3e-fab` — seed, pipe, and close.

This module provides everything you need to BUILD with `Fab`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.Fab.view`.

@docs build, toElement, view
@docs Builder, AttrCaps, SlotCaps, Is, Content, CloseIconSlot, LabelSlot, ChildAdmittedBy, ActionCaps
@docs withClass, withDisabled, withDisabledInteractive, withDownload, withExtended, withHref, withId, withLowered, withName, withOnClick, withRel, withSize, withSlot, withStyle, withTarget, withType, withValue, withVariant
@docs closeIcon, label
@docs withCloseIcon, withLabel, withChild

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Action as Ac
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Fab as Component
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


{-| The behaviours this component's required action admits.
-}
type alias ActionCaps =
    Component.ActionCaps


type alias Content =
    Component.Content


type alias CloseIconSlot =
    Component.CloseIconSlot


type alias LabelSlot =
    Component.LabelSlot


{-| Seed the pipe-builder with required content (and action).
-}
build :
    { content : Element Component.Content (Component.ChildAdmittedBy childAdm) msg
    , action : Ac.Action Component.ActionCaps msg
    }
    -> Builder AttrCaps SlotCaps msg kind
build required_ =
    B.init "m3e-fab" (Ac.toAttrs required_.action) [ Ac.wrapContent required_.action (El.toNode required_.content) ]


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


{-| Place a builder-built element into the named `close-icon` slot — calls `B.toElement` internally.
-}
closeIcon :
    B.Builder childRow childAttrCaps childSlotCaps Component.CloseIconSlot msg
    -> Element free freeAdmittedBy msg
closeIcon builder =
    Component.closeIcon (B.toElement builder)


{-| Place a builder-built element into the named `label` slot — calls `B.toElement` internally.
-}
label :
    B.Builder childRow childAttrCaps childSlotCaps Component.LabelSlot msg
    -> Element free freeAdmittedBy msg
label builder =
    Component.label (B.toElement builder)


{-| Pipe form of the `close-icon` slot — accepts a builder directly (no `.toElement`).
-}
withCloseIcon :
    B.Builder childRow childAttrCaps childSlotCaps Component.CloseIconSlot msg
    -> Builder attrCaps { s | closeIcon : Available } msg kind
    -> Builder attrCaps { s | closeIcon : Used } msg kind
withCloseIcon slotBuilder builder_ =
    B.withChild (El.toNode (Component.closeIcon (B.toElement slotBuilder))) builder_


{-| Pipe form of the `label` slot — accepts a builder directly (no `.toElement`).
-}
withLabel :
    B.Builder childRow childAttrCaps childSlotCaps Component.LabelSlot msg
    -> Builder attrCaps { s | label : Available } msg kind
    -> Builder attrCaps { s | label : Used } msg kind
withLabel slotBuilder builder_ =
    B.withChild (El.toNode (Component.label (B.toElement slotBuilder))) builder_


{-| Pipe form of a default-slot child (repeatable) — accepts a builder directly.
-}
withChild :
    B.Builder childRow childAttrCaps childSlotCaps accepts msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withChild childBuilder builder_ =
    B.withChild (El.toNode (B.toElement childBuilder)) builder_


{-| Pipe form of `class` — re-exported from `M3e.Fab`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.Fab`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.Fab`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.Fab`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `disabled` — re-exported from `M3e.Fab`.
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg kind -> Builder { a | disabled : Used } slotCaps msg kind
withDisabled =
    Component.withDisabled


{-| Pipe form of `disabledInteractive` — re-exported from `M3e.Fab`.
-}
withDisabledInteractive : Bool -> Builder { a | disabledInteractive : Available } slotCaps msg kind -> Builder { a | disabledInteractive : Used } slotCaps msg kind
withDisabledInteractive =
    Component.withDisabledInteractive


{-| Pipe form of `download` — re-exported from `M3e.Fab`.
-}
withDownload : String -> Builder { a | download : Available } slotCaps msg kind -> Builder { a | download : Used } slotCaps msg kind
withDownload =
    Component.withDownload


{-| Pipe form of `extended` — re-exported from `M3e.Fab`.
-}
withExtended : Bool -> Builder { a | extended : Available } slotCaps msg kind -> Builder { a | extended : Used } slotCaps msg kind
withExtended =
    Component.withExtended


{-| Pipe form of `href` — re-exported from `M3e.Fab`.
-}
withHref : String -> Builder { a | href : Available } slotCaps msg kind -> Builder { a | href : Used } slotCaps msg kind
withHref =
    Component.withHref


{-| Pipe form of `lowered` — re-exported from `M3e.Fab`.
-}
withLowered : Bool -> Builder { a | lowered : Available } slotCaps msg kind -> Builder { a | lowered : Used } slotCaps msg kind
withLowered =
    Component.withLowered


{-| Pipe form of `name` — re-exported from `M3e.Fab`.
-}
withName : String -> Builder { a | name : Available } slotCaps msg kind -> Builder { a | name : Used } slotCaps msg kind
withName =
    Component.withName


{-| Pipe form of `rel` — re-exported from `M3e.Fab`.
-}
withRel : String -> Builder { a | rel : Available } slotCaps msg kind -> Builder { a | rel : Used } slotCaps msg kind
withRel =
    Component.withRel


{-| Pipe form of `size` — re-exported from `M3e.Fab`.
-}
withSize : Value Component.Size -> Builder { a | size : Available } slotCaps msg kind -> Builder { a | size : Used } slotCaps msg kind
withSize =
    Component.withSize


{-| Pipe form of `target` — re-exported from `M3e.Fab`.
-}
withTarget : String -> Builder { a | target : Available } slotCaps msg kind -> Builder { a | target : Used } slotCaps msg kind
withTarget =
    Component.withTarget


{-| Pipe form of `type_` — re-exported from `M3e.Fab`.
-}
withType : Value Component.Type -> Builder { a | type_ : Available } slotCaps msg kind -> Builder { a | type_ : Used } slotCaps msg kind
withType =
    Component.withType


{-| Pipe form of `value` — re-exported from `M3e.Fab`.
-}
withValue : String -> Builder { a | value : Available } slotCaps msg kind -> Builder { a | value : Used } slotCaps msg kind
withValue =
    Component.withValue


{-| Pipe form of `variant` — re-exported from `M3e.Fab`.
-}
withVariant : Value Component.Variant -> Builder { a | variant : Available } slotCaps msg kind -> Builder { a | variant : Used } slotCaps msg kind
withVariant =
    Component.withVariant


{-| Pipe form of `onClick` — re-exported from `M3e.Fab`.
-}
withOnClick : msg -> Builder { a | onClick : Available } slotCaps msg kind -> Builder { a | onClick : Used } slotCaps msg kind
withOnClick =
    Component.withOnClick
