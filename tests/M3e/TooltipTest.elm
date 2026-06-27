module M3e.TooltipTest exposing (suite)

import Expect
import Html
import Json.Encode as Encode
import M3e.Element as Element exposing (Element)
import M3e.Node as Node exposing (Node)
import M3e.Tooltip as Tooltip
import Test exposing (Test, describe, test)



-- Helpers -----------------------------------------------------------------


fakeElement : Element { element : Element.Supported } msg
fakeElement =
    Element.element { tag = "span" } [] []


plainNode : List (Tooltip.PlainOption msg) -> Node msg
plainNode opts =
    Tooltip.plain { anchorId = "my-btn", label = "Delete" } opts
        |> Element.toNode


richNode : List (Tooltip.RichOption msg) -> Node msg
richNode opts =
    Tooltip.rich { anchorId = "my-btn", content = [] } opts
        |> Element.toNode


suite : Test
suite =
    describe "M3e.Tooltip — view-style port"
        [ -- Plain tooltip
          test "plain renders <m3e-tooltip>" <|
            \_ ->
                plainNode []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-tooltip")
        , test "plain sets the 'for' attribute to anchorId" <|
            \_ ->
                plainNode []
                    |> Node.findAttribute "for"
                    |> Expect.equal (Just "my-btn")
        , test "plainId sets the 'id' attribute" <|
            \_ ->
                plainNode [ Tooltip.plainId "tip-1" ]
                    |> Node.findAttribute "id"
                    |> Expect.equal (Just "tip-1")
        , test "id absent by default on plain" <|
            \_ ->
                plainNode []
                    |> Node.findAttribute "id"
                    |> Expect.equal Nothing
        , test "plain label is a text child" <|
            \_ ->
                plainNode []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 1
        , test "plainHideDelay sets the hide-delay DOM property" <|
            \_ ->
                plainNode [ Tooltip.plainHideDelay 500 ]
                    |> Node.findProperty "hideDelay"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "500")
        , test "hide-delay absent by default on plain" <|
            \_ ->
                plainNode []
                    |> Node.findProperty "hideDelay"
                    |> Expect.equal Nothing

        -- Rich tooltip
        , test "rich renders <m3e-rich-tooltip>" <|
            \_ ->
                richNode []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-rich-tooltip")
        , test "rich sets the 'for' attribute to anchorId" <|
            \_ ->
                richNode []
                    |> Node.findAttribute "for"
                    |> Expect.equal (Just "my-btn")
        , test "richId sets the 'id' attribute" <|
            \_ ->
                richNode [ Tooltip.richId "rich-tip-1" ]
                    |> Node.findAttribute "id"
                    |> Expect.equal (Just "rich-tip-1")
        , test "richHideDelay sets the hide-delay DOM property" <|
            \_ ->
                richNode [ Tooltip.richHideDelay 300 ]
                    |> Node.findProperty "hideDelay"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "300")
        , test "richSubhead child lands in the subhead slot" <|
            \_ ->
                richNode [ Tooltip.richSubhead fakeElement ]
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "subhead")
        , test "richActions child lands in the actions slot" <|
            \_ ->
                richNode [ Tooltip.richActions [ fakeElement ] ]
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "actions")
                    |> List.length
                    |> Expect.equal 1
        , test "rich content appears without a slot attribute" <|
            \_ ->
                Tooltip.rich
                    { anchorId = "x"
                    , content = [ Element.html (Html.text "hello") ]
                    }
                    []
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Nothing)
                    |> List.length
                    |> Expect.equal 1
        , test "no children by default on rich (empty content)" <|
            \_ ->
                richNode []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 0
        ]
