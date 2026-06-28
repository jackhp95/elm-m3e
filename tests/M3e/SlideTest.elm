module M3e.SlideTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element
import M3e.Node as Node exposing (Node)
import M3e.Slide as Slide
import M3e.Text as Text
import Test exposing (Test, describe, test)



-- Helpers -----------------------------------------------------------------


slideNode : List (Slide.Option msg) -> Node msg
slideNode opts =
    Slide.view
        { items =
            [ Text.bodyLarge "Slide 1"
            , Text.bodyLarge "Slide 2"
            ]
        }
        opts
        |> Element.toNode


groupNode : List (Slide.SlideGroupOption msg) -> Node msg
groupNode opts =
    Slide.slideGroup
        { content =
            [ Text.bodyLarge "Item 1"
            , Text.bodyLarge "Item 2"
            ]
        }
        opts
        |> Element.toNode


suite : Test
suite =
    describe "M3e.Slide"
        [ -- ── m3e-slide (standalone carousel) ──────────────────────────
          describe "view (<m3e-slide> standalone carousel)"
            [ test "view renders <m3e-slide>" <|
                \_ ->
                    slideNode []
                        |> Node.tagOf
                        |> Expect.equal (Just "m3e-slide")
            , test "items become direct children of <m3e-slide>" <|
                \_ ->
                    slideNode []
                        |> Node.childrenOf
                        |> List.length
                        |> Expect.equal 2
            , test "item content lands inside <m3e-slide> (no wrapping element)" <|
                \_ ->
                    Slide.view { items = [ Text.bodyLarge "Hello" ] } []
                        |> Element.toNode
                        |> Node.childrenOf
                        |> List.head
                        |> Maybe.andThen Node.tagOf
                        -- Text.bodyLarge renders a <p> tag
                        |> Expect.equal (Just "p")
            , test "selectedIndex sets selected-index DOM property" <|
                \_ ->
                    slideNode [ Slide.selectedIndex 2 ]
                        |> Node.findProperty "selectedIndex"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "2")
            , test "selectedIndex=0 sets the property" <|
                \_ ->
                    slideNode [ Slide.selectedIndex 0 ]
                        |> Node.findProperty "selectedIndex"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "0")
            , test "selected-index is absent by default (null semantics — not set)" <|
                \_ ->
                    -- Without selectedIndex option the property is not emitted at all,
                    -- preserving the upstream default of null (inert carousel).
                    slideNode []
                        |> Node.findProperty "selectedIndex"
                        |> Expect.equal Nothing
            ]

        -- ── m3e-slide-group (scroll wrapper) ─────────────────────────
        , describe "slideGroup (<m3e-slide-group> scroll wrapper)"
            [ test "slideGroup renders <m3e-slide-group>" <|
                \_ ->
                    groupNode []
                        |> Node.tagOf
                        |> Expect.equal (Just "m3e-slide-group")
            , test "content items become direct children of <m3e-slide-group>" <|
                \_ ->
                    groupNode []
                        |> Node.childrenOf
                        |> List.length
                        |> Expect.equal 2
            , test "disabled is a DOM property — introspectable" <|
                \_ ->
                    groupNode [ Slide.disabled True ]
                        |> Node.findProperty "disabled"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            , test "disabled emits false by default" <|
                \_ ->
                    groupNode []
                        |> Node.findProperty "disabled"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "false")
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
            , test "nextPageLabel sets the next-page-label attribute" <|
                \_ ->
                    groupNode [ Slide.nextPageLabel "Scroll right" ]
                        |> Node.findAttribute "next-page-label"
                        |> Expect.equal (Just "Scroll right")
            , test "previousPageLabel sets the previous-page-label attribute" <|
                \_ ->
                    groupNode [ Slide.previousPageLabel "Scroll left" ]
                        |> Node.findAttribute "previous-page-label"
                        |> Expect.equal (Just "Scroll left")
            , test "slideGroup accepts arbitrary content (not typed m3e-slide children)" <|
                \_ ->
                    -- Content is any element — here Text nodes, not m3e-slide wrappers.
                    groupNode []
                        |> Node.childrenOf
                        |> List.map Node.tagOf
                        |> Expect.equal [ Just "p", Just "p" ]
            ]
        ]
