module Layout exposing
    ( row, col, stack, center, container
    , rowWith, colWith, stackWith, gridWith, sectionWith, centerWith, containerWith
    , div, section, span, nav, ul, li
    )

{-| Named layout presets and exact-class escapes for the docs application.

The library (`M3e.*`) is deliberately layout-unopinionated. This module
belongs to the **docs app** and centralises every hand-rolled flex row,
flex column, grid, and stack so that layout intent is always named rather
than inlined.

**Usage discipline**

  - Use a preset (`Layout.row`) **only** when the original Tailwind class
    string **exactly** equals that preset's class string. The faithfulness
    invariant requires byte-identical rendered classes before and after a
    migration.
  - When the class string differs from every preset, use the exact-class
    escape (`Layout.div "exact classes here" children`). This is always safe.
  - Only use `Layout.*` for `Node.Node` layout wrappers. Leave `Node.raw`
    leaf content (pure `Html.Html` nodes with no `M3e.*` components) as is.


## Presets

@docs row, col, stack, center, container


## Named escape variants

@docs rowWith, colWith, stackWith, gridWith, sectionWith, centerWith, containerWith


## Generic tag helpers

@docs div, section, span, nav, ul, li

-}

import Html.Attributes as Attr
import M3e.Element exposing (Element)
import M3e.Value exposing (Supported)
import Native
import Seam


{-| A flex row with centred vertical alignment and a 3-unit gap.

Equivalent class: `"flex items-center gap-3"`

Use this preset only when the original class string is **exactly**
`"flex items-center gap-3"`.

-}
row : List (Element s msg) -> Element { k | html : Supported } msg
row =
    div "flex items-center gap-3"


{-| A flex column with a 4-unit gap between children.

Equivalent class: `"flex flex-col gap-4"`

Use this preset only when the original class string is **exactly**
`"flex flex-col gap-4"`.

-}
col : List (Element s msg) -> Element { k | html : Supported } msg
col =
    div "flex flex-col gap-4"


{-| A vertical stack with `space-y-4` between children.

Equivalent class: `"space-y-4"`

Use this preset only when the original class string is **exactly**
`"space-y-4"`.

-}
stack : List (Element s msg) -> Element { k | html : Supported } msg
stack =
    div "space-y-4"


{-| A horizontally-centred container with no width constraint.

Equivalent class: `"mx-auto"`

Use this preset only when the original class string is **exactly**
`"mx-auto"`.

-}
center : List (Element s msg) -> Element { k | html : Supported } msg
center =
    div "mx-auto"


{-| The standard docs-page content wrapper.

Equivalent class: `"mx-auto max-w-4xl space-y-8"`

Use this preset only when the original class string is **exactly**
`"mx-auto max-w-4xl space-y-8"`.

-}
container : List (Element s msg) -> Element { k | html : Supported } msg
container =
    div "mx-auto max-w-4xl space-y-8"



-- NAMED ESCAPE VARIANTS -------------------------------------------------------


{-| A flex row wrapper carrying exact Tailwind classes.

Use this when the row's classes differ from the `row` preset. The class
argument is passed through byte-for-byte — never alter it.

-}
rowWith : String -> List (Element s msg) -> Element { k | html : Supported } msg
rowWith =
    div


{-| A flex column wrapper carrying exact Tailwind classes.

Use this when the column's classes differ from the `col` preset.

-}
colWith : String -> List (Element s msg) -> Element { k | html : Supported } msg
colWith =
    div


{-| A vertical stack wrapper carrying exact Tailwind classes.

Use this when the stack's classes differ from the `stack` preset.

-}
stackWith : String -> List (Element s msg) -> Element { k | html : Supported } msg
stackWith =
    div


{-| A CSS grid wrapper carrying exact Tailwind classes.

The class argument should include the `grid` utility and any column/gap
configuration; it is passed through byte-for-byte.

-}
gridWith : String -> List (Element s msg) -> Element { k | html : Supported } msg
gridWith =
    div


{-| A `<section>` element carrying exact Tailwind classes.

Use for semantic sections when the class differs from the common
`"space-y-3"` or `"space-y-4"` patterns.

-}
sectionWith : String -> List (Element s msg) -> Element { k | html : Supported } msg
sectionWith =
    section


{-| A centred container carrying exact Tailwind classes.

Use this when the centring wrapper needs a width constraint or spacing
that differs from the `center` preset.

-}
centerWith : String -> List (Element s msg) -> Element { k | html : Supported } msg
centerWith =
    div


{-| A page content wrapper carrying exact Tailwind classes.

Use this when the page wrapper's class differs from the `container` preset.

-}
containerWith : String -> List (Element s msg) -> Element { k | html : Supported } msg
containerWith =
    div



-- GENERIC TAG HELPERS ---------------------------------------------------------


{-| A `<div>` element carrying the given Tailwind class string verbatim.

This is the catch-all escape: any layout `<div>` whose classes do not
match a preset should use this function. The class string is passed through
exactly — never add, drop, or reorder classes here.

-}
div : String -> List (Element s msg) -> Element { k | html : Supported } msg
div cls children =
    Native.div [ Seam.asAttribute (Attr.class cls) ] children


{-| A `<section>` element carrying the given Tailwind class string verbatim.

Use for semantic page sections (headings, content areas) whose classes do
not match the `sectionWith` shorthand.

-}
section : String -> List (Element s msg) -> Element { k | html : Supported } msg
section cls children =
    Native.section [ Seam.asAttribute (Attr.class cls) ] children


{-| A `<span>` element carrying the given Tailwind class string verbatim.

Use for inline layout wrappers (icon containers, badge anchors, etc.).

-}
span : String -> List (Element s msg) -> Element { k | html : Supported } msg
span cls children =
    Native.span [ Seam.asAttribute (Attr.class cls) ] children


{-| A `<nav>` element carrying the given Tailwind class string verbatim.

Use for navigation landmark wrappers.

-}
nav : String -> List (Element s msg) -> Element { k | html : Supported } msg
nav cls children =
    Native.nav [ Seam.asAttribute (Attr.class cls) ] children


{-| A `<ul>` element carrying the given Tailwind class string verbatim.

Use for unstyled or utility-classed unordered lists.

-}
ul : String -> List (Element s msg) -> Element { k | html : Supported } msg
ul cls children =
    Native.ul [ Seam.asAttribute (Attr.class cls) ] children


{-| A `<li>` element carrying the given Tailwind class string verbatim.

Use for list items whose layout is driven by Tailwind utilities.

-}
li : String -> List (Element s msg) -> Element { k | html : Supported } msg
li cls children =
    Native.li [ Seam.asAttribute (Attr.class cls) ] children
