module M3e.SliderTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable
import M3e.Slider as Slider
import Test exposing (Test, describe, test)


node : List (Slider.Option msg) -> Node.Node msg
node opts =
    Slider.view { name = "Volume" } opts |> Renderable.toNode


suite : Test
suite =
    describe "M3e.Slider — view-style port"
        [ test "renders <m3e-slider>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-slider")
        , test "aria-label equals the required name field" <|
            \_ ->
                node []
                    |> Node.findAttribute "aria-label"
                    |> Expect.equal (Just "Volume")
        , test "has exactly one thumb child (<m3e-slider-thumb>)" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.filterMap Node.tagOf
                    |> Expect.equal [ "m3e-slider-thumb" ]
        , test "min is visible as a DOM property (Float)" <|
            \_ ->
                node [ Slider.min 10 ]
                    |> Node.findProperty "min"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "10")
        , test "max is visible as a DOM property (Float)" <|
            \_ ->
                node [ Slider.max 200 ]
                    |> Node.findProperty "max"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "200")
        , test "step is visible as a DOM property (Float)" <|
            \_ ->
                node [ Slider.step 5 ]
                    |> Node.findProperty "step"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "5")
        , test "discrete=true is visible as a DOM property" <|
            \_ ->
                node [ Slider.discrete True ]
                    |> Node.findProperty "discrete"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "discrete absent by default" <|
            \_ ->
                node []
                    |> Node.findProperty "discrete"
                    |> Expect.equal Nothing
        , test "disabled=true is visible as a DOM property" <|
            \_ ->
                node [ Slider.disabled True ]
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "value option is set as a property on the thumb child" <|
            \_ ->
                node [ Slider.value 42 ]
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findProperty "value")
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "\"42\"")
        , test "value absent from thumb when option not provided" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findProperty "value")
                    |> Expect.equal Nothing
        ]
