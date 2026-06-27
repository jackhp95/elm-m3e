module M3e.SegmentedButtonTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element exposing (Element)
import M3e.Node as Node exposing (Node)
import M3e.SegmentedButton as SegmentedButton
import Test exposing (Test, describe, test)


seg1 : Element { segment : Element.Supported } msg
seg1 =
    SegmentedButton.segment { label = "Day", checked = True } []


seg2 : Element { segment : Element.Supported } msg
seg2 =
    SegmentedButton.segment { label = "Week", checked = False } []


parentNode : List (SegmentedButton.ParentOption msg) -> Node msg
parentNode opts =
    SegmentedButton.view { segments = [ seg1, seg2 ] } opts
        |> Element.toNode


segNode : Bool -> List (SegmentedButton.SegmentOption msg) -> Node msg
segNode ch opts =
    SegmentedButton.segment { label = "Day", checked = ch } opts
        |> Element.toNode


suite : Test
suite =
    describe "M3e.SegmentedButton — view-style port"
        [ describe "parent (<m3e-segmented-button>)"
            [ test "renders <m3e-segmented-button>" <|
                \_ ->
                    parentNode []
                        |> Node.tagOf
                        |> Expect.equal (Just "m3e-segmented-button")
            , test "children are the provided segments" <|
                \_ ->
                    parentNode []
                        |> Node.childrenOf
                        |> List.length
                        |> Expect.equal 2
            , test "each child renders as <m3e-button-segment>" <|
                \_ ->
                    parentNode []
                        |> Node.childrenOf
                        |> List.filterMap Node.tagOf
                        |> Expect.equal [ "m3e-button-segment", "m3e-button-segment" ]
            , test "multi=true is a DOM property — introspectable" <|
                \_ ->
                    parentNode [ SegmentedButton.multi True ]
                        |> Node.findProperty "multi"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            , test "multi emits false by default" <|
                \_ ->
                    parentNode []
                        |> Node.findProperty "multi"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "false")
            , test "disabled on parent is a DOM property" <|
                \_ ->
                    parentNode [ SegmentedButton.disabled True ]
                        |> Node.findProperty "disabled"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            ]
        , describe "segment child (<m3e-button-segment>)"
            [ test "renders <m3e-button-segment>" <|
                \_ ->
                    segNode True []
                        |> Node.tagOf
                        |> Expect.equal (Just "m3e-button-segment")
            , test "checked=true is a DOM property" <|
                \_ ->
                    segNode True []
                        |> Node.findProperty "checked"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            , test "checked=false is also emitted as a DOM property" <|
                \_ ->
                    segNode False []
                        |> Node.findProperty "checked"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "false")
            , test "label text is a child node" <|
                \_ ->
                    segNode True []
                        |> Node.childrenOf
                        |> List.head
                        |> Maybe.andThen textContent
                        |> Expect.equal (Just "Day")
            , test "value defaults to the label text" <|
                \_ ->
                    segNode True []
                        |> Node.findProperty "value"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "\"Day\"")
            , test "segmentDisabled is a DOM property on the segment" <|
                \_ ->
                    segNode True [ SegmentedButton.segmentDisabled True ]
                        |> Node.findProperty "disabled"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            ]
        ]


textContent : Node msg -> Maybe String
textContent n =
    case n of
        Node.Text s ->
            Just s

        _ ->
            Nothing
