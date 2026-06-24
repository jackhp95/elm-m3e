module Ui.CheckboxTest exposing (suite)

import Expect
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Checkbox


suite : Test
suite =
    describe "Ui.Checkbox label anchoring"
        [ test "label carries slot=label and for=<stable id>" <|
            \_ ->
                Ui.Checkbox.boolean
                    { label = "I agree to the terms"
                    , checked = False
                    , onChange = always ()
                    }
                    |> Ui.Checkbox.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "label" ]
                    |> Query.has
                        [ Selector.attribute (Attr.attribute "slot" "label")
                        , Selector.attribute (Attr.for "uif-i-agree-to-the-terms")
                        ]
        , test "control carries the same stable id as the label's for" <|
            \_ ->
                Ui.Checkbox.boolean
                    { label = "I agree to the terms"
                    , checked = False
                    , onChange = always ()
                    }
                    |> Ui.Checkbox.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-checkbox" ]
                    |> Query.has [ Selector.id "uif-i-agree-to-the-terms" ]
        , test "withId overrides the stable id on both label and control" <|
            \_ ->
                Ui.Checkbox.boolean
                    { label = "Subscribe"
                    , checked = True
                    , onChange = always ()
                    }
                    |> Ui.Checkbox.withId "sub-1"
                    |> Ui.Checkbox.view
                    |> Query.fromHtml
                    |> Expect.all
                        [ Query.find [ Selector.tag "label" ]
                            >> Query.has [ Selector.attribute (Attr.for "sub-1") ]
                        , Query.find [ Selector.tag "m3e-checkbox" ]
                            >> Query.has [ Selector.id "sub-1" ]
                        ]
        ]
