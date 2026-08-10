module M3e.SearchView.Build exposing
    ( build, toElement, view
    , Builder, AttrCaps, SlotCaps, Is, ClearIconSlot, CloseIconSlot, ClosedLeadingSlot, ClosedTrailingSlot, OpenLeadingSlot, OpenTrailingSlot, SearchIconSlot, ChildAdmittedBy
    , withClass, withClearLabel, withCloseLabel, withContained, withHideSearchIcon, withId, withMode, withOnBeforetoggle, withOnClear, withOnQuery, withOnToggle, withOpen, withSlot, withStyle
    , clearIcon, closeIcon, closedLeading, closedTrailing, input, openLeading, openTrailing, searchIcon
    , withClearIcon, withCloseIcon, withInput, withSearchIcon, withClosedLeading, withClosedTrailing, withOpenLeading, withOpenTrailing, withChild
    )

{-| The builder module for `m3e-search-view` — seed, pipe, and close.

This module provides everything you need to BUILD with `SearchView`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.SearchView.view`.

@docs build, toElement, view
@docs Builder, AttrCaps, SlotCaps, Is, ClearIconSlot, CloseIconSlot, ClosedLeadingSlot, ClosedTrailingSlot, OpenLeadingSlot, OpenTrailingSlot, SearchIconSlot, ChildAdmittedBy
@docs withClass, withClearLabel, withCloseLabel, withContained, withHideSearchIcon, withId, withMode, withOnBeforetoggle, withOnClear, withOnQuery, withOnToggle, withOpen, withSlot, withStyle
@docs clearIcon, closeIcon, closedLeading, closedTrailing, input, openLeading, openTrailing, searchIcon
@docs withClearIcon, withCloseIcon, withInput, withSearchIcon, withClosedLeading, withClosedTrailing, withOpenLeading, withOpenTrailing, withChild

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.SearchView as Component
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


type alias ClearIconSlot =
    Component.ClearIconSlot


type alias CloseIconSlot =
    Component.CloseIconSlot


type alias ClosedLeadingSlot =
    Component.ClosedLeadingSlot


type alias ClosedTrailingSlot =
    Component.ClosedTrailingSlot


type alias OpenLeadingSlot =
    Component.OpenLeadingSlot


type alias OpenTrailingSlot =
    Component.OpenTrailingSlot


type alias SearchIconSlot =
    Component.SearchIconSlot


{-| Seed the pipe-builder with required content (and action).
-}
build :
    { input : Element childAccepts (Component.ChildAdmittedBy childAdm) msg }
    -> Builder AttrCaps SlotCaps msg kind
build required_ =
    B.init "m3e-search-view" [] [ El.toNode (Component.input required_.input) ]


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


{-| Place a builder-built element into the named `clear-icon` slot — calls `B.toElement` internally.
-}
clearIcon :
    B.Builder childRow childAttrCaps childSlotCaps Component.ClearIconSlot msg
    -> Element free freeAdmittedBy msg
clearIcon builder =
    Component.clearIcon (B.toElement builder)


{-| Place a builder-built element into the named `close-icon` slot — calls `B.toElement` internally.
-}
closeIcon :
    B.Builder childRow childAttrCaps childSlotCaps Component.CloseIconSlot msg
    -> Element free freeAdmittedBy msg
closeIcon builder =
    Component.closeIcon (B.toElement builder)


{-| Place a builder-built element into the named `closed-leading` slot — calls `B.toElement` internally.
-}
closedLeading :
    B.Builder childRow childAttrCaps childSlotCaps Component.ClosedLeadingSlot msg
    -> Element free freeAdmittedBy msg
closedLeading builder =
    Component.closedLeading (B.toElement builder)


{-| Place a builder-built element into the named `closed-trailing` slot — calls `B.toElement` internally.
-}
closedTrailing :
    B.Builder childRow childAttrCaps childSlotCaps Component.ClosedTrailingSlot msg
    -> Element free freeAdmittedBy msg
closedTrailing builder =
    Component.closedTrailing (B.toElement builder)


{-| Place a builder-built element into the named `input` slot — calls `B.toElement` internally.
-}
input :
    B.Builder childRow childAttrCaps childSlotCaps childAccepts msg
    -> Element free freeAdmittedBy msg
input builder =
    Component.input (B.toElement builder)


{-| Place a builder-built element into the named `open-leading` slot — calls `B.toElement` internally.
-}
openLeading :
    B.Builder childRow childAttrCaps childSlotCaps Component.OpenLeadingSlot msg
    -> Element free freeAdmittedBy msg
openLeading builder =
    Component.openLeading (B.toElement builder)


{-| Place a builder-built element into the named `open-trailing` slot — calls `B.toElement` internally.
-}
openTrailing :
    B.Builder childRow childAttrCaps childSlotCaps Component.OpenTrailingSlot msg
    -> Element free freeAdmittedBy msg
openTrailing builder =
    Component.openTrailing (B.toElement builder)


{-| Place a builder-built element into the named `search-icon` slot — calls `B.toElement` internally.
-}
searchIcon :
    B.Builder childRow childAttrCaps childSlotCaps Component.SearchIconSlot msg
    -> Element free freeAdmittedBy msg
searchIcon builder =
    Component.searchIcon (B.toElement builder)


{-| Pipe form of the `clear-icon` slot — accepts a builder directly (no `.toElement`).
-}
withClearIcon :
    B.Builder childRow childAttrCaps childSlotCaps Component.ClearIconSlot msg
    -> Builder attrCaps { s | clearIcon : Available } msg kind
    -> Builder attrCaps { s | clearIcon : Used } msg kind
withClearIcon slotBuilder builder_ =
    B.withChild (El.toNode (Component.clearIcon (B.toElement slotBuilder))) builder_


{-| Pipe form of the `close-icon` slot — accepts a builder directly (no `.toElement`).
-}
withCloseIcon :
    B.Builder childRow childAttrCaps childSlotCaps Component.CloseIconSlot msg
    -> Builder attrCaps { s | closeIcon : Available } msg kind
    -> Builder attrCaps { s | closeIcon : Used } msg kind
withCloseIcon slotBuilder builder_ =
    B.withChild (El.toNode (Component.closeIcon (B.toElement slotBuilder))) builder_


{-| Pipe form of the `input` slot — accepts a builder directly (no `.toElement`).
-}
withInput :
    B.Builder childRow childAttrCaps childSlotCaps childAccepts msg
    -> Builder attrCaps { s | input : Available } msg kind
    -> Builder attrCaps { s | input : Used } msg kind
withInput slotBuilder builder_ =
    B.withChild (El.toNode (Component.input (B.toElement slotBuilder))) builder_


{-| Pipe form of the `search-icon` slot — accepts a builder directly (no `.toElement`).
-}
withSearchIcon :
    B.Builder childRow childAttrCaps childSlotCaps Component.SearchIconSlot msg
    -> Builder attrCaps { s | searchIcon : Available } msg kind
    -> Builder attrCaps { s | searchIcon : Used } msg kind
withSearchIcon slotBuilder builder_ =
    B.withChild (El.toNode (Component.searchIcon (B.toElement slotBuilder))) builder_


{-| Pipe form of the `closed-leading` slot (repeatable) — accepts a builder directly.
-}
withClosedLeading :
    B.Builder childRow childAttrCaps childSlotCaps Component.ClosedLeadingSlot msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withClosedLeading slotBuilder builder_ =
    B.withChild (El.toNode (Component.closedLeading (B.toElement slotBuilder))) builder_


{-| Pipe form of the `closed-trailing` slot (repeatable) — accepts a builder directly.
-}
withClosedTrailing :
    B.Builder childRow childAttrCaps childSlotCaps Component.ClosedTrailingSlot msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withClosedTrailing slotBuilder builder_ =
    B.withChild (El.toNode (Component.closedTrailing (B.toElement slotBuilder))) builder_


{-| Pipe form of the `open-leading` slot (repeatable) — accepts a builder directly.
-}
withOpenLeading :
    B.Builder childRow childAttrCaps childSlotCaps Component.OpenLeadingSlot msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withOpenLeading slotBuilder builder_ =
    B.withChild (El.toNode (Component.openLeading (B.toElement slotBuilder))) builder_


{-| Pipe form of the `open-trailing` slot (repeatable) — accepts a builder directly.
-}
withOpenTrailing :
    B.Builder childRow childAttrCaps childSlotCaps Component.OpenTrailingSlot msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withOpenTrailing slotBuilder builder_ =
    B.withChild (El.toNode (Component.openTrailing (B.toElement slotBuilder))) builder_


{-| Pipe form of a default-slot child (repeatable) — accepts a builder directly.
-}
withChild :
    B.Builder childRow childAttrCaps childSlotCaps accepts msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withChild childBuilder builder_ =
    B.withChild (El.toNode (B.toElement childBuilder)) builder_


{-| Pipe form of `class` — re-exported from `M3e.SearchView`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.SearchView`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.SearchView`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.SearchView`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `clearLabel` — re-exported from `M3e.SearchView`.
-}
withClearLabel : String -> Builder { a | clearLabel : Available } slotCaps msg kind -> Builder { a | clearLabel : Used } slotCaps msg kind
withClearLabel =
    Component.withClearLabel


