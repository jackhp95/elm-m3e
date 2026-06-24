module Ui.NavigationRailTest exposing (suite)

import Expect
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Icon
import Ui.NavigationRail


type Page
    = Home
    | Inbox


rail : Ui.NavigationRail.NavigationRail Page Page
rail =
    Ui.NavigationRail.new
        { items =
            [ Ui.NavigationRail.item { value = Home, icon = Ui.Icon.material "home" }
                |> Ui.NavigationRail.withItemLabel "Home"
            , Ui.NavigationRail.item { value = Inbox, icon = Ui.Icon.material "inbox" }
                |> Ui.NavigationRail.withItemLabel "Inbox"
                |> Ui.NavigationRail.withItemBadge "3"
            ]
        , selected = Just Home
        , onChange = identity
        }


suite : Test
suite =
    describe "Ui.NavigationRail"
        [ test "renders destinations as m3e-nav-item (CEM rail item element)" <|
            \_ ->
                rail
                    |> Ui.NavigationRail.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.tag "m3e-nav-item" ]
                    |> Query.count (Expect.equal 2)
        , test "does NOT emit m3e-nav-menu-item (drawer-family child)" <|
            \_ ->
                rail
                    |> Ui.NavigationRail.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.tag "m3e-nav-menu-item" ]
                    |> Query.count (Expect.equal 0)
        , test "label goes in the default slot — no slot=label" <|
            \_ ->
                rail
                    |> Ui.NavigationRail.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.attribute (Attr.attribute "slot" "label") ]
                    |> Query.count (Expect.equal 0)
        , test "label text is present" <|
            \_ ->
                rail
                    |> Ui.NavigationRail.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.text "Inbox" ]
        , test "badge is NOT routed to a slot=badge (no such slot on m3e-nav-item)" <|
            \_ ->
                rail
                    |> Ui.NavigationRail.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.attribute (Attr.attribute "slot" "badge") ]
                    |> Query.count (Expect.equal 0)
        , test "badge is composed as an m3e-badge element carrying the text" <|
            \_ ->
                rail
                    |> Ui.NavigationRail.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-badge" ]
                    |> Query.has [ Selector.text "3" ]
        ]
