module M3e.NavigationDrawerTest exposing (suite)

import Expect
import Html
import Json.Encode as Encode
import M3e.Icon as Icon
import M3e.Internal as Internal
import M3e.NavigationDrawer as NavigationDrawer
import M3e.Node as Node
import M3e.Renderable as Renderable
import Test exposing (Test, describe, test)



-- Helpers ---------------------------------------------------------------------


{-| Render the container with one link entry and return the IR node.
-}
viewNode : List (NavigationDrawer.Option String) -> Node.Node String
viewNode opts =
    NavigationDrawer.view
        { entries =
            [ NavigationDrawer.link { label = "Home", href = "/" } [] ]
        }
        opts
        |> Renderable.toNode


{-| The `<m3e-nav-menu>` child of the container.
-}
navMenuChild : Node.Node msg -> Maybe (Node.Node msg)
navMenuChild node =
    Node.childrenOf node |> List.head


{-| Items inside the nav-menu (children of `<m3e-nav-menu>`).
-}
navMenuItems : Node.Node msg -> List (Node.Node msg)
navMenuItems node =
    navMenuChild node
        |> Maybe.map Node.childrenOf
        |> Maybe.withDefault []


linkNode : List (NavigationDrawer.LinkOption String) -> Node.Node String
linkNode opts =
    NavigationDrawer.link { label = "Overview", href = "/docs" } opts
        |> Renderable.toNode


groupNode : List (Node.Node String) -> List (NavigationDrawer.GroupOption String) -> Node.Node String
groupNode childNodes opts =
    NavigationDrawer.group
        { label = "Docs" }
        (List.map (\n -> Internal.fromNode n) childNodes)
        opts
        |> Renderable.toNode



-- Tests -----------------------------------------------------------------------


