module M3e.Toc exposing
    ( view, build, toElement
    , Is, Attrs, OverlineSlot, TitleSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , for, maxDepth
    , overline, title
    , withAriaLabel, withChild, withClass, withFor, withId, withMaxDepth, withOverline, withSlot, withStyle, withTitle
    )

{-| The `m3e-toc` component — strict per-component surface.

A table of contents that provides in-page scroll navigation.

@docs view, build, toElement
@docs Is, Attrs, OverlineSlot, TitleSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs for, maxDepth
@docs overline, title
@docs withAriaLabel, withChild, withClass, withFor, withId, withMaxDepth, withOverline, withSlot, withStyle, withTitle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Node exposing (Node)
import M3e.Attributes
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-toc` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | toc : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { ariaLabel : Supported
    , class : Supported
    , for : Supported
    , id : Supported
    , maxDepth : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds the `overline` slot admits.
-}
type alias OverlineSlot =
    { sharedText : Shared }


{-| The kinds the `title` slot admits.
-}
type alias TitleSlot =
    { sharedText : Shared }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | toc : Ctx }


{-| Standard constructor: `[attributes] [children]`. The default slot is
kind-permissive (`any`): children of any kind compose, but each child's OWN
admittedBy must still admit this context — a restricted-parent element is
rejected here at compile time.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view attrs children =
    Ir.fromNode (Ir.node "m3e-toc" attrs (List.map HtmlIr.Element.toNode children))


{-| See `M3e.Attributes.for`.
-}
for : String -> Attr { c | for : Supported } msg
for =
    M3e.Attributes.for


{-| See `M3e.Attributes.maxDepth`.
-}
maxDepth : Float -> Attr { c | maxDepth : Supported } msg
maxDepth =
    M3e.Attributes.maxDepth


{-| Place an element into the named `overline` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
overline : Element OverlineSlot admittedBy msg -> Element free freeAdmittedBy msg
overline element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "overline") (HtmlIr.Element.toNode element))


{-| Place an element into the named `title` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
title : Element TitleSlot admittedBy msg -> Element free freeAdmittedBy msg
title element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "title") (HtmlIr.Element.toNode element))


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { ariaLabel : Available
    , class : Available
    , for : Available
    , id : Available
    , maxDepth : Available
    , slot : Available
    , style : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { overline : Available
    , title : Available
    }


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    Builder { attrs = [], children = [] }


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement (Builder b) =
    Ir.fromNode (Ir.node "m3e-toc" (List.reverse b.attrs) (List.reverse b.children))


{-| Pipe form of `ariaLabel` — consumes its capability (write-once).
-}
withAriaLabel : String -> Builder { a | ariaLabel : Available } slotCaps msg -> Builder { a | ariaLabel : Used } slotCaps msg
withAriaLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.ariaLabel value_ :: b.attrs }


{-| Pipe form of `class` — consumes its capability (write-once).
-}
withClass : String -> Builder { a | class : Available } slotCaps msg -> Builder { a | class : Used } slotCaps msg
withClass value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.class value_ :: b.attrs }


{-| Pipe form of `id` — consumes its capability (write-once).
-}
withId : String -> Builder { a | id : Available } slotCaps msg -> Builder { a | id : Used } slotCaps msg
withId value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.id value_ :: b.attrs }


{-| Pipe form of `slot` — consumes its capability (write-once).
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg -> Builder { a | slot : Used } slotCaps msg
withSlot value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.slot value_ :: b.attrs }


{-| Pipe form of `style` — consumes its capability (write-once).
-}
withStyle : String -> Builder { a | style : Available } slotCaps msg -> Builder { a | style : Used } slotCaps msg
withStyle value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.style value_ :: b.attrs }


{-| Pipe form of `for` — consumes its capability (write-once).
-}
withFor : String -> Builder { a | for : Available } slotCaps msg -> Builder { a | for : Used } slotCaps msg
withFor value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.for value_ :: b.attrs }


{-| Pipe form of `maxDepth` — consumes its capability (write-once).
-}
withMaxDepth : Float -> Builder { a | maxDepth : Available } slotCaps msg -> Builder { a | maxDepth : Used } slotCaps msg
withMaxDepth value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.maxDepth value_ :: b.attrs }


{-| Pipe form of the `overline` slot — consumes its capability (write-once).
-}
withOverline : Element OverlineSlot admittedBy msg -> Builder attrCaps { s | overline : Available } msg -> Builder attrCaps { s | overline : Used } msg
withOverline element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (overline element) :: b.children }


{-| Pipe form of the `title` slot — consumes its capability (write-once).
-}
withTitle : Element TitleSlot admittedBy msg -> Builder attrCaps { s | title : Available } msg -> Builder attrCaps { s | title : Used } msg
withTitle element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (title element) :: b.children }


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode element :: b.children }
