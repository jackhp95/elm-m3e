module M3e.DrawerToggleTest exposing (suite)

import Expect
import M3e.DrawerToggle as DrawerToggle
import M3e.Element as Element
import M3e.Node as Node exposing (Node)
import Test exposing (Test, describe, test)


node : List (DrawerToggle.Option msg) -> Node msg
node opts =
    DrawerToggle.view opts |> Element.toNode


suite : Test
suite =
    describe "M3e.DrawerToggle — view-style port"
        [ test "renders <m3e-drawer-toggle>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-drawer-toggle")
        , test "drawer-toggle is a leaf — no children" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 0
        , test "for sets the introspectable attribute" <|
            \_ ->
                node [ DrawerToggle.for "nav-drawer" ]
                    |> Node.findAttribute "for"
                    |> Expect.equal (Just "nav-drawer")
        , test "for is absent by default" <|
            \_ ->
                node []
                    |> Node.findAttribute "for"
                    |> Expect.equal Nothing
        ]
