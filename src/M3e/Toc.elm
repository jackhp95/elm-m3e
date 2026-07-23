module M3e.Toc exposing
    ( view, build, toElement
    , Is, Attrs, OverlineSlot, TitleSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , for, maxDepth
    , overline, title
    , withChild, withClass, withFor, withId, withMaxDepth, withOverline, withSlot, withStyle, withTitle
    )

{-| The `m3e-toc` component — strict per-component surface.

A table of contents that provides in-page scroll navigation.

@docs view, build, toElement
@docs Is, Attrs, OverlineSlot, TitleSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs for, maxDepth
@docs overline, title
@docs withChild, withClass, withFor, withId, withMaxDepth, withOverline, withSlot, withStyle, withTitle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Html as H
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-toc` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | toc : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
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


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable. Aliases the shared builder in
`Build.Internal`, closed over this component's `Attrs` row.
-}
type alias Builder attrCaps slotCaps msg =
    B.Builder Attrs attrCaps slotCaps msg


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { class : Available
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
    B.init "m3e-toc" [] []


{-| Close the pipe-builder (`toElement` is defined once in `Build.Internal`).
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement =
    B.toElement


{-| Pipe form of `class` — consumes its capability (write-once).
-}
withClass : String -> Builder { a | class : Available } slotCaps msg -> Builder { a | class : Used } slotCaps msg
withClass value_ =
    B.withAttribute (A.class value_)


{-| Pipe form of `id` — consumes its capability (write-once).
-}
withId : String -> Builder { a | id : Available } slotCaps msg -> Builder { a | id : Used } slotCaps msg
withId value_ =
    B.withAttribute (A.id value_)


{-| Pipe form of `slot` — consumes its capability (write-once).
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg -> Builder { a | slot : Used } slotCaps msg
withSlot value_ =
    B.withAttribute (A.slot value_)


{-| Pipe form of `style` — consumes its capability (write-once).
-}
withStyle : String -> Builder { a | style : Available } slotCaps msg -> Builder { a | style : Used } slotCaps msg
withStyle value_ =
    B.withAttribute (A.style value_)


{-| Pipe form of `for` — consumes its capability (write-once).
-}
withFor : String -> Builder { a | for : Available } slotCaps msg -> Builder { a | for : Used } slotCaps msg
withFor value_ =
    B.withAttribute (A.for value_)


{-| Pipe form of `maxDepth` — consumes its capability (write-once).
-}
withMaxDepth : Float -> Builder { a | maxDepth : Available } slotCaps msg -> Builder { a | maxDepth : Used } slotCaps msg
withMaxDepth value_ =
    B.withAttribute (A.maxDepth value_)


{-| Pipe form of the `overline` slot — consumes its capability (write-once).
-}
withOverline : Element OverlineSlot admittedBy msg -> Builder attrCaps { s | overline : Available } msg -> Builder attrCaps { s | overline : Used } msg
withOverline element =
    B.withChild (El.toNode (overline element))


{-| Pipe form of the `title` slot — consumes its capability (write-once).
-}
withTitle : Element TitleSlot admittedBy msg -> Builder attrCaps { s | title : Available } msg -> Builder attrCaps { s | title : Used } msg
withTitle element =
    B.withChild (El.toNode (title element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
