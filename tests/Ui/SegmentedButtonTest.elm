module Ui.SegmentedButtonTest exposing (suite)

import Expect
import Html.Attributes as Attr
import M3e.ButtonSegment
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
        , test "each segment's DOM value mirrors its label (Elm-controlled; no form submission path)" <|
            \_ ->
                -- Selection is owned in Elm via onChange; the DOM `value` is
                -- never read because no name/form-submission path is exposed.
                -- We document that by mirroring the label as the value.
                viewSeg
                    |> Ui.SegmentedButton.view
                    |> Query.fromHtml
                    |> Expect.all
                        [ Query.has [ Selector.attribute (M3e.ButtonSegment.value "Day") ]
                        , Query.has [ Selector.attribute (M3e.ButtonSegment.value "Week") ]
                        ]
        , test "label association is via aria-label on the group (not a fragile for)" <|
            \_ ->
                viewSeg
                    |> Ui.SegmentedButton.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-segmented-button"
                        , Selector.attribute (Attr.attribute "aria-label" "View")
                        ]
        ]
