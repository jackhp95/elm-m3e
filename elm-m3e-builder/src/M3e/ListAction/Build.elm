module M3e.ListAction.Build exposing
    ( build, toElement, view
    , Builder, AttrCaps, SlotCaps, Is, Content, LeadingSlot, OverlineSlot, SupportingTextSlot, TrailingSlot, ChildAdmittedBy
    , withClass, withDisabled, withDownload, withHref, withId, withOnClick, withRel, withSlot, withStyle, withTarget
    , leading, overline, supportingText, trailing
    , withLeading, withOverline, withSupportingText, withTrailing, withChild
    )

{-| The builder module for `m3e-list-action` — seed, pipe, and close.

This module provides everything you need to BUILD with `ListAction`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.ListAction.view`.

@docs build, toElement, view
@docs Builder, AttrCaps, SlotCaps, Is, Content, LeadingSlot, OverlineSlot, SupportingTextSlot, TrailingSlot, ChildAdmittedBy
@docs withClass, withDisabled, withDownload, withHref, withId, withOnClick, withRel, withSlot, withStyle, withTarget
@docs leading, overline, supportingText, trailing
@docs withLeading, withOverline, withSupportingText, withTrailing, withChild

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.ListAction as Component


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


{-| The kinds the default slot admits.
-}
type alias Content =
    Component.Content


{-| The kinds the `leading` slot admits.
-}
type alias LeadingSlot =
    Component.LeadingSlot


{-| The kinds the `overline` slot admits.
-}
type alias OverlineSlot =
    Component.OverlineSlot


{-| The kinds the `supporting-text` slot admits.
-}
type alias SupportingTextSlot =
    Component.SupportingTextSlot


{-| The kinds the `trailing` slot admits.
-}
type alias TrailingSlot =
    Component.TrailingSlot


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-list-action" [] []


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


{-| Place a builder-built element into the named `leading` slot — calls `B.toElement` internally.
-}
leading :
    B.Builder childRow childAttrCaps childSlotCaps Component.LeadingSlot msg
    -> Element free freeAdmittedBy msg
leading builder =
    Component.leading (B.toElement builder)


{-| Place a builder-built element into the named `overline` slot — calls `B.toElement` internally.
-}
overline :
    B.Builder childRow childAttrCaps childSlotCaps Component.OverlineSlot msg
    -> Element free freeAdmittedBy msg
overline builder =
    Component.overline (B.toElement builder)


{-| Place a builder-built element into the named `supporting-text` slot — calls `B.toElement` internally.
-}
supportingText :
    B.Builder childRow childAttrCaps childSlotCaps Component.SupportingTextSlot msg
    -> Element free freeAdmittedBy msg
supportingText builder =
    Component.supportingText (B.toElement builder)


{-| Place a builder-built element into the named `trailing` slot — calls `B.toElement` internally.
-}
trailing :
    B.Builder childRow childAttrCaps childSlotCaps Component.TrailingSlot msg
    -> Element free freeAdmittedBy msg
trailing builder =
    Component.trailing (B.toElement builder)


{-| Pipe form of the `leading` slot — accepts a builder directly (no `.toElement`).
-}
withLeading :
    B.Builder childRow childAttrCaps childSlotCaps Component.LeadingSlot msg
    -> Builder attrCaps { s | leading : Available } msg kind
    -> Builder attrCaps { s | leading : Used } msg kind
withLeading slotBuilder builder_ =
    B.withChild (El.toNode (Component.leading (B.toElement slotBuilder))) builder_


{-| Pipe form of the `overline` slot — accepts a builder directly (no `.toElement`).
-}
withOverline :
    B.Builder childRow childAttrCaps childSlotCaps Component.OverlineSlot msg
    -> Builder attrCaps { s | overline : Available } msg kind
    -> Builder attrCaps { s | overline : Used } msg kind
withOverline slotBuilder builder_ =
    B.withChild (El.toNode (Component.overline (B.toElement slotBuilder))) builder_


{-| Pipe form of the `supporting-text` slot — accepts a builder directly (no `.toElement`).
-}
withSupportingText :
    B.Builder childRow childAttrCaps childSlotCaps Component.SupportingTextSlot msg
    -> Builder attrCaps { s | supportingText : Available } msg kind
    -> Builder attrCaps { s | supportingText : Used } msg kind
withSupportingText slotBuilder builder_ =
    B.withChild (El.toNode (Component.supportingText (B.toElement slotBuilder))) builder_


{-| Pipe form of the `trailing` slot — accepts a builder directly (no `.toElement`).
-}
withTrailing :
    B.Builder childRow childAttrCaps childSlotCaps Component.TrailingSlot msg
    -> Builder attrCaps { s | trailing : Available } msg kind
    -> Builder attrCaps { s | trailing : Used } msg kind
withTrailing slotBuilder builder_ =
    B.withChild (El.toNode (Component.trailing (B.toElement slotBuilder))) builder_


{-| Pipe form of a default-slot child (repeatable) — accepts a builder directly.
-}
withChild :
    B.Builder childRow childAttrCaps childSlotCaps accepts msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withChild childBuilder builder_ =
    B.withChild (El.toNode (B.toElement childBuilder)) builder_


{-| Pipe form of `class` — re-exported from `M3e.ListAction`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.ListAction`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.ListAction`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.ListAction`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `disabled` — re-exported from `M3e.ListAction`.
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg kind -> Builder { a | disabled : Used } slotCaps msg kind
withDisabled =
    Component.withDisabled


{-| Pipe form of `download` — re-exported from `M3e.ListAction`.
-}
withDownload : String -> Builder { a | download : Available } slotCaps msg kind -> Builder { a | download : Used } slotCaps msg kind
withDownload =
    Component.withDownload


{-| Pipe form of `href` — re-exported from `M3e.ListAction`.
-}
withHref : String -> Builder { a | href : Available } slotCaps msg kind -> Builder { a | href : Used } slotCaps msg kind
withHref =
    Component.withHref


{-| Pipe form of `rel` — re-exported from `M3e.ListAction`.
-}
withRel : String -> Builder { a | rel : Available } slotCaps msg kind -> Builder { a | rel : Used } slotCaps msg kind
withRel =
    Component.withRel


{-| Pipe form of `target` — re-exported from `M3e.ListAction`.
-}
withTarget : String -> Builder { a | target : Available } slotCaps msg kind -> Builder { a | target : Used } slotCaps msg kind
withTarget =
    Component.withTarget


{-| Pipe form of `onClick` — re-exported from `M3e.ListAction`.
-}
withOnClick : msg -> Builder { a | onClick : Available } slotCaps msg kind -> Builder { a | onClick : Used } slotCaps msg kind
withOnClick =
    Component.withOnClick
