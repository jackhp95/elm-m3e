module M3e.ToolbarTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Button as Button
import M3e.Element as Element
import M3e.Node as Node exposing (Node)
import M3e.Toolbar as Toolbar
import Test exposing (Test, describe, test)


node : List (Toolbar.Option msg) -> Node msg
node opts =
    Toolbar.view { content = [] } opts
        |> Element.toNode


suite : Test
suite =
    describe "M3e.Toolbar — view-style port"
        [ test "renders <m3e-toolbar>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-toolbar")
        , test "elevated=true is a DOM property — introspectable" <|
            \_ ->
                node [ Toolbar.elevated True ]
                    |> Node.findProperty "elevated"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "elevated absent by default" <|
            \_ ->
                node []
                    |> Node.findProperty "elevated"
                    |> Expect.equal Nothing
        , test "vertical=true is a DOM property — introspectable" <|
            \_ ->
                node [ Toolbar.vertical True ]
                    |> Node.findProperty "vertical"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "vertical absent by default" <|
            \_ ->
                node []
                    |> Node.findProperty "vertical"
                    |> Expect.equal Nothing
        , test "content children land in default slot (no slot attribute)" <|
            \_ ->
                Toolbar.view
                    { content =
                        [ Button.view { label = "Save", variant = Button.Filled } []
                        , Button.view { label = "Discard", variant = Button.Text } []
                        ]
                    }
                    []
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        , test "content children carry no injected slot" <|
            \_ ->
                Toolbar.view
                    { content =
                        [ Button.view { label = "Save", variant = Button.Filled } [] ]
                    }
                    []
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal Nothing
        , test "children are m3e-button when buttons are passed" <|
            \_ ->
                Toolbar.view
                    { content =
                        [ Button.view { label = "X", variant = Button.Text } [] ]
                    }
                    []
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.filterMap Node.tagOf
                    |> Expect.equal [ "m3e-button" ]
        , test "html escape is accepted in content (free row)" <|
            \_ ->
                Toolbar.view
                    { content =
                        [ Element.html (Node.toHtml (Node.text "divider")) ]
                    }
                    []
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 1
        ]
