module M3e.BottomSheetTriggerTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.BottomSheetTrigger as BottomSheetTrigger
import M3e.Element as Element exposing (Element)
import M3e.Node as Node exposing (Node)
import Test exposing (Test, describe, test)


label : Element { element : Element.Supported } msg
label =
    Element.text "Show options"


node : List (BottomSheetTrigger.Option msg) -> Node msg
node opts =
    BottomSheetTrigger.view [ label ] opts |> Element.toNode


suite : Test
suite =
    describe "M3e.BottomSheetTrigger — view-style port"
        [ test "renders <m3e-bottom-sheet-trigger>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-bottom-sheet-trigger")
        , test "content lands in default slot" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 1
        , test "for sets the introspectable attribute" <|
            \_ ->
                node [ BottomSheetTrigger.for "my-sheet" ]
                    |> Node.findAttribute "for"
                    |> Expect.equal (Just "my-sheet")
        , test "for is absent by default" <|
            \_ ->
                node []
                    |> Node.findAttribute "for"
                    |> Expect.equal Nothing
        , test "detent sets the introspectable property" <|
            \_ ->
                node [ BottomSheetTrigger.detent 1 ]
                    |> Node.findProperty "detent"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "1")
        , test "detent is absent by default" <|
            \_ ->
                node []
                    |> Node.findProperty "detent"
                    |> Expect.equal Nothing
        , test "secondary=true is a DOM property — introspectable" <|
            \_ ->
                node [ BottomSheetTrigger.secondary True ]
                    |> Node.findProperty "secondary"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "secondary emits false by default" <|
            \_ ->
                node []
                    |> Node.findProperty "secondary"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        ]
