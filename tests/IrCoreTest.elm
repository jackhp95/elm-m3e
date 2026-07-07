module IrCoreTest exposing (suite)

{-| Runtime tests for the hand-written IR-core reductions in `M3e.Node.Internal`
and `M3e.Content.Internal` — the four footguns `elm make` cannot catch:

1.  `addChild` silently no-ops when the parent is a `Text`/`Raw` leaf (the child
    is dropped).
2.  `map` collapses the typed IR to an opaque `Raw` (so, e.g., a later `addChild`
    becomes a no-op).
3.  `slotWithAttr` is the for/id auto-wiring primitive — it stamps BOTH `slot=`
    and a second raw attribute.
4.  A `Text`/`Raw` leaf given a (non-slot) attribute is promoted to a `<span>`
    carrying it, rather than silently dropping the attribute.

These are the runtime reductions `NodeSlotTest` (issue #79) only exercised for the
named-slot case.

-}

import Expect
import Html
import Html.Attributes as HtmlAttr
import M3e.Cem.Attr as CemAttr
import M3e.Content.Internal as Content
import M3e.Element as Element
import M3e.Node.Internal as Node
import Seam
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector


{-| A child node with a distinctive tag, so `findAll [ tag "child-marker" ]` tells
us whether it survived (or was dropped by) a reduction.
-}
childMarker : Node.Node msg
childMarker =
    Node.fromComponent (\_ _ -> Html.node "child-marker" [] []) [] []


{-| An `Element`-branch parent node that renders `<div class="parent">…children…</div>`.
-}
elementParent : Node.Node msg
elementParent =
    Node.fromComponent
        (\_ kids -> Html.div [ HtmlAttr.class "parent" ] kids)
        []
        []


{-| A `Raw`-backed element, the kind `slotWithAttr` promotes on the way in.
-}
labelEl : Element.Element supported msg
labelEl =
    Seam.fromHtml (Html.span [] [ Html.text "Name" ])


{-| A plain (non-slot) class attribute, as an `Attr () msg`.
-}
promotedClass : CemAttr.Attr () msg
promotedClass =
    Seam.asAttribute (HtmlAttr.class "promoted")


{-| Render a node inside a wrapper `<div>` so `findAll` (which searches descendants
only) can see the node itself.
-}
wrapped : Node.Node msg -> Query.Single msg
wrapped node =
    Html.div [] [ Node.toHtml node ]
        |> Query.fromHtml


suite : Test
suite =
    describe "IR-core runtime reductions"
        [ describe "Node.addChild"
            [ test "appends to an Element parent" <|
                \_ ->
                    Node.addChild childMarker elementParent
                        |> wrapped
                        |> Query.findAll [ Selector.tag "child-marker" ]
                        |> Query.count (Expect.equal 1)
            , test "no-ops on a Text leaf parent — the child is dropped" <|
                \_ ->
                    Node.addChild childMarker (Node.text "leaf")
                        |> wrapped
                        |> Expect.all
                            [ Query.findAll [ Selector.tag "child-marker" ] >> Query.count (Expect.equal 0)
                            , Query.has [ Selector.text "leaf" ]
                            ]
            , test "no-ops on a Raw leaf parent — the child is dropped" <|
                \_ ->
                    Node.addChild childMarker (Node.raw (Html.node "raw-leaf" [] []))
                        |> wrapped
                        |> Expect.all
                            [ Query.findAll [ Selector.tag "child-marker" ] >> Query.count (Expect.equal 0)
                            , Query.findAll [ Selector.tag "raw-leaf" ] >> Query.count (Expect.equal 1)
                            ]
            ]
        , describe "Node.map collapses the typed IR to Raw"
            [ test "the rendered output is unchanged after map" <|
                \_ ->
                    Node.map identity elementParent
                        |> wrapped
                        |> Query.has [ Selector.tag "div", Selector.class "parent" ]
            , test "addChild after map is a no-op — the node is now an opaque Raw" <|
                \_ ->
                    Node.addChild childMarker (Node.map identity elementParent)
                        |> wrapped
                        |> Query.findAll [ Selector.tag "child-marker" ]
                        |> Query.count (Expect.equal 0)
            ]
        , describe "Content.slotWithAttr — for/id auto-wiring"
            [ test "stamps BOTH slot= and the extra attribute (for/id association)" <|
                \_ ->
                    Content.slotWithAttr "label" "for" "field-1" labelEl
                        |> Content.toNode
                        |> Node.toHtml
                        |> Query.fromHtml
                        |> Query.has
                            [ Selector.attribute (HtmlAttr.attribute "slot" "label")
                            , Selector.attribute (HtmlAttr.attribute "for" "field-1")
                            ]
            , test "the default (unnamed) slot stamps only the attribute, no slot=" <|
                \_ ->
                    Content.slotWithAttr "" "id" "field-1" labelEl
                        |> Content.toNode
                        |> wrapped
                        |> Expect.all
                            [ Query.has [ Selector.attribute (HtmlAttr.attribute "id" "field-1") ]
                            , Query.findAll [ Selector.attribute (HtmlAttr.attribute "slot" "") ]
                                >> Query.count (Expect.equal 0)
                            ]
            ]
        , describe "Text/Raw -> <span> attribute promotion (non-slot attr)"
            [ test "a Text leaf given an attribute is promoted to a <span> carrying it" <|
                \_ ->
                    Node.addAttr promotedClass (Node.text "hi")
                        |> Node.toHtml
                        |> Query.fromHtml
                        |> Query.has
                            [ Selector.tag "span"
                            , Selector.class "promoted"
                            , Selector.text "hi"
                            ]
            , test "a Raw leaf given an attribute is promoted to a <span> wrapping it" <|
                \_ ->
                    Node.addAttr promotedClass (Node.raw (Html.node "raw-leaf" [] []))
                        |> Node.toHtml
                        |> Query.fromHtml
                        |> Expect.all
                            [ Query.has [ Selector.tag "span", Selector.class "promoted" ]
                            , Query.findAll [ Selector.tag "raw-leaf" ] >> Query.count (Expect.equal 1)
                            ]
            ]
        ]
