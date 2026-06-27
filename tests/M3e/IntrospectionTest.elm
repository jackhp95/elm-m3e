module M3e.IntrospectionTest exposing (suite)

import Expect
import Html
import Json.Encode as Encode
import M3e.AppBar as AppBar
import M3e.Card as Card
import M3e.Chip as Chip
import M3e.Element as Element
import M3e.IconButton as IconButton
import M3e.Node as Node
import M3e.Search as Search
import Test exposing (Test, describe, test)


firstChild : Node.Node msg -> Maybe (Node.Node msg)
firstChild node =
    Node.childrenOf node |> List.head


suite : Test
suite =
    describe "Ux IR — introspection, the view-style model, and the escapes"
        [ test "a DOM property is visible as data — Test.Html cannot do this" <|
            \_ ->
                IconButton.view { icon = "delete", name = "Delete" } [ IconButton.selected True ]
                    |> Element.toNode
                    |> Node.findProperty "selected"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "required a11y name lands as aria-label" <|
            \_ ->
                IconButton.view { icon = "delete", name = "Delete items" } []
                    |> Element.toNode
                    |> Node.findAttribute "aria-label"
                    |> Expect.equal (Just "Delete items")
        , test "no-lift heterogeneous slot folds like Html; parent injects slot=" <|
            \_ ->
                AppBar.view
                    [ AppBar.trailing
                        [ Search.view { placeholder = "Search" } [ Search.onInput identity ]
                        , IconButton.view { icon = "more_vert", name = "More" } [ IconButton.onClick "x" ]
                        ]
                    ]
                    |> Element.toNode
                    |> firstChild
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "trailing")
        , test "element escape in a named slot DOES carry the injected slot (C+D)" <|
            \_ ->
                AppBar.view
                    [ AppBar.trailing [ Element.element { tag = "div" } [] [ Node.text "Custom" ] ] ]
                    |> Element.toNode
                    |> firstChild
                    |> Maybe.map (\n -> ( Node.tagOf n, Node.findAttribute "slot" n ))
                    |> Expect.equal (Just ( Just "div", Just "trailing" ))
        , test "html escape lives happily in a default-slot region" <|
            \_ ->
                Card.view
                    [ Card.body
                        [ Chip.view { label = "Featured" } []
                        , Element.html (Html.text "raw escape")
                        ]
                    ]
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        ]
