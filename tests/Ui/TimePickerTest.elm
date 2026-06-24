module Ui.TimePickerTest exposing (suite)

import Expect
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.TimePicker


suite : Test
suite =
    describe "Ui.TimePicker label anchoring"
        [ test "label carries slot=label and for=<stable id>" <|
            \_ ->
                Ui.TimePicker.new
                    { label = "Meeting time"
                    , value = "09:00"
                    , onChange = always ()
                    }
                    |> Ui.TimePicker.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "label" ]
                    |> Query.has
                        [ Selector.attribute (Attr.attribute "slot" "label")
                        , Selector.attribute (Attr.for "uif-meeting-time")
                        ]
        , test "input carries the same stable id" <|
            \_ ->
                Ui.TimePicker.new
                    { label = "Meeting time"
                    , value = "09:00"
                    , onChange = always ()
                    }
                    |> Ui.TimePicker.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "input" ]
                    |> Query.has [ Selector.id "uif-meeting-time" ]
        , test "withId overrides on both label and control" <|
            \_ ->
                Ui.TimePicker.new
                    { label = "Meeting time"
                    , value = "09:00"
                    , onChange = always ()
                    }
                    |> Ui.TimePicker.withId "mt"
                    |> Ui.TimePicker.view
                    |> Query.fromHtml
                    |> Expect.all
                        [ Query.find [ Selector.tag "label" ]
                            >> Query.has [ Selector.attribute (Attr.for "mt") ]
                        , Query.find [ Selector.tag "input" ]
                            >> Query.has [ Selector.id "mt" ]
                        ]
        ]
