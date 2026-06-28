module M3e.CardTest exposing (suite)

import Expect
import Html
import Json.Encode as Encode
import M3e.Button as Button
import M3e.Card as Card
import M3e.Element as Element exposing (Element, Supported)
import M3e.Heading as Heading
import M3e.Node as Node
import M3e.Value as Value
import Test exposing (Test, describe, test)


htmlText : String -> Element { s | html : Supported } msg
htmlText s =
    Element.html (Html.text s)


htmlImg : Element { s | html : Supported } msg
htmlImg =
    Element.html (Html.node "img" [] [])


suite : Test
suite =
    describe "M3e.Card — expanded surface"
        [ test "body (default slot) — children count preserved" <|
            \_ ->
                Card.view [ Card.body [ htmlText "Item A", htmlText "Item B" ] ]
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        , test "variant option emits variant attribute" <|
            \_ ->
                Card.view [ Card.variant Value.elevated ]
                    |> Element.toNode
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "elevated")
        , test "media option produces a child with slot=header" <|
            \_ ->
                Card.view [ Card.media htmlImg ]
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "header")
        , test "headline option produces a child with slot=content" <|
            \_ ->
                Card.view
                    [ Card.headline
                        (Heading.view { label = "Title", variant = Value.title } [])
                    ]
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "content")
        , test "actions option produces a child with slot=actions" <|
            \_ ->
                Card.view
                    [ Card.actions
                        [ Button.view { label = "OK", variant = Value.filled } [] ]
                    ]
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "actions")
        , test "footer option produces a child with slot=footer" <|
            \_ ->
                Card.view [ Card.footer (htmlText "Footer") ]
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "footer")
        , test "actionable is a DOM property" <|
            \_ ->
                Card.view [ Card.actionable True ]
                    |> Element.toNode
                    |> Node.findProperty "actionable"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "headline + body gives 2 children (content-div + body item)" <|
            \_ ->
                Card.view
                    [ Card.variant Value.outlined
                    , Card.headline
                        (Heading.view { label = "Title", variant = Value.title } [])
                    , Card.body [ htmlText "body" ]
                    ]
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2

        -- Fix #66 — orientation and link button options
        , test "fix-#66: orientation Vertical emits orientation=vertical" <|
            \_ ->
                Card.view [ Card.orientation Card.Vertical ]
                    |> Element.toNode
                    |> Node.findAttribute "orientation"
                    |> Expect.equal (Just "vertical")
        , test "fix-#66: orientation Horizontal emits orientation=horizontal" <|
            \_ ->
                Card.view [ Card.orientation Card.Horizontal ]
                    |> Element.toNode
                    |> Node.findAttribute "orientation"
                    |> Expect.equal (Just "horizontal")
        , test "fix-#66: no orientation option — no orientation attribute by default" <|
            \_ ->
                Card.view []
                    |> Element.toNode
                    |> Node.findAttribute "orientation"
                    |> Expect.equal Nothing
        , test "fix-#66: href sets the href attribute (LinkButton)" <|
            \_ ->
                Card.view [ Card.href "/detail" ]
                    |> Element.toNode
                    |> Node.findAttribute "href"
                    |> Expect.equal (Just "/detail")
        , test "fix-#66: target sets the target attribute (LinkButton)" <|
            \_ ->
                Card.view [ Card.target "_blank" ]
                    |> Element.toNode
                    |> Node.findAttribute "target"
                    |> Expect.equal (Just "_blank")
        , test "fix-#66: rel sets the rel attribute (LinkButton)" <|
            \_ ->
                Card.view [ Card.rel "noreferrer" ]
                    |> Element.toNode
                    |> Node.findAttribute "rel"
                    |> Expect.equal (Just "noreferrer")
        , test "fix-#66: download sets the download attribute (LinkButton)" <|
            \_ ->
                Card.view [ Card.download "file.pdf" ]
                    |> Element.toNode
                    |> Node.findAttribute "download"
                    |> Expect.equal (Just "file.pdf")
        ]
