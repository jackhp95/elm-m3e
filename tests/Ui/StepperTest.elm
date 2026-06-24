module Ui.StepperTest exposing (suite)

import Html
import Html.Attributes
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Stepper


suite : Test
suite =
    describe "Ui.Stepper"
        [ test "withDefaultSelected does NOT emit the raw selected=\"true\" string attribute" <|
            \_ ->
                -- The typed M3e.Step.selected sets the `selected` DOM
                -- property; the old raw `Attr.attribute \"selected\" \"true\"`
                -- emitted a literal attribute the element ignores.
                Ui.Stepper.new
                    |> Ui.Stepper.withId "wizard"
                    |> Ui.Stepper.withStep
                        (Ui.Stepper.step "one" (Html.text "One") [])
                    |> Ui.Stepper.withDefaultSelected "one"
                    |> Ui.Stepper.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-step" ]
                    |> Query.hasNot
                        [ Selector.attribute
                            (Html.Attributes.attribute "selected" "true")
                        ]
        ]
