module M3e.RadioButtonTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Node as Node
import M3e.RadioButton as RadioButton
import M3e.Renderable as Renderable
import Test exposing (Test, describe, test)


options : List { value : String, label : String }
options =
    [ { value = "monthly", label = "Monthly" }
    , { value = "yearly", label = "Yearly" }
    ]


groupNode : Maybe String -> List (RadioButton.Option msg) -> Node.Node msg
groupNode sel opts =
    RadioButton.view
        { name = "Billing cycle"
        , options = options
        , selected = sel
        }
        opts
        |> Renderable.toNode


suite : Test
suite =
    describe "M3e.RadioButton — view-style port"
        [ test "renders <m3e-radio-group>" <|
            \_ ->
                groupNode Nothing []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-radio-group")
        , test "aria-label equals the required name field" <|
            \_ ->
                groupNode Nothing []
                    |> Node.findAttribute "aria-label"
                    |> Expect.equal (Just "Billing cycle")
        , test "name attribute equals the required name field (links radios)" <|
            \_ ->
                groupNode Nothing []
                    |> Node.findAttribute "name"
                    |> Expect.equal (Just "Billing cycle")
        , test "each option produces a <label> child" <|
            \_ ->
                groupNode Nothing []
                    |> Node.childrenOf
                    |> List.filterMap Node.tagOf
                    |> Expect.equal [ "label", "label" ]
        , test "inside each <label>, first child is <m3e-radio>" <|
            \_ ->
                groupNode Nothing []
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.map Node.childrenOf
                    |> Maybe.andThen List.head
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "m3e-radio")
        , test "F-bug fix: <m3e-radio> has NO children (label is a sibling)" <|
            \_ ->
                groupNode Nothing []
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.map Node.childrenOf
                    |> Maybe.andThen List.head
                    |> Maybe.map (Node.childrenOf >> List.length)
                    |> Expect.equal (Just 0)
        , test "selected option has checked=true property on its radio" <|
            \_ ->
                groupNode (Just "monthly") []
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.map Node.childrenOf
                    |> Maybe.andThen List.head
                    |> Maybe.andThen (Node.findProperty "checked")
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "unselected option has checked=false property on its radio" <|
            \_ ->
                groupNode (Just "monthly") []
                    |> Node.childrenOf
                    |> List.drop 1
                    |> List.head
                    |> Maybe.map Node.childrenOf
                    |> Maybe.andThen List.head
                    |> Maybe.andThen (Node.findProperty "checked")
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "disabled option sets disabled property on the group" <|
            \_ ->
                groupNode Nothing [ RadioButton.disabled True ]
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disabled absent by default" <|
            \_ ->
                groupNode Nothing []
                    |> Node.findProperty "disabled"
                    |> Expect.equal Nothing
        , test "required option sets required property on the group" <|
            \_ ->
                groupNode Nothing [ RadioButton.required True ]
                    |> Node.findProperty "required"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "each radio carries the group name attribute" <|
            \_ ->
                groupNode Nothing []
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.map Node.childrenOf
                    |> Maybe.andThen List.head
                    |> Maybe.andThen (Node.findAttribute "name")
                    |> Expect.equal (Just "Billing cycle")
        ]
