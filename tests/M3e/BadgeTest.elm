module M3e.BadgeTest exposing (suite)

import Expect
import M3e.Badge as Badge
import M3e.Node as Node
import M3e.Renderable as Renderable
import Test exposing (Test, describe, test)


node : List (Badge.Option msg) -> Node.Node msg
node opts =
    Badge.view opts |> Renderable.toNode


{-| Extract the text content of the first Text child of a node.
-}
firstChildText : Node.Node msg -> Maybe String
firstChildText n =
    case Node.childrenOf n of
        (Node.Text s) :: _ ->
            Just s

        _ ->
            Nothing


suite : Test
suite =
    describe "M3e.Badge — view-style port"
        [ test "renders <m3e-badge>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-badge")
        , test "dot option — no text children" <|
            \_ ->
                node [ Badge.dot ]
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 0
        , test "count option — child text is the formatted number" <|
            \_ ->
                node [ Badge.count 5 ]
                    |> firstChildText
                    |> Expect.equal (Just "5")
        , test "count > 999 is truncated to 999+" <|
            \_ ->
                node [ Badge.count 1000 ]
                    |> firstChildText
                    |> Expect.equal (Just "999+")
        , test "count exactly 999 is not truncated" <|
            \_ ->
                node [ Badge.count 999 ]
                    |> firstChildText
                    |> Expect.equal (Just "999")
        , test "label option — child text matches the label" <|
            \_ ->
                node [ Badge.label "New" ]
                    |> firstChildText
                    |> Expect.equal (Just "New")
        , test "forId is emitted as an introspectable attribute" <|
            \_ ->
                node [ Badge.forId "inbox-button" ]
                    |> Node.findAttribute "for"
                    |> Expect.equal (Just "inbox-button")
        , test "no forId → for attribute is absent" <|
            \_ ->
                node []
                    |> Node.findAttribute "for"
                    |> Expect.equal Nothing
        , test "no content option — no children" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 0
        ]
