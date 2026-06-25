module Ui.TabsTest exposing (suite)

import Expect
import Html
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Icon
import Ui.Tabs


type Section
    = Overview
    | Activity


tabs : Ui.Tabs.Tabs Section Section
tabs =
    Ui.Tabs.new
        { tabs =
            [ Ui.Tabs.tab { value = Overview, label = "Overview" }
            , Ui.Tabs.tab { value = Activity, label = "Activity" }
                |> Ui.Tabs.withTabBadge "5"
            ]
        , selected = Overview
        , onChange = identity
        }


tabsWithPanels : Ui.Tabs.Tabs Section Section
tabsWithPanels =
    Ui.Tabs.new
        { tabs =
            [ Ui.Tabs.tab { value = Overview, label = "Overview" }
                |> Ui.Tabs.withPanel (Html.text "Overview content")
            , Ui.Tabs.tab { value = Activity, label = "Activity" }
                |> Ui.Tabs.withPanel (Html.text "Activity content")
            ]
        , selected = Overview
        , onChange = identity
        }
        |> Ui.Tabs.withId "media"
        |> Ui.Tabs.withNextIcon (Ui.Icon.material "chevron_right")
        |> Ui.Tabs.withPrevIcon (Ui.Icon.material "chevron_left")


suite : Test
suite =
    describe "Ui.Tabs"
        [ test "tab badge is NOT routed to slot=badge (no such slot on m3e-tab)" <|
            \_ ->
                tabs
                    |> Ui.Tabs.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.attribute (Attr.attribute "slot" "badge") ]
                    |> Query.count (Expect.equal 0)
        , test "badge is composed as an m3e-badge element carrying the text" <|
            \_ ->
                tabs
                    |> Ui.Tabs.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-badge" ]
                    |> Query.has [ Selector.text "5" ]
        , test "tab label text is still present in the default content" <|
            \_ ->
                tabs
                    |> Ui.Tabs.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.text "Activity" ]
        , test "strip-only tabs emit no m3e-tab-panel" <|
            \_ ->
                tabs
                    |> Ui.Tabs.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.tag "m3e-tab-panel" ]
                    |> Query.count (Expect.equal 0)
        , test "withPanel emits an m3e-tab-panel into the panel slot per panelled tab" <|
            \_ ->
                tabsWithPanels
                    |> Ui.Tabs.view
                    |> Query.fromHtml
                    |> Query.findAll
                        [ Selector.tag "m3e-tab-panel"
                        , Selector.attribute (Attr.attribute "slot" "panel")
                        ]
                    |> Query.count (Expect.equal 2)
        , test "panel carries the tab's content" <|
            \_ ->
                tabsWithPanels
                    |> Ui.Tabs.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-tab-panel", Selector.id "media-panel-0" ]
                    |> Query.has [ Selector.text "Overview content" ]
        , test "tab is associated to its panel by for/id" <|
            \_ ->
                tabsWithPanels
                    |> Ui.Tabs.view
                    |> Query.fromHtml
                    |> Query.findAll
                        [ Selector.tag "m3e-tab"
                        , Selector.attribute (Attr.attribute "for" "media-panel-1")
                        ]
                    |> Query.count (Expect.equal 1)
        , test "withNextIcon / withPrevIcon emit the pagination icon slots" <|
            \_ ->
                let
                    rendered =
                        tabsWithPanels |> Ui.Tabs.view |> Query.fromHtml
                in
                Expect.all
                    [ \r ->
                        r
                            |> Query.findAll [ Selector.attribute (Attr.attribute "slot" "next-icon") ]
                            |> Query.count (Expect.equal 1)
                    , \r ->
                        r
                            |> Query.findAll [ Selector.attribute (Attr.attribute "slot" "prev-icon") ]
                            |> Query.count (Expect.equal 1)
                    ]
                    rendered
        ]
