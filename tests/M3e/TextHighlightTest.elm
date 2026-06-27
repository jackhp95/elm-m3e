module M3e.TextHighlightTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable as Renderable
import M3e.TextHighlight as TextHighlight
import Test exposing (Test, describe, test)


item : String -> Renderable.Renderable any msg
item tag =
    Internal.fromNode (Node.element tag [] [])


nodeWith : List (TextHighlight.Option msg) -> List (Renderable.Renderable any msg) -> Node.Node msg
nodeWith opts content =
    TextHighlight.view { content = content } opts |> Renderable.toNode


suite : Test
suite =
    describe "M3e.TextHighlight — view-style port"
        [ test "renders <m3e-text-highlight>" <|
            \_ ->
                nodeWith [] []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-text-highlight")
        , test "no content → zero children" <|
            \_ ->
                nodeWith [] []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 0
        , test "content items become children" <|
            \_ ->
                nodeWith [] [ item "span", item "em" ]
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        , test "caseSensitive=True is a DOM property — introspectable" <|
            \_ ->
                nodeWith [ TextHighlight.caseSensitive True ] []
                    |> Node.findProperty "caseSensitive"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "caseSensitive absent by default" <|
            \_ ->
                nodeWith [] []
                    |> Node.findProperty "caseSensitive"
                    |> Expect.equal Nothing
        , test "disabled=True is a DOM property — introspectable" <|
            \_ ->
                nodeWith [ TextHighlight.disabled True ] []
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disabled absent by default" <|
            \_ ->
                nodeWith [] []
                    |> Node.findProperty "disabled"
                    |> Expect.equal Nothing
        , test "term option does not crash (rawAttr — not introspectable)" <|
            \_ ->
                nodeWith [ TextHighlight.term "hello" ] []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-text-highlight")
        , test "mode StartsWith does not crash (rawAttr — not introspectable)" <|
            \_ ->
                nodeWith [ TextHighlight.mode TextHighlight.StartsWith ] []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-text-highlight")
        , test "mode EndsWith does not crash" <|
            \_ ->
                nodeWith [ TextHighlight.mode TextHighlight.EndsWith ] []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-text-highlight")
        ]
