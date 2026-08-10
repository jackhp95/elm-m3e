module M3e.Build.Menu exposing
    ( build, toElement
    , Builder, AttrCaps, SlotCaps, Is, Content, ChildAdmittedBy
    , withClass, withId, withOnBeforetoggle, withOnToggle, withPositionX, withPositionY, withSlot, withStyle, withSubmenu, withVariant
    , withChild
    )

{-| The builder module for `m3e-menu` — seed, pipe, and close.

This module provides everything you need to BUILD with `Menu`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.Component.Menu.view`.

@docs build, toElement
@docs Builder, AttrCaps, SlotCaps, Is, Content, ChildAdmittedBy
@docs withClass, withId, withOnBeforetoggle, withOnToggle, withPositionX, withPositionY, withSlot, withStyle, withSubmenu, withVariant
@docs withChild

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Component.Menu as Component
import M3e.Internal.Types.Menu
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.Values


{-| The kind this element produces — a `Brand` that marks the phantom row.
-}
type alias Is s =
    M3e.Internal.Types.Menu.Is s


{-| The pipe-builder, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Internal.Types.Menu.Builder attrCaps slotCaps msg kind


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.Menu.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.Menu.ChildAdmittedBy childAdm


{-| The kinds the default slot admits.
-}
type alias Content =
    M3e.Internal.Types.Menu.Content


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-menu" [] []


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg kind -> Element (Component.Is kind) admittedBy msg
toElement =
    B.toElement


{-| Alias for [`toElement`](#toElement) — close and convert to an element.
-}


{-| Pipe form of a default-slot child (repeatable) — accepts a builder directly.
-}
withChild :
    B.Builder childRow childAttrCaps childSlotCaps accepts msg
    -> Builder attrCaps slotCaps msg kind
    -> Builder attrCaps slotCaps msg kind
withChild childBuilder builder_ =
    B.withChild (El.toNode (B.toElement childBuilder)) builder_


{-| Pipe form of `class` — re-exported from `M3e.Menu`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.Menu`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.Menu`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.Menu`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `positionX` — re-exported from `M3e.Menu`.
-}
withPositionX : Value Component.PositionX -> Builder { a | positionX : Available } slotCaps msg kind -> Builder { a | positionX : Used } slotCaps msg kind
withPositionX =
    Component.withPositionX


{-| Pipe form of `positionY` — re-exported from `M3e.Menu`.
-}
withPositionY : Value Component.PositionY -> Builder { a | positionY : Available } slotCaps msg kind -> Builder { a | positionY : Used } slotCaps msg kind
withPositionY =
    Component.withPositionY


{-| Pipe form of `submenu` — re-exported from `M3e.Menu`.
-}
withSubmenu : Bool -> Builder { a | submenu : Available } slotCaps msg kind -> Builder { a | submenu : Used } slotCaps msg kind
withSubmenu =
    Component.withSubmenu


{-| Pipe form of `variant` — re-exported from `M3e.Menu`.
-}
withVariant : Value Component.Variant -> Builder { a | variant : Available } slotCaps msg kind -> Builder { a | variant : Used } slotCaps msg kind
withVariant =
    Component.withVariant


{-| Pipe form of `onBeforetoggle` — re-exported from `M3e.Menu`.
-}
withOnBeforetoggle : msg -> Builder { a | onBeforetoggle : Available } slotCaps msg kind -> Builder { a | onBeforetoggle : Used } slotCaps msg kind
withOnBeforetoggle =
    Component.withOnBeforetoggle


{-| Pipe form of `onToggle` — re-exported from `M3e.Menu`.
-}
withOnToggle : (String -> msg) -> Builder { a | onToggle : Available } slotCaps msg kind -> Builder { a | onToggle : Used } slotCaps msg kind
withOnToggle =
    Component.withOnToggle
