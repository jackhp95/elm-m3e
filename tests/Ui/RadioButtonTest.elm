module Ui.RadioButtonTest exposing (suite)

import Expect
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.RadioButton


type Pricing
    = Monthly
    | Yearly


pricing : Ui.RadioButton.RadioGroup Pricing ()
pricing =
    Ui.RadioButton.group
        { label = "Billing cycle"
        , options =
            [ Ui.RadioButton.option { value = Monthly, label = "Monthly" }
            , Ui.RadioButton.option { value = Yearly, label = "Yearly" }
            ]
        , selected = Just Monthly
        , onChange = always ()
        }


suite : Test
suite =
    describe "Ui.RadioButton"
        [ test "label carries slot=label and for=<stable id>" <|
            \_ ->
                pricing
                    |> Ui.RadioButton.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "label" ]
                    |> Query.has
                        [ Selector.attribute (Attr.attribute "slot" "label")
                        , Selector.attribute (Attr.for "uif-billing-cycle")
                        ]
        , test "group carries the stable id" <|
            \_ ->
                pricing
                    |> Ui.RadioButton.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-radio-group" ]
                    |> Query.has [ Selector.id "uif-billing-cycle" ]
        , test "group carries a name attribute" <|
            \_ ->
                pricing
                    |> Ui.RadioButton.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-radio-group" ]
                    |> Query.has [ Selector.attribute (Attr.name "uif-billing-cycle") ]
        , test "every radio shares the same name as the group" <|
            \_ ->
                pricing
                    |> Ui.RadioButton.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.tag "m3e-radio" ]
                    |> Query.each
                        (Query.has [ Selector.attribute (Attr.name "uif-billing-cycle") ])
        , test "withId overrides the group id and the derived name" <|
            \_ ->
                pricing
                    |> Ui.RadioButton.withId "bc"
                    |> Ui.RadioButton.view
                    |> Query.fromHtml
                    |> Expect.all
                        [ Query.find [ Selector.tag "m3e-radio-group" ]
                            >> Query.has
                                [ Selector.id "bc"
                                , Selector.attribute (Attr.name "bc")
                                ]
                        , Query.findAll [ Selector.tag "m3e-radio" ]
                            >> Query.each
                                (Query.has [ Selector.attribute (Attr.name "bc") ])
                        ]
        ]
