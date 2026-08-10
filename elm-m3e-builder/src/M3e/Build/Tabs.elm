module M3e.Build.Tabs exposing
    ( build, toElement
    , Builder, AttrCaps, SlotCaps, Is, Content, NextIconSlot, PanelSlot, PrevIconSlot, ChildAdmittedBy
    , withClass, withDisablePagination, withHeaderPosition, withId, withNextPageLabel, withOnBeforeinput, withOnChange, withOnInput, withPreviousPageLabel, withSlot, withStretch, withStyle, withVariant
    , nextIcon, panel, prevIcon
    , withNextIcon, withPrevIcon, withPanel, withChild
    )

{-| The builder module for `m3e-tabs` — seed, pipe, and close.

This module provides everything you need to BUILD with `Tabs`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.Component.Tabs.view`.

@docs build, toElement
@docs Builder, AttrCaps, SlotCaps, Is, Content, NextIconSlot, PanelSlot, PrevIconSlot, ChildAdmittedBy
@docs withClass, withDisablePagination, withHeaderPosition, withId, withNextPageLabel, withOnBeforeinput, withOnChange, withOnInput, withPreviousPageLabel, withSlot, withStretch, withStyle, withVariant
@docs nextIcon, panel, prevIcon
@docs withNextIcon, withPrevIcon, withPanel, withChild

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Component.Tabs as Component
import M3e.Internal.Types.Tabs
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.Values


{-| The kind this element produces — a `Brand` that marks the phantom row.
-}
type alias Is s =
    M3e.Internal.Types.Tabs.Is s


{-| The pipe-builder, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Internal.Types.Tabs.Builder attrCaps slotCaps msg kind


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.Tabs.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    M3e.Internal.Types.Tabs.SlotCaps


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.Tabs.ChildAdmittedBy childAdm


{-| The kinds the default slot admits.
-}
type alias Content =
    M3e.Internal.Types.Tabs.Content


{-| The kinds the `next-icon` slot admits.
-}
type alias NextIconSlot =
    M3e.Internal.Types.Tabs.NextIconSlot


{-| The kinds the `panel` slot admits.
-}
type alias PanelSlot =
    M3e.Internal.Types.Tabs.PanelSlot


{-| The kinds the `prev-icon` slot admits.
-}
type alias PrevIconSlot =
    M3e.Internal.Types.Tabs.PrevIconSlot


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-tabs" [] []


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg kind -> Element (Component.Is kind) admittedBy msg
toElement =
    B.toElement


{-| Place a builder-built element into the named `next-icon` slot — calls `B.toElement` internally.
-}
nextIcon :
    B.Builder childRow childAttrCaps childSlotCaps (Component.NextIconSlot) msg
    -> Element free freeAdmittedBy msg
nextIcon builder =
    Component.nextIcon (B.toElement builder)


{-| Place a builder-built element into the named `panel` slot — calls `B.toElement` internally.
-}
panel :
    B.Builder childRow childAttrCaps childSlotCaps (Component.PanelSlot) msg
    -> Element free freeAdmittedBy msg
panel builder =
    Component.panel (B.toElement builder)


{-| Place a builder-built element into the named `prev-icon` slot — calls `B.toElement` internally.
-}
prevIcon :
    B.Builder childRow childAttrCaps childSlotCaps (Component.PrevIconSlot) msg
    -> Element free freeAdmittedBy msg
prevIcon builder =
    Component.prevIcon (B.toElement builder)


{-| Pipe form of the `next-icon` slot — accepts a builder directly (no `.toElement`).
-}
withNextIcon :
    B.Builder childRow childAttrCaps childSlotCaps (Component.NextIconSlot) msg
    -> Builder attrCaps { s | nextIcon : Available } msg kind
    -> Builder attrCaps { s | nextIcon : Used } msg kind
withNextIcon slotBuilder builder_ =
    B.withChild (El.toNode (Component.nextIcon (B.toElement slotBuilder))) builder_


{-| Pipe form of the `prev-icon` slot — accepts a builder directly (no `.toElement`).
-}
withPrevIcon :
    B.Builder childRow childAttrCaps childSlotCaps (Component.PrevIconSlot) msg
    -> Builder attrCaps { s | prevIcon : Available } msg kind
    -> Builder attrCaps { s | prevIcon : Used } msg kind
withPrevIcon slotBuilder builder_ =
    B.withChild (El.toNode (Component.prevIcon (B.toElement slotBuilder))) builder_


{-| Pipe form of the `panel` slot (repeatable) — accepts a builder directly.
-}
withPanel :
    B.Builder childRow childAttrCaps childSlotCaps (Component.PanelSlot) msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withPanel slotBuilder builder_ =
    B.withChild (El.toNode (Component.panel (B.toElement slotBuilder))) builder_


{-| Pipe form of a default-slot child (repeatable) — accepts a builder directly.
-}
withChild :
    B.Builder childRow childAttrCaps childSlotCaps accepts msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withChild childBuilder builder_ =
    B.withChild (El.toNode (B.toElement childBuilder)) builder_


{-| Pipe form of `class` — re-exported from `M3e.Tabs`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.Tabs`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.Tabs`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.Tabs`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `disablePagination` — re-exported from `M3e.Tabs`.
-}
withDisablePagination : Value Component.DisablePagination -> Builder { a | disablePagination : Available } slotCaps msg kind -> Builder { a | disablePagination : Used } slotCaps msg kind
withDisablePagination =
    Component.withDisablePagination


