module M3e.Toc.Build exposing
    ( build, toElement, view
    , Builder, AttrCaps, SlotCaps, Is, OverlineSlot, TitleSlot, ChildAdmittedBy
    , withClass, withFor, withId, withMaxDepth, withSlot, withStyle
    , overline, title
    , withOverline, withTitle, withChild
    )

{-| The builder module for `m3e-toc` — seed, pipe, and close.

This module provides everything you need to BUILD with `Toc`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.Toc.view`.

@docs build, toElement, view
@docs Builder, AttrCaps, SlotCaps, Is, OverlineSlot, TitleSlot, ChildAdmittedBy
@docs withClass, withFor, withId, withMaxDepth, withSlot, withStyle
@docs overline, title
@docs withOverline, withTitle, withChild

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.Toc as Component


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


type alias OverlineSlot =
    Component.OverlineSlot


type alias TitleSlot =
    Component.TitleSlot


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-toc" [] []


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


{-| Place a builder-built element into the named `overline` slot — calls `B.toElement` internally.
-}
overline :
    B.Builder childRow childAttrCaps childSlotCaps Component.OverlineSlot msg
    -> Element free freeAdmittedBy msg
overline builder =
    Component.overline (B.toElement builder)


{-| Place a builder-built element into the named `title` slot — calls `B.toElement` internally.
-}
title :
    B.Builder childRow childAttrCaps childSlotCaps Component.TitleSlot msg
    -> Element free freeAdmittedBy msg
title builder =
    Component.title (B.toElement builder)


{-| Pipe form of the `overline` slot — accepts a builder directly (no `.toElement`).
-}
withOverline :
    B.Builder childRow childAttrCaps childSlotCaps Component.OverlineSlot msg
    -> Builder attrCaps { s | overline : Available } msg kind
    -> Builder attrCaps { s | overline : Used } msg kind
withOverline slotBuilder builder_ =
    B.withChild (El.toNode (Component.overline (B.toElement slotBuilder))) builder_


{-| Pipe form of the `title` slot — accepts a builder directly (no `.toElement`).
-}
withTitle :
    B.Builder childRow childAttrCaps childSlotCaps Component.TitleSlot msg
    -> Builder attrCaps { s | title : Available } msg kind
    -> Builder attrCaps { s | title : Used } msg kind
withTitle slotBuilder builder_ =
    B.withChild (El.toNode (Component.title (B.toElement slotBuilder))) builder_


{-| Pipe form of a default-slot child (repeatable) — accepts a builder directly.
-}
withChild :
    B.Builder childRow childAttrCaps childSlotCaps accepts msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withChild childBuilder builder_ =
    B.withChild (El.toNode (B.toElement childBuilder)) builder_


{-| Pipe form of `class` — re-exported from `M3e.Toc`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.Toc`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.Toc`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.Toc`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `for` — re-exported from `M3e.Toc`.
-}
withFor : String -> Builder { a | for : Available } slotCaps msg kind -> Builder { a | for : Used } slotCaps msg kind
withFor =
    Component.withFor


{-| Pipe form of `maxDepth` — re-exported from `M3e.Toc`.
-}
withMaxDepth : Float -> Builder { a | maxDepth : Available } slotCaps msg kind -> Builder { a | maxDepth : Used } slotCaps msg kind
withMaxDepth =
    Component.withMaxDepth
