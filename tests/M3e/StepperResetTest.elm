module M3e.StepperResetTest exposing (suite)

import Expect
import M3e.Element as Element exposing (Element)
import M3e.Node as Node exposing (Node)
import M3e.StepperReset as StepperReset
import Test exposing (Test, describe, test)


label : Element { element : Element.Supported } msg
label =
    Element.text "Restart"


node : Node msg
node =
    StepperReset.view [ label ] |> Element.toNode


suite : Test
suite =
    describe "M3e.StepperReset — view-style port"
        [ test "renders <m3e-stepper-reset>" <|
            \_ ->
                node
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-stepper-reset")
        , test "content lands in default slot" <|
            \_ ->
                node
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 1
        , test "no children when passed empty list" <|
            \_ ->
                StepperReset.view []
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 0
        ]
