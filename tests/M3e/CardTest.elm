module M3e.CardTest exposing (suite)

import Expect
import Html
import Json.Encode as Encode
import Test exposing (Test, describe, test)
import M3e.Button as Button
import M3e.Card as Card
import M3e.Heading as Heading
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


htmlText : String -> Renderable { s | html : Supported } msg
htmlText s =
    Renderable.html (Html.text s)


htmlImg : Renderable { s | html : Supported } msg
htmlImg =
    Renderable.html (Html.node "img" [] [])


suite : Test
suite =
    describe "M3e.Card — expanded surface"
        [ test "body (default slot) — children count preserved" <|
            \_ ->
                Card.view [ Card.body [ htmlText "Item A", htmlText "Item B" ] ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        , test "variant option emits variant attribute" <|
            \_ ->
                Card.view [ Card.variant Card.Elevated ]
                    |> Renderable.toNode
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "elevated")
        , test "media option produces a child with slot=header" <|
            \_ ->
                Card.view [ Card.media htmlImg ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "header")
        , test "headline option produces a child with slot=content" <|
            \_ ->
                Card.view
                    [ Card.headline
                        (Heading.view { label = "Title", variant = Heading.Title } [])
                    ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "content")
        , test "actions option produces a child with slot=actions" <|
            \_ ->
                Card.view
                    [ Card.actions
                        [ Button.view { label = "OK", variant = Button.Filled } [] ]
                    ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "actions")
        , test "footer option produces a child with slot=footer" <|
            \_ ->
                Card.view [ Card.footer (htmlText "Footer") ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "footer")
        , test "actionable is a DOM property" <|
            \_ ->
                Card.view [ Card.actionable True ]
                    |> Renderable.toNode
                    |> Node.findProperty "actionable"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "headline + body gives 2 children (content-div + body item)" <|
            \_ ->
                Card.view
                    [ Card.variant Card.Outlined
                    , Card.headline
                        (Heading.view { label = "Title", variant = Heading.Title } [])
                    , Card.body [ htmlText "body" ]
                    ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        ]
