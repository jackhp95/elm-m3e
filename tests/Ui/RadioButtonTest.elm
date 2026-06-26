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
    describe "Ui.RadioButton (bare group)"
        [ test "renders a bare m3e-radio-group with the group label as aria-label" <|
            \_ ->
                pricing
                    |> Ui.RadioButton.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-radio-group"
                        , Selector.attribute (Attr.attribute "aria-label" "Billing cycle")
                        ]
        , test "renders no m3e-form-field and no visible label" <|
            \_ ->
                pricing
                    |> Ui.RadioButton.view
                    |> Query.fromHtml
                    |> Expect.all
                        [ Query.findAll [ Selector.tag "m3e-form-field" ] >> Query.count (Expect.equal 0)
                        , Query.findAll [ Selector.tag "label" ] >> Query.count (Expect.equal 0)
                        ]
        , test "group carries the stable id and a matching name" <|
            \_ ->
                pricing
                    |> Ui.RadioButton.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-radio-group"
                        , Selector.id "uif-billing-cycle"
                        , Selector.attribute (Attr.name "uif-billing-cycle")
                        ]
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
                        [ Query.has
                            [ Selector.tag "m3e-radio-group"
                            , Selector.id "bc"
                            , Selector.attribute (Attr.name "bc")
                            ]
                        , Query.findAll [ Selector.tag "m3e-radio" ]
                            >> Query.each
                                (Query.has [ Selector.attribute (Attr.name "bc") ])
                        ]
        ]
