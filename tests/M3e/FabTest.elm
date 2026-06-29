module M3e.FabTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element
import M3e.Fab as Fab
import M3e.Node as Node exposing (Node)
import M3e.Value as Value
import Test exposing (Test, describe, test)


node : String -> List (Fab.Option msg) -> Node msg
node icon opts =
    Fab.view { icon = icon, ariaLabel = "Add item" } opts |> Element.toNode


suite : Test
suite =
    describe "M3e.Fab — view-style port"
        [ test "renders <m3e-fab>" <|
            \_ ->
                node "add" []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-fab")
        , test "ariaLabel field is emitted as aria-label" <|
            \_ ->
                Fab.view { icon = "add", ariaLabel = "Create note" } []
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
        , test "no label → extended property emits false" <|
            \_ ->
                node "add" []
                    |> Node.findProperty "extended"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "no disabled → disabled emits false by default" <|
            \_ ->
                node "add" []
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "name option emits name attribute (FormSubmitter)" <|
            \_ ->
                node "add" [ Fab.name "create" ]
                    |> Node.findAttribute "name"
                    |> Expect.equal (Just "create")
        , test "value option emits value attribute (FormSubmitter)" <|
            \_ ->
                node "add" [ Fab.value "item" ]
                    |> Node.findAttribute "value"
                    |> Expect.equal (Just "item")
        , test "formType Submit emits type=submit (FormSubmitter)" <|
            \_ ->
                node "add" [ Fab.formType Value.submit ]
                    |> Node.findAttribute "type"
                    |> Expect.equal (Just "submit")
        , test "formType Reset emits type=reset (FormSubmitter)" <|
            \_ ->
                node "add" [ Fab.formType Value.reset ]
                    |> Node.findAttribute "type"
                    |> Expect.equal (Just "reset")
        , test "formType Button emits type=button (FormSubmitter)" <|
            \_ ->
                node "add" [ Fab.formType Value.button ]
                    |> Node.findAttribute "type"
                    |> Expect.equal (Just "button")
        , test "no formType — no type attribute emitted by default" <|
            \_ ->
                node "add" []
                    |> Node.findAttribute "type"
                    |> Expect.equal Nothing
        ]
