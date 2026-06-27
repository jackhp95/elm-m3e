module M3e.NavigationRailTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element exposing (Element)
import M3e.Internal as Internal
import M3e.NavigationRail as NavRail
import M3e.Node as Node exposing (Node)
import Test exposing (Test, describe, test)



-- Helpers -----------------------------------------------------------------


fakeIcon : Element { icon : Element.Supported } msg
fakeIcon =
    Internal.fromNode (Node.element "m3e-icon" [] [ Node.text "home" ])


railNode : List (NavRail.Option msg) -> List (Element { navItem : Element.Supported } msg) -> Node msg
railNode opts items =
    NavRail.view { items = items } opts
        |> Element.toNode


{-| Build a rail item with a required label.
-}
railItem : String -> List (NavRail.ItemOption String) -> Element { navItem : Element.Supported } String
railItem lbl opts =
    NavRail.item { icon = fakeIcon, label = lbl } opts


suite : Test
suite =
    describe "M3e.NavigationRail — view-style port"
        [ -- Container
          test "view renders <m3e-nav-rail>" <|
            \_ ->
                railNode [] []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-nav-rail")
        , test "id sets the 'id' attribute" <|
            \_ ->
                railNode [ NavRail.id "side-nav" ] []
                    |> Node.findAttribute "id"
                    |> Expect.equal (Just "side-nav")
        , test "item count reflects the items list" <|
            \_ ->
                railNode [] [ railItem "A" [], railItem "B" [] ]
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2

        -- Item
        , test "item renders <m3e-nav-item>" <|
            \_ ->
                railItem "Home" []
                    |> Element.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-nav-item")
        , test "item carries an accessible name (label text node always present)" <|
            \_ ->
                railItem "Settings" []
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.member (Node.text "Settings")
                    |> Expect.equal True
        , test "selected=false is emitted as DOM property by default" <|
            \_ ->
                railItem "Home" []
                    |> Element.toNode
                    |> Node.findProperty "selected"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "itemSelected=true sets the selected DOM property" <|
            \_ ->
                railItem "Home" [ NavRail.itemSelected True ]
                    |> Element.toNode
                    |> Node.findProperty "selected"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "icon lands in the icon slot" <|
            \_ ->
                railItem "Home" []
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "icon")
        , test "label text is always a child (always 2+ children: icon + label)" <|
            \_ ->
                railItem "Home" []
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.atLeast 2
        , test "itemSelectedIcon lands in the selected-icon slot" <|
            \_ ->
                railItem "Home" [ NavRail.itemSelectedIcon fakeIcon ]
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "selected-icon")
                    |> List.length
                    |> Expect.equal 1
        , test "itemBadge appends an <m3e-badge> child" <|
            \_ ->
                railItem "Home" [ NavRail.itemBadge "5" ]
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.tagOf n == Just "m3e-badge")
                    |> List.length
                    |> Expect.equal 1
        , test "itemDisabled=true sets the disabled DOM property" <|
            \_ ->
                railItem "Home" [ NavRail.itemDisabled True ]
                    |> Element.toNode
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disabled absent by default" <|
            \_ ->
                railItem "Home" []
                    |> Element.toNode
                    |> Node.findProperty "disabled"
                    |> Expect.equal Nothing
        , test "itemHref sets the href attribute" <|
            \_ ->
                railItem "Home" [ NavRail.itemHref "/settings" ]
                    |> Element.toNode
                    |> Node.findAttribute "href"
                    |> Expect.equal (Just "/settings")
        ]
