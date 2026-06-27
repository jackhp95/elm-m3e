module M3e.ScrollContainerTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable as Renderable
import M3e.ScrollContainer as ScrollContainer
import Test exposing (Test, describe, test)


contentItem : Renderable.Renderable any msg
contentItem =
    Internal.fromNode (Node.element "p" [] [ Node.text "Some content" ])


node : List (ScrollContainer.Option msg) -> Node.Node msg
node opts =
    ScrollContainer.view { content = [ contentItem, contentItem ] } opts
        |> Renderable.toNode


suite : Test
suite =
    describe "M3e.ScrollContainer — view-style port"
        [ test "renders <m3e-scroll-container>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-scroll-container")
        , test "dividers attribute defaults to 'above-below'" <|
            \_ ->
                node []
                    |> Node.findAttribute "dividers"
                    |> Expect.equal (Just "above-below")
        , test "dividers attribute can be overridden" <|
            \_ ->
                node [ ScrollContainer.dividers ScrollContainer.None ]
                    |> Node.findAttribute "dividers"
                    |> Expect.equal (Just "none")
        , test "dividers Above renders 'above'" <|
            \_ ->
                node [ ScrollContainer.dividers ScrollContainer.Above ]
                    |> Node.findAttribute "dividers"
                    |> Expect.equal (Just "above")
        , test "dividers Below renders 'below'" <|
            \_ ->
                node [ ScrollContainer.dividers ScrollContainer.Below ]
                    |> Node.findAttribute "dividers"
                    |> Expect.equal (Just "below")
        , test "thin=true is a DOM property — introspectable" <|
            \_ ->
                node [ ScrollContainer.thin True ]
                    |> Node.findProperty "thin"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "thin absent by default" <|
            \_ ->
                node []
                    |> Node.findProperty "thin"
                    |> Expect.equal Nothing
        , test "content children are rendered in the default slot" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        , test "each content child is a <p>" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.filterMap Node.tagOf
                    |> Expect.equal [ "p", "p" ]
        ]
