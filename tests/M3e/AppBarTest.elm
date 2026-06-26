module M3e.AppBarTest exposing (suite)

import Expect
import Json.Encode as Encode
import Test exposing (Test, describe, test)
import M3e.AppBar as AppBar
import M3e.Heading as Heading
import M3e.IconButton as IB
import M3e.Node as Node
import M3e.Renderable as Renderable


suite : Test
suite =
    describe "M3e.AppBar — expanded surface"
        [ test "withTrailing (existing) still injects slot=trailing on first child" <|
            \_ ->
                AppBar.new
                    |> AppBar.withTrailing
                        [ IB.view { icon = "more_vert", name = "More" } [] ]
                    |> AppBar.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "trailing")
        , test "withLeading injects slot=leading" <|
            \_ ->
                AppBar.new
                    |> AppBar.withLeading (IB.view { icon = "menu", name = "Menu" } [])
                    |> AppBar.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "leading")
        , test "withTitle injects slot=title" <|
            \_ ->
                AppBar.new
                    |> AppBar.withTitle
                        (Heading.view { label = "My App", variant = Heading.Title } [])
                    |> AppBar.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "title")
        , test "withSubtitle injects slot=subtitle" <|
            \_ ->
                AppBar.new
                    |> AppBar.withSubtitle
                        (Heading.view { label = "Dashboard", variant = Heading.Label } [])
                    |> AppBar.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "subtitle")
        , test "withSize emits size attribute" <|
            \_ ->
                AppBar.new
                    |> AppBar.withSize AppBar.Large
                    |> AppBar.toNode
                    |> Node.findAttribute "size"
                    |> Expect.equal (Just "large")
        , test "withCentered emits centered DOM property" <|
            \_ ->
                AppBar.new
                    |> AppBar.withCentered True
                    |> AppBar.toNode
                    |> Node.findProperty "centered"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "withId emits id attribute" <|
            \_ ->
                AppBar.new
                    |> AppBar.withId "main-bar"
                    |> AppBar.toNode
                    |> Node.findAttribute "id"
                    |> Expect.equal (Just "main-bar")
        , test "element escape in leading slot carries slot=leading" <|
            \_ ->
                AppBar.new
                    |> AppBar.withLeading (Renderable.element { tag = "img" } [] [])
                    |> AppBar.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "leading")
        ]
