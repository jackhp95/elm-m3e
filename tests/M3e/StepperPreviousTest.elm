module M3e.StepperPreviousTest exposing (suite)

import Expect
import M3e.Element as Element exposing (Element)
import M3e.Node as Node exposing (Node)
import M3e.StepperPrevious as StepperPrevious
import Test exposing (Test, describe, test)


label : Element { element : Element.Supported } msg
label =
    Element.text "Back"


node : Node msg
node =
    StepperPrevious.view [ label ] |> Element.toNode


suite : Test
suite =
    describe "M3e.StepperPrevious — view-style port"
        [ test "renders <m3e-stepper-previous>" <|
            \_ ->
                node
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-stepper-previous")
        , test "content lands in default slot" <|
            \_ ->
                node
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 1
        , test "no children when passed empty list" <|
            \_ ->
                StepperPrevious.view []
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 0
        ]
