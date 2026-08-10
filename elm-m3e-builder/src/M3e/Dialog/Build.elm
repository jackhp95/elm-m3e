module M3e.Dialog.Build exposing
    ( build, toElement, view
    , Builder, AttrCaps, SlotCaps, Is, CloseIconSlot, HeaderSlot, ChildAdmittedBy
    , withAlert, withClass, withCloseLabel, withDisableClose, withDismissible, withId, withNoFocusTrap, withOnCancel, withOnClosed, withOnClosing, withOnOpened, withOnOpening, withOpen, withSlot, withStyle
    , actions, closeIcon, header
    , withActions, withCloseIcon, withHeader, withChild
    )

{-| The builder module for `m3e-dialog` — seed, pipe, and close.

This module provides everything you need to BUILD with `Dialog`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.Dialog.view`.

@docs build, toElement, view
@docs Builder, AttrCaps, SlotCaps, Is, CloseIconSlot, HeaderSlot, ChildAdmittedBy
@docs withAlert, withClass, withCloseLabel, withDisableClose, withDismissible, withId, withNoFocusTrap, withOnCancel, withOnClosed, withOnClosing, withOnOpened, withOnOpening, withOpen, withSlot, withStyle
@docs actions, closeIcon, header
@docs withActions, withCloseIcon, withHeader, withChild

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Dialog as Component
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


type alias CloseIconSlot =
    Component.CloseIconSlot


type alias HeaderSlot =
    Component.HeaderSlot


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-dialog" [] []


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


{-| Place a builder-built element into the named `close-icon` slot — calls `B.toElement` internally.
-}
closeIcon :
    B.Builder childRow childAttrCaps childSlotCaps Component.CloseIconSlot msg
    -> Element free freeAdmittedBy msg
closeIcon builder =
    Component.closeIcon (B.toElement builder)


{-| Place a builder-built element into the named `header` slot — calls `B.toElement` internally.
-}
header :
    B.Builder childRow childAttrCaps childSlotCaps Component.HeaderSlot msg
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


{-| Pipe form of the `close-icon` slot — accepts a builder directly (no `.toElement`).
-}
withCloseIcon :
    B.Builder childRow childAttrCaps childSlotCaps Component.CloseIconSlot msg
    -> Builder attrCaps { s | closeIcon : Available } msg kind
    -> Builder attrCaps { s | closeIcon : Used } msg kind
withCloseIcon slotBuilder builder_ =
    B.withChild (El.toNode (Component.closeIcon (B.toElement slotBuilder))) builder_


{-| Pipe form of the `header` slot — accepts a builder directly (no `.toElement`).
-}
withHeader :
    B.Builder childRow childAttrCaps childSlotCaps Component.HeaderSlot msg
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


{-| Pipe form of `class` — re-exported from `M3e.Dialog`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.Dialog`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.Dialog`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.Dialog`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `alert` — re-exported from `M3e.Dialog`.
-}
withAlert : Bool -> Builder { a | alert : Available } slotCaps msg kind -> Builder { a | alert : Used } slotCaps msg kind
withAlert =
    Component.withAlert


{-| Pipe form of `closeLabel` — re-exported from `M3e.Dialog`.
-}
withCloseLabel : String -> Builder { a | closeLabel : Available } slotCaps msg kind -> Builder { a | closeLabel : Used } slotCaps msg kind
withCloseLabel =
    Component.withCloseLabel


{-| Pipe form of `disableClose` — re-exported from `M3e.Dialog`.
-}
withDisableClose : Bool -> Builder { a | disableClose : Available } slotCaps msg kind -> Builder { a | disableClose : Used } slotCaps msg kind
withDisableClose =
    Component.withDisableClose


{-| Pipe form of `dismissible` — re-exported from `M3e.Dialog`.
-}
withDismissible : Bool -> Builder { a | dismissible : Available } slotCaps msg kind -> Builder { a | dismissible : Used } slotCaps msg kind
withDismissible =
    Component.withDismissible


{-| Pipe form of `noFocusTrap` — re-exported from `M3e.Dialog`.
-}
withNoFocusTrap : Bool -> Builder { a | noFocusTrap : Available } slotCaps msg kind -> Builder { a | noFocusTrap : Used } slotCaps msg kind
withNoFocusTrap =
    Component.withNoFocusTrap


{-| Pipe form of `open` — re-exported from `M3e.Dialog`.
-}
withOpen : Bool -> Builder { a | open : Available } slotCaps msg kind -> Builder { a | open : Used } slotCaps msg kind
withOpen =
    Component.withOpen


{-| Pipe form of `onOpening` — re-exported from `M3e.Dialog`.
-}
withOnOpening : msg -> Builder { a | onOpening : Available } slotCaps msg kind -> Builder { a | onOpening : Used } slotCaps msg kind
withOnOpening =
    Component.withOnOpening


{-| Pipe form of `onOpened` — re-exported from `M3e.Dialog`.
-}
withOnOpened : msg -> Builder { a | onOpened : Available } slotCaps msg kind -> Builder { a | onOpened : Used } slotCaps msg kind
withOnOpened =
    Component.withOnOpened


{-| Pipe form of `onClosing` — re-exported from `M3e.Dialog`.
-}
withOnClosing : msg -> Builder { a | onClosing : Available } slotCaps msg kind -> Builder { a | onClosing : Used } slotCaps msg kind
withOnClosing =
    Component.withOnClosing


{-| Pipe form of `onClosed` — re-exported from `M3e.Dialog`.
-}
withOnClosed : msg -> Builder { a | onClosed : Available } slotCaps msg kind -> Builder { a | onClosed : Used } slotCaps msg kind
withOnClosed =
    Component.withOnClosed


{-| Pipe form of `onCancel` — re-exported from `M3e.Dialog`.
-}
withOnCancel : msg -> Builder { a | onCancel : Available } slotCaps msg kind -> Builder { a | onCancel : Used } slotCaps msg kind
withOnCancel =
    Component.withOnCancel
