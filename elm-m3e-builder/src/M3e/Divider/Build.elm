module M3e.Divider.Build exposing
    ( build, toElement, view
    , Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
    , withClass, withId, withInset, withInsetEnd, withInsetStart, withSlot, withStyle, withVertical
    )

{-| The builder module for `m3e-divider` — seed, pipe, and close.

This module provides everything you need to BUILD with `Divider`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.Divider.view`.

@docs build, toElement, view
@docs Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
@docs withClass, withId, withInset, withInsetEnd, withInsetStart, withSlot, withStyle, withVertical

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Divider as Component
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


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-divider" [] []


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


{-| Pipe form of `class` — re-exported from `M3e.Divider`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.Divider`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.Divider`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.Divider`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `inset` — re-exported from `M3e.Divider`.
-}
withInset : Bool -> Builder { a | inset : Available } slotCaps msg kind -> Builder { a | inset : Used } slotCaps msg kind
withInset =
    Component.withInset


{-| Pipe form of `insetEnd` — re-exported from `M3e.Divider`.
-}
withInsetEnd : Bool -> Builder { a | insetEnd : Available } slotCaps msg kind -> Builder { a | insetEnd : Used } slotCaps msg kind
withInsetEnd =
    Component.withInsetEnd


{-| Pipe form of `insetStart` — re-exported from `M3e.Divider`.
-}
withInsetStart : Bool -> Builder { a | insetStart : Available } slotCaps msg kind -> Builder { a | insetStart : Used } slotCaps msg kind
withInsetStart =
    Component.withInsetStart


{-| Pipe form of `vertical` — re-exported from `M3e.Divider`.
-}
withVertical : Bool -> Builder { a | vertical : Available } slotCaps msg kind -> Builder { a | vertical : Used } slotCaps msg kind
withVertical =
    Component.withVertical
