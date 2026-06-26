module M3e.TabsTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable
import M3e.Tabs as Tabs
import Test exposing (Test, describe, test)


tab1 : Renderable.Renderable { tab : Renderable.Supported } msg
tab1 =
    Tabs.tab { label = "Tab 1" } [ Tabs.tabSelected True, Tabs.tabFor "p1" ]


tab2 : Renderable.Renderable { tab : Renderable.Supported } msg
tab2 =
    Tabs.tab { label = "Tab 2" } [ Tabs.tabFor "p2" ]


panel1 : Renderable.Renderable { tabPanel : Renderable.Supported } msg
panel1 =
    Tabs.panel { content = [] } [ Tabs.panelId "p1" ]


panel2 : Renderable.Renderable { tabPanel : Renderable.Supported } msg
panel2 =
    Tabs.panel { content = [] } [ Tabs.panelId "p2" ]


stripNode : List (Tabs.Option msg) -> Node.Node msg
stripNode opts =
    Tabs.view
        { tabs = [ tab1, tab2 ]
        , panels = [ panel1, panel2 ]
        }
        opts
        |> Renderable.toNode


suite : Test
suite =
    describe "M3e.Tabs — view-style port"
        [ test "view renders <m3e-tabs>" <|
            \_ ->
                stripNode []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-tabs")
        , test "tab helper renders <m3e-tab>" <|
            \_ ->
                tab1
                    |> Renderable.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-tab")
        , test "panel helper renders <m3e-tab-panel>" <|
            \_ ->
                panel1
                    |> Renderable.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-tab-panel")
        , test "tabs land in the default slot (no slot attribute)" <|
            \_ ->
                stripNode []
                    |> Node.childrenOf
                    |> List.take 2
                    |> List.map (Node.findAttribute "slot")
                    |> Expect.equal [ Nothing, Nothing ]
        , test "panels land in the panel slot" <|
            \_ ->
                stripNode []
                    |> Node.childrenOf
                    |> List.drop 2
                    |> List.map (Node.findAttribute "slot")
                    |> Expect.equal [ Just "panel", Just "panel" ]
        , test "selected=true is a DOM property on the tab" <|
            \_ ->
                tab1
                    |> Renderable.toNode
                    |> Node.findProperty "selected"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "selected=false is always emitted on unselected tab" <|
            \_ ->
                tab2
                    |> Renderable.toNode
                    |> Node.findProperty "selected"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "tabFor sets the 'for' attribute" <|
            \_ ->
                tab1
                    |> Renderable.toNode
                    |> Node.findAttribute "for"
                    |> Expect.equal (Just "p1")
        , test "panelId sets the 'id' attribute on the panel" <|
            \_ ->
                panel1
                    |> Renderable.toNode
                    |> Node.findAttribute "id"
                    |> Expect.equal (Just "p1")
        , test "tabDisabled=true sets disabled DOM property" <|
            \_ ->
                Tabs.tab { label = "Off" } [ Tabs.tabDisabled True ]
                    |> Renderable.toNode
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disabled absent by default" <|
            \_ ->
                tab1
                    |> Renderable.toNode
                    |> Node.findProperty "disabled"
                    |> Expect.equal Nothing
        , test "stretch=true is a DOM property on the strip" <|
            \_ ->
                stripNode [ Tabs.stretch True ]
                    |> Node.findProperty "stretch"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "stretch absent by default" <|
            \_ ->
                stripNode []
                    |> Node.findProperty "stretch"
                    |> Expect.equal Nothing
        , test "total children = tabs + panels" <|
            \_ ->
                stripNode []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 4
        ]
