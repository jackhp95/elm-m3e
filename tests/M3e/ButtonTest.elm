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
        ]


childText : Node msg -> Maybe String
childText n =
    case n of
        Node.Text s ->
            Just s

        _ ->
            Nothing
