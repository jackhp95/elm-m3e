module M3e.ButtonTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Button as Button
import M3e.Element as Element
import M3e.Icon as Icon
import M3e.Node as Node exposing (Node)
import Test exposing (Test, describe, test)


node : String -> List (Button.Option msg) -> Node msg
node label opts =
    Button.view { label = label, variant = Button.Filled } opts |> Element.toNode


suite : Test
suite =
    describe "M3e.Button — view-style port"
        [ test "renders <m3e-button> with the label as its (accessible) text" <|
            \_ ->
                node "Save" []
                    |> (\n -> ( Node.tagOf n, Node.childrenOf n |> List.filterMap childText ))
                    |> Expect.equal ( Just "m3e-button", [ "Save" ] )
        , test "disabled is a DOM property — introspectable/testable (Test.Html can't)" <|
            \_ ->
                node "Save" [ Button.disabled True ]
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "leadingIcon is slotted into slot=icon, and is an <m3e-icon>" <|
            \_ ->
                node "Add" [ Button.leadingIcon (Icon.view { name = "add" }) ]
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.map (\n -> ( Node.tagOf n, Node.findAttribute "slot" n ))
                    |> Expect.equal (Just ( Just "m3e-icon", Just "icon" ))
        , test "name option emits name attribute (FormSubmitter)" <|
            \_ ->
                node "Save" [ Button.name "action" ]
                    |> Node.findAttribute "name"
                    |> Expect.equal (Just "action")
        , test "value option emits value attribute (FormSubmitter)" <|
            \_ ->
                node "Save" [ Button.value "save" ]
                    |> Node.findAttribute "value"
                    |> Expect.equal (Just "save")
        , test "formType Submit emits type=submit (FormSubmitter)" <|
            \_ ->
                node "Submit" [ Button.formType Button.Submit ]
                    |> Node.findAttribute "type"
                    |> Expect.equal (Just "submit")
        , test "formType Reset emits type=reset (FormSubmitter)" <|
            \_ ->
                node "Reset" [ Button.formType Button.Reset ]
                    |> Node.findAttribute "type"
                    |> Expect.equal (Just "reset")
        , test "formType Button emits type=button (FormSubmitter)" <|
            \_ ->
                node "Button" [ Button.formType Button.Button ]
                    |> Node.findAttribute "type"
                    |> Expect.equal (Just "button")
        , test "no formType — no type attribute emitted by default" <|
            \_ ->
                node "Save" []
                    |> Node.findAttribute "type"
                    |> Expect.equal Nothing
        ]


childText : Node msg -> Maybe String
childText n =
    case n of
        Node.Text s ->
            Just s

        _ ->
            Nothing
