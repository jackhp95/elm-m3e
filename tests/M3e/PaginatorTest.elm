module M3e.PaginatorTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Paginator as Paginator
import M3e.Renderable as Renderable
import Test exposing (Test, describe, test)


node : List (Paginator.Option msg) -> Node.Node msg
node opts =
    Paginator.view { length = 300 } opts
        |> Renderable.toNode


suite : Test
suite =
    describe "M3e.Paginator — view-style port"
        [ test "renders <m3e-paginator>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-paginator")
        , test "length is a DOM property — introspectable" <|
            \_ ->
                node []
                    |> Node.findProperty "length"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "300")
        , test "pageIndex is a DOM property when set" <|
            \_ ->
                node [ Paginator.pageIndex 2 ]
                    |> Node.findProperty "page-index"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "2")
        , test "pageIndex absent by default" <|
            \_ ->
                node []
                    |> Node.findProperty "page-index"
                    |> Expect.equal Nothing
        , test "disabled is a DOM property" <|
            \_ ->
                node [ Paginator.disabled True ]
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disabled absent by default" <|
            \_ ->
                node []
                    |> Node.findProperty "disabled"
                    |> Expect.equal Nothing
        , test "showFirstLastButtons is a DOM property" <|
            \_ ->
                node [ Paginator.showFirstLastButtons True ]
                    |> Node.findProperty "show-first-last-buttons"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "hidePageSize is a DOM property" <|
            \_ ->
                node [ Paginator.hidePageSize True ]
                    |> Node.findProperty "hide-page-size"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "pageSizes is a string attribute (not property)" <|
            \_ ->
                node [ Paginator.pageSizes "10,25,50" ]
                    |> Node.findAttribute "page-sizes"
                    |> Expect.equal (Just "10,25,50")
        , test "paginator is a leaf — no children" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 0
        ]
