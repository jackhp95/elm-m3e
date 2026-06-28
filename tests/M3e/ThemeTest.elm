module M3e.ThemeTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element
import M3e.Node as Node exposing (Node)
import M3e.Text as Text
import M3e.Theme as Theme
import M3e.Value as Value
import Test exposing (Test, describe, test)


node : List (Theme.Option msg) -> Node msg
node opts =
    Theme.view { content = [] } opts |> Element.toNode


suite : Test
suite =
    describe "M3e.Theme — view-style port"
        [ test "renders <m3e-theme>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-theme")
        , test "content children land inside the element" <|
            \_ ->
                Theme.view
                    { content = [ Text.bodyLarge "Hello" ] }
                    []
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "p")
        , test "density is a DOM property — introspectable" <|
            \_ ->
                node [ Theme.density -1 ]
                    |> Node.findProperty "density"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "-1")
        , test "density absent by default" <|
            \_ ->
                node []
                    |> Node.findProperty "density"
                    |> Expect.equal Nothing
        , test "strongFocus is a DOM property — introspectable" <|
            \_ ->
                node [ Theme.strongFocus True ]
                    |> Node.findProperty "strongFocus"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "strongFocus absent by default" <|
            \_ ->
                node []
                    |> Node.findProperty "strongFocus"
                    |> Expect.equal Nothing
        , test "seedColor option does not crash (rawAttr — not introspectable)" <|
            \_ ->
                node [ Theme.seedColor "#ff0000" ]
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-theme")
        , test "scheme option does not crash (rawAttr — not introspectable)" <|
            \_ ->
                node [ Theme.scheme Theme.Dark ]
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-theme")
        , test "variant option does not crash (rawAttr — not introspectable)" <|
            \_ ->
                node [ Theme.variant Value.vibrant ]
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-theme")
        , test "contrast option does not crash (rawAttr — not introspectable)" <|
            \_ ->
                node [ Theme.contrast Theme.High ]
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-theme")
        , test "motion option does not crash (rawAttr — not introspectable)" <|
            \_ ->
                node [ Theme.motion Theme.MotionExpressive ]
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-theme")
        ]
