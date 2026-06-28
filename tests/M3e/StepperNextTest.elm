module M3e.StepperNextTest exposing (suite)

import Expect
import M3e.Element as Element exposing (Element)
import M3e.Node as Node exposing (Node)
import M3e.StepperNext as StepperNext
import Test exposing (Test, describe, test)


label : Element { element : Element.Supported } msg
label =
    Element.text "Next"


node : Node msg
node =
    StepperNext.view [ label ] |> Element.toNode


suite : Test
suite =
    describe "M3e.StepperNext — view-style port"
        [ test "renders <m3e-stepper-next>" <|
            \_ ->
                node
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-stepper-next")
        , test "content lands in default slot" <|
            \_ ->
                node
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 1
        , test "no children when passed empty list" <|
            \_ ->
                StepperNext.view []
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 0
        ]
