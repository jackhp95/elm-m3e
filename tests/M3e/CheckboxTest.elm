module M3e.CheckboxTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Checkbox as Checkbox
import M3e.Element as Element
import M3e.Node as Node exposing (Node)
import Test exposing (Test, describe, test)


node : List (Checkbox.Option msg) -> Node msg
node opts =
    Checkbox.view { name = "Accept terms" } opts |> Element.toNode


suite : Test
suite =
    describe "M3e.Checkbox — view-style port"
        [ test "renders <m3e-checkbox>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-checkbox")
        , test "aria-label equals the required name field" <|
            \_ ->
                Checkbox.view { name = "Subscribe to newsletter" } []
                    |> Element.toNode
                    |> Node.findAttribute "aria-label"
                    |> Expect.equal (Just "Subscribe to newsletter")
        , test "checked=true is visible as a DOM property" <|
            \_ ->
                node [ Checkbox.checked True ]
                    |> Node.findProperty "checked"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "checked=false is also emitted as a DOM property" <|
            \_ ->
                node [ Checkbox.checked False ]
                    |> Node.findProperty "checked"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "indeterminate=true is visible as a DOM property" <|
            \_ ->
                node [ Checkbox.indeterminate True ]
                    |> Node.findProperty "indeterminate"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "indeterminate emits false by default" <|
            \_ ->
                node []
                    |> Node.findProperty "indeterminate"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "disabled=true is visible as a DOM property" <|
            \_ ->
                node [ Checkbox.disabled True ]
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disabled emits false by default" <|
            \_ ->
                node []
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "checkbox is a leaf — no children" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 0
        ]
