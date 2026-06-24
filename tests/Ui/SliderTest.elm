module Ui.SliderTest exposing (suite)

import Expect
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Slider


suite : Test
suite =
    describe "Ui.Slider"
        [ test "label carries slot=label and for=<stable id>" <|
            \_ ->
                Ui.Slider.value
                    { label = "Volume"
                    , value = 50
                    , onChange = always ()
                    }
                    |> Ui.Slider.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "label" ]
                    |> Query.has
                        [ Selector.attribute (Attr.attribute "slot" "label")
                        , Selector.attribute (Attr.for "uif-volume")
                        ]
        , test "slider control carries the same stable id" <|
            \_ ->
                Ui.Slider.value
                    { label = "Volume"
                    , value = 50
                    , onChange = always ()
                    }
                    |> Ui.Slider.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-slider" ]
                    |> Query.has [ Selector.id "uif-volume" ]
        , test "thumb carries the typed value attribute" <|
            \_ ->
                Ui.Slider.value
                    { label = "Volume"
                    , value = 42
                    , onChange = always ()
                    }
                    |> Ui.Slider.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-slider-thumb" ]
                    |> Query.has [ Selector.attribute (Attr.value "42") ]
        , test "withId overrides on both label and control" <|
            \_ ->
                Ui.Slider.value
                    { label = "Volume"
                    , value = 50
                    , onChange = always ()
                    }
                    |> Ui.Slider.withId "vol"
                    |> Ui.Slider.view
                    |> Query.fromHtml
                    |> Expect.all
                        [ Query.find [ Selector.tag "label" ]
                            >> Query.has [ Selector.attribute (Attr.for "vol") ]
                        , Query.find [ Selector.tag "m3e-slider" ]
                            >> Query.has [ Selector.id "vol" ]
                        ]
        , describe "withVisibleLabel False (bare mode)"
            [ test "renders no m3e-form-field and no visible label, keeps aria-label" <|
                \_ ->
                    Ui.Slider.value { label = "Brightness", value = 50, onChange = always () }
                        |> Ui.Slider.withVisibleLabel False
                        |> Ui.Slider.view
                        |> Query.fromHtml
                        |> Expect.all
                            [ Query.findAll [ Selector.tag "m3e-form-field" ] >> Query.count (Expect.equal 0)
                            , Query.findAll [ Selector.tag "label" ] >> Query.count (Expect.equal 0)
                            , Query.has [ Selector.tag "m3e-slider", Selector.attribute (Attr.attribute "aria-label" "Brightness") ]
                            ]
            ]
        ]
