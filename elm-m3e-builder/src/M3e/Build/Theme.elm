module M3e.Build.Theme exposing
    ( build, toElement
    , Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
    , withClass, withColor, withContrast, withDensity, withId, withMotion, withOnChange, withScheme, withSlot, withStrongFocus, withStyle, withVariant
    , withChild
    )

{-| The builder module for `m3e-theme` — seed, pipe, and close.

This module provides everything you need to BUILD with `Theme`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.Component.Theme.view`.

@docs build, toElement
@docs Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
@docs withClass, withColor, withContrast, withDensity, withId, withMotion, withOnChange, withScheme, withSlot, withStrongFocus, withStyle, withVariant
@docs withChild

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Component.Theme as Component
import M3e.Internal.Types.Theme
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.Values


{-| The kind this element produces — a `Brand` that marks the phantom row.
-}
type alias Is s =
    M3e.Internal.Types.Theme.Is s


{-| The pipe-builder, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Internal.Types.Theme.Builder attrCaps slotCaps msg kind


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.Theme.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.Theme.ChildAdmittedBy childAdm


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-theme" [] []


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


{-| Pipe form of `class` — re-exported from `M3e.Theme`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.Theme`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.Theme`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.Theme`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `color` — re-exported from `M3e.Theme`.
-}
withColor : String -> Builder { a | color : Available } slotCaps msg kind -> Builder { a | color : Used } slotCaps msg kind
withColor =
    Component.withColor


{-| Pipe form of `contrast` — re-exported from `M3e.Theme`.
-}
withContrast : Value Component.Contrast -> Builder { a | contrast : Available } slotCaps msg kind -> Builder { a | contrast : Used } slotCaps msg kind
withContrast =
    Component.withContrast


{-| Pipe form of `density` — re-exported from `M3e.Theme`.
-}
withDensity : Float -> Builder { a | density : Available } slotCaps msg kind -> Builder { a | density : Used } slotCaps msg kind
withDensity =
    Component.withDensity


{-| Pipe form of `motion` — re-exported from `M3e.Theme`.
-}
withMotion : Value Component.Motion -> Builder { a | motion : Available } slotCaps msg kind -> Builder { a | motion : Used } slotCaps msg kind
withMotion =
    Component.withMotion


{-| Pipe form of `scheme` — re-exported from `M3e.Theme`.
-}
withScheme : Value Component.Scheme -> Builder { a | scheme : Available } slotCaps msg kind -> Builder { a | scheme : Used } slotCaps msg kind
withScheme =
    Component.withScheme


{-| Pipe form of `strongFocus` — re-exported from `M3e.Theme`.
-}
withStrongFocus : Bool -> Builder { a | strongFocus : Available } slotCaps msg kind -> Builder { a | strongFocus : Used } slotCaps msg kind
withStrongFocus =
    Component.withStrongFocus


{-| Pipe form of `variant` — re-exported from `M3e.Theme`.
-}
withVariant : Value Component.Variant -> Builder { a | variant : Available } slotCaps msg kind -> Builder { a | variant : Used } slotCaps msg kind
withVariant =
    Component.withVariant


{-| Pipe form of `onChange` — re-exported from `M3e.Theme`.
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg kind -> Builder { a | onChange : Used } slotCaps msg kind
withOnChange =
    Component.withOnChange
