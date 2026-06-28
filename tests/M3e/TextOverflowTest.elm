module M3e.TextOverflowTest exposing (suite)

import Expect
import M3e.Element as Element
import M3e.Node as Node exposing (Node)
import M3e.TextOverflow as TextOverflow
import Test exposing (Test, describe, test)


node : Node msg
node =
    TextOverflow.view { content = [] } |> Element.toNode


suite : Test
suite =
    describe "M3e.TextOverflow — view-style port"
        [ test "renders <m3e-text-overflow>" <|
            \_ ->
                node
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-text-overflow")
        , test "empty content list — no children" <|
            \_ ->
                node
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 0
        , test "content renders into the default slot" <|
            \_ ->
                TextOverflow.view
                    { content = [ Element.text "A very long label that may overflow" ] }
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 1
        , test "no attrs emitted" <|
            \_ ->
                node
                    |> Node.findAttribute "class"
                    |> Expect.equal Nothing
        ]
