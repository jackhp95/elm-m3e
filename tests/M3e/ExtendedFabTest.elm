module M3e.ExtendedFabTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element
import M3e.ExtendedFab as ExtendedFab
import M3e.Node as Node exposing (Node)
import M3e.Value as Value
import Test exposing (Test, describe, test)


node : List (ExtendedFab.Option msg) -> Node msg
node opts =
    ExtendedFab.view
        { icon = "add", label = "Create note", variant = Value.primaryContainer }
        opts
        |> Element.toNode


suite : Test
suite =
    describe "M3e.ExtendedFab — view-style port"
        [ test "renders <m3e-fab>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-fab")
        , test "extended property is always True" <|
            \_ ->
                node []
                    |> Node.findProperty "extended"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "first child is <m3e-icon> for the icon glyph" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "m3e-icon")
        , test "second child is a <span> in slot=label" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.drop 1
                    |> List.head
                    |> Maybe.map
                        (\n ->
                            ( Node.tagOf n, Node.findAttribute "slot" n )
                        )
                    |> Expect.equal (Just ( Just "span", Just "label" ))
        , test "label text appears inside the label slot span" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.drop 1
                    |> List.head
                    |> Maybe.map Node.childrenOf
                    |> Maybe.andThen List.head
                    |> Maybe.andThen textContent
                    |> Expect.equal (Just "Create note")
        , test "disabled property is introspectable" <|
            \_ ->
                node [ ExtendedFab.disabled True ]
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "lowered property is introspectable" <|
            \_ ->
                node [ ExtendedFab.lowered True ]
                    |> Node.findProperty "lowered"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disabled emits false by default" <|
            \_ ->
                node []
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        ]


textContent : Node msg -> Maybe String
textContent n =
    case n of
        Node.Text s ->
            Just s

        _ ->
            Nothing
