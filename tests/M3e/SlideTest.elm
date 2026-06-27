module M3e.SlideTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element
import M3e.Node as Node
import M3e.Slide as Slide
import M3e.Text as Text
import Test exposing (Test, describe, test)


groupNode : List (Slide.Option msg) -> Node.Node msg
groupNode opts =
    Slide.view
        { slides =
            [ Slide.slide [ Text.bodyLarge "Slide 1" ]
            , Slide.slide [ Text.bodyLarge "Slide 2" ]
            ]
        }
        opts
        |> Element.toNode


suite : Test
suite =
    describe "M3e.Slide — view-style port"
        [ test "view renders <m3e-slide-group>" <|
            \_ ->
                groupNode []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-slide-group")
        , test "slide helper renders <m3e-slide>" <|
            \_ ->
                Slide.slide [ Text.bodyLarge "Content" ]
                    |> Element.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-slide")
        , test "slides become direct children of the group" <|
            \_ ->
                groupNode []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        , test "each child of the group is an <m3e-slide>" <|
            \_ ->
                groupNode []
                    |> Node.childrenOf
                    |> List.map Node.tagOf
                    |> Expect.equal [ Just "m3e-slide", Just "m3e-slide" ]
        , test "slide content lands inside the <m3e-slide>" <|
            \_ ->
                Slide.slide [ Text.bodyLarge "Hello" ]
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "p")
        , test "disabled is a DOM property — introspectable" <|
            \_ ->
                groupNode [ Slide.disabled True ]
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disabled absent by default" <|
            \_ ->
                groupNode []
                    |> Node.findProperty "disabled"
                    |> Expect.equal Nothing
        , test "vertical is a DOM property — introspectable" <|
            \_ ->
                groupNode [ Slide.vertical True ]
                    |> Node.findProperty "vertical"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "threshold is a DOM property — introspectable" <|
            \_ ->
                groupNode [ Slide.threshold 32 ]
                    |> Node.findProperty "threshold"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "32")
        ]
