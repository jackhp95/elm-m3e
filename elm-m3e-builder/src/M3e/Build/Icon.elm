module M3e.Build.Icon exposing
    ( build, toElement
    , Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
    , withClass, withFilled, withGrade, withId, withName, withOpticalSize, withSlot, withStyle, withVariant, withWeight
    )

{-| The builder module for `m3e-icon` — seed, pipe, and close.

This module provides everything you need to BUILD with `Icon`
using the pipe-builder pattern. Slot placers and slot pipes accept builders
directly — no `.toElement` needed at the call site.

For the standard `[attrs] [children]` constructor, use `M3e.Component.Icon.view`.

@docs build, toElement
@docs Builder, AttrCaps, SlotCaps, Is, ChildAdmittedBy
@docs withClass, withFilled, withGrade, withId, withName, withOpticalSize, withSlot, withStyle, withVariant, withWeight

-}

import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Component.Icon as Component
import M3e.Internal.Types.Icon
import M3e.Kind exposing (Available, Ctx, Used)
import M3e.Values


{-| The kind this element produces — a `Brand` that marks the phantom row.
-}
type alias Is s =
    M3e.Internal.Types.Icon.Is s


{-| The pipe-builder, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Internal.Types.Icon.Builder attrCaps slotCaps msg kind


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.Icon.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.Icon.ChildAdmittedBy childAdm


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-icon" [] []


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg kind -> Element (Component.Is kind) admittedBy msg
toElement =
    B.toElement


{-| Alias for [`toElement`](#toElement) — close and convert to an element.
-}


{-| Pipe form of `class` — re-exported from `M3e.Icon`.
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass =
    Component.withClass


{-| Pipe form of `id` — re-exported from `M3e.Icon`.
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId =
    Component.withId


{-| Pipe form of `slot` — re-exported from `M3e.Icon`.
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot =
    Component.withSlot


{-| Pipe form of `style` — re-exported from `M3e.Icon`.
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle =
    Component.withStyle


{-| Pipe form of `filled` — re-exported from `M3e.Icon`.
-}
withFilled : Bool -> Builder { a | filled : Available } slotCaps msg kind -> Builder { a | filled : Used } slotCaps msg kind
withFilled =
    Component.withFilled


{-| Pipe form of `grade` — re-exported from `M3e.Icon`.
-}
withGrade : Value Component.Grade -> Builder { a | grade : Available } slotCaps msg kind -> Builder { a | grade : Used } slotCaps msg kind
withGrade =
    Component.withGrade


{-| Pipe form of `name` — re-exported from `M3e.Icon`.
-}
withName : String -> Builder { a | name : Available } slotCaps msg kind -> Builder { a | name : Used } slotCaps msg kind
withName =
    Component.withName


{-| Pipe form of `opticalSize` — re-exported from `M3e.Icon`.
-}
withOpticalSize : Float -> Builder { a | opticalSize : Available } slotCaps msg kind -> Builder { a | opticalSize : Used } slotCaps msg kind
withOpticalSize =
    Component.withOpticalSize


{-| Pipe form of `variant` — re-exported from `M3e.Icon`.
-}
withVariant : Value Component.Variant -> Builder { a | variant : Available } slotCaps msg kind -> Builder { a | variant : Used } slotCaps msg kind
withVariant =
    Component.withVariant


{-| Pipe form of `weight` — re-exported from `M3e.Icon`.
-}
withWeight : Int -> Builder { a | weight : Available } slotCaps msg kind -> Builder { a | weight : Used } slotCaps msg kind
withWeight =
    Component.withWeight
