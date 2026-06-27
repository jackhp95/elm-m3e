module M3e.SplitPaneTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element exposing (Element)
import M3e.Node as Node
import M3e.SplitPane as SplitPane
import M3e.Text as Text
import Test exposing (Test, describe, test)


node :
    { start : List (Element any msg), end : List (Element any msg) }
    -> List (SplitPane.Option msg)
    -> Node.Node msg
node req opts =
    SplitPane.view req opts |> Element.toNode


emptyPane : { start : List (Element any msg), end : List (Element any msg) }
emptyPane =
    { start = [], end = [] }


suite : Test
suite =
    describe "M3e.SplitPane — view-style port"
        [ test "renders <m3e-split-pane>" <|
            \_ ->
                node emptyPane []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-split-pane")
        , test "has exactly two children (start and end panes)" <|
            \_ ->
                node emptyPane []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        , test "start child is m3e-content-pane slotted into start" <|
            \_ ->
                node emptyPane []
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.map (\n -> ( Node.tagOf n, Node.findAttribute "slot" n ))
                    |> Expect.equal (Just ( Just "m3e-content-pane", Just "start" ))
        , test "end child is m3e-content-pane slotted into end" <|
            \_ ->
                node emptyPane []
                    |> Node.childrenOf
                    |> List.drop 1
                    |> List.head
                    |> Maybe.map (\n -> ( Node.tagOf n, Node.findAttribute "slot" n ))
                    |> Expect.equal (Just ( Just "m3e-content-pane", Just "end" ))
        , test "start region content lands inside the start pane" <|
            \_ ->
                node { start = [ Text.bodyLarge "Nav" ], end = [] } []
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.map (Node.childrenOf >> List.head >> Maybe.andThen Node.tagOf)
                    |> Expect.equal (Just (Just "p"))
        , test "disabled is a DOM property — introspectable" <|
            \_ ->
                node emptyPane [ SplitPane.disabled True ]
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disabled absent by default" <|
            \_ ->
                node emptyPane []
                    |> Node.findProperty "disabled"
                    |> Expect.equal Nothing
        , test "label attribute is introspectable" <|
            \_ ->
                node emptyPane [ SplitPane.label "Adjust panes" ]
                    |> Node.findAttribute "label"
                    |> Expect.equal (Just "Adjust panes")
        ]
