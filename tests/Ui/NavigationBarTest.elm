module Ui.NavigationBarTest exposing (suite)

import Expect
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Icon
import Ui.NavigationBar


type Page
    = Home
    | Inbox


bar : Ui.NavigationBar.NavigationBar Page Page
bar =
    Ui.NavigationBar.new
        { items =
            [ Ui.NavigationBar.item { value = Home, icon = Ui.Icon.material "home" }
                |> Ui.NavigationBar.withItemLabel "Home"
            , Ui.NavigationBar.item { value = Inbox, icon = Ui.Icon.material "inbox" }
                |> Ui.NavigationBar.withItemLabel "Inbox"
                |> Ui.NavigationBar.withItemBadge "3"
            ]
        , selected = Just Home
        , onChange = identity
        }


suite : Test
suite =
    describe "Ui.NavigationBar"
        [ test "renders destinations as m3e-nav-item (CEM child of m3e-nav-bar)" <|
            \_ ->
                bar
                    |> Ui.NavigationBar.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.tag "m3e-nav-item" ]
                    |> Query.count (Expect.equal 2)
        , test "does NOT emit m3e-nav-menu-item (drawer-family child)" <|
            \_ ->
                bar
                    |> Ui.NavigationBar.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.tag "m3e-nav-menu-item" ]
                    |> Query.count (Expect.equal 0)
        , test "label goes in the default slot — no slot=label (not a real slot on m3e-nav-item)" <|
            \_ ->
                bar
                    |> Ui.NavigationBar.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.attribute (Attr.attribute "slot" "label") ]
                    |> Query.count (Expect.equal 0)
        , test "label text is present" <|
            \_ ->
                bar
                    |> Ui.NavigationBar.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.text "Inbox" ]
        , test "badge is NOT routed to a slot=badge (no such slot on m3e-nav-item)" <|
            \_ ->
                bar
                    |> Ui.NavigationBar.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.attribute (Attr.attribute "slot" "badge") ]
                    |> Query.count (Expect.equal 0)
        , test "badge is composed as an m3e-badge element carrying the text" <|
            \_ ->
                bar
                    |> Ui.NavigationBar.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-badge" ]
                    |> Query.has [ Selector.text "3" ]
        , test "withItemSelectedIcon emits the selected-icon slot" <|
            \_ ->
                Ui.NavigationBar.new
                    { items =
                        [ Ui.NavigationBar.item { value = Home, icon = Ui.Icon.material "home" }
                            |> Ui.NavigationBar.withItemSelectedIcon (Ui.Icon.material "home_filled")
                        ]
                    , selected = Just Home
                    , onChange = identity
                    }
                    |> Ui.NavigationBar.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.attribute (Attr.attribute "slot" "selected-icon") ]
                    |> Query.count (Expect.equal 1)
        , test "no selected-icon slot when not set" <|
            \_ ->
                bar
                    |> Ui.NavigationBar.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.attribute (Attr.attribute "slot" "selected-icon") ]
                    |> Query.count (Expect.equal 0)
        ]
