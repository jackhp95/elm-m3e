module M3e.ProgressTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Progress as Progress
import M3e.Renderable as Renderable
import Test exposing (Test, describe, test)


linearNode : List (Progress.Option msg) -> Node.Node msg
linearNode opts =
    Progress.view { shape = Progress.Linear } opts |> Renderable.toNode


circularNode : List (Progress.Option msg) -> Node.Node msg
circularNode opts =
    Progress.view { shape = Progress.Circular } opts |> Renderable.toNode


suite : Test
suite =
    describe "M3e.Progress — view-style port"
        [ describe "Linear"
            [ test "renders <m3e-linear-progress-indicator>" <|
                \_ ->
                    linearNode []
                        |> Node.tagOf
                        |> Expect.equal (Just "m3e-linear-progress-indicator")
            , test "linear is a leaf — no children" <|
                \_ ->
                    linearNode []
                        |> Node.childrenOf
                        |> List.length
                        |> Expect.equal 0
            , test "max property is always emitted (default 100)" <|
                \_ ->
                    linearNode []
                        |> Node.findProperty "max"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "100")
            , test "max option overrides default" <|
                \_ ->
                    linearNode [ Progress.max 200 ]
                        |> Node.findProperty "max"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "200")
            , test "value option sets the value property" <|
                \_ ->
                    linearNode [ Progress.value 42 ]
                        |> Node.findProperty "value"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "\"42\"")
            , test "no value option → value property is absent (indeterminate via rawAttr mode)" <|
                \_ ->
                    linearNode []
                        |> Node.findProperty "value"
                        |> Expect.equal Nothing
            ]
        , describe "Circular"
            [ test "renders <m3e-circular-progress-indicator>" <|
                \_ ->
                    circularNode []
                        |> Node.tagOf
                        |> Expect.equal (Just "m3e-circular-progress-indicator")
            , test "circular is a leaf — no children" <|
                \_ ->
                    circularNode []
                        |> Node.childrenOf
                        |> List.length
                        |> Expect.equal 0
            , test "max property is always emitted (default 100)" <|
                \_ ->
                    circularNode []
                        |> Node.findProperty "max"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "100")
            , test "value option sets the value property" <|
                \_ ->
                    circularNode [ Progress.value 75 ]
                        |> Node.findProperty "value"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "\"75\"")
            , test "no value option → indeterminate property is true" <|
                \_ ->
                    circularNode []
                        |> Node.findProperty "indeterminate"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            , test "value option → indeterminate property is absent" <|
                \_ ->
                    circularNode [ Progress.value 50 ]
                        |> Node.findProperty "indeterminate"
                        |> Expect.equal Nothing
            ]
        ]
