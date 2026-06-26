module Ui.SearchTest exposing (suite)

import Html.Attributes
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Search


suite : Test
suite =
    describe "Ui.Search"
        [ test "results withDefaultOpen True does NOT emit the raw open=\"true\" string attribute" <|
            \_ ->
                -- The typed Cem.M3e.SearchView.open sets the `open` DOM *property*,
                -- which never renders as a literal attribute. The old raw
                -- `Attr.attribute "open" "true"` did. Asserting the literal
                -- attribute is absent pins the typed binding.
                Ui.Search.results []
                    |> Ui.Search.withDefaultOpen True
                    |> Ui.Search.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-search-view" ]
                    |> Query.hasNot
                        [ Selector.attribute
                            (Html.Attributes.attribute "open" "true")
                        ]
        ]
