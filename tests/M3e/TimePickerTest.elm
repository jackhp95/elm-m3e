module M3e.TimePickerTest exposing (suite)

import Expect
import Html
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable
import M3e.TimePicker as TimePicker
import Test exposing (Test, describe, test)



-- Helpers ---------------------------------------------------------------------


viewNode : List (TimePicker.Option String) -> Node.Node String
viewNode opts =
    TimePicker.view { label = "Meeting time" } opts
        |> Renderable.toNode


labelChild : Node.Node msg -> Maybe (Node.Node msg)
labelChild node =
    Node.childrenOf node |> List.head


inputChild : Node.Node msg -> Maybe (Node.Node msg)
inputChild node =
    Node.childrenOf node |> List.drop 1 |> List.head



-- Tests -----------------------------------------------------------------------


suite : Test
suite =
    describe "M3e.TimePicker — view-style port (native <input type=time>)"
        [ -- Tag
          test "view renders <m3e-form-field>" <|
            \_ ->
                viewNode []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-form-field")
        , test "input child renders <input>" <|
            \_ ->
                inputChild (viewNode [])
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "input")
        , test "input always has type='time'" <|
            \_ ->
                inputChild (viewNode [])
                    |> Maybe.andThen (Node.findAttribute "type")
                    |> Expect.equal (Just "time")

        -- Label / id wiring
        , test "label child has 'for' attribute set" <|
            \_ ->
                labelChild (viewNode [])
                    |> Maybe.andThen (Node.findAttribute "for")
                    |> Expect.notEqual Nothing
        , test "input 'id' matches label 'for'" <|
            \_ ->
                let
                    node =
                        viewNode []

                    labelFor =
                        labelChild node |> Maybe.andThen (Node.findAttribute "for")

                    inputId =
                        inputChild node |> Maybe.andThen (Node.findAttribute "id")
                in
                Expect.equal labelFor inputId
        , test "id overrides the derived id on label and input" <|
            \_ ->
                let
                    node =
                        viewNode [ TimePicker.id "meeting-t" ]

                    labelFor =
                        labelChild node |> Maybe.andThen (Node.findAttribute "for")

                    inputId =
                        inputChild node |> Maybe.andThen (Node.findAttribute "id")
                in
                Expect.all
                    [ \_ -> Expect.equal (Just "meeting-t") labelFor
                    , \_ -> Expect.equal (Just "meeting-t") inputId
                    ]
                    ()

        -- Value property
        , test "value sets the 'value' DOM property" <|
            \_ ->
                inputChild (viewNode [ TimePicker.value "14:30" ])
                    |> Maybe.andThen (Node.findProperty "value")
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "\"14:30\"")
        , test "value absent by default" <|
            \_ ->
                inputChild (viewNode [])
                    |> Maybe.andThen (Node.findProperty "value")
                    |> Expect.equal Nothing

        -- min / max / step attributes
        , test "min sets the 'min' attribute" <|
            \_ ->
                inputChild (viewNode [ TimePicker.min "09:00" ])
                    |> Maybe.andThen (Node.findAttribute "min")
                    |> Expect.equal (Just "09:00")
        , test "max sets the 'max' attribute" <|
            \_ ->
                inputChild (viewNode [ TimePicker.max "17:00" ])
                    |> Maybe.andThen (Node.findAttribute "max")
                    |> Expect.equal (Just "17:00")
        , test "step sets the 'step' attribute as a string" <|
            \_ ->
                inputChild (viewNode [ TimePicker.step 60 ])
                    |> Maybe.andThen (Node.findAttribute "step")
                    |> Expect.equal (Just "60")

        -- disabled / required
        , test "disabled True sets 'disabled' DOM property" <|
            \_ ->
                inputChild (viewNode [ TimePicker.disabled True ])
                    |> Maybe.andThen (Node.findProperty "disabled")
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "required True sets 'required' DOM property" <|
            \_ ->
                inputChild (viewNode [ TimePicker.required True ])
                    |> Maybe.andThen (Node.findProperty "required")
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disabled absent by default" <|
            \_ ->
                inputChild (viewNode [])
                    |> Maybe.andThen (Node.findProperty "disabled")
                    |> Expect.equal Nothing

        -- Slot children
        , test "hint adds a child with slot='hint'" <|
            \_ ->
                viewNode [ TimePicker.hint (Html.text "24-hour format") ]
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "hint")
                    |> List.isEmpty
                    |> Expect.equal False
        , test "error adds a child with slot='error'" <|
            \_ ->
                viewNode [ TimePicker.error (Html.text "Invalid time") ]
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "error")
                    |> List.isEmpty
                    |> Expect.equal False
        ]
