module Ui.PaginatorTest exposing (suite)

import Html.Attributes
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
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
        ]
