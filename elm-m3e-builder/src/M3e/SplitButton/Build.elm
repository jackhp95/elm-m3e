module M3e.SplitButton.Build exposing
    ( build, toElement, view
    , Builder, AttrCaps, SlotCaps, Is, LeadingButtonSlot, TrailingButtonSlot, ChildAdmittedBy
    , withClass, withId, withSize, withSlot, withStyle, withVariant
    , leadingButton, trailingButton
    , withLeadingButton, withTrailingButton
    )

{-| The builder module for `m3e-split-button` — seed, pipe, and close.

This module provides everything you need to BUILD with `SplitButton`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.SplitButton.view`.

@docs build, toElement, view
@docs Builder, AttrCaps, SlotCaps, Is, LeadingButtonSlot, TrailingButtonSlot, ChildAdmittedBy
@docs withClass, withId, withSize, withSlot, withStyle, withVariant
@docs leadingButton, trailingButton
@docs withLeadingButton, withTrailingButton

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.SplitButton as Component
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


{-| The kinds the `leading-button` slot admits.
-}
type alias LeadingButtonSlot =
    Component.LeadingButtonSlot


{-| The kinds the `trailing-button` slot admits.
-}
type alias TrailingButtonSlot =
    Component.TrailingButtonSlot


{-| Seed the pipe-builder with required content (and action).
-}
build :
    { leadingButton : Element Component.LeadingButtonSlot (Component.ChildAdmittedBy childAdm) msg
    , trailingButton : Element Component.TrailingButtonSlot (Component.ChildAdmittedBy childAdm) msg
    }
    -> Builder AttrCaps SlotCaps msg kind
build required_ =
    B.init "m3e-split-button" [] [ El.toNode (Component.leadingButton required_.leadingButton), El.toNode (Component.trailingButton required_.trailingButton) ]


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


{-| Place a builder-built element into the named `leading-button` slot — calls `B.toElement` internally.
-}
leadingButton :
    B.Builder childRow childAttrCaps childSlotCaps Component.LeadingButtonSlot msg
    -> Element free freeAdmittedBy msg
leadingButton builder =
    Component.leadingButton (B.toElement builder)


{-| Place a builder-built element into the named `trailing-button` slot — calls `B.toElement` internally.
-}
trailingButton :
    B.Builder childRow childAttrCaps childSlotCaps Component.TrailingButtonSlot msg
    -> Element free freeAdmittedBy msg
trailingButton builder =
    Component.trailingButton (B.toElement builder)


{-| Pipe form of the `leading-button` slot — accepts a builder directly (no `.toElement`).
-}
withLeadingButton :
    B.Builder childRow childAttrCaps childSlotCaps Component.LeadingButtonSlot msg
    -> Builder attrCaps { s | leadingButton : Available } msg kind
    -> Builder attrCaps { s | leadingButton : Used } msg kind
withLeadingButton slotBuilder builder_ =
    B.withChild (El.toNode (Component.leadingButton (B.toElement slotBuilder))) builder_


{-| Pipe form of the `trailing-button` slot — accepts a builder directly (no `.toElement`).
-}
withTrailingButton :
    B.Builder childRow childAttrCaps childSlotCaps Component.TrailingButtonSlot msg
    -> Builder attrCaps { s | trailingButton : Available } msg kind
    -> Builder attrCaps { s | trailingButton : Used } msg kind
withTrailingButton slotBuilder builder_ =
    B.withChild (El.toNode (Component.trailingButton (B.toElement slotBuilder))) builder_


{-| Pipe form of `class` — re-exported from `M3e.SplitButton`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.SplitButton`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.SplitButton`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.SplitButton`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `size` — re-exported from `M3e.SplitButton`.
-}
withSize : Value Component.Size -> Builder { a | size : Available } slotCaps msg kind -> Builder { a | size : Used } slotCaps msg kind
withSize =
    Component.withSize


{-| Pipe form of `variant` — re-exported from `M3e.SplitButton`.
-}
withVariant : Value Component.Variant -> Builder { a | variant : Available } slotCaps msg kind -> Builder { a | variant : Used } slotCaps msg kind
withVariant =
    Component.withVariant
