module M3e.DialogTriggerTest exposing (suite)

import Expect
import M3e.DialogTrigger as DialogTrigger
import M3e.Element as Element
import M3e.Node as Node exposing (Node)
import Test exposing (Test, describe, test)


node : List (DialogTrigger.Option msg) -> Node msg
node opts =
    DialogTrigger.view opts |> Element.toNode


suite : Test
suite =
    describe "M3e.DialogTrigger — view-style port"
        [ test "renders <m3e-dialog-trigger>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-dialog-trigger")
        , test "dialog-trigger is a leaf — no children" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 0
        , test "for sets the introspectable attribute" <|
            \_ ->
                node [ DialogTrigger.for "my-dialog" ]
                    |> Node.findAttribute "for"
                    |> Expect.equal (Just "my-dialog")
        , test "for is absent by default" <|
            \_ ->
                node []
                    |> Node.findAttribute "for"
                    |> Expect.equal Nothing
        ]
