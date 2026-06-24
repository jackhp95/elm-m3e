module Ui.CarouselTest exposing (suite)

import Expect
import Html exposing (text)
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Carousel


suite : Test
suite =
    describe "Ui.Carousel"
        [ test "renders an m3e-slide-group" <|
            \_ ->
                Ui.Carousel.new [ text "a" ]
                    |> Ui.Carousel.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-slide-group" ]
        , test "projects each item into the slide-group default slot via m3e-slide (no slot attribute)" <|
            \_ ->
                Ui.Carousel.new [ text "a", text "b" ]
                    |> Ui.Carousel.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.tag "m3e-slide" ]
                    |> Query.count (Expect.equal 2)
        ]
