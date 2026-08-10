module M3e.Build.Autocomplete exposing
    ( build, toElement
    , Builder, AttrCaps, SlotCaps, Is, Content, ChildAdmittedBy
    , withAutoActivate, withCaseSensitive, withClass, withFilter, withFor, withHideLoading, withHideNoData, withHideSelectionIndicator, withId, withLoading, withLoadingLabel, withNoDataLabel, withOnChange, withOnQuery, withOnToggle, withPanelClass, withRequired, withResultsLabel, withSlot, withStyle
    , loading, noData
    , withLoadingSlot, withNoData, withChild
    )

{-| The builder module for `m3e-autocomplete` — seed, pipe, and close.

This module provides everything you need to BUILD with `Autocomplete`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.Component.Autocomplete.view`.

@docs build, toElement
@docs Builder, AttrCaps, SlotCaps, Is, Content, ChildAdmittedBy
@docs withAutoActivate, withCaseSensitive, withClass, withFilter, withFor, withHideLoading, withHideNoData, withHideSelectionIndicator, withId, withLoading, withLoadingLabel, withNoDataLabel, withOnChange, withOnQuery, withOnToggle, withPanelClass, withRequired, withResultsLabel, withSlot, withStyle
@docs loading, noData
@docs withLoadingSlot, withNoData, withChild

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Component.Autocomplete as Component
import M3e.Internal.Types.Autocomplete
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.Values


{-| The kind this element produces — a `Brand` that marks the phantom row.
-}
type alias Is s =
    M3e.Internal.Types.Autocomplete.Is s


{-| The pipe-builder, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Internal.Types.Autocomplete.Builder attrCaps slotCaps msg kind


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.Autocomplete.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    M3e.Internal.Types.Autocomplete.SlotCaps


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.Autocomplete.ChildAdmittedBy childAdm


{-| The kinds the default slot admits.
-}
type alias Content =
    M3e.Internal.Types.Autocomplete.Content


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-autocomplete" [] []


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
    B.Builder childRow childAttrCaps childSlotCaps (childAccepts) msg
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


{-| Pipe form of the `loading` slot — accepts a builder directly (no `.toElement`).
-}
withLoadingSlot :
    B.Builder childRow childAttrCaps childSlotCaps (childAccepts) msg
    -> Builder attrCaps { s | loading : Available } msg kind
    -> Builder attrCaps { s | loading : Used } msg kind
withLoadingSlot slotBuilder builder_ =
    B.withChild (El.toNode (Component.loading (B.toElement slotBuilder))) builder_


{-| Pipe form of the `no-data` slot — accepts a builder directly (no `.toElement`).
-}
withNoData :
    B.Builder childRow childAttrCaps childSlotCaps (childAccepts) msg
    -> Builder attrCaps { s | noData : Available } msg kind
    -> Builder attrCaps { s | noData : Used } msg kind
withNoData slotBuilder builder_ =
    B.withChild (El.toNode (Component.noData (B.toElement slotBuilder))) builder_


{-| Pipe form of a default-slot child (repeatable) — accepts a builder directly.
-}
withChild :
    B.Builder childRow childAttrCaps childSlotCaps accepts msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withChild childBuilder builder_ =
    B.withChild (El.toNode (B.toElement childBuilder)) builder_


{-| Pipe form of `class` — re-exported from `M3e.Autocomplete`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.Autocomplete`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.Autocomplete`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.Autocomplete`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `autoActivate` — re-exported from `M3e.Autocomplete`.
-}
withAutoActivate : Bool -> Builder { a | autoActivate : Available } slotCaps msg kind -> Builder { a | autoActivate : Used } slotCaps msg kind
withAutoActivate =
    Component.withAutoActivate


{-| Pipe form of `caseSensitive` — re-exported from `M3e.Autocomplete`.
-}
withCaseSensitive : Bool -> Builder { a | caseSensitive : Available } slotCaps msg kind -> Builder { a | caseSensitive : Used } slotCaps msg kind
withCaseSensitive =
    Component.withCaseSensitive