{-| Pipe form of `headerPosition` — re-exported from `M3e.Tabs`.
-}
withHeaderPosition : Value Component.HeaderPosition -> Builder { a | headerPosition : Available } slotCaps msg kind -> Builder { a | headerPosition : Used } slotCaps msg kind
withHeaderPosition =
    Component.withHeaderPosition


{-| Pipe form of `nextPageLabel` — re-exported from `M3e.Tabs`.
-}
withNextPageLabel : String -> Builder { a | nextPageLabel : Available } slotCaps msg kind -> Builder { a | nextPageLabel : Used } slotCaps msg kind
withNextPageLabel =
    Component.withNextPageLabel


{-| Pipe form of `previousPageLabel` — re-exported from `M3e.Tabs`.
-}
withPreviousPageLabel : String -> Builder { a | previousPageLabel : Available } slotCaps msg kind -> Builder { a | previousPageLabel : Used } slotCaps msg kind
withPreviousPageLabel =
    Component.withPreviousPageLabel


{-| Pipe form of `stretch` — re-exported from `M3e.Tabs`.
-}
withStretch : Bool -> Builder { a | stretch : Available } slotCaps msg kind -> Builder { a | stretch : Used } slotCaps msg kind
withStretch =
    Component.withStretch


{-| Pipe form of `variant` — re-exported from `M3e.Tabs`.
-}
withVariant : Value Component.Variant -> Builder { a | variant : Available } slotCaps msg kind -> Builder { a | variant : Used } slotCaps msg kind
withVariant =
    Component.withVariant


{-| Pipe form of `onChange` — re-exported from `M3e.Tabs`.
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg kind -> Builder { a | onChange : Used } slotCaps msg kind
withOnChange =
    Component.withOnChange


{-| Pipe form of `onBeforeinput` — re-exported from `M3e.Tabs`.
-}
withOnBeforeinput : msg -> Builder { a | onBeforeinput : Available } slotCaps msg kind -> Builder { a | onBeforeinput : Used } slotCaps msg kind
withOnBeforeinput =
    Component.withOnBeforeinput


{-| Pipe form of `onInput` — re-exported from `M3e.Tabs`.
-}
withOnInput : msg -> Builder { a | onInput : Available } slotCaps msg kind -> Builder { a | onInput : Used } slotCaps msg kind
withOnInput =
    Component.withOnInput
