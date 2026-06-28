module M3e.RadioButtonTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element
import M3e.Node as Node exposing (Attr(..), Node(..))
import M3e.RadioButton as RadioButton
import Test exposing (Test, describe, test)


options : List { value : String, label : String }
options =
    [ { value = "monthly", label = "Monthly" }
    , { value = "yearly", label = "Yearly" }
    ]


groupNode : Maybe String -> List (RadioButton.Option msg) -> Node msg
groupNode sel opts =
    RadioButton.view
        { name = "Billing cycle"
        , options = options
        , selected = sel
        }
        opts
        |> Element.toNode


{-| Count the number of RawAttr (event listeners / opaque attrs) on an element
node. Used to verify that event handlers are registered.
-}
countRawAttrs : Node msg -> Int
countRawAttrs node =
    case node of
        Element { attrs } ->
            List.length
                (List.filter
                    (\a ->
                        case a of
                            RawAttr _ ->
                                True

                            _ ->
                                False
                    )
                    attrs
                )

        _ ->
            0


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
        , test "disabled emits false by default" <|
            \_ ->
                groupNode Nothing []
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
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
        , test "each radio carries a value attribute matching its option value" <|
            \_ ->
                -- Required so event.target.value on the group's change event
                -- returns the correct option value string.
                groupNode Nothing []
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.map Node.childrenOf
                    |> Maybe.andThen List.head
                    |> Maybe.andThen (Node.findAttribute "value")
                    |> Expect.equal (Just "monthly")
        , test "onChange wires a 'change' event on the group (not a per-radio click)" <|
            \_ ->
                -- The change event handler is placed on <m3e-radio-group>,
                -- not on individual <m3e-radio> elements. Without onChange
                -- the group has 0 RawAttrs; with it, 1.
                let
                    withoutHandler : Int
                    withoutHandler =
                        groupNode Nothing [] |> countRawAttrs

                    withHandler : Int
                    withHandler =
                        groupNode Nothing [ RadioButton.onChange identity ] |> countRawAttrs
                in
                Expect.all
                    [ \_ -> withoutHandler |> Expect.equal 0
                    , \_ -> withHandler |> Expect.greaterThan 0
                    ]
                    ()
        , test "onChange does NOT add a RawAttr to individual radios (group-level event)" <|
            \_ ->
                -- The <m3e-radio> child should have NO opaque event listeners;
                -- the change handler lives on the group element.
                groupNode Nothing [ RadioButton.onChange identity ]
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.map Node.childrenOf
                    |> Maybe.andThen List.head
                    |> Maybe.map countRawAttrs
                    |> Expect.equal (Just 0)
        ]
