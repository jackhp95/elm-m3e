module M3e.ButtonGroupTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Button as Button
import M3e.ButtonGroup as ButtonGroup
import M3e.Element as Element
import M3e.Node as Node
import Test exposing (Test, describe, test)


button1 : Element.Element { button : Element.Supported } msg
button1 =
    Button.view { label = "Save", variant = Button.Filled } []


button2 : Element.Element { button : Element.Supported } msg
button2 =
    Button.view { label = "Cancel", variant = Button.Text } []


node : List (ButtonGroup.Option msg) -> Node.Node msg
node opts =
    ButtonGroup.view { buttons = [ button1, button2 ] } opts
        |> Element.toNode


suite : Test
suite =
    describe "M3e.ButtonGroup — view-style port"
        [ test "renders <m3e-button-group>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-button-group")
        , test "children are the provided buttons" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        , test "each child renders as <m3e-button>" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.filterMap Node.tagOf
                    |> Expect.equal [ "m3e-button", "m3e-button" ]
        , test "multi=true is a DOM property — introspectable" <|
            \_ ->
                node [ ButtonGroup.multi True ]
                    |> Node.findProperty "multi"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "multi absent by default" <|
            \_ ->
                node []
                    |> Node.findProperty "multi"
                    |> Expect.equal Nothing
        ]
