module Ui.CheckboxTest exposing (suite)

import Expect
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Checkbox


suite : Test
suite =
    describe "Ui.Checkbox (bare control)"
        [ test "renders a bare m3e-checkbox with the label as aria-label" <|
            \_ ->
                Ui.Checkbox.boolean
                    { label = "I agree to the terms"
                    , checked = False
                    , onChange = always ()
                    }
                    |> Ui.Checkbox.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-checkbox"
                        , Selector.attribute (Attr.attribute "aria-label" "I agree to the terms")
                        ]
        , test "renders no m3e-form-field and no visible label" <|
            \_ ->
                Ui.Checkbox.boolean
                    { label = "I agree to the terms"
                    , checked = False
                    , onChange = always ()
                    }
                    |> Ui.Checkbox.view
                    |> Query.fromHtml
                    |> Expect.all
                        [ Query.findAll [ Selector.tag "m3e-form-field" ] >> Query.count (Expect.equal 0)
                        , Query.findAll [ Selector.tag "label" ] >> Query.count (Expect.equal 0)
                        ]
        , test "control carries the stable id derived from the label" <|
            \_ ->
                Ui.Checkbox.boolean
                    { label = "I agree to the terms"
                    , checked = False
                    , onChange = always ()
                    }
                    |> Ui.Checkbox.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-checkbox", Selector.id "uif-i-agree-to-the-terms" ]
        , test "withId overrides the stable id on the control" <|
            \_ ->
                Ui.Checkbox.boolean
                    { label = "Subscribe"
                    , checked = True
                    , onChange = always ()
                    }
                    |> Ui.Checkbox.withId "sub-1"
                    |> Ui.Checkbox.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-checkbox", Selector.id "sub-1" ]
        ]
