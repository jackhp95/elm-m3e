module M3e.AppBarTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.AppBar as AppBar
import M3e.Element as Element
import M3e.Heading as Heading
import M3e.IconButton as IB
import M3e.Node as Node
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "M3e.AppBar — expanded surface"
        [ test "trailing injects slot=trailing on first child" <|
            \_ ->
                AppBar.view
                    [ AppBar.trailing
                        [ IB.view { icon = "more_vert", ariaLabel = "More" } [] ]
                    ]
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "trailing")
        , test "leading injects slot=leading" <|
            \_ ->
                AppBar.view
                    [ AppBar.leading (IB.view { icon = "menu", ariaLabel = "Menu" } []) ]
                    |> Element.toNode
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
                    |> Element.toNode
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
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "subtitle")
        , test "size emits size attribute" <|
            \_ ->
                AppBar.view [ AppBar.size AppBar.Large ]
                    |> Element.toNode
                    |> Node.findAttribute "size"
                    |> Expect.equal (Just "large")
        , test "centered emits centered DOM property" <|
            \_ ->
                AppBar.view [ AppBar.centered True ]
                    |> Element.toNode
                    |> Node.findProperty "centered"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "id emits id attribute" <|
            \_ ->
                AppBar.view [ AppBar.id "main-bar" ]
                    |> Element.toNode
                    |> Node.findAttribute "id"
                    |> Expect.equal (Just "main-bar")
        , test "element escape in leading slot carries slot=leading" <|
            \_ ->
                AppBar.view
                    [ AppBar.leading (Element.element { tag = "img" } [] []) ]
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "leading")

        -- Fix #66 — for attribute (scroll-elevation attach target)
        , test "fix-#66: for sets the 'for' attribute (scroll-elevation target)" <|
            \_ ->
                AppBar.view [ AppBar.for "scroll-container" ]
                    |> Element.toNode
                    |> Node.findAttribute "for"
                    |> Expect.equal (Just "scroll-container")
        , test "fix-#66: no for option — no for attribute by default" <|
            \_ ->
                AppBar.view []
                    |> Element.toNode
                    |> Node.findAttribute "for"
                    |> Expect.equal Nothing
        ]
