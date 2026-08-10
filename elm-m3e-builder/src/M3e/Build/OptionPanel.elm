module M3e.Build.OptionPanel exposing
    ( build, toElement
    , Builder, AttrCaps, SlotCaps, Is, Content, LoadingSlot, ChildAdmittedBy
    , withAnchorOffset, withClass, withFitAnchorWidth, withId, withOnBeforetoggle, withOnToggle, withScrollStrategy, withSlot, withState, withStyle
    , loading, noData
    , withNoData, withLoading, withChild
    )

{-| The builder module for `m3e-option-panel` — seed, pipe, and close.

This module provides everything you need to BUILD with `OptionPanel`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.Component.OptionPanel.view`.

@docs build, toElement
@docs Builder, AttrCaps, SlotCaps, Is, Content, LoadingSlot, ChildAdmittedBy
@docs withAnchorOffset, withClass, withFitAnchorWidth, withId, withOnBeforetoggle, withOnToggle, withScrollStrategy, withSlot, withState, withStyle
@docs loading, noData
@docs withNoData, withLoading, withChild

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Component.OptionPanel as Component
import M3e.Internal.Types.OptionPanel
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.Values


{-| The kind this element produces — a `Brand` that marks the phantom row.
-}
type alias Is s =
    M3e.Internal.Types.OptionPanel.Is s


{-| The pipe-builder, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Internal.Types.OptionPanel.Builder attrCaps slotCaps msg kind


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.OptionPanel.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    M3e.Internal.Types.OptionPanel.SlotCaps


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.OptionPanel.ChildAdmittedBy childAdm


{-| The kinds the default slot admits.
-}
type alias Content =
    M3e.Internal.Types.OptionPanel.Content


{-| The kinds the `loading` slot admits.
-}
type alias LoadingSlot =
    M3e.Internal.Types.OptionPanel.LoadingSlot


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-option-panel" [] []


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg kind -> Element (Component.Is kind) admittedBy msg
toElement =
    B.toElement


{-| Alias for [`toElement`](#toElement) — close and convert to an element.
-}


{-| Place a builder-built element into the named `loading` slot — calls `B.toElement` internally.
-}
loading :
    B.Builder childRow childAttrCaps childSlotCaps (Component.LoadingSlot) msg
    -> Element free freeAdmittedBy msg
loading builder =
    Component.loading (B.toElement builder)


{-| Place a builder-built element into the named `no-data` slot — calls `B.toElement` internally.
-}
noData :
    B.Builder childRow childAttrCaps childSlotCaps (childAccepts) msg
    -> Element free freeAdmittedBy msg
noData builder =
    Component.noData (B.toElement builder)


{-| Pipe form of the `no-data` slot — accepts a builder directly (no `.toElement`).
-}
withNoData :
    B.Builder childRow childAttrCaps childSlotCaps (childAccepts) msg
    -> Builder attrCaps { s | noData : Available } msg kind
    -> Builder attrCaps { s | noData : Used } msg kind
withNoData slotBuilder builder_ =
    B.withChild (El.toNode (Component.noData (B.toElement slotBuilder))) builder_


{-| Pipe form of the `loading` slot (repeatable) — accepts a builder directly.
-}
withLoading :
    B.Builder childRow childAttrCaps childSlotCaps (Component.LoadingSlot) msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withLoading slotBuilder builder_ =
    B.withChild (El.toNode (Component.loading (B.toElement slotBuilder))) builder_


{-| Pipe form of a default-slot child (repeatable) — accepts a builder directly.
-}
withChild :
    B.Builder childRow childAttrCaps childSlotCaps accepts msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withChild childBuilder builder_ =
    B.withChild (El.toNode (B.toElement childBuilder)) builder_


{-| Pipe form of `class` — re-exported from `M3e.OptionPanel`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.OptionPanel`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.OptionPanel`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.OptionPanel`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `anchorOffset` — re-exported from `M3e.OptionPanel`.
-}
withAnchorOffset : Float -> Builder { a | anchorOffset : Available } slotCaps msg kind -> Builder { a | anchorOffset : Used } slotCaps msg kind
withAnchorOffset =
    Component.withAnchorOffset


{-| Pipe form of `fitAnchorWidth` — re-exported from `M3e.OptionPanel`.
-}
withFitAnchorWidth : Bool -> Builder { a | fitAnchorWidth : Available } slotCaps msg kind -> Builder { a | fitAnchorWidth : Used } slotCaps msg kind
withFitAnchorWidth =
    Component.withFitAnchorWidth


{-| Pipe form of `scrollStrategy` — re-exported from `M3e.OptionPanel`.
-}
withScrollStrategy : Value Component.ScrollStrategy -> Builder { a | scrollStrategy : Available } slotCaps msg kind -> Builder { a | scrollStrategy : Used } slotCaps msg kind
withScrollStrategy =
    Component.withScrollStrategy


{-| Pipe form of `state` — re-exported from `M3e.OptionPanel`.
-}
withState : Value Component.State -> Builder { a | state : Available } slotCaps msg kind -> Builder { a | state : Used } slotCaps msg kind
withState =
    Component.withState


{-| Pipe form of `onBeforetoggle` — re-exported from `M3e.OptionPanel`.
-}
withOnBeforetoggle : msg -> Builder { a | onBeforetoggle : Available } slotCaps msg kind -> Builder { a | onBeforetoggle : Used } slotCaps msg kind
withOnBeforetoggle =
    Component.withOnBeforetoggle


{-| Pipe form of `onToggle` — re-exported from `M3e.OptionPanel`.
-}
withOnToggle : msg -> Builder { a | onToggle : Available } slotCaps msg kind -> Builder { a | onToggle : Used } slotCaps msg kind
withOnToggle =
    Component.withOnToggle
