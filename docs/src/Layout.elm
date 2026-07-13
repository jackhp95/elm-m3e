module Layout exposing
    ( rowWith, colWith, gridWith
    , div, divWithId, section, span, nav, ul, li
    , button
    , class
    )

{-| Named tag helpers over raw HTML for the docs app's layout seam. Layout intent
is named at the call site via an exact class string.

The library (`M3e.*`) is deliberately layout-unopinionated. This module belongs to
the **docs app** and centralises the hand-rolled flex/grid wrappers so a layout
`<div>`/`<section>` is a named crossing in one place rather than a scattered `Seam`.


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
import M3e.Kind
import Markup.Element exposing (Element)
import Markup.Html.Attr
import Native
import Seam



-- NAMED LAYOUT WRAPPERS -------------------------------------------------------


{-| A flex row wrapper carrying exact Tailwind classes, passed through
byte-for-byte — never alter it.
-}
rowWith : String -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
rowWith =
    div


{-| A flex column wrapper carrying exact Tailwind classes.
-}
colWith : String -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
colWith =
    div


{-| A CSS grid wrapper carrying exact Tailwind classes.

The class argument should include the `grid` utility and any column/gap
configuration; it is passed through byte-for-byte.

-}
gridWith : String -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
gridWith =
    div



-- GENERIC TAG HELPERS ---------------------------------------------------------


{-| A `<div>` element carrying the given Tailwind class string verbatim.

This is the catch-all escape: any layout `<div>` whose classes do not
match a preset should use this function. The class string is passed through
exactly — never add, drop, or reorder classes here.

-}
div : String -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
div cls children =
    Native.div [ Seam.asAttribute (Attr.class cls) ] children


{-| A `<div>` carrying the given Tailwind class string verbatim plus an `id`
attribute, so the block can be deep-linked (e.g. `/components/all#button`).
Same discipline as `div`: the class string is passed through exactly.
-}
divWithId : String -> String -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
divWithId id cls children =
    Native.div [ Seam.asAttribute (Attr.id id), Seam.asAttribute (Attr.class cls) ] children


{-| A `<section>` element carrying the given Tailwind class string verbatim.

Use for semantic page sections (headings, content areas) whose classes do
not match the `sectionWith` shorthand.

-}
section : String -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
section cls children =
    Native.section [ Seam.asAttribute (Attr.class cls) ] children


{-| A `<span>` element carrying the given Tailwind class string verbatim.

Use for inline layout wrappers (icon containers, badge anchors, etc.).

-}
span : String -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
span cls children =
    Native.span [ Seam.asAttribute (Attr.class cls) ] children


{-| A `<nav>` element carrying the given Tailwind class string verbatim.

Use for navigation landmark wrappers.

-}
nav : String -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
nav cls children =
    Native.nav [ Seam.asAttribute (Attr.class cls) ] children


{-| A `<ul>` element carrying the given Tailwind class string verbatim.

Use for unstyled or utility-classed unordered lists.

-}
ul : String -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
ul cls children =
    Native.ul [ Seam.asAttribute (Attr.class cls) ] children


{-| A `<li>` element carrying the given Tailwind class string verbatim.

Use for list items whose layout is driven by Tailwind utilities.

-}
li : String -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
li cls children =
    Native.li [ Seam.asAttribute (Attr.class cls) ] children


{-| A native `<button>` carrying the given Tailwind class string verbatim and an
`onClick` handler.

For docs-app affordances that need a plain clickable button without an M3e
component (e.g. the `/components/all` reveal gate). Keeps the `Seam`/`onClick`
crossing fenced in this adapter, so feature routes stay seam-free.

-}
button : msg -> String -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
button onClick cls children =
    Native.button
        [ Seam.asAttribute (Html.Events.onClick onClick)
        , Seam.asAttribute (Attr.class cls)
        ]
        children


{-| A layout class string as a composable attribute.

Use this to put layout utilities (flex/grid/gap/padding/margin) on an element
built by another seam producer — e.g. layout classes on a `Kit.Surface.view` —
without reaching for `Seam` in feature code. Layout-only, same discipline as the
tag helpers above.

-}
class : String -> Markup.Html.Attr.Attr c msg
class cls =
    Seam.asAttribute (Attr.class cls)
