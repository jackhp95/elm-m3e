module M3e.SliderTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element
import M3e.Node as Node exposing (Attr(..), Node(..))
import M3e.Slider as Slider
import Test exposing (Test, describe, test)


node : List (Slider.Option msg) -> Node msg
node opts =
    Slider.view { name = "Volume" } opts |> Element.toNode


thumbNode : List (Slider.Option msg) -> Maybe (Node msg)
thumbNode opts =
    node opts |> Node.childrenOf |> List.head


{-| Count RawAttr (opaque event listeners) on a node.
-}
countRawAttrs : Node msg -> Int
countRawAttrs n =
    case n of
        Element { attrs } ->
            List.length
                (List.filter
                    (\a ->
                        case a of
                            RawAttr _ ->
                                True

                            _ ->
                                False
                    )
                    attrs
                )

        _ ->
            0


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
        , test "discrete emits false by default" <|
            \_ ->
                node []
                    |> Node.findProperty "discrete"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
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
                    |> Expect.equal (Just "42")
        , test "value absent from thumb when option not provided" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findProperty "value")
                    |> Expect.equal Nothing
        , test "onChange wires a 'change' (committed) listener on the thumb" <|
            \_ ->
                -- Committed change event: fires once when drag is released.
                -- Without onChange, thumb has 0 RawAttrs; with it, 1+.
                let
                    withoutHandler : Int
                    withoutHandler =
                        thumbNode [] |> Maybe.map countRawAttrs |> Maybe.withDefault 0

                    withHandler : Int
                    withHandler =
                        thumbNode [ Slider.onChange (\_ -> ()) ] |> Maybe.map countRawAttrs |> Maybe.withDefault 0
                in
                Expect.all
                    [ \_ -> withoutHandler |> Expect.equal 0
                    , \_ -> withHandler |> Expect.greaterThan 0
                    ]
                    ()
        , test "onInput wires a 'input' (live) listener on the thumb" <|
            \_ ->
                -- Live input event: fires continuously during drag.
                -- Without onInput, thumb has 0 RawAttrs; with it, 1+.
                let
                    withoutHandler : Int
                    withoutHandler =
                        thumbNode [] |> Maybe.map countRawAttrs |> Maybe.withDefault 0

                    withHandler : Int
                    withHandler =
                        thumbNode [ Slider.onInput (\_ -> ()) ] |> Maybe.map countRawAttrs |> Maybe.withDefault 0
                in
                Expect.all
                    [ \_ -> withoutHandler |> Expect.equal 0
                    , \_ -> withHandler |> Expect.greaterThan 0
                    ]
                    ()
        , test "onChange and onInput produce independent listeners on the thumb" <|
            \_ ->
                -- Both onChange and onInput each add one RawAttr.
                thumbNode [ Slider.onChange (\_ -> ()), Slider.onInput (\_ -> ()) ]
                    |> Maybe.map countRawAttrs
                    |> Expect.equal (Just 2)
        ]