{-| Pipe form of `closeLabel` — re-exported from `M3e.SearchView`.
-}
withCloseLabel : String -> Builder { a | closeLabel : Available } slotCaps msg kind -> Builder { a | closeLabel : Used } slotCaps msg kind
withCloseLabel =
    Component.withCloseLabel


{-| Pipe form of `contained` — re-exported from `M3e.SearchView`.
-}
withContained : Bool -> Builder { a | contained : Available } slotCaps msg kind -> Builder { a | contained : Used } slotCaps msg kind
withContained =
    Component.withContained


{-| Pipe form of `hideSearchIcon` — re-exported from `M3e.SearchView`.
-}
withHideSearchIcon : Bool -> Builder { a | hideSearchIcon : Available } slotCaps msg kind -> Builder { a | hideSearchIcon : Used } slotCaps msg kind
withHideSearchIcon =
    Component.withHideSearchIcon


{-| Pipe form of `mode` — re-exported from `M3e.SearchView`.
-}
withMode : Value Component.Mode -> Builder { a | mode : Available } slotCaps msg kind -> Builder { a | mode : Used } slotCaps msg kind
withMode =
    Component.withMode


{-| Pipe form of `open` — re-exported from `M3e.SearchView`.
-}
withOpen : Bool -> Builder { a | open : Available } slotCaps msg kind -> Builder { a | open : Used } slotCaps msg kind
withOpen =
    Component.withOpen


{-| Pipe form of `onQuery` — re-exported from `M3e.SearchView`.
-}
withOnQuery : msg -> Builder { a | onQuery : Available } slotCaps msg kind -> Builder { a | onQuery : Used } slotCaps msg kind
withOnQuery =
    Component.withOnQuery


{-| Pipe form of `onClear` — re-exported from `M3e.SearchView`.
-}
withOnClear : msg -> Builder { a | onClear : Available } slotCaps msg kind -> Builder { a | onClear : Used } slotCaps msg kind
withOnClear =
    Component.withOnClear


{-| Pipe form of `onBeforetoggle` — re-exported from `M3e.SearchView`.
-}
withOnBeforetoggle : msg -> Builder { a | onBeforetoggle : Available } slotCaps msg kind -> Builder { a | onBeforetoggle : Used } slotCaps msg kind
withOnBeforetoggle =
    Component.withOnBeforetoggle


{-| Pipe form of `onToggle` — re-exported from `M3e.SearchView`.
-}
withOnToggle : msg -> Builder { a | onToggle : Available } slotCaps msg kind -> Builder { a | onToggle : Used } slotCaps msg kind
withOnToggle =
    Component.withOnToggle
