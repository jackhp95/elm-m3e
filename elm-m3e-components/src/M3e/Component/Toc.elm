module M3e.Component.Toc exposing
    ( view, build, toElement
    , Is, Attrs, OverlineSlot, TitleSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , for, maxDepth
    , overline, title, child
    , withChild, withClass, withFor, withId, withMaxDepth, withOverline, withSlot, withStyle, withTitle
    )

{-| The `m3e-toc` component — strict per-component surface.

A table of contents that provides in-page scroll navigation.

@docs view, build, toElement
@docs Is, Attrs, OverlineSlot, TitleSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs for, maxDepth
@docs overline, title, child
@docs withChild, withClass, withFor, withId, withMaxDepth, withOverline, withSlot, withStyle, withTitle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Html as H
import M3e.Internal.Types.Toc
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-toc` produces (open — composes into any slot naming it).
-}
type alias Is s =
    M3e.Internal.Types.Toc.Is s


{-| The closed attribute-capability row.
-}
type alias Attrs =
    M3e.Internal.Types.Toc.Attrs


{-| The kinds the `overline` slot admits.
-}
type alias OverlineSlot =
    M3e.Internal.Types.Toc.OverlineSlot


{-| The kinds the `title` slot admits.
-}
type alias TitleSlot =
    M3e.Internal.Types.Toc.TitleSlot


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.Toc.ChildAdmittedBy childAdm


{-| Standard constructor: `[attributes] [children]`. The default slot is
kind-permissive (`any`): children of any kind compose, but each child's OWN
admittedBy must still admit this context — a restricted-parent element is
rejected here at compile time.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.toc


{-| See `M3e.Attributes.for`.
-}
for : String -> Attr { c | for : Supported } msg
for =
    A.for


{-| See `M3e.Attributes.maxDepth`.
-}
maxDepth : Float -> Attr { c | maxDepth : Supported } msg
maxDepth =
    A.maxDepth


{-| Place an element into the named `overline` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
overline : Element OverlineSlot admittedBy msg -> Element free freeAdmittedBy msg
overline element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "overline") (El.toNode element))


{-| Place an element into the named `title` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
title : Element TitleSlot admittedBy msg -> Element free freeAdmittedBy msg
title element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "title") (El.toNode element))


{-| Place a pre-built element into the default (unnamed) slot (input
constrained to the slot's kinds; output row free so it composes into the
child list). The list-form sibling of the builder's `withChild`.
-}
child : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
child element =
    Ir.fromNode (El.toNode element)


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable. Aliases the shared builder in
`Build.Internal`, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg s =
    M3e.Internal.Types.Toc.Builder attrCaps slotCaps msg s


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.Toc.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    M3e.Internal.Types.Toc.SlotCaps


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-toc" [] []


{-| Close the pipe-builder (`toElement` is defined once in `Build.Internal`).
-}
toElement : Builder attrCaps slotCaps msg kind -> Element (Is kind) admittedBy msg
toElement =
    B.toElement


{-| Pipe form of `class` — consumes its capability (write-once).
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass value_ =
    B.withAttribute (A.class value_)


{-| Pipe form of `id` — consumes its capability (write-once).
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId value_ =
    B.withAttribute (A.id value_)


{-| Pipe form of `slot` — consumes its capability (write-once).
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot value_ =
    B.withAttribute (A.slot value_)


{-| Pipe form of `style` — consumes its capability (write-once).
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle property value_ =
    B.withAttribute (A.style property value_)


{-| Pipe form of `for` — consumes its capability (write-once).
-}
withFor : String -> Builder { a | for : Available } slotCaps msg kind -> Builder { a | for : Used } slotCaps msg kind
withFor value_ =
    B.withAttribute (A.for value_)


{-| Pipe form of `maxDepth` — consumes its capability (write-once).
-}
withMaxDepth : Float -> Builder { a | maxDepth : Available } slotCaps msg kind -> Builder { a | maxDepth : Used } slotCaps msg kind
withMaxDepth value_ =
    B.withAttribute (A.maxDepth value_)


{-| Pipe form of the `overline` slot — consumes its capability (write-once).
-}
withOverline : Element OverlineSlot admittedBy msg -> Builder attrCaps { s | overline : Available } msg kind -> Builder attrCaps { s | overline : Used } msg kind
withOverline element =
    B.withChild (El.toNode (overline element))


{-| Pipe form of the `title` slot — consumes its capability (write-once).
-}
withTitle : Element TitleSlot admittedBy msg -> Builder attrCaps { s | title : Available } msg kind -> Builder attrCaps { s | title : Used } msg kind
withTitle element =
    B.withChild (El.toNode (title element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg kind -> Builder attrCaps slotCaps msg kind
withChild element =
    B.withChild (El.toNode element)
