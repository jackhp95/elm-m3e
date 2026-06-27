module M3e.NavigationBarTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Internal as Internal
import M3e.NavigationBar as NavBar
import M3e.Node as Node
import M3e.Renderable as Renderable
import Test exposing (Test, describe, test)


-- Helpers -----------------------------------------------------------------


fakeIcon : Renderable.Renderable { icon : Renderable.Supported } msg
fakeIcon =
    Internal.fromNode (Node.element "m3e-icon" [] [ Node.text "home" ])


navNode : List (NavBar.Option msg) -> List (Renderable.Renderable { navItem : Renderable.Supported } msg) -> Node.Node msg
navNode opts items =
    NavBar.view { items = items } opts
        |> Renderable.toNode


{-| Build a bar item with a required label. -}
barItem : String -> List (NavBar.ItemOption String) -> Renderable.Renderable { navItem : Renderable.Supported } String
barItem lbl opts =
    NavBar.item { icon = fakeIcon, label = lbl } opts


suite : Test
suite =
    describe "M3e.NavigationBar — view-style port"
        [ -- Container
          test "view renders <m3e-nav-bar>" <|
            \_ ->
                navNode [] []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-nav-bar")
        , test "withId sets the 'id' attribute" <|
            \_ ->
                navNode [ NavBar.withId "main-nav" ] []
                    |> Node.findAttribute "id"
                    |> Expect.equal (Just "main-nav")
        , test "item count reflects the items list" <|
            \_ ->
                navNode [] [ barItem "A" [], barItem "B" [], barItem "C" [] ]
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 3

        -- Item
        , test "item renders <m3e-nav-item>" <|
            \_ ->
                barItem "Home" []
                    |> Renderable.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-nav-item")
        , test "item carries an accessible name (label text node always present)" <|
            \_ ->
                barItem "Inbox" []
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.any (\n -> n == Node.text "Inbox")
                    |> Expect.equal True
        , test "selected=false is emitted as DOM property by default" <|
            \_ ->
                barItem "Home" []
                    |> Renderable.toNode
                    |> Node.findProperty "selected"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "itemSelected=true sets the selected DOM property" <|
            \_ ->
                barItem "Home" [ NavBar.itemSelected True ]
                    |> Renderable.toNode
                    |> Node.findProperty "selected"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "icon lands in the icon slot" <|
            \_ ->
                barItem "Home" []
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "icon")
        , test "label text is always a child (always 2+ children: icon + label)" <|
            \_ ->
                barItem "Home" []
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.atLeast 2
        , test "itemSelectedIcon lands in the selected-icon slot" <|
            \_ ->
                barItem "Home" [ NavBar.itemSelectedIcon fakeIcon ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "selected-icon")
                    |> List.length
                    |> Expect.equal 1
        , test "itemBadge appends an <m3e-badge> child" <|
            \_ ->
                barItem "Home" [ NavBar.itemBadge "3" ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.tagOf n == Just "m3e-badge")
                    |> List.length
                    |> Expect.equal 1
        , test "itemDisabled=true sets the disabled DOM property" <|
            \_ ->
                barItem "Home" [ NavBar.itemDisabled True ]
                    |> Renderable.toNode
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disabled absent by default" <|
            \_ ->
                barItem "Home" []
                    |> Renderable.toNode
                    |> Node.findProperty "disabled"
                    |> Expect.equal Nothing
        , test "itemHref sets the href attribute" <|
            \_ ->
                barItem "Home" [ NavBar.itemHref "/home" ]
                    |> Renderable.toNode
                    |> Node.findAttribute "href"
                    |> Expect.equal (Just "/home")
        ]
