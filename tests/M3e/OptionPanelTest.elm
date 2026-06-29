module M3e.OptionPanelTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element
import M3e.Node as Node exposing (Node)
import M3e.OptionPanel as OptionPanel
import M3e.Value as Value
import Test exposing (Test, describe, test)


node : List (OptionPanel.Option msg) -> Node msg
node opts =
    OptionPanel.view { content = [] } opts |> Element.toNode


suite : Test
suite =
    describe "M3e.OptionPanel — view-style port"
        [ test "renders <m3e-option-panel>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-option-panel")
        , test "no state attribute by default" <|
            \_ ->
                node []
                    |> Node.findAttribute "state"
                    |> Expect.equal Nothing
        , test "state Content emits state=content" <|
            \_ ->
                node [ OptionPanel.state Value.content ]
                    |> Node.findAttribute "state"
                    |> Expect.equal (Just "content")
        , test "state Loading emits state=loading" <|
            \_ ->
                node [ OptionPanel.state Value.loading ]
                    |> Node.findAttribute "state"
                    |> Expect.equal (Just "loading")
        , test "state NoData emits state=no-data" <|
            \_ ->
                node [ OptionPanel.state Value.noData ]
                    |> Node.findAttribute "state"
                    |> Expect.equal (Just "no-data")
        , test "no scroll-strategy attribute by default" <|
            \_ ->
                node []
                    |> Node.findAttribute "scroll-strategy"
                    |> Expect.equal Nothing
        , test "scrollStrategy Reposition emits scroll-strategy=reposition" <|
            \_ ->
                node [ OptionPanel.scrollStrategy Value.reposition ]
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
                node [ OptionPanel.fitAnchorWidth True ]
                    |> Node.findProperty "fitAnchorWidth"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "anchorOffset defaults to 0 — always emitted" <|
            \_ ->
                node []
                    |> Node.findProperty "anchorOffset"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "0")
        , test "content renders into the default slot" <|
            \_ ->
                OptionPanel.view
                    { content = [ Element.text "Choice A", Element.text "Choice B" ] }
                    []
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        ]