{-| Pipe form of `filter` — re-exported from `M3e.Autocomplete`.
-}
withFilter : Value Component.Filter -> Builder { a | filter : Available } slotCaps msg kind -> Builder { a | filter : Used } slotCaps msg kind
withFilter =
    Component.withFilter


{-| Pipe form of `for` — re-exported from `M3e.Autocomplete`.
-}
withFor : String -> Builder { a | for : Available } slotCaps msg kind -> Builder { a | for : Used } slotCaps msg kind
withFor =
    Component.withFor


{-| Pipe form of `hideLoading` — re-exported from `M3e.Autocomplete`.
-}
withHideLoading : Bool -> Builder { a | hideLoading : Available } slotCaps msg kind -> Builder { a | hideLoading : Used } slotCaps msg kind
withHideLoading =
    Component.withHideLoading


{-| Pipe form of `hideNoData` — re-exported from `M3e.Autocomplete`.
-}
withHideNoData : Bool -> Builder { a | hideNoData : Available } slotCaps msg kind -> Builder { a | hideNoData : Used } slotCaps msg kind
withHideNoData =
    Component.withHideNoData


{-| Pipe form of `hideSelectionIndicator` — re-exported from `M3e.Autocomplete`.
-}
withHideSelectionIndicator : Bool -> Builder { a | hideSelectionIndicator : Available } slotCaps msg kind -> Builder { a | hideSelectionIndicator : Used } slotCaps msg kind
withHideSelectionIndicator =
    Component.withHideSelectionIndicator


{-| Pipe form of `loading` — re-exported from `M3e.Autocomplete`.
-}
withLoading : Bool -> Builder { a | loading : Available } slotCaps msg kind -> Builder { a | loading : Used } slotCaps msg kind
withLoading =
    Component.withLoading


{-| Pipe form of `loadingLabel` — re-exported from `M3e.Autocomplete`.
-}
withLoadingLabel : String -> Builder { a | loadingLabel : Available } slotCaps msg kind -> Builder { a | loadingLabel : Used } slotCaps msg kind
withLoadingLabel =
    Component.withLoadingLabel


{-| Pipe form of `noDataLabel` — re-exported from `M3e.Autocomplete`.
-}
withNoDataLabel : String -> Builder { a | noDataLabel : Available } slotCaps msg kind -> Builder { a | noDataLabel : Used } slotCaps msg kind
withNoDataLabel =
    Component.withNoDataLabel


{-| Pipe form of `panelClass` — re-exported from `M3e.Autocomplete`.
-}
withPanelClass : String -> Builder { a | panelClass : Available } slotCaps msg kind -> Builder { a | panelClass : Used } slotCaps msg kind
withPanelClass =
    Component.withPanelClass


{-| Pipe form of `required` — re-exported from `M3e.Autocomplete`.
-}
withRequired : Bool -> Builder { a | required : Available } slotCaps msg kind -> Builder { a | required : Used } slotCaps msg kind
withRequired =
    Component.withRequired


{-| Pipe form of `resultsLabel` — re-exported from `M3e.Autocomplete`.
-}
withResultsLabel : String -> Builder { a | resultsLabel : Available } slotCaps msg kind -> Builder { a | resultsLabel : Used } slotCaps msg kind
withResultsLabel =
    Component.withResultsLabel


{-| Pipe form of `onChange` — re-exported from `M3e.Autocomplete`.
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg kind -> Builder { a | onChange : Used } slotCaps msg kind
withOnChange =
    Component.withOnChange


{-| Pipe form of `onQuery` — re-exported from `M3e.Autocomplete`.
-}
withOnQuery : msg -> Builder { a | onQuery : Available } slotCaps msg kind -> Builder { a | onQuery : Used } slotCaps msg kind
withOnQuery =
    Component.withOnQuery


{-| Pipe form of `onToggle` — re-exported from `M3e.Autocomplete`.
-}
withOnToggle : msg -> Builder { a | onToggle : Available } slotCaps msg kind -> Builder { a | onToggle : Used } slotCaps msg kind
withOnToggle =
    Component.withOnToggle
