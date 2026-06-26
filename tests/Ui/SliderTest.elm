module Ui.SliderTest exposing (suite)

import Expect
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Slider


suite : Test
suite =
    describe "Ui.Slider (bare control)"
        [ test "renders a bare m3e-slider with the label as aria-label" <|
            \_ ->
                Ui.Slider.value
                    { label = "Volume"
                    , value = 50
                    , onChange = always ()
                    }
                    |> Ui.Slider.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-slider"
                        , Selector.attribute (Attr.attribute "aria-label" "Volume")
                        ]
        , test "renders no m3e-form-field and no visible label" <|
            \_ ->
                Ui.Slider.value
                    { label = "Volume"
                    , value = 50
                    , onChange = always ()
                    }
                    |> Ui.Slider.view
                    |> Query.fromHtml
                    |> Expect.all
                        [ Query.findAll [ Selector.tag "m3e-form-field" ] >> Query.count (Expect.equal 0)
                        , Query.findAll [ Selector.tag "label" ] >> Query.count (Expect.equal 0)
                        ]
        , test "slider control carries the stable id derived from the label" <|
            \_ ->
                Ui.Slider.value
                    { label = "Volume"
                    , value = 50
                    , onChange = always ()
                    }
                    |> Ui.Slider.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-slider", Selector.id "uif-volume" ]
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
        , test "withId overrides the stable id on the control" <|
            \_ ->
                Ui.Slider.value
                    { label = "Volume"
                    , value = 50
                    , onChange = always ()
                    }
                    |> Ui.Slider.withId "vol"
                    |> Ui.Slider.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-slider", Selector.id "vol" ]
        ]
