module Ui.StepperTest exposing (suite)

import Expect
import Html
import Html.Attributes
import M3e.Step
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Button
import Ui.Icon
import Ui.Stepper


richStep : Ui.Stepper.Step msg
richStep =
    Ui.Stepper.step "one" (Html.text "One") [ Html.text "Step body" ]
        |> Ui.Stepper.withStepIcon (Ui.Icon.material "person")
        |> Ui.Stepper.withStepHint (Html.text "Enter your name")
        |> Ui.Stepper.withStepError (Html.text "Name is required")
        |> Ui.Stepper.withStepActions
            [ Ui.Button.view
                (Ui.Button.new { label = "Next", variant = Ui.Button.Filled })
            ]


richStepper : Ui.Stepper.Stepper msg
richStepper =
    Ui.Stepper.new
        |> Ui.Stepper.withId "wizard"
        |> Ui.Stepper.withStep richStep


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
        , test "withStepIcon slots a custom icon onto the m3e-step" <|
            \_ ->
                richStepper
                    |> Ui.Stepper.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-step" ]
                    |> Query.findAll [ Selector.attribute (Html.Attributes.attribute "slot" "icon") ]
                    |> Query.count (Expect.equal 1)
        , test "withStepHint slots hint content onto the m3e-step" <|
            \_ ->
                richStepper
                    |> Ui.Stepper.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.attribute (Html.Attributes.attribute "slot" "hint") ]
                    |> Query.has [ Selector.text "Enter your name" ]
        , test "withStepError slots error content and marks the step invalid" <|
            \_ ->
                let
                    rendered =
                        richStepper |> Ui.Stepper.view |> Query.fromHtml
                in
                Expect.all
                    [ \r ->
                        r
                            |> Query.find [ Selector.attribute (Html.Attributes.attribute "slot" "error") ]
                            |> Query.has [ Selector.text "Name is required" ]
                    , \r ->
                        r
                            |> Query.find [ Selector.tag "m3e-step" ]
                            |> Query.has [ Selector.attribute (M3e.Step.invalid True) ]
                    ]
                    rendered
        , test "withStepActions slots an actions bar (slot=actions, not actions-) into the m3e-step-panel" <|
            \_ ->
                richStepper
                    |> Ui.Stepper.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-step-panel" ]
                    |> Query.findAll [ Selector.attribute (Html.Attributes.attribute "slot" "actions") ]
                    |> Query.count (Expect.equal 1)
        , test "withStepDisabled and withStepEditable emit on the m3e-step" <|
            \_ ->
                Ui.Stepper.new
                    |> Ui.Stepper.withId "wizard"
                    |> Ui.Stepper.withStep
                        (Ui.Stepper.step "one" (Html.text "One") []
                            |> Ui.Stepper.withStepDisabled True
                            |> Ui.Stepper.withStepEditable True
                        )
                    |> Ui.Stepper.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-step" ]
                    |> Query.has
                        [ Selector.attribute (M3e.Step.disabled True)
                        , Selector.attribute (M3e.Step.editable True)
                        ]
        , test "withHeaderPosition emits header-position on the m3e-stepper" <|
            \_ ->
                Ui.Stepper.new
                    |> Ui.Stepper.withId "wizard"
                    |> Ui.Stepper.withHeaderPosition Ui.Stepper.HeaderBelow
                    |> Ui.Stepper.withStep (Ui.Stepper.step "one" (Html.text "One") [])
                    |> Ui.Stepper.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-stepper"
                        , Selector.attribute (Html.Attributes.attribute "header-position" "below")
                        ]
        , test "step is associated to its panel by for/id" <|
            \_ ->
                let
                    rendered =
                        richStepper |> Ui.Stepper.view |> Query.fromHtml
                in
                Expect.all
                    [ \r ->
                        r
                            |> Query.find [ Selector.tag "m3e-step" ]
                            |> Query.has [ Selector.attribute (Html.Attributes.attribute "for" "wizard-panel-one") ]
                    , \r ->
                        r
                            |> Query.find [ Selector.tag "m3e-step-panel" ]
                            |> Query.has [ Selector.id "wizard-panel-one" ]
                    ]
                    rendered
        ]
