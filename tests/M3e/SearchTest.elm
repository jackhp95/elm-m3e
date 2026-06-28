module M3e.SearchTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element
import M3e.Icon as Icon
import M3e.Node as Node exposing (Node)
import M3e.Search as Search
import Test exposing (Test, describe, test)


node : String -> List (Search.Option msg) -> Node msg
node placeholder opts =
    Search.view { placeholder = placeholder } opts |> Element.toNode


suite : Test
suite =
    describe "M3e.Search — expanded surface"
        [ test "renders m3e-search-bar at root" <|
            \_ ->
                node "Search" []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-search-bar")
        , test "input child exists with slot=input" <|
            \_ ->
                node "Search" []
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "input")
                    |> List.length
                    |> Expect.equal 1
        , test "placeholder rides the input child" <|
            \_ ->
                node "Search suppliers" []
                    |> Node.childrenOf
                    |> List.filterMap (Node.findAttribute "placeholder")
                    |> Expect.equal [ "Search suppliers" ]
        , test "clearable is a DOM property when set" <|
            \_ ->
                node "Search" [ Search.clearable True ]
                    |> Node.findProperty "clearable"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "clearLabel emits clear-label attribute" <|
            \_ ->
                node "Search" [ Search.clearLabel "Clear search" ]
                    |> Node.findAttribute "clear-label"
                    |> Expect.equal (Just "Clear search")
        , test "leadingIcon child is slotted into slot=leading" <|
            \_ ->
                node "Search" [ Search.leadingIcon (Icon.view { name = "search" } []) ]
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "leading")
                    |> List.length
                    |> Expect.equal 1
        , test "trailingIcon child is slotted into slot=trailing" <|
            \_ ->
                node "Search" [ Search.trailingIcon (Icon.view { name = "mic" } []) ]
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "trailing")
                    |> List.length
                    |> Expect.equal 1
        , test "parent can inject id onto the root element (FieldTest compat)" <|
            \_ ->
                node "Query" []
                    |> Node.setAttribute "id" "field-q"
                    |> Node.findAttribute "id"
                    |> Expect.equal (Just "field-q")
        ]
