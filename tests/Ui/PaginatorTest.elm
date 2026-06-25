module Ui.PaginatorTest exposing (suite)

import Expect
import Html.Attributes
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Icon
import Ui.Paginator


suite : Test
suite =
    describe "Ui.Paginator"
        [ test "withDefaultPage does NOT emit the ignored camelCase pageIndex attribute" <|
            \_ ->
                -- The CEM attribute is `page-index`, set via the typed
                -- `M3e.Paginator.pageIndex` DOM *property* (matching the
                -- ExplicitPage branch). The old raw `Attr.attribute
                -- \"pageIndex\" \"3\"` emitted a camelCase string attribute
                -- the element silently ignores. Pin its absence.
                Ui.Paginator.new
                    |> Ui.Paginator.withLength 100
                    |> Ui.Paginator.withDefaultPage 3
                    |> Ui.Paginator.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-paginator" ]
                    |> Query.hasNot
                        [ Selector.attribute
                            (Html.Attributes.attribute "pageIndex" "3")
                        ]
        , test "withFirstPageIcon/withLastPageIcon emit their page-icon slots" <|
            \_ ->
                Ui.Paginator.new
                    |> Ui.Paginator.withFirstPageIcon (Ui.Icon.material "first_page")
                    |> Ui.Paginator.withLastPageIcon (Ui.Icon.material "last_page")
                    |> Ui.Paginator.view
                    |> Query.fromHtml
                    |> Expect.all
                        [ Query.findAll
                            [ Selector.attribute (Html.Attributes.attribute "slot" "first-page-icon") ]
                            >> Query.count (Expect.equal 1)
                        , Query.findAll
                            [ Selector.attribute (Html.Attributes.attribute "slot" "last-page-icon") ]
                            >> Query.count (Expect.equal 1)
                        ]
        , test "withPreviousPageIcon/withNextPageIcon emit their page-icon slots" <|
            \_ ->
                Ui.Paginator.new
                    |> Ui.Paginator.withPreviousPageIcon (Ui.Icon.material "chevron_left")
                    |> Ui.Paginator.withNextPageIcon (Ui.Icon.material "chevron_right")
                    |> Ui.Paginator.view
                    |> Query.fromHtml
                    |> Expect.all
                        [ Query.findAll
                            [ Selector.attribute (Html.Attributes.attribute "slot" "previous-page-icon") ]
                            >> Query.count (Expect.equal 1)
                        , Query.findAll
                            [ Selector.attribute (Html.Attributes.attribute "slot" "next-page-icon") ]
                            >> Query.count (Expect.equal 1)
                        ]
        ]
