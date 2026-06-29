module M3e.FloatingPanelTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element
import M3e.FloatingPanel as FloatingPanel
import M3e.Node as Node exposing (Node)
import M3e.Value as Value
import Test exposing (Test, describe, test)


node : List (FloatingPanel.Option msg) -> Node msg
node opts =
    FloatingPanel.view { content = [] } opts |> Element.toNode


suite : Test
suite =
    describe "M3e.FloatingPanel — view-style port"
        [ test "renders <m3e-floating-panel>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-floating-panel")
        , test "no scroll-strategy attribute by default" <|
            \_ ->
                node []
                    |> Node.findAttribute "scroll-strategy"
                    |> Expect.equal Nothing
        , test "scrollStrategy hide emits scroll-strategy=hide" <|
            \_ ->
                node [ FloatingPanel.scrollStrategy Value.hide ]
                    |> Node.findAttribute "scroll-strategy"
                    |> Expect.equal (Just "hide")
        , test "scrollStrategy reposition emits scroll-strategy=reposition" <|
            \_ ->
                node [ FloatingPanel.scrollStrategy Value.reposition ]
                    |> Node.findAttribute "scroll-strategy"
                    |> Expect.equal (Just "reposition")
        , test "fitAnchorWidth=false is always emitted as a DOM property" <|
            \_ ->
                node []
                    |> Node.findProperty "fitAnchorWidth"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "fitAnchorWidth=true is a DOM property — introspectable" <|
            \_ ->
                node [ FloatingPanel.fitAnchorWidth True ]
                    |> Node.findProperty "fitAnchorWidth"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "anchorOffset defaults to 0 — always emitted" <|
            \_ ->
                node []
                    |> Node.findProperty "anchorOffset"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "0")
        , test "anchorOffset value is a DOM property — introspectable" <|
            \_ ->
                node [ FloatingPanel.anchorOffset 8 ]
                    |> Node.findProperty "anchorOffset"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "8")
        , test "content renders into the default slot" <|
            \_ ->
                FloatingPanel.view
                    { content = [ Element.text "Option A", Element.text "Option B" ] }
                    []
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        ]
