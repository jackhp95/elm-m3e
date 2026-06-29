module M3e.SwitchTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element
import M3e.Node as Node exposing (Node)
import M3e.Switch as Switch
import M3e.Value as Value
import Test exposing (Test, describe, test)


node : List (Switch.Option msg) -> Node msg
node opts =
    Switch.view { ariaLabel = "Dark mode" } opts |> Element.toNode


suite : Test
suite =
    describe "M3e.Switch — view-style port"
        [ test "renders <m3e-switch>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-switch")
        , test "ariaLabel field is emitted as aria-label" <|
            \_ ->
                Switch.view { ariaLabel = "Email notifications" } []
                    |> Element.toNode
                    |> Node.findAttribute "aria-label"
                    |> Expect.equal (Just "Email notifications")
        , test "checked=true is visible as a DOM property" <|
            \_ ->
                node [ Switch.checked True ]
                    |> Node.findProperty "checked"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "checked=false is emitted as a DOM property" <|
            \_ ->
                node [ Switch.checked False ]
                    |> Node.findProperty "checked"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "disabled=true is visible as a DOM property" <|
            \_ ->
                node [ Switch.disabled True ]
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disabled emits false by default" <|
            \_ ->
                node []
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "icons None — no icons attr emitted (upstream default)" <|
            \_ ->
                node []
                    |> Node.findAttribute "icons"
                    |> Expect.equal Nothing
        , test "icons Selected — icons attr absent (RawAttr; not introspectable via findAttribute)" <|
            -- RawAttr is opaque; we can only verify the option compiles and the
            -- total attr count increases relative to the baseline.
            \_ ->
                let
                    withIcons : Int
                    withIcons =
                        node [ Switch.icons Value.selected ]
                            |> attrsOf
                            |> List.length

                    withoutIcons : Int
                    withoutIcons =
                        node []
                            |> attrsOf
                            |> List.length
                in
                withIcons
                    |> Expect.equal (withoutIcons + 1)
        , test "icons Both — icons attr absent (RawAttr; not introspectable via findAttribute)" <|
            \_ ->
                let
                    withIcons : Int
                    withIcons =
                        node [ Switch.icons Value.both ]
                            |> attrsOf
                            |> List.length

                    withoutIcons : Int
                    withoutIcons =
                        node []
                            |> attrsOf
                            |> List.length
                in
                withIcons
                    |> Expect.equal (withoutIcons + 1)
        , test "switch is a leaf — no children" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 0
        , test "name option emits name attribute (FormAssociated)" <|
            \_ ->
                node [ Switch.name "notifications" ]
                    |> Node.findAttribute "name"
                    |> Expect.equal (Just "notifications")
        , test "value option emits value attribute (FormAssociated, default on)" <|
            \_ ->
                node [ Switch.value "enabled" ]
                    |> Node.findAttribute "value"
                    |> Expect.equal (Just "enabled")
        , test "no name option — no name attribute emitted" <|
            \_ ->
                node []
                    |> Node.findAttribute "name"
                    |> Expect.equal Nothing
        ]


attrsOf : Node msg -> List (Node.Attr msg)
attrsOf n =
    case n of
        Node.Element el ->
            el.attrs

        _ ->
            []
