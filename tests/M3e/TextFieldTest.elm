module M3e.TextFieldTest exposing (suite)

import Expect
import Html
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable
import M3e.TextField as TextField
import Test exposing (Test, describe, test)


-- Helpers ---------------------------------------------------------------------


viewNode : List (TextField.Option String) -> Node.Node String
viewNode opts =
    TextField.view { label = "Email" } opts
        |> Renderable.toNode


labelChild : Node.Node msg -> Maybe (Node.Node msg)
labelChild node =
    Node.childrenOf node |> List.head


controlChild : Node.Node msg -> Maybe (Node.Node msg)
controlChild node =
    Node.childrenOf node |> List.drop 1 |> List.head


-- Tests -----------------------------------------------------------------------


suite : Test
suite =
    describe "M3e.TextField — view-style port"
        [ -- Tag
          test "view renders <m3e-form-field>" <|
            \_ ->
                viewNode []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-form-field")

        -- Label / id wiring
        , test "label child has the 'for' attribute set" <|
            \_ ->
                viewNode []
                    |> labelChild
                    |> Maybe.andThen (Node.findAttribute "for")
                    |> Expect.notEqual Nothing
        , test "control child has 'id' matching the label 'for'" <|
            \_ ->
                let
                    node =
                        viewNode []

                    labelFor =
                        labelChild node |> Maybe.andThen (Node.findAttribute "for")

                    controlId =
                        controlChild node |> Maybe.andThen (Node.findAttribute "id")
                in
                Expect.equal labelFor controlId
        , test "withId overrides the derived id on both label and input" <|
            \_ ->
                let
                    node =
                        viewNode [ TextField.withId "my-email" ]

                    labelFor =
                        labelChild node |> Maybe.andThen (Node.findAttribute "for")

                    controlId =
                        controlChild node |> Maybe.andThen (Node.findAttribute "id")
                in
                Expect.all
                    [ \_ -> Expect.equal (Just "my-email") labelFor
                    , \_ -> Expect.equal (Just "my-email") controlId
                    ]
                    ()

        -- Variant
        , test "withVariant Filled sets variant='filled' on the form-field" <|
            \_ ->
                viewNode [ TextField.withVariant TextField.Filled ]
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "filled")
        , test "withVariant Outlined sets variant='outlined'" <|
            \_ ->
                viewNode [ TextField.withVariant TextField.Outlined ]
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "outlined")
        , test "variant absent by default" <|
            \_ ->
                viewNode []
                    |> Node.findAttribute "variant"
                    |> Expect.equal Nothing

        -- Control tag
        , test "default control is <input>" <|
            \_ ->
                controlChild (viewNode [])
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "input")
        , test "multiline True renders <textarea>" <|
            \_ ->
                controlChild (viewNode [ TextField.multiline True ])
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "textarea")

        -- Input type
        , test "default input type is 'text'" <|
            \_ ->
                controlChild (viewNode [])
                    |> Maybe.andThen (Node.findAttribute "type")
                    |> Expect.equal (Just "text")
        , test "withInputType Password sets type='password'" <|
            \_ ->
                controlChild (viewNode [ TextField.withInputType TextField.Password ])
                    |> Maybe.andThen (Node.findAttribute "type")
                    |> Expect.equal (Just "password")
        , test "multiline control has no 'type' attribute" <|
            \_ ->
                controlChild (viewNode [ TextField.multiline True ])
                    |> Maybe.andThen (Node.findAttribute "type")
                    |> Expect.equal Nothing

        -- Value property
        , test "withValue sets the 'value' DOM property on the input" <|
            \_ ->
                controlChild (viewNode [ TextField.withValue "hello@example.com" ])
                    |> Maybe.andThen (Node.findProperty "value")
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "\"hello@example.com\"")
        , test "value absent by default" <|
            \_ ->
                controlChild (viewNode [])
                    |> Maybe.andThen (Node.findProperty "value")
                    |> Expect.equal Nothing

        -- disabled
        , test "withDisabled True sets the 'disabled' DOM property on the input" <|
            \_ ->
                controlChild (viewNode [ TextField.withDisabled True ])
                    |> Maybe.andThen (Node.findProperty "disabled")
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disabled absent by default" <|
            \_ ->
                controlChild (viewNode [])
                    |> Maybe.andThen (Node.findProperty "disabled")
                    |> Expect.equal Nothing

        -- Autosize sibling (bug #A6/#17 fix)
        , test "autosize adds a sibling <m3e-textarea-autosize>, not a wrapper" <|
            \_ ->
                viewNode [ TextField.multiline True, TextField.withAutosize { min = 3, max = 8 } ]
                    |> Node.childrenOf
                    -- label=0, textarea=1, autosize=2  (siblings under m3e-form-field)
                    |> List.drop 2
                    |> List.head
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "m3e-textarea-autosize")
        , test "autosize sibling 'for' matches the textarea id" <|
            \_ ->
                viewNode [ TextField.withId "desc", TextField.multiline True, TextField.withAutosize { min = 2, max = 6 } ]
                    |> Node.childrenOf
                    |> List.drop 2
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "for")
                    |> Expect.equal (Just "desc")
        , test "textarea is a direct child of m3e-form-field (not inside autosize)" <|
            \_ ->
                viewNode [ TextField.multiline True, TextField.withAutosize { min = 2, max = 6 } ]
                    |> Node.childrenOf
                    |> List.drop 1
                    |> List.head
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "textarea")

        -- Slot children
        , test "withHint adds a child with slot='hint'" <|
            \_ ->
                viewNode [ TextField.withHint (Html.text "Optional") ]
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "hint")
                    |> List.isEmpty
                    |> Expect.equal False
        , test "withError adds a child with slot='error'" <|
            \_ ->
                viewNode [ TextField.withError (Html.text "Required") ]
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "error")
                    |> List.isEmpty
                    |> Expect.equal False
        ]
