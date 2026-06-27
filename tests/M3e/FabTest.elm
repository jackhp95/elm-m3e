module M3e.FabTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element
import M3e.Fab as Fab
import M3e.Node as Node
import Test exposing (Test, describe, test)


node : String -> List (Fab.Option msg) -> Node.Node msg
node icon opts =
    Fab.view { icon = icon, name = "Add item" } opts |> Element.toNode


suite : Test
suite =
    describe "M3e.Fab — view-style port"
        [ test "renders <m3e-fab>" <|
            \_ ->
                node "add" []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-fab")
        , test "aria-label equals the required name field" <|
            \_ ->
                Fab.view { icon = "add", name = "Create note" } []
                    |> Element.toNode
                    |> Node.findAttribute "aria-label"
                    |> Expect.equal (Just "Create note")
        , test "disabled is a DOM property — introspectable" <|
            \_ ->
                node "add" [ Fab.disabled True ]
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "lowered is a DOM property — introspectable" <|
            \_ ->
                node "add" [ Fab.lowered True ]
                    |> Node.findProperty "lowered"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "icon child is an <m3e-icon> in the default slot" <|
            \_ ->
                node "edit" []
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "m3e-icon")
        , test "icon child carries the correct name attribute" <|
            \_ ->
                node "edit" []
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "name")
                    |> Expect.equal (Just "edit")
        , test "label option sets extended property to true" <|
            \_ ->
                node "add" [ Fab.label "Create" ]
                    |> Node.findProperty "extended"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "label option injects a child with slot=label" <|
            \_ ->
                node "add" [ Fab.label "Create" ]
                    |> Node.childrenOf
                    |> List.drop 1
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "label")
        , test "no label → extended property is absent" <|
            \_ ->
                node "add" []
                    |> Node.findProperty "extended"
                    |> Expect.equal Nothing
        , test "no disabled → disabled property is absent" <|
            \_ ->
                node "add" []
                    |> Node.findProperty "disabled"
                    |> Expect.equal Nothing
        ]
