module Ui.NavigationDrawerTest exposing (suite)

import Expect
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
        ]
