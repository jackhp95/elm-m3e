module M3e.Build.Snackbar exposing
    ( build, toElement
    , Builder, AttrCaps, SlotCaps, Is, Content, CloseIconSlot, ChildAdmittedBy
    , withAction, withClass, withCloseLabel, withDismissible, withDuration, withId, withOnBeforetoggle, withOnToggle, withSlot, withStyle
    , closeIcon
    , withCloseIcon, withChild
    )

{-| The builder module for `m3e-snackbar` — seed, pipe, and close.

This module provides everything you need to BUILD with `Snackbar`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.Component.Snackbar.view`.

@docs build, toElement
@docs Builder, AttrCaps, SlotCaps, Is, Content, CloseIconSlot, ChildAdmittedBy
@docs withAction, withClass, withCloseLabel, withDismissible, withDuration, withId, withOnBeforetoggle, withOnToggle, withSlot, withStyle
@docs closeIcon
@docs withCloseIcon, withChild

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Component.Snackbar as Component
import M3e.Internal.Types.Snackbar
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind this element produces — a `Brand` that marks the phantom row.
-}
type alias Is s =
    M3e.Internal.Types.Snackbar.Is s


{-| The pipe-builder, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Internal.Types.Snackbar.Builder attrCaps slotCaps msg kind


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.Snackbar.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    M3e.Internal.Types.Snackbar.SlotCaps


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.Snackbar.ChildAdmittedBy childAdm


{-| The kinds the default slot admits.
-}
type alias Content =
    M3e.Internal.Types.Snackbar.Content


{-| The kinds the `close-icon` slot admits.
-}
type alias CloseIconSlot =
    M3e.Internal.Types.Snackbar.CloseIconSlot


{-| Seed the pipe-builder with required content (and action).
-}
build :
    { content : Element (Component.Content) (Component.ChildAdmittedBy childAdm) msg }
    -> Builder AttrCaps SlotCaps msg kind
build required_ =
    B.init "m3e-snackbar" ([]) [ El.toNode required_.content ]


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg kind -> Element (Component.Is kind) admittedBy msg
toElement =
    B.toElement


{-| Alias for [`toElement`](#toElement) — close and convert to an element.
-}


{-| Place a builder-built element into the named `close-icon` slot — calls `B.toElement` internally.
-}
closeIcon :
    B.Builder childRow childAttrCaps childSlotCaps (Component.CloseIconSlot) msg
    -> Element free freeAdmittedBy msg
closeIcon builder =
    Component.closeIcon (B.toElement builder)


{-| Pipe form of the `close-icon` slot — accepts a builder directly (no `.toElement`).
-}
withCloseIcon :
    B.Builder childRow childAttrCaps childSlotCaps (Component.CloseIconSlot) msg
    -> Builder attrCaps { s | closeIcon : Available } msg kind
    -> Builder attrCaps { s | closeIcon : Used } msg kind
withCloseIcon slotBuilder builder_ =
    B.withChild (El.toNode (Component.closeIcon (B.toElement slotBuilder))) builder_


{-| Pipe form of a default-slot child (repeatable) — accepts a builder directly.
-}
withChild :
    B.Builder childRow childAttrCaps childSlotCaps accepts msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withChild childBuilder builder_ =
    B.withChild (El.toNode (B.toElement childBuilder)) builder_


{-| Pipe form of `class` — re-exported from `M3e.Snackbar`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.Snackbar`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.Snackbar`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.Snackbar`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `action` — re-exported from `M3e.Snackbar`.
-}
withAction : String -> Builder { a | action : Available } slotCaps msg kind -> Builder { a | action : Used } slotCaps msg kind
withAction =
    Component.withAction


{-| Pipe form of `closeLabel` — re-exported from `M3e.Snackbar`.
-}
withCloseLabel : String -> Builder { a | closeLabel : Available } slotCaps msg kind -> Builder { a | closeLabel : Used } slotCaps msg kind
withCloseLabel =
    Component.withCloseLabel


{-| Pipe form of `dismissible` — re-exported from `M3e.Snackbar`.
-}
withDismissible : Bool -> Builder { a | dismissible : Available } slotCaps msg kind -> Builder { a | dismissible : Used } slotCaps msg kind
withDismissible =
    Component.withDismissible


{-| Pipe form of `duration` — re-exported from `M3e.Snackbar`.
-}
withDuration : Float -> Builder { a | duration : Available } slotCaps msg kind -> Builder { a | duration : Used } slotCaps msg kind
withDuration =
    Component.withDuration


{-| Pipe form of `onBeforetoggle` — re-exported from `M3e.Snackbar`.
-}
withOnBeforetoggle : msg -> Builder { a | onBeforetoggle : Available } slotCaps msg kind -> Builder { a | onBeforetoggle : Used } slotCaps msg kind
withOnBeforetoggle =
    Component.withOnBeforetoggle


{-| Pipe form of `onToggle` — re-exported from `M3e.Snackbar`.
-}
withOnToggle : msg -> Builder { a | onToggle : Available } slotCaps msg kind -> Builder { a | onToggle : Used } slotCaps msg kind
withOnToggle =
    Component.withOnToggle
