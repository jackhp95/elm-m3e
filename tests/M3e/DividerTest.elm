module M3e.DividerTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Divider as Divider
import M3e.Element as Element
import M3e.Node as Node exposing (Node)
import Test exposing (Test, describe, test)


node : List (Divider.Option msg) -> Node msg
node opts =
    Divider.view opts |> Element.toNode


suite : Test
suite =
    describe "M3e.Divider — view-style port"
        [ test "renders <m3e-divider>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-divider")
        , test "divider is a leaf — no children" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 0
        , test "vertical=true is a DOM property — introspectable" <|
            \_ ->
                node [ Divider.vertical True ]
                    |> Node.findProperty "vertical"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "vertical emits false by default" <|
            \_ ->
                node []
                    |> Node.findProperty "vertical"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "inset=true is a DOM property — introspectable" <|
            \_ ->
                node [ Divider.inset True ]
                    |> Node.findProperty "inset"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "inset emits false by default" <|
            \_ ->
                node []
                    |> Node.findProperty "inset"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "insetStart=true sets property inset-start" <|
            \_ ->
                node [ Divider.insetStart True ]
                    |> Node.findProperty "insetStart"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "insetEnd=true sets property inset-end" <|
            \_ ->
                node [ Divider.insetEnd True ]
                    |> Node.findProperty "insetEnd"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        ]
