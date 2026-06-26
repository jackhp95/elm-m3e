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
        [ test "withBody (existing) — children count preserved" <|
            \_ ->
                Card.new
                    |> Card.withBody [ htmlText "Item A", htmlText "Item B" ]
                    |> Card.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        , test "withVariant emits variant attribute" <|
            \_ ->
                Card.new
                    |> Card.withVariant Card.Elevated
                    |> Card.toNode
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "elevated")
        , test "withMedia produces a child with slot=header" <|
            \_ ->
                Card.new
                    |> Card.withMedia htmlImg
                    |> Card.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "header")
        , test "withHeadline produces a child with slot=content" <|
            \_ ->
                Card.new
                    |> Card.withHeadline
                        (Heading.view { label = "Title", variant = Heading.Title } [])
                    |> Card.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "content")
        , test "withActions produces a child with slot=actions" <|
            \_ ->
                Card.new
                    |> Card.withActions
                        [ Button.view { label = "OK", variant = Button.Filled } [] ]
                    |> Card.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "actions")
        , test "withFooter produces a child with slot=footer" <|
            \_ ->
                Card.new
                    |> Card.withFooter (htmlText "Footer")
                    |> Card.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "footer")
        , test "actionable is a DOM property" <|
            \_ ->
                Card.new
                    |> Card.withActionable True
                    |> Card.toNode
                    |> Node.findProperty "actionable"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "headline + body gives 2 children (content-div + body item)" <|
            \_ ->
                Card.new
                    |> Card.withVariant Card.Outlined
                    |> Card.withHeadline
                        (Heading.view { label = "Title", variant = Heading.Title } [])
                    |> Card.withBody [ htmlText "body" ]
                    |> Card.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        ]
