module M3e.ShapeTest exposing (suite)

import Cem.M3e.Shape
import Expect
import M3e.Element as Element exposing (Element)
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)
import M3e.Shape as Shape
import Test exposing (Test, describe, test)


{-| Build a universally-typed content item via `fromNode` (the prototype exposes
this; in the published package it lives in an unexposed Internal module).
-}
item : String -> Element any msg
item tag =
    Internal.fromNode (Node.element tag [] [])


nodeWith : List (Shape.Option msg) -> List (Element any msg) -> Node msg
nodeWith opts content =
    Shape.view { content = content } opts |> Element.toNode


suite : Test
suite =
    describe "M3e.Shape — view-style port"
        [ test "renders <m3e-shape>" <|
            \_ ->
                nodeWith [] []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-shape")
        , test "no content → zero children" <|
            \_ ->
                nodeWith [] []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 0
        , test "one content item → one child" <|
            \_ ->
                nodeWith [] [ item "img" ]
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 1
        , test "two content items → two children" <|
            \_ ->
                nodeWith [] [ item "img", item "span" ]
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        , test "name option does not crash (rawAttr — not introspectable)" <|
            \_ ->
                nodeWith [ Shape.name Cem.M3e.Shape.Circle ] []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-shape")
        ]
