module M3e.IconTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element
import M3e.Icon as Icon
import M3e.Node as Node exposing (Node)
import M3e.Value as Value
import Test exposing (Test, describe, test)


node : String -> List (Icon.Option msg) -> Node msg
node name opts =
    Icon.view { name = name } opts |> Element.toNode


suite : Test
suite =
    describe "M3e.Icon — visual axes (fix #66)"
        [ -- Name (always required)
          test "name sets the name attribute" <|
            \_ ->
                node "home" []
                    |> Node.findAttribute "name"
                    |> Expect.equal (Just "home")
        , test "renders <m3e-icon>" <|
            \_ ->
                node "home" []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-icon")

        -- Default axes: not emitted unless specified (leave upstream defaults intact)
        , test "no variant option — no variant attribute by default" <|
            \_ ->
                node "home" []
                    |> Node.findAttribute "variant"
                    |> Expect.equal Nothing
        , test "no grade option — no grade attribute by default" <|
            \_ ->
                node "home" []
                    |> Node.findAttribute "grade"
                    |> Expect.equal Nothing
        , test "no weight option — no weight attribute by default" <|
            \_ ->
                node "home" []
                    |> Node.findAttribute "weight"
                    |> Expect.equal Nothing
        , test "no opticalSize option — no optical-size attribute by default" <|
            \_ ->
                node "home" []
                    |> Node.findAttribute "optical-size"
                    |> Expect.equal Nothing
        , test "no filled option — filled property emits false by default" <|
            \_ ->
                node "home" []
                    |> Node.findProperty "filled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")

        -- Variant
        , test "variant Outlined emits variant=outlined" <|
            \_ ->
                node "home" [ Icon.variant Value.outlined ]
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "outlined")
        , test "variant Rounded emits variant=rounded" <|
            \_ ->
                node "home" [ Icon.variant Value.rounded ]
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "rounded")
        , test "variant Sharp emits variant=sharp" <|
            \_ ->
                node "home" [ Icon.variant Value.sharp ]
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "sharp")

        -- Grade
        , test "grade low emits grade=low" <|
            \_ ->
                node "home" [ Icon.grade Value.low ]
                    |> Node.findAttribute "grade"
                    |> Expect.equal (Just "low")
        , test "grade medium emits grade=medium" <|
            \_ ->
                node "home" [ Icon.grade Value.medium ]
                    |> Node.findAttribute "grade"
                    |> Expect.equal (Just "medium")
        , test "grade high emits grade=high" <|
            \_ ->
                node "home" [ Icon.grade Value.high ]
                    |> Node.findAttribute "grade"
                    |> Expect.equal (Just "high")

        -- Weight
        , test "weight W100 emits weight=100" <|
            \_ ->
                node "home" [ Icon.weight Icon.W100 ]
                    |> Node.findAttribute "weight"
                    |> Expect.equal (Just "100")
        , test "weight W400 emits weight=400" <|
            \_ ->
                node "home" [ Icon.weight Icon.W400 ]
                    |> Node.findAttribute "weight"
                    |> Expect.equal (Just "400")
        , test "weight W700 emits weight=700" <|
            \_ ->
                node "home" [ Icon.weight Icon.W700 ]
                    |> Node.findAttribute "weight"
                    |> Expect.equal (Just "700")

        -- Optical size
        , test "opticalSize 20 emits optical-size=20" <|
            \_ ->
                node "home" [ Icon.opticalSize 20 ]
                    |> Node.findAttribute "optical-size"
                    |> Expect.equal (Just "20")
        , test "opticalSize 48 emits optical-size=48" <|
            \_ ->
                node "home" [ Icon.opticalSize 48 ]
                    |> Node.findAttribute "optical-size"
                    |> Expect.equal (Just "48")

        -- Filled
        , test "filled True emits filled DOM property" <|
            \_ ->
                node "favorite" [ Icon.filled True ]
                    |> Node.findProperty "filled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "filled False — property emits false (resets on re-render)" <|
            \_ ->
                node "favorite" [ Icon.filled False ]
                    |> Node.findProperty "filled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        ]
