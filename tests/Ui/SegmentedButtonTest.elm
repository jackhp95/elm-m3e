module Ui.SegmentedButtonTest exposing (suite)

import Expect
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.SegmentedButton


type View
    = Day
    | Week


viewSeg : Ui.SegmentedButton.SegmentedButton Ui.SegmentedButton.Single View ()
viewSeg =
    Ui.SegmentedButton.single
        { label = "View"
        , segments =
            [ Ui.SegmentedButton.segment { value = Day, label = "Day" }
            , Ui.SegmentedButton.segment { value = Week, label = "Week" }
            ]
        , selected = Just Week
        , onChange = always ()
        }


suite : Test
suite =
    describe "Ui.SegmentedButton"
        [ test "renders m3e-segmented-button without an m3e-form-field wrap" <|
            \_ ->
                viewSeg
                    |> Ui.SegmentedButton.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.tag "m3e-form-field" ]
                    |> Query.count (Expect.equal 0)
        , test "still renders the m3e-segmented-button element" <|
            \_ ->
                viewSeg
                    |> Ui.SegmentedButton.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-segmented-button" ]
        , test "renders each segment" <|
            \_ ->
                viewSeg
                    |> Ui.SegmentedButton.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.tag "m3e-button-segment" ]
                    |> Query.count (Expect.equal 2)
        ]
