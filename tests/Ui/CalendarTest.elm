module Ui.CalendarTest exposing (suite)

import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Calendar


suite : Test
suite =
    describe "Ui.Calendar"
        [ test "navigation labels emit on the m3e-calendar" <|
            \_ ->
                Ui.Calendar.new
                    |> Ui.Calendar.withPreviousMonthLabel "Prev month"
                    |> Ui.Calendar.withNextMonthLabel "Next month"
                    |> Ui.Calendar.withPreviousYearLabel "Prev year"
                    |> Ui.Calendar.withNextYearLabel "Next year"
                    |> Ui.Calendar.withPreviousMultiYearLabel "Prev 24 years"
                    |> Ui.Calendar.withNextMultiYearLabel "Next 24 years"
                    |> Ui.Calendar.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-calendar"
                        , Selector.attribute (Attr.attribute "previous-month-label" "Prev month")
                        , Selector.attribute (Attr.attribute "next-month-label" "Next month")
                        , Selector.attribute (Attr.attribute "previous-year-label" "Prev year")
                        , Selector.attribute (Attr.attribute "next-year-label" "Next year")
                        , Selector.attribute (Attr.attribute "previous-multi-year-label" "Prev 24 years")
                        , Selector.attribute (Attr.attribute "next-multi-year-label" "Next 24 years")
                        ]
        , test "navigation labels are omitted when unset" <|
            \_ ->
                Ui.Calendar.new
                    |> Ui.Calendar.view
                    |> Query.fromHtml
                    |> Query.hasNot
                        [ Selector.attribute (Attr.attribute "previous-month-label" "Previous month") ]
        ]
