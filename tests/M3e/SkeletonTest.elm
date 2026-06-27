module M3e.SkeletonTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element exposing (Element)
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)
import M3e.Skeleton as Skeleton
import Test exposing (Test, describe, test)


item : String -> Element any msg
item tag =
    Internal.fromNode (Node.element tag [] [])


nodeWith : List (Skeleton.Option msg) -> List (Element any msg) -> Node msg
nodeWith opts content =
    Skeleton.view { content = content } opts |> Element.toNode


suite : Test
suite =
    describe "M3e.Skeleton — view-style port"
        [ test "renders <m3e-skeleton>" <|
            \_ ->
                nodeWith [] []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-skeleton")
        , test "no content → zero children" <|
            \_ ->
                nodeWith [] []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 0
        , test "content items become children" <|
            \_ ->
                nodeWith [] [ item "div", item "span" ]
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        , test "loaded=True is a DOM property — introspectable" <|
            \_ ->
                nodeWith [ Skeleton.loaded True ] []
                    |> Node.findProperty "loaded"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "loaded absent by default" <|
            \_ ->
                nodeWith [] []
                    |> Node.findProperty "loaded"
                    |> Expect.equal Nothing
        , test "shape option does not crash (rawAttr — not introspectable)" <|
            \_ ->
                nodeWith [ Skeleton.shape Skeleton.Circular ] []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-skeleton")
        , test "animation option does not crash (rawAttr — not introspectable)" <|
            \_ ->
                nodeWith [ Skeleton.animation Skeleton.Pulse ] []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-skeleton")
        ]
