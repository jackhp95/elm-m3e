module M3e.AppBarTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.AppBar as AppBar
import M3e.Heading as Heading
import M3e.IconButton as IB
import M3e.Node as Node
import M3e.Renderable as Renderable
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "M3e.AppBar — expanded surface"
        [ test "trailing injects slot=trailing on first child" <|
            \_ ->
                AppBar.view
                    [ AppBar.trailing
                        [ IB.view { icon = "more_vert", name = "More" } [] ]
                    ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "trailing")
        , test "leading injects slot=leading" <|
            \_ ->
                AppBar.view
                    [ AppBar.leading (IB.view { icon = "menu", name = "Menu" } []) ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "leading")
        , test "title injects slot=title" <|
            \_ ->
                AppBar.view
                    [ AppBar.title
                        (Heading.view { label = "My App", variant = Heading.Title } [])
                    ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "title")
        , test "subtitle injects slot=subtitle" <|
            \_ ->
                AppBar.view
                    [ AppBar.subtitle
                        (Heading.view { label = "Dashboard", variant = Heading.Label } [])
                    ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "subtitle")
        , test "size emits size attribute" <|
            \_ ->
                AppBar.view [ AppBar.size AppBar.Large ]
                    |> Renderable.toNode
                    |> Node.findAttribute "size"
                    |> Expect.equal (Just "large")
        , test "centered emits centered DOM property" <|
            \_ ->
                AppBar.view [ AppBar.centered True ]
                    |> Renderable.toNode
                    |> Node.findProperty "centered"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "id emits id attribute" <|
            \_ ->
                AppBar.view [ AppBar.id "main-bar" ]
                    |> Renderable.toNode
                    |> Node.findAttribute "id"
                    |> Expect.equal (Just "main-bar")
        , test "element escape in leading slot carries slot=leading" <|
            \_ ->
                AppBar.view
                    [ AppBar.leading (Renderable.element { tag = "img" } [] []) ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "leading")
        ]
