module Ui.TextHighlightTest exposing (suite)

import Html exposing (text)
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.TextHighlight


suite : Test
suite =
    describe "Ui.TextHighlight"
        [ test "renders an m3e-text-highlight element" <|
            \_ ->
                Ui.TextHighlight.new
                    |> Ui.TextHighlight.withTerm "ac"
                    |> Ui.TextHighlight.view [ text "Acme" ]
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-text-highlight" ]
        ]
