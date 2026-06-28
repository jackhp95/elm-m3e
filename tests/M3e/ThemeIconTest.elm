module M3e.ThemeIconTest exposing (suite)

import Expect
import M3e.Element as Element
import M3e.Node as Node exposing (Node)
import M3e.ThemeIcon as ThemeIcon
import Test exposing (Test, describe, test)


node : List (ThemeIcon.Option msg) -> Node msg
node opts =
    ThemeIcon.view opts |> Element.toNode


suite : Test
suite =
    describe "M3e.ThemeIcon — view-style port"
        [ test "renders <m3e-theme-icon>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-theme-icon")
        , test "theme-icon is a leaf — no children" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 0
        , test "color sets the introspectable attribute" <|
            \_ ->
                node [ ThemeIcon.color "#ff0000" ]
                    |> Node.findAttribute "color"
                    |> Expect.equal (Just "#ff0000")
        , test "color is absent by default" <|
            \_ ->
                node []
                    |> Node.findAttribute "color"
                    |> Expect.equal Nothing
        , test "scheme Dark sets attribute to \"dark\"" <|
            \_ ->
                node [ ThemeIcon.scheme ThemeIcon.Dark ]
                    |> Node.findAttribute "scheme"
                    |> Expect.equal (Just "dark")
        , test "scheme Light sets attribute to \"light\"" <|
            \_ ->
                node [ ThemeIcon.scheme ThemeIcon.Light ]
                    |> Node.findAttribute "scheme"
                    |> Expect.equal (Just "light")
        , test "scheme Auto sets attribute to \"auto\"" <|
            \_ ->
                node [ ThemeIcon.scheme ThemeIcon.Auto ]
                    |> Node.findAttribute "scheme"
                    |> Expect.equal (Just "auto")
        , test "scheme is absent by default" <|
            \_ ->
                node []
                    |> Node.findAttribute "scheme"
                    |> Expect.equal Nothing
        , test "variant TonalSpot sets attribute to \"tonal-spot\"" <|
            \_ ->
                node [ ThemeIcon.variant ThemeIcon.TonalSpot ]
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "tonal-spot")
        , test "variant FruitSalad sets attribute to \"fruit-salad\"" <|
            \_ ->
                node [ ThemeIcon.variant ThemeIcon.FruitSalad ]
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "fruit-salad")
        , test "variant is absent by default" <|
            \_ ->
                node []
                    |> Node.findAttribute "variant"
                    |> Expect.equal Nothing
        ]
