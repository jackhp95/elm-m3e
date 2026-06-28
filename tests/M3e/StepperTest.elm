module M3e.StepperTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Button as Button
import M3e.Element as Element exposing (Element)
import M3e.Node as Node exposing (Node)
import M3e.Stepper as Stepper
import M3e.Value as Value
import Test exposing (Test, describe, test)


step1 : Element { step : Element.Supported } msg
step1 =
    Stepper.step { label = "Shipping" }
        [ Stepper.stepId "s1"
        , Stepper.stepFor "p1"
        , Stepper.stepSelected True
        ]


step2 : Element { step : Element.Supported } msg
step2 =
    Stepper.step { label = "Payment" }
        [ Stepper.stepId "s2"
        , Stepper.stepFor "p2"
        ]


actionButton : Element { button : Element.Supported } msg
actionButton =
    Button.view { label = "Next", variant = Value.filled } []


panel1 : Element { stepPanel : Element.Supported } msg
panel1 =
    Stepper.stepPanel { content = [] }
        [ Stepper.panelId "p1"
        , Stepper.panelActions [ actionButton ]
        ]


panel2 : Element { stepPanel : Element.Supported } msg
panel2 =
    Stepper.stepPanel { content = [] } [ Stepper.panelId "p2" ]


stripNode : List (Stepper.Option msg) -> Node msg
stripNode opts =
    Stepper.view
        { steps = [ step1, step2 ]
        , panels = [ panel1, panel2 ]
        }
        opts
        |> Element.toNode


suite : Test
suite =
    describe "M3e.Stepper — view-style port"
        [ test "view renders <m3e-stepper>" <|
            \_ ->
                stripNode []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-stepper")
        , test "step helper renders <m3e-step>" <|
            \_ ->
                step1
                    |> Element.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-step")
        , test "stepPanel helper renders <m3e-step-panel>" <|
            \_ ->
                panel1
                    |> Element.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-step-panel")
        , test "steps receive slot=\"step\" from view" <|
            \_ ->
                stripNode []
                    |> Node.childrenOf
                    |> List.take 2
                    |> List.map (Node.findAttribute "slot")
                    |> Expect.equal [ Just "step", Just "step" ]
        , test "panels receive slot=\"panel\" from view" <|
            \_ ->
                stripNode []
                    |> Node.childrenOf
                    |> List.drop 2
                    |> List.map (Node.findAttribute "slot")
                    |> Expect.equal [ Just "panel", Just "panel" ]
        , test "selected=true is a DOM property on step" <|
            \_ ->
                step1
                    |> Element.toNode
                    |> Node.findProperty "selected"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "selected=false on unselected step" <|
            \_ ->
                step2
                    |> Element.toNode
                    |> Node.findProperty "selected"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "stepId sets the 'id' attribute on the step" <|
            \_ ->
                step1
                    |> Element.toNode
                    |> Node.findAttribute "id"
                    |> Expect.equal (Just "s1")
        , test "stepFor sets the 'for' attribute on the step" <|
            \_ ->
                step1
                    |> Element.toNode
                    |> Node.findAttribute "for"
                    |> Expect.equal (Just "p1")
        , test "panelId sets the 'id' attribute on the panel" <|
            \_ ->
                panel1
                    |> Element.toNode
                    |> Node.findAttribute "id"
                    |> Expect.equal (Just "p1")
        , test "Fix #13: panelActions slot is exactly \"actions\" (not \"actions-\")" <|
            \_ ->
                panel1
                    |> Element.toNode
                    |> Node.childrenOf
                    -- the actions div is the first (and only) child here
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "slot")
                    |> Expect.equal (Just "actions")
        , test "Fix #13: action buttons land inside the actions wrapper" <|
            \_ ->
                panel1
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.map (Node.childrenOf >> List.length)
                    |> Expect.equal (Just 1)
        , test "no actions child when panelActions is empty" <|
            \_ ->
                panel2
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 0
        , test "stepCompleted is a DOM property" <|
            \_ ->
                Stepper.step { label = "Done" } [ Stepper.stepCompleted True ]
                    |> Element.toNode
                    |> Node.findProperty "completed"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "linear=true is a DOM property on the stepper" <|
            \_ ->
                stripNode [ Stepper.linear True ]
                    |> Node.findProperty "linear"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "linear emits false by default" <|
            \_ ->
                stripNode []
                    |> Node.findProperty "linear"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        ]
