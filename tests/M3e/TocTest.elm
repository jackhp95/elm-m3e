module M3e.TocTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable
import M3e.Toc as Toc
import Test exposing (Test, describe, test)


node : String -> List (Toc.Option msg) -> Node.Node msg
node forId opts =
    Toc.view { for = forId } opts |> Renderable.toNode


suite : Test
suite =
    describe "M3e.Toc — view-style port"
        [ test "renders <m3e-toc>" <|
            \_ ->
                node "content" []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-toc")
        , test "for attribute is introspectable" <|
            \_ ->
                node "page-content" []
                    |> Node.findAttribute "for"
                    |> Expect.equal (Just "page-content")
        , test "maxDepth is a DOM property — introspectable" <|
            \_ ->
                node "content" [ Toc.maxDepth 3 ]
                    |> Node.findProperty "max-depth"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "3")
        , test "maxDepth absent by default" <|
            \_ ->
                node "content" []
                    |> Node.findProperty "max-depth"
                    |> Expect.equal Nothing
        , test "title option injects a <span> with slot=title" <|
            \_ ->
                node "content" [ Toc.title "On this page" ]
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "title")
                    |> List.head
                    |> Maybe.map (\n -> ( Node.tagOf n, Node.findAttribute "slot" n ))
                    |> Expect.equal (Just ( Just "span", Just "title" ))
        , test "overline option injects a <span> with slot=overline" <|
            \_ ->
                node "content" [ Toc.overline "Contents" ]
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "overline")
                    |> List.head
                    |> Maybe.map (\n -> ( Node.tagOf n, Node.findAttribute "slot" n ))
                    |> Expect.equal (Just ( Just "span", Just "overline" ))
        , test "overline child contains the overline text" <|
            \_ ->
                node "content" [ Toc.overline "Chapter" ]
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "overline")
                    |> List.head
                    |> Maybe.andThen
                        (\n ->
                            case Node.childrenOf n of
                                (Node.Text s) :: _ ->
                                    Just s

                                _ ->
                                    Nothing
                        )
                    |> Expect.equal (Just "Chapter")
        , test "title and overline together — both children present" <|
            \_ ->
                node "content" [ Toc.title "On this page", Toc.overline "Docs" ]
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        ]
