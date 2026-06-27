module M3e.SelectTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element exposing (Element)
import M3e.Node as Node exposing (Node)
import M3e.Select as Select
import Test exposing (Test, describe, test)



-- Helpers ---------------------------------------------------------------------


viewNode : List (Select.Option String) -> Node String
viewNode opts =
    Select.view { label = "Plan" } opts
        |> Element.toNode


labelChild : Node msg -> Maybe (Node msg)
labelChild node =
    Node.childrenOf node |> List.head


selectChild : Node msg -> Maybe (Node msg)
selectChild node =
    Node.childrenOf node |> List.drop 1 |> List.head


freeOpt : Element { selectOption : Element.Supported } String
freeOpt =
    Select.option { value = "free", label = "Free" } []


proOpt : Element { selectOption : Element.Supported } String
proOpt =
    Select.option { value = "pro", label = "Pro" } [ Select.optionSelected True ]



-- Tests -----------------------------------------------------------------------


suite : Test
suite =
    describe "M3e.Select — view-style port (fix #13 relational label)"
        [ -- Tag
          test "view renders <m3e-form-field>" <|
            \_ ->
                viewNode []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-form-field")
        , test "select child renders <m3e-select>" <|
            \_ ->
                selectChild (viewNode [])
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "m3e-select")

        -- Fix #13 — relational label wiring
        , test "label child has 'for' attribute (fix #13: not an inert attr on m3e-select)" <|
            \_ ->
                labelChild (viewNode [])
                    |> Maybe.andThen (Node.findAttribute "for")
                    |> Expect.notEqual Nothing
        , test "m3e-select child has 'id' matching the label's 'for' (fix #13)" <|
            \_ ->
                let
                    node : Node String
                    node =
                        viewNode []

                    labelFor : Maybe String
                    labelFor =
                        labelChild node |> Maybe.andThen (Node.findAttribute "for")

                    selectId : Maybe String
                    selectId =
                        selectChild node |> Maybe.andThen (Node.findAttribute "id")
                in
                Expect.equal labelFor selectId
        , test "m3e-select does NOT have an inert 'label' attribute (fix #13)" <|
            \_ ->
                selectChild (viewNode [])
                    |> Maybe.andThen (Node.findAttribute "label")
                    |> Expect.equal Nothing
        , test "id overrides derived id on both label 'for' and select 'id'" <|
            \_ ->
                let
                    node : Node String
                    node =
                        viewNode [ Select.id "plan-sel" ]

                    labelFor : Maybe String
                    labelFor =
                        labelChild node |> Maybe.andThen (Node.findAttribute "for")

                    selectId : Maybe String
                    selectId =
                        selectChild node |> Maybe.andThen (Node.findAttribute "id")
                in
                Expect.all
                    [ \_ -> Expect.equal (Just "plan-sel") labelFor
                    , \_ -> Expect.equal (Just "plan-sel") selectId
                    ]
                    ()

        -- Properties
        , test "multi True sets 'multi' DOM property on m3e-select" <|
            \_ ->
                selectChild (viewNode [ Select.multi True ])
                    |> Maybe.andThen (Node.findProperty "multi")
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "multi emits false by default" <|
            \_ ->
                selectChild (viewNode [])
                    |> Maybe.andThen (Node.findProperty "multi")
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "required True sets 'required' DOM property" <|
            \_ ->
                selectChild (viewNode [ Select.required True ])
                    |> Maybe.andThen (Node.findProperty "required")
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disabled True sets 'disabled' DOM property" <|
            \_ ->
                selectChild (viewNode [ Select.disabled True ])
                    |> Maybe.andThen (Node.findProperty "disabled")
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")

        -- Options
        , test "options populates m3e-select children" <|
            \_ ->
                selectChild (viewNode [ Select.options [ freeOpt, proOpt ] ])
                    |> Maybe.map Node.childrenOf
                    |> Maybe.map List.length
                    |> Expect.equal (Just 2)
        , test "option renders <m3e-option>" <|
            \_ ->
                freeOpt
                    |> Element.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-option")
        , test "option value is set as the 'value' attribute on <m3e-option>" <|
            \_ ->
                freeOpt
                    |> Element.toNode
                    |> Node.findAttribute "value"
                    |> Expect.equal (Just "free")
        , test "optionSelected=true sets 'selected' DOM property on option" <|
            \_ ->
                proOpt
                    |> Element.toNode
                    |> Node.findProperty "selected"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "optionSelected=false by default" <|
            \_ ->
                freeOpt
                    |> Element.toNode
                    |> Node.findProperty "selected"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        ]
