module Ui.TabsTest exposing (suite)

import Expect
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
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
        ]
