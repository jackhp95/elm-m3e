module Layout exposing
    ( rowWith, colWith, gridWith
    , div, divWithId, section, span, nav, ul, li
    , button
    , class
    )

{-| Named tag helpers over raw HTML for the docs app's layout seam.

Migrated to the phantom substrate: `Markup.*` → `HtmlIr.*`.


## Named layout wrappers

@docs rowWith, colWith, gridWith


## Generic tag helpers

@docs div, divWithId, section, span, nav, ul, li


## Interactive helpers

@docs button


## Layout attribute

@docs class

-}

import Html.Attributes as Attr
import Html.Events
import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import M3e.Kind
import Native
import Seam



-- NAMED LAYOUT WRAPPERS -------------------------------------------------------


{-| A flex row wrapper carrying exact Tailwind classes.
-}
rowWith : String -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
rowWith =
    div


{-| A flex column wrapper carrying exact Tailwind classes.
-}
colWith : String -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
colWith =
    div


{-| A CSS grid wrapper carrying exact Tailwind classes.
-}
gridWith : String -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
gridWith =
    div



-- GENERIC TAG HELPERS ---------------------------------------------------------


{-| A `<div>` element carrying the given Tailwind class string verbatim.
-}
div : String -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
div cls children =
    Native.div [ Seam.asAttribute (Attr.class cls) ] children


{-| A `<div>` carrying the given Tailwind class string verbatim plus an `id`.
-}
divWithId : String -> String -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
divWithId id cls children =
    Native.div [ Seam.asAttribute (Attr.id id), Seam.asAttribute (Attr.class cls) ] children


{-| A `<section>` element carrying the given Tailwind class string verbatim.
-}
section : String -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
section cls children =
    Native.section [ Seam.asAttribute (Attr.class cls) ] children


{-| A `<span>` element carrying the given Tailwind class string verbatim.
-}
span : String -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
span cls children =
    Native.span [ Seam.asAttribute (Attr.class cls) ] children


{-| A `<nav>` element carrying the given Tailwind class string verbatim.
-}
nav : String -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
nav cls children =
    Native.nav [ Seam.asAttribute (Attr.class cls) ] children


{-| A `<ul>` element carrying the given Tailwind class string verbatim.
-}
ul : String -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
ul cls children =
    Native.ul [ Seam.asAttribute (Attr.class cls) ] children


{-| A `<li>` element carrying the given Tailwind class string verbatim.
-}
li : String -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
li cls children =
    Native.li [ Seam.asAttribute (Attr.class cls) ] children


{-| A native `<button>` carrying the given Tailwind class string verbatim.
-}
button : msg -> String -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
button onClick cls children =
    Native.button
        [ Seam.asAttribute (Html.Events.onClick onClick)
        , Seam.asAttribute (Attr.class cls)
        ]
        children


{-| A layout class string as a composable attribute.
-}
class : String -> Attr c msg
class cls =
    Seam.asAttribute (Attr.class cls)