suite : Test
suite =
    describe "M3e.NavigationDrawer — view-style port (tree API)"
        [ -- Container tag
          test "view renders <m3e-drawer-container>" <|
            \_ ->
                viewNode []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-drawer-container")

        -- Nav-menu slot
        , test "first child is <m3e-nav-menu>" <|
            \_ ->
                navMenuChild (viewNode [])
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "m3e-nav-menu")
        , test "nav-menu has slot='start' by default" <|
            \_ ->
                navMenuChild (viewNode [])
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "start")

        -- Open state
        , test "default open=True sets 'start' attribute on container" <|
            \_ ->
                viewNode []
                    |> Node.findAttribute "start"
                    |> Expect.notEqual Nothing
        , test "open False removes 'start' attribute" <|
            \_ ->
                viewNode [ NavigationDrawer.open False ]
                    |> Node.findAttribute "start"
                    |> Expect.equal Nothing

        -- Mode
        , test "default mode sets 'start-mode=side'" <|
            \_ ->
                viewNode []
                    |> Node.findAttribute "start-mode"
                    |> Expect.equal (Just "side")
        , test "mode ModeAuto sets 'start-mode=auto'" <|
            \_ ->
                viewNode [ NavigationDrawer.mode NavigationDrawer.ModeAuto ]
                    |> Node.findAttribute "start-mode"
                    |> Expect.equal (Just "auto")
        , test "mode ModeOver sets 'start-mode=over'" <|
            \_ ->
                viewNode [ NavigationDrawer.mode NavigationDrawer.ModeOver ]
                    |> Node.findAttribute "start-mode"
                    |> Expect.equal (Just "over")

        -- Side = End
        , test "side End uses 'end-mode' attribute name" <|
            \_ ->
                viewNode [ NavigationDrawer.side NavigationDrawer.End ]
                    |> Node.findAttribute "end-mode"
                    |> Expect.notEqual Nothing
        , test "side End uses 'end' for open attribute" <|
            \_ ->
                viewNode [ NavigationDrawer.side NavigationDrawer.End ]
                    |> Node.findAttribute "end"
                    |> Expect.notEqual Nothing
        , test "side End: nav-menu slot='end'" <|
            \_ ->
                navMenuChild
                    (viewNode [ NavigationDrawer.side NavigationDrawer.End ])
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "end")

        -- Container id
        , test "id sets 'id' attribute on container" <|
            \_ ->
                viewNode [ NavigationDrawer.id "main-drawer" ]
                    |> Node.findAttribute "id"
                    |> Expect.equal (Just "main-drawer")

        -- Content projection
        , test "content option adds extra children after nav-menu" <|
            \_ ->
                let
                    n : Node.Node msg
                    n =
                        NavigationDrawer.view
                            { entries = [] }
                            [ NavigationDrawer.content [ Html.div [] [] ] ]
                            |> Renderable.toNode
                in
                Node.childrenOf n
                    |> List.length
                    |> Expect.atLeast 2

        -- Entries wired into nav-menu
        , test "entries become children of <m3e-nav-menu>" <|
            \_ ->
                let
                    node : Node.Node msg
                    node =
                        NavigationDrawer.view
                            { entries =
                                [ NavigationDrawer.link { label = "A", href = "/a" } []
                                , NavigationDrawer.link { label = "B", href = "/b" } []
                                ]
                            }
                            []
                            |> Renderable.toNode
                in
                navMenuItems node
                    |> List.length
                    |> Expect.equal 2

        -- link
        , test "link renders <m3e-nav-menu-item>" <|
            \_ ->
                linkNode []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-nav-menu-item")
        , test "link: selected=false property emitted by default" <|
            \_ ->
                linkNode []
                    |> Node.findProperty "selected"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "link: linkSelected True sets selected property" <|
            \_ ->
                linkNode [ NavigationDrawer.linkSelected True ]
                    |> Node.findProperty "selected"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "link: label child is <a> with slot='label'" <|
            \_ ->
                linkNode []
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "label")
        , test "link: <a> carries the href" <|
            \_ ->
                linkNode []
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "href")
                    |> Expect.equal (Just "/docs")
        , test "link: <a> is an anchor element" <|
            \_ ->
                linkNode []
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "a")
        , test "link: linkTarget sets target attribute on <a>" <|
            \_ ->
                linkNode [ NavigationDrawer.linkTarget "_blank" ]
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "target")
                    |> Expect.equal (Just "_blank")
        , test "link: linkBadge adds a child with slot='badge'" <|
            \_ ->
                linkNode [ NavigationDrawer.linkBadge "3" ]
                    |> Node.childrenOf
                    |> List.any (\n -> Node.findAttribute "slot" n == Just "badge")
                    |> not
                    |> Expect.equal False
        , test "link: linkIcon prepends a child with slot='icon'" <|
            \_ ->
                linkNode [ NavigationDrawer.linkIcon (Icon.view { name = "home" }) ]
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "icon")
        , test "link: no icon child when linkIcon not used" <|
            \_ ->
                linkNode []
                    |> Node.childrenOf
                    |> List.any (\n -> Node.findAttribute "slot" n == Just "icon")
                    |> not
                    |> Expect.equal True

        -- group
        , test "group renders <m3e-nav-menu-item>" <|
            \_ ->
                groupNode [] []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-nav-menu-item")
        , test "group: selected=false property emitted by default" <|
            \_ ->
                groupNode [] []
                    |> Node.findProperty "selected"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "group: groupSelected True sets selected property" <|
            \_ ->
                groupNode [] [ NavigationDrawer.groupSelected True ]
                    |> Node.findProperty "selected"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "group: open absent by default (collapsed)" <|
            \_ ->
                groupNode [] []
                    |> Node.findProperty "open"
                    |> Expect.equal Nothing
        , test "group: groupOpen True sets open property" <|
            \_ ->
                groupNode [] [ NavigationDrawer.groupOpen True ]
                    |> Node.findProperty "open"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "group: label child is <span> with slot='label'" <|
            \_ ->
                groupNode [] []
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "label")
        , test "group: label <span> is a span" <|
            \_ ->
                groupNode [] []
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "span")
        , test "group: badge child gets slot='badge'" <|
            \_ ->
                groupNode [] [ NavigationDrawer.groupBadge "5" ]
                    |> Node.childrenOf
                    |> List.any (\n -> Node.findAttribute "slot" n == Just "badge")
                    |> not
                    |> Expect.equal False
        , test "group: icon gets slot='icon' injected" <|
            \_ ->
                groupNode [] [ NavigationDrawer.groupIcon (Icon.view { name = "folder" }) ]
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "icon")

        -- Recursive nesting
        , test "group children appear as children of the group item" <|
            \_ ->
                let
                    child : Node.Node msg
                    child =
                        NavigationDrawer.link { label = "Child", href = "/child" } []
                            |> Renderable.toNode

                    g : Node.Node String
                    g =
                        groupNode [ child ] []
                in
                Node.childrenOf g
                    |> List.any (\n -> Node.tagOf n == Just "m3e-nav-menu-item")
                    |> not
                    |> Expect.equal False
        , test "nested group: child count matches" <|
            \_ ->
                let
                    children : List (Node.Node msg)
                    children =
                        [ NavigationDrawer.link { label = "A", href = "/a" } []
                            |> Renderable.toNode
                        , NavigationDrawer.link { label = "B", href = "/b" } []
                            |> Renderable.toNode
                        ]

                    g : Node.Node String
                    g =
                        groupNode children []
                in
                Node.childrenOf g
                    |> List.filter (\n -> Node.tagOf n == Just "m3e-nav-menu-item")
                    |> List.length
                    |> Expect.equal 2
        ]
