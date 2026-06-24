module Ui.ScrollContainerTest exposing (suite)

import Html exposing (text)
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.ScrollContainer


suite : Test
suite =
    describe "Ui.ScrollContainer"
        [ test "renders an m3e-scroll-container element" <|
            \_ ->
                Ui.ScrollContainer.new
                    |> Ui.ScrollContainer.view [ text "content" ]
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-scroll-container" ]
        ]
