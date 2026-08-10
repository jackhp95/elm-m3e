module M3e.NavMenuItem.Build exposing
    ( build, toElement, view
    , Builder, AttrCaps, SlotCaps, Is, Content, BadgeSlot, IconSlot, LabelSlot, SelectedIconSlot, ToggleIconSlot, ChildAdmittedBy
    , withClass, withDisabled, withId, withOnClick, withOnClosed, withOnClosing, withOnOpened, withOnOpening, withOpen, withSelected, withSlot, withStyle
    , badge, icon, label, selectedIcon, toggleIcon
    , withBadge, withIcon, withLabel, withSelectedIcon, withToggleIcon, withChild
    )

{-| The builder module for `m3e-nav-menu-item` — seed, pipe, and close.

This module provides everything you need to BUILD with `NavMenuItem`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.NavMenuItem.view`.

@docs build, toElement, view
@docs Builder, AttrCaps, SlotCaps, Is, Content, BadgeSlot, IconSlot, LabelSlot, SelectedIconSlot, ToggleIconSlot, ChildAdmittedBy
@docs withClass, withDisabled, withId, withOnClick, withOnClosed, withOnClosing, withOnOpened, withOnOpening, withOpen, withSelected, withSlot, withStyle
@docs badge, icon, label, selectedIcon, toggleIcon
@docs withBadge, withIcon, withLabel, withSelectedIcon, withToggleIcon, withChild

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Internal.Types.NavMenuItem
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.NavMenuItem as Component


{-| The kind this element produces — a `Brand` that marks the phantom row.
-}
type alias Is s =
    M3e.Internal.Types.NavMenuItem.Is s


{-| The pipe-builder, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Internal.Types.NavMenuItem.Builder attrCaps slotCaps msg kind


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.NavMenuItem.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    M3e.Internal.Types.NavMenuItem.SlotCaps


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.NavMenuItem.ChildAdmittedBy childAdm


{-| The kinds the default slot admits.
-}
type alias Content =
    M3e.Internal.Types.NavMenuItem.Content


{-| The kinds the `badge` slot admits.
-}
type alias BadgeSlot =
    M3e.Internal.Types.NavMenuItem.BadgeSlot


{-| The kinds the `icon` slot admits.
-}
type alias IconSlot =
    M3e.Internal.Types.NavMenuItem.IconSlot


{-| The kinds the `label` slot admits.
-}
type alias LabelSlot =
    M3e.Internal.Types.NavMenuItem.LabelSlot


{-| The kinds the `selected-icon` slot admits.
-}
type alias SelectedIconSlot =
    M3e.Internal.Types.NavMenuItem.SelectedIconSlot


{-| The kinds the `toggle-icon` slot admits.
-}
type alias ToggleIconSlot =
    M3e.Internal.Types.NavMenuItem.ToggleIconSlot


{-| Seed the pipe-builder with required content (and action).
-}
build :
    { label : Element Component.LabelSlot (Component.ChildAdmittedBy childAdm) msg }
    -> Builder AttrCaps SlotCaps msg kind
build required_ =
    B.init "m3e-nav-menu-item" [] [ El.toNode (Component.label required_.label) ]


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


{-| Place a builder-built element into the named `badge` slot — calls `B.toElement` internally.
-}
badge :
    B.Builder childRow childAttrCaps childSlotCaps Component.BadgeSlot msg
    -> Element free freeAdmittedBy msg
badge builder =
    Component.badge (B.toElement builder)


{-| Place a builder-built element into the named `icon` slot — calls `B.toElement` internally.
-}
icon :
    B.Builder childRow childAttrCaps childSlotCaps Component.IconSlot msg
    -> Element free freeAdmittedBy msg
icon builder =
    Component.icon (B.toElement builder)


{-| Place a builder-built element into the named `label` slot — calls `B.toElement` internally.
-}
label :
    B.Builder childRow childAttrCaps childSlotCaps Component.LabelSlot msg
    -> Element free freeAdmittedBy msg
label builder =
    Component.label (B.toElement builder)


{-| Place a builder-built element into the named `selected-icon` slot — calls `B.toElement` internally.
-}
selectedIcon :
    B.Builder childRow childAttrCaps childSlotCaps Component.SelectedIconSlot msg
    -> Element free freeAdmittedBy msg
selectedIcon builder =
    Component.selectedIcon (B.toElement builder)


{-| Place a builder-built element into the named `toggle-icon` slot — calls `B.toElement` internally.
-}
toggleIcon :
    B.Builder childRow childAttrCaps childSlotCaps Component.ToggleIconSlot msg
    -> Element free freeAdmittedBy msg
toggleIcon builder =
    Component.toggleIcon (B.toElement builder)


{-| Pipe form of the `badge` slot — accepts a builder directly (no `.toElement`).
-}
withBadge :
    B.Builder childRow childAttrCaps childSlotCaps Component.BadgeSlot msg
    -> Builder attrCaps { s | badge : Available } msg kind
    -> Builder attrCaps { s | badge : Used } msg kind
withBadge slotBuilder builder_ =
    B.withChild (El.toNode (Component.badge (B.toElement slotBuilder))) builder_


{-| Pipe form of the `icon` slot — accepts a builder directly (no `.toElement`).
-}
withIcon :
    B.Builder childRow childAttrCaps childSlotCaps Component.IconSlot msg
    -> Builder attrCaps { s | icon : Available } msg kind
    -> Builder attrCaps { s | icon : Used } msg kind
withIcon slotBuilder builder_ =
    B.withChild (El.toNode (Component.icon (B.toElement slotBuilder))) builder_


{-| Pipe form of the `label` slot — accepts a builder directly (no `.toElement`).
-}
withLabel :
    B.Builder childRow childAttrCaps childSlotCaps Component.LabelSlot msg
    -> Builder attrCaps { s | label : Available } msg kind
    -> Builder attrCaps { s | label : Used } msg kind
withLabel slotBuilder builder_ =
    B.withChild (El.toNode (Component.label (B.toElement slotBuilder))) builder_


{-| Pipe form of the `selected-icon` slot — accepts a builder directly (no `.toElement`).
-}
withSelectedIcon :
    B.Builder childRow childAttrCaps childSlotCaps Component.SelectedIconSlot msg
    -> Builder attrCaps { s | selectedIcon : Available } msg kind
    -> Builder attrCaps { s | selectedIcon : Used } msg kind
withSelectedIcon slotBuilder builder_ =
    B.withChild (El.toNode (Component.selectedIcon (B.toElement slotBuilder))) builder_


{-| Pipe form of the `toggle-icon` slot — accepts a builder directly (no `.toElement`).
-}
withToggleIcon :
    B.Builder childRow childAttrCaps childSlotCaps Component.ToggleIconSlot msg
    -> Builder attrCaps { s | toggleIcon : Available } msg kind
    -> Builder attrCaps { s | toggleIcon : Used } msg kind
withToggleIcon slotBuilder builder_ =
    B.withChild (El.toNode (Component.toggleIcon (B.toElement slotBuilder))) builder_


{-| Pipe form of a default-slot child (repeatable) — accepts a builder directly.
-}
withChild :
    B.Builder childRow childAttrCaps childSlotCaps accepts msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withChild childBuilder builder_ =
    B.withChild (El.toNode (B.toElement childBuilder)) builder_


{-| Pipe form of `class` — re-exported from `M3e.NavMenuItem`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.NavMenuItem`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.NavMenuItem`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.NavMenuItem`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `disabled` — re-exported from `M3e.NavMenuItem`.
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg kind -> Builder { a | disabled : Used } slotCaps msg kind
withDisabled =
    Component.withDisabled


{-| Pipe form of `open` — re-exported from `M3e.NavMenuItem`.
-}
withOpen : Bool -> Builder { a | open : Available } slotCaps msg kind -> Builder { a | open : Used } slotCaps msg kind
withOpen =
    Component.withOpen


{-| Pipe form of `selected` — re-exported from `M3e.NavMenuItem`.
-}
withSelected : Bool -> Builder { a | selected : Available } slotCaps msg kind -> Builder { a | selected : Used } slotCaps msg kind
withSelected =
    Component.withSelected


{-| Pipe form of `onOpening` — re-exported from `M3e.NavMenuItem`.
-}
withOnOpening : msg -> Builder { a | onOpening : Available } slotCaps msg kind -> Builder { a | onOpening : Used } slotCaps msg kind
withOnOpening =
    Component.withOnOpening


{-| Pipe form of `onOpened` — re-exported from `M3e.NavMenuItem`.
-}
withOnOpened : msg -> Builder { a | onOpened : Available } slotCaps msg kind -> Builder { a | onOpened : Used } slotCaps msg kind
withOnOpened =
    Component.withOnOpened


{-| Pipe form of `onClosing` — re-exported from `M3e.NavMenuItem`.
-}
withOnClosing : msg -> Builder { a | onClosing : Available } slotCaps msg kind -> Builder { a | onClosing : Used } slotCaps msg kind
withOnClosing =
    Component.withOnClosing


{-| Pipe form of `onClosed` — re-exported from `M3e.NavMenuItem`.
-}
withOnClosed : msg -> Builder { a | onClosed : Available } slotCaps msg kind -> Builder { a | onClosed : Used } slotCaps msg kind
withOnClosed =
    Component.withOnClosed


{-| Pipe form of `onClick` — re-exported from `M3e.NavMenuItem`.
-}
withOnClick : msg -> Builder { a | onClick : Available } slotCaps msg kind -> Builder { a | onClick : Used } slotCaps msg kind
withOnClick =
    Component.withOnClick
