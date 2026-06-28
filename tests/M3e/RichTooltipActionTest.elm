module M3e.RichTooltipActionTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element exposing (Element)
import M3e.Node as Node exposing (Node)
import M3e.RichTooltipAction as RichTooltipAction
import Test exposing (Test, describe, test)


label : Element { element : Element.Supported } msg
label =
    Element.text "Got it"


node : List (RichTooltipAction.Option msg) -> Node msg
node opts =
    RichTooltipAction.view [ label ] opts |> Element.toNode


suite : Test
suite =
    describe "M3e.RichTooltipAction — view-style port"
        [ test "renders <m3e-rich-tooltip-action>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-rich-tooltip-action")
        , test "content lands in default slot" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 1
        , test "disableRestoreFocus=true is a DOM property — introspectable" <|
            \_ ->
                node [ RichTooltipAction.disableRestoreFocus True ]
                    |> Node.findProperty "disableRestoreFocus"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disableRestoreFocus emits false by default" <|
            \_ ->
                node []
                    |> Node.findProperty "disableRestoreFocus"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        ]
