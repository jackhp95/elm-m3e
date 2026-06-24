module Ui.SplitPaneTest exposing (suite)

import Html exposing (text)
import Html.Attributes
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.SplitPane


suite : Test
suite =
    describe "Ui.SplitPane"
        [ test "the start pane carries slot=\"start\"" <|
            \_ ->
                splitPane
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.attribute
                            (Html.Attributes.attribute "slot" "start")
                        ]
        , test "the end pane carries slot=\"end\"" <|
            \_ ->
                splitPane
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.attribute
                            (Html.Attributes.attribute "slot" "end")
                        ]
        ]


splitPane : Html.Html msg
splitPane =
    Ui.SplitPane.new
        |> Ui.SplitPane.withStart [ text "left" ]
        |> Ui.SplitPane.withEnd [ text "right" ]
        |> Ui.SplitPane.view
