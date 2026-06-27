module M3e.NavigationRailTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.NavigationRail as NavRail
import M3e.Node as Node
import M3e.Renderable as Renderable
import M3e.Internal as Internal
import Test exposing (Test, describe, test)


-- Helpers -----------------------------------------------------------------


fakeIcon : Renderable.Renderable { icon : Renderable.Supported } msg
fakeIcon =
    Internal.fromNode (Node.element "m3e-icon" [] [ Node.text "home" ])


railNode : List (NavRail.Option msg) -> List (Renderable.Renderable { navItem : Renderable.Supported } msg) -> Node.Node msg
railNode opts items =
    NavRail.view { items = items } opts
        |> Renderable.toNode


railItem : List (NavRail.ItemOption String) -> Renderable.Renderable { navItem : Renderable.Supported } String
railItem opts =
    NavRail.item { icon = fakeIcon } opts


suite : Test
suite =
    describe "M3e.NavigationRail — view-style port"
        [ -- Container
          test "view renders <m3e-nav-rail>" <|
            \_ ->
                railNode [] []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-nav-rail")
        , test "withId sets the 'id' attribute" <|
            \_ ->
                railNode [ NavRail.withId "side-nav" ] []
                    |> Node.findAttribute "id"
                    |> Expect.equal (Just "side-nav")
        , test "item count reflects the items list" <|
            \_ ->
                railNode [] [ railItem [], railItem [] ]
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2

        -- Item
        , test "item renders <m3e-nav-item>" <|
            \_ ->
                railItem []
                    |> Renderable.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-nav-item")
        , test "selected=false is emitted as DOM property by default" <|
            \_ ->
                railItem []
                    |> Renderable.toNode
                    |> Node.findProperty "selected"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "itemSelected=true sets the selected DOM property" <|
            \_ ->
                railItem [ NavRail.itemSelected True ]
                    |> Renderable.toNode
                    |> Node.findProperty "selected"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "icon lands in the icon slot" <|
            \_ ->
                railItem []
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "icon")
        , test "itemLabel appends a text child after the icon" <|
            \_ ->
                railItem [ NavRail.itemLabel "Home" ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        , test "itemSelectedIcon lands in the selected-icon slot" <|
            \_ ->
                railItem [ NavRail.itemSelectedIcon fakeIcon ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "selected-icon")
                    |> List.length
                    |> Expect.equal 1
        , test "itemBadge appends an <m3e-badge> child" <|
            \_ ->
                railItem [ NavRail.itemBadge "5" ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.tagOf n == Just "m3e-badge")
                    |> List.length
                    |> Expect.equal 1
        , test "itemDisabled=true sets the disabled DOM property" <|
            \_ ->
                railItem [ NavRail.itemDisabled True ]
                    |> Renderable.toNode
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disabled absent by default" <|
            \_ ->
                railItem []
                    |> Renderable.toNode
                    |> Node.findProperty "disabled"
                    |> Expect.equal Nothing
        , test "itemHref sets the href attribute" <|
            \_ ->
                railItem [ NavRail.itemHref "/settings" ]
                    |> Renderable.toNode
                    |> Node.findAttribute "href"
                    |> Expect.equal (Just "/settings")
        ]
