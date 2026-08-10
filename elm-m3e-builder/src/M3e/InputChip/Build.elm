module M3e.InputChip.Build exposing
    ( build, toElement, view
    , Builder, AttrCaps, SlotCaps, Is, Content, AvatarSlot, IconSlot, RemoveIconSlot, ChildAdmittedBy
    , withClass, withDisabled, withDisabledInteractive, withId, withOnClick, withOnRemove, withRemovable, withRemoveLabel, withSlot, withStyle, withValue, withVariant
    , avatar, icon, removeIcon
    , withAvatar, withIcon, withRemoveIcon, withChild
    )

{-| The builder module for `m3e-input-chip` — seed, pipe, and close.

This module provides everything you need to BUILD with `InputChip`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.InputChip.view`.

@docs build, toElement, view
@docs Builder, AttrCaps, SlotCaps, Is, Content, AvatarSlot, IconSlot, RemoveIconSlot, ChildAdmittedBy
@docs withClass, withDisabled, withDisabledInteractive, withId, withOnClick, withOnRemove, withRemovable, withRemoveLabel, withSlot, withStyle, withValue, withVariant
@docs avatar, icon, removeIcon
@docs withAvatar, withIcon, withRemoveIcon, withChild

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.InputChip as Component
import M3e.Internal.Types.InputChip
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.Values


{-| The kind this element produces — a `Brand` that marks the phantom row.
-}
type alias Is s =
    M3e.Internal.Types.InputChip.Is s


{-| The pipe-builder, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Internal.Types.InputChip.Builder attrCaps slotCaps msg kind


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.InputChip.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    M3e.Internal.Types.InputChip.SlotCaps


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.InputChip.ChildAdmittedBy childAdm


{-| The kinds the default slot admits.
-}
type alias Content =
    M3e.Internal.Types.InputChip.Content


{-| The kinds the `avatar` slot admits.
-}
type alias AvatarSlot =
    M3e.Internal.Types.InputChip.AvatarSlot


{-| The kinds the `icon` slot admits.
-}
type alias IconSlot =
    M3e.Internal.Types.InputChip.IconSlot


{-| The kinds the `remove-icon` slot admits.
-}
type alias RemoveIconSlot =
    M3e.Internal.Types.InputChip.RemoveIconSlot


{-| Seed the pipe-builder with required content (and action).
-}
build :
    { content : Element Component.Content (Component.ChildAdmittedBy childAdm) msg }
    -> Builder AttrCaps SlotCaps msg kind
build required_ =
    B.init "m3e-input-chip" [] [ El.toNode required_.content ]


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


{-| Place a builder-built element into the named `avatar` slot — calls `B.toElement` internally.
-}
avatar :
    B.Builder childRow childAttrCaps childSlotCaps Component.AvatarSlot msg
    -> Element free freeAdmittedBy msg
avatar builder =
    Component.avatar (B.toElement builder)


{-| Place a builder-built element into the named `icon` slot — calls `B.toElement` internally.
-}
icon :
    B.Builder childRow childAttrCaps childSlotCaps Component.IconSlot msg
    -> Element free freeAdmittedBy msg
icon builder =
    Component.icon (B.toElement builder)


{-| Place a builder-built element into the named `remove-icon` slot — calls `B.toElement` internally.
-}
removeIcon :
    B.Builder childRow childAttrCaps childSlotCaps Component.RemoveIconSlot msg
    -> Element free freeAdmittedBy msg
removeIcon builder =
    Component.removeIcon (B.toElement builder)


{-| Pipe form of the `avatar` slot — accepts a builder directly (no `.toElement`).
-}
withAvatar :
    B.Builder childRow childAttrCaps childSlotCaps Component.AvatarSlot msg
    -> Builder attrCaps { s | avatar : Available } msg kind
    -> Builder attrCaps { s | avatar : Used } msg kind
withAvatar slotBuilder builder_ =
    B.withChild (El.toNode (Component.avatar (B.toElement slotBuilder))) builder_


{-| Pipe form of the `icon` slot — accepts a builder directly (no `.toElement`).
-}
withIcon :
    B.Builder childRow childAttrCaps childSlotCaps Component.IconSlot msg
    -> Builder attrCaps { s | icon : Available } msg kind
    -> Builder attrCaps { s | icon : Used } msg kind
withIcon slotBuilder builder_ =
    B.withChild (El.toNode (Component.icon (B.toElement slotBuilder))) builder_


{-| Pipe form of the `remove-icon` slot — accepts a builder directly (no `.toElement`).
-}
withRemoveIcon :
    B.Builder childRow childAttrCaps childSlotCaps Component.RemoveIconSlot msg
    -> Builder attrCaps { s | removeIcon : Available } msg kind
    -> Builder attrCaps { s | removeIcon : Used } msg kind
withRemoveIcon slotBuilder builder_ =
    B.withChild (El.toNode (Component.removeIcon (B.toElement slotBuilder))) builder_


{-| Pipe form of a default-slot child (repeatable) — accepts a builder directly.
-}
withChild :
    B.Builder childRow childAttrCaps childSlotCaps accepts msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withChild childBuilder builder_ =
    B.withChild (El.toNode (B.toElement childBuilder)) builder_


{-| Pipe form of `class` — re-exported from `M3e.InputChip`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.InputChip`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.InputChip`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.InputChip`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `disabled` — re-exported from `M3e.InputChip`.
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg kind -> Builder { a | disabled : Used } slotCaps msg kind
withDisabled =
    Component.withDisabled


{-| Pipe form of `disabledInteractive` — re-exported from `M3e.InputChip`.
-}
withDisabledInteractive : Bool -> Builder { a | disabledInteractive : Available } slotCaps msg kind -> Builder { a | disabledInteractive : Used } slotCaps msg kind
withDisabledInteractive =
    Component.withDisabledInteractive


{-| Pipe form of `removable` — re-exported from `M3e.InputChip`.
-}
withRemovable : Bool -> Builder { a | removable : Available } slotCaps msg kind -> Builder { a | removable : Used } slotCaps msg kind
withRemovable =
    Component.withRemovable


{-| Pipe form of `removeLabel` — re-exported from `M3e.InputChip`.
-}
withRemoveLabel : String -> Builder { a | removeLabel : Available } slotCaps msg kind -> Builder { a | removeLabel : Used } slotCaps msg kind
withRemoveLabel =
    Component.withRemoveLabel


{-| Pipe form of `value` — re-exported from `M3e.InputChip`.
-}
withValue : String -> Builder { a | value : Available } slotCaps msg kind -> Builder { a | value : Used } slotCaps msg kind
withValue =
    Component.withValue


{-| Pipe form of `variant` — re-exported from `M3e.InputChip`.
-}
withVariant : Value Component.Variant -> Builder { a | variant : Available } slotCaps msg kind -> Builder { a | variant : Used } slotCaps msg kind
withVariant =
    Component.withVariant


{-| Pipe form of `onRemove` — re-exported from `M3e.InputChip`.
-}
withOnRemove : msg -> Builder { a | onRemove : Available } slotCaps msg kind -> Builder { a | onRemove : Used } slotCaps msg kind
withOnRemove =
    Component.withOnRemove


{-| Pipe form of `onClick` — re-exported from `M3e.InputChip`.
-}
withOnClick : msg -> Builder { a | onClick : Available } slotCaps msg kind -> Builder { a | onClick : Used } slotCaps msg kind
withOnClick =
    Component.withOnClick
