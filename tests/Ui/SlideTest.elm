module Ui.SlideTest exposing (suite)

import Expect
import Html exposing (text)
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Icon
import Ui.Slide


suite : Test
suite =
    describe "Ui.Slide"
        [ test "renders an m3e-slide-group" <|
            \_ ->
                Ui.Slide.new
                    |> Ui.Slide.withSlides [ [ text "a" ] ]
                    |> Ui.Slide.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-slide-group" ]
        , test "wraps each slide in its own m3e-slide projected into the default slot" <|
            \_ ->
                Ui.Slide.new
                    |> Ui.Slide.withSlides [ [ text "a" ], [ text "b" ] ]
                    |> Ui.Slide.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.tag "m3e-slide" ]
                    |> Query.count (Expect.equal 2)
        , test "withThreshold wires the threshold property without disturbing structure" <|
            -- `threshold` is a float DOM *property* (M3e.SlideGroup.threshold);
            -- Test.Html.Selector can only match string/bool facts, so the value
            -- itself is not assertable here. This exercises the code path and
            -- confirms the slide-group still renders its slides.
            \_ ->
                Ui.Slide.new
                    |> Ui.Slide.withThreshold 48
                    |> Ui.Slide.withSlides [ [ text "a" ] ]
                    |> Ui.Slide.view
                    |> Query.fromHtml
                    |> Expect.all
                        [ Query.has [ Selector.tag "m3e-slide-group" ]
                        , Query.findAll [ Selector.tag "m3e-slide" ]
                            >> Query.count (Expect.equal 1)
                        ]
        , test "withNextIcon and withPrevIcon slot icons into next-icon/prev-icon" <|
            \_ ->
                Ui.Slide.new
                    |> Ui.Slide.withNextIcon (Ui.Icon.material "chevron_right")
                    |> Ui.Slide.withPrevIcon (Ui.Icon.material "chevron_left")
                    |> Ui.Slide.withSlides [ [ text "a" ] ]
                    |> Ui.Slide.view
                    |> Query.fromHtml
                    |> Expect.all
                        [ Query.findAll [ Selector.attribute (Attr.attribute "slot" "next-icon") ]
                            >> Query.count (Expect.equal 1)
                        , Query.findAll [ Selector.attribute (Attr.attribute "slot" "prev-icon") ]
                            >> Query.count (Expect.equal 1)
                        ]
        ]
