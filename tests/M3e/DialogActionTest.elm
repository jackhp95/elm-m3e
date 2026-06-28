module M3e.DialogActionTest exposing (suite)

import Expect
import M3e.DialogAction as DialogAction
import M3e.Element as Element exposing (Element)
import M3e.Node as Node exposing (Node)
import Test exposing (Test, describe, test)


label : Element { element : Element.Supported } msg
label =
    Element.text "Confirm"


node : List (DialogAction.Option msg) -> Node msg
node opts =
    DialogAction.view [ label ] opts |> Element.toNode


suite : Test
suite =
    describe "M3e.DialogAction — view-style port"
        [ test "renders <m3e-dialog-action>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-dialog-action")
        , test "content lands in default slot" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 1
        , test "returnValue sets the introspectable attribute" <|
            \_ ->
                node [ DialogAction.returnValue "confirm" ]
                    |> Node.findAttribute "return-value"
                    |> Expect.equal (Just "confirm")
        , test "returnValue is absent by default" <|
            \_ ->
                node []
                    |> Node.findAttribute "return-value"
                    |> Expect.equal Nothing
        ]
