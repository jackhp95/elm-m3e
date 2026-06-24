module Ui.SlideTest exposing (suite)

import Expect
import Html exposing (text)
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
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
        ]
