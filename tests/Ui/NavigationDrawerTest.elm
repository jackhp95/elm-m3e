module Ui.NavigationDrawerTest exposing (suite)

import Expect
import Html
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Icon
import Ui.NavigationDrawer


type Page
    = Home
    | Settings


drawer : Ui.NavigationDrawer.Side -> Ui.NavigationDrawer.NavigationDrawer Page Page
drawer side =
    Ui.NavigationDrawer.new
        { items =
            [ Ui.NavigationDrawer.item { value = Home, icon = Ui.Icon.material "home" }
                |> Ui.NavigationDrawer.withItemLabel "Home"
            , Ui.NavigationDrawer.item { value = Settings, icon = Ui.Icon.material "settings" }
                |> Ui.NavigationDrawer.withItemLabel "Settings"
            ]
        , selected = Just Home
        , onChange = identity
        }
        |> Ui.NavigationDrawer.withSide side


suite : Test
suite =
    describe "Ui.NavigationDrawer"
        [ test "nav-menu is projected into the drawer's start slot when side=Start (not the default/content slot)" <|
            \_ ->
                drawer Ui.NavigationDrawer.Start
                    |> Ui.NavigationDrawer.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-nav-menu" ]
                    |> Query.has [ Selector.attribute (Attr.attribute "slot" "start") ]
        , test "nav-menu is projected into the drawer's end slot when side=End" <|
            \_ ->
                drawer Ui.NavigationDrawer.End
                    |> Ui.NavigationDrawer.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-nav-menu" ]
                    |> Query.has [ Selector.attribute (Attr.attribute "slot" "end") ]
        , test "start-mode is emitted (typed binding) for a start-side modal drawer" <|
            \_ ->
                drawer Ui.NavigationDrawer.Start
                    |> Ui.NavigationDrawer.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.attribute (Attr.attribute "start-mode" "over") ]
        , test "side-mode drawer (modal False) emits start-mode=side" <|
            \_ ->
                Ui.NavigationDrawer.new
                    { items =
                        [ Ui.NavigationDrawer.item { value = Home, icon = Ui.Icon.material "home" }
                            |> Ui.NavigationDrawer.withItemLabel "Home"
                        ]
                    , selected = Just Home
                    , onChange = identity
                    }
                    |> Ui.NavigationDrawer.withModal False
                    |> Ui.NavigationDrawer.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.attribute (Attr.attribute "start-mode" "side") ]
        , test "drawer item label still rides slot=label on m3e-nav-menu-item (correct here)" <|
            \_ ->
                drawer Ui.NavigationDrawer.Start
                    |> Ui.NavigationDrawer.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.attribute (Attr.attribute "slot" "label") ]
                    |> Query.count (Expect.equal 2)
        , describe "tree shape"
            [ -- NOTE: `open`/`selected` are set as DOM *properties* by the m3e
              -- bindings, so Test.Html can't observe them — those are verified in
              -- the browser (Playwright). Here we assert the observable structure.
              test "a group carries its label in a span[slot=label] (not an anchor)" <|
                \_ ->
                    navTree
                        |> Ui.NavigationDrawer.view
                        |> Query.fromHtml
                        |> Query.find [ Selector.tag "span", Selector.attribute (Attr.attribute "slot" "label") ]
                        |> Query.has [ Selector.text "Getting Started" ]
            , test "a link entry renders a real a[href] in the label slot (not a span)" <|
                \_ ->
                    navTree
                        |> Ui.NavigationDrawer.view
                        |> Query.fromHtml
                        |> Query.find [ Selector.tag "a", Selector.attribute (Attr.href "/getting-started/overview") ]
                        |> Query.has [ Selector.attribute (Attr.attribute "slot" "label"), Selector.text "Overview" ]
            , test "every leaf link is a real anchor in the label slot" <|
                \_ ->
                    navTree
                        |> Ui.NavigationDrawer.view
                        |> Query.fromHtml
                        |> Query.findAll [ Selector.tag "a", Selector.attribute (Attr.attribute "slot" "label") ]
                        |> Query.count (Expect.equal 2)
            , test "tree content is projected into the drawer's default (content) slot" <|
                \_ ->
                    navTree
                        |> Ui.NavigationDrawer.view
                        |> Query.fromHtml
                        |> Query.find [ Selector.id "page-content" ]
                        |> Query.has [ Selector.text "Body" ]
            ]
        ]


navTree : Ui.NavigationDrawer.NavigationDrawer Page msg
navTree =
    Ui.NavigationDrawer.tree
        |> Ui.NavigationDrawer.withEntries
            [ Ui.NavigationDrawer.group "Getting Started"
                |> Ui.NavigationDrawer.withEntryIcon (Ui.Icon.material "rocket_launch")
                |> Ui.NavigationDrawer.withEntryOpen True
                |> Ui.NavigationDrawer.withEntryChildren
                    [ Ui.NavigationDrawer.link "Overview"
                        |> Ui.NavigationDrawer.withEntryHref "/getting-started/overview"
                        |> Ui.NavigationDrawer.withEntrySelected True
                    , Ui.NavigationDrawer.link "Installation"
                        |> Ui.NavigationDrawer.withEntryHref "/getting-started/installation"
                    ]
            ]
        |> Ui.NavigationDrawer.withContent
            [ Html.div [ Attr.id "page-content" ] [ Html.text "Body" ] ]
