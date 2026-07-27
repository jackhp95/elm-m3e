module IrCoreTest exposing (suite)

{-| Runtime tests for the hand-written IR-core reductions in `HtmlIr.Internal`
and `HtmlIr.Node` — the footguns `elm make` cannot catch.

Ported to the phantom substrate. The retired `M3e.Node.Internal`/
`M3e.Element.Internal` runtime was a _component-node_ tree (`fromComponent`,
`addChild`, eager-map-to-`Raw`); it was replaced by the structural
`HtmlIr` IR (`Tag`/`KeyedTag`/`Text`/`Raw`, structural `map`). Two of the
original four footguns therefore no longer exist as behaviour to test:

  - `addChild` (append-to-existing-node, with its silent no-op on leaf parents)
    has no equivalent — the IR builds children eagerly at `node`/`keyedNode`
    construction, so there is no post-hoc append to no-op.
  - `map`-collapses-to-`Raw` is gone: `HtmlIr.Internal.mapNode`/`HtmlIr.Node.map`
    are structural (the doc comment on `mapElement` explicitly contrasts "the
    retired runtime, which rendered eagerly on map"), so a `map` no longer turns
    a node opaque.

The two surviving reductions — both of which `NodeSlotTest` (issue #79) only
exercised for the named-slot case — are pinned here:

1.  `HtmlIr.Internal.addAttribute` on a `Text`/`Raw` leaf **promotes it to a
    `<span>`** carrying the attribute rather than silently dropping it.
2.  The for/id auto-wiring composition (`Seam.slot` then a raw `for=`/`id=`
    attribute via `HtmlIr.Internal.addAttribute`) stamps BOTH `slot=` and the
    second attribute, and the empty slot name adds no `slot=`.

These runtime reductions are not covered by the IR package's own `verify/`
suite (which is compile-time type-safety attacks only).

-}

import Expect
import Html
import Html.Attributes as HtmlAttr
import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Node as Node
import Seam
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector


{-| A `Raw`-backed element, the kind the for/id composition promotes on the way
in.
-}
labelEl : Element accepts admittedBy msg
labelEl =
    Seam.fromHtml (Html.span [] [ Html.text "Name" ])


{-| A plain (non-slot) class attribute, as an `Attr` with a fully-open row.
-}
promotedClass : Attr capability msg
promotedClass =
    Seam.asAttribute (HtmlAttr.class "promoted")


{-| Render a node inside a wrapper `<div>` so `findAll` (which searches
descendants only) can see the node itself.
-}
wrapped : Node.Node msg -> Query.Single msg
wrapped node =
    Html.div [] [ Node.toHtml node ]
        |> Query.fromHtml


{-| The for/id auto-wiring composition, built from the surviving IR primitives:
an empty slot name adds no `slot=` (the default slot is raw children), a named
slot stamps `slot="name"`, and both stamp the extra attribute (the for/id
association). This is the composition brand packages build above the IR.
-}
slotWithAttr : String -> String -> String -> Element accepts admittedBy msg -> Element other otherAdm msg
slotWithAttr slotName attrName attrValue el =
    Seam.slot slotName el
        |> Element.toNode
        |> Ir.addAttribute (Ir.attribute attrName attrValue)
        |> Ir.fromNode


suite : Test
suite =
    describe "IR-core runtime reductions"
        [ describe "Text/Raw -> <span> attribute promotion (non-slot attr)"
            [ test "a Text leaf given an attribute is promoted to a <span> carrying it" <|
                \_ ->
                    Ir.addAttribute promotedClass (Node.text "hi")
                        |> Node.toHtml
                        |> Query.fromHtml
                        |> Query.has
                            [ Selector.tag "span"
                            , Selector.class "promoted"
                            , Selector.text "hi"
                            ]
            , test "a Raw leaf given an attribute is promoted to a <span> wrapping it" <|
                \_ ->
                    Ir.addAttribute promotedClass (Ir.fromHtml (Html.node "raw-leaf" [] []))
                        |> Node.toHtml
                        |> Query.fromHtml
                        |> Expect.all
                            [ Query.has [ Selector.tag "span", Selector.class "promoted" ]
                            , Query.findAll [ Selector.tag "raw-leaf" ] >> Query.count (Expect.equal 1)
                            ]
            ]
        , describe "slotWithAttr (slot + raw attr) — for/id auto-wiring"
            [ test "stamps BOTH slot= and the extra attribute (for/id association)" <|
                \_ ->
                    slotWithAttr "label" "for" "field-1" labelEl
                        |> Element.toNode
                        |> Node.toHtml
                        |> Query.fromHtml
                        |> Query.has
                            [ Selector.attribute (HtmlAttr.attribute "slot" "label")
                            , Selector.attribute (HtmlAttr.attribute "for" "field-1")
                            ]
            , test "the default (unnamed) slot stamps only the attribute, no slot=" <|
                \_ ->
                    slotWithAttr "" "id" "field-1" labelEl
                        |> Element.toNode
                        |> wrapped
                        |> Expect.all
                            [ Query.has [ Selector.attribute (HtmlAttr.attribute "id" "field-1") ]
                            , Query.findAll [ Selector.attribute (HtmlAttr.attribute "slot" "") ]
                                >> Query.count (Expect.equal 0)
                            ]
            ]
        ]
