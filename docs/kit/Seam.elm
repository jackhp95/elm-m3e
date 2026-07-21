module Seam exposing (asAttribute, asElement, fromHtml, label, link, recast, recastAttr, slot, text)

{-| The **single** sanctioned userland boundary — migrated to the phantom substrate.

`Seam` crosses between raw Elm `Html` and the opaque, phantom-typed IR. It is built
directly on `HtmlIr.Internal` — the interior surface that exposes the raw-to-phantom
constructors the public modules deliberately withhold.

This module supersedes the former markup-core `Seam`: all `Markup.*` references now
route through `HtmlIr.*` and `TypedHtml.*`.

-}

import Html exposing (Html)
import Html.Attributes
import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared)
import HtmlIr.Node exposing (Node)


{-| Lift a raw `Html` leaf into an `Element`, stamping whatever phantom row the
call site needs.
-}
fromHtml : Html msg -> Element accepts admittedBy msg
fromHtml h =
    Ir.fromNode (Ir.fromHtml h)


{-| Stamp a bare `Node` as an `Element` with whatever phantom row the call site
needs.
-}
asElement : Node msg -> Element accepts admittedBy msg
asElement =
    Ir.fromNode


{-| Turn a raw `Html.Attribute` into a typed `Attr` carrying a fully-open
capability row.
-}
asAttribute : Html.Attribute msg -> Attr capability msg
asAttribute a =
    Ir.fromHtmlAttribute a


{-| Stamp a slot name onto an `Element`, re-forging a FREE phantom row on the
result so it composes into any container's child list.
-}
slot : String -> Element any anyAdm msg -> Element other otherAdm msg
slot name el =
    if name == "" then
        Ir.fromNode (HtmlIr.Element.toNode el)

    else
        Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" name) (HtmlIr.Element.toNode el))


{-| Coerce an `Element`'s phantom rows from one shape to another.
Loud and greppable.
-}
recast : Element a aAdm msg -> Element b bAdm msg
recast el =
    Ir.fromNode (HtmlIr.Element.toNode el)


{-| Coerce an `Attr`'s capability row from one shape to another.
-}
recastAttr : Attr a msg -> Attr b msg
recastAttr a =
    Ir.fromHtmlAttribute (HtmlIr.Attribute.toHtmlAttribute a)


-- SEMANTIC SEAMS ---------------------------------------------------------------


{-| The `text` seam: a bare text leaf carrying the `sharedText` kind.
-}
text : String -> Element { s | sharedText : Shared } admittedBy msg
text s =
    Ir.fromNode (Ir.text s)


{-| The `link` seam: a plain navigation anchor (`<a href>`) wrapping children.
Carries the `sharedLink` kind.
-}
link : String -> List (Element s admittedBy msg) -> Element { k | sharedLink : Shared } linkAdm msg
link href kids =
    Ir.fromNode
        (Ir.node "a"
            [ Ir.fromHtmlAttribute (Html.Attributes.href href) ]
            (List.map HtmlIr.Element.toNode kids)
        )


{-| The `label` seam: a native `<label>` wrapping children. Carries the `sharedLabel` kind.
-}
label : List (Element s admittedBy msg) -> Element { k | sharedLabel : Shared } labelAdm msg
label kids =
    Ir.fromNode
        (Ir.node "label"
            []
            (List.map HtmlIr.Element.toNode kids)
        )
