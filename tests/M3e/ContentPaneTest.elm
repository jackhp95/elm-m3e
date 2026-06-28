module M3e.ContentPaneTest exposing (suite)

import Expect
import M3e.ContentPane as ContentPane
import M3e.Element as Element
import M3e.Node as Node exposing (Node)
import Test exposing (Test, describe, test)


node : Node msg
node =
    ContentPane.view { content = [] } |> Element.toNode


suite : Test
suite =
    describe "M3e.ContentPane — view-style port"
        [ test "renders <m3e-content-pane>" <|
            \_ ->
                node
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-content-pane")
        , test "empty content list — no children" <|
            \_ ->
                node
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 0
        , test "content renders into the default slot" <|
            \_ ->
                ContentPane.view
                    { content = [ Element.text "Item A", Element.text "Item B" ] }
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        , test "no attrs emitted" <|
            \_ ->
                node
                    |> Node.findAttribute "class"
                    |> Expect.equal Nothing
        ]
