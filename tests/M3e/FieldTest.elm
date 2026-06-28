module M3e.FieldTest exposing (suite)

import Expect
import Html
import M3e.Element as Element exposing (Element)
import M3e.Field as Field
import M3e.Label as Label
import M3e.Node as Node exposing (Node)
import M3e.Value as Value
import Test exposing (Test, describe, test)


{-| An element-bearing control (the only kind Field accepts).
-}
inputElement : Element { s | element : Element.Supported } msg
inputElement =
    Element.element { tag = "input" } [ Node.attribute "type" "email" ] []


suite : Test
suite =
    describe "M3e.Field — relational composition over the IR"
        [ test "label[for] and control[id] wired to the same generated id" <|
            \_ ->
                let
                    node : Node msg
                    node =
                        Field.view
                            { id = "field-email"
                            , label = Label.fromHtml (Html.text "Email")
                            , control = inputElement
                            }
                            []

                    kids : List (Node msg)
                    kids =
                        Node.childrenOf node
                in
                ( kids |> List.head |> Maybe.andThen (Node.findAttribute "for")
                , kids |> List.drop 1 |> List.head |> Maybe.andThen (Node.findAttribute "id")
                )
                    |> Expect.equal ( Just "field-email", Just "field-email" )
        , test "control node carries the injected id attribute" <|
            \_ ->
                Field.view
                    { id = "ctrl-id"
                    , label = Label.fromHtml (Html.text "Label")
                    , control = inputElement
                    }
                    []
                    |> Node.childrenOf
                    |> List.drop 1
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "id")
                    |> Expect.equal (Just "ctrl-id")

        -- Fix #66 — variant option
        , test "fix-#66: no variant option — no variant attribute by default (upstream default outlined)" <|
            \_ ->
                Field.view
                    { id = "f"
                    , label = Label.fromHtml (Html.text "L")
                    , control = inputElement
                    }
                    []
                    |> Node.findAttribute "variant"
                    |> Expect.equal Nothing
        , test "fix-#66: Filled variant emits variant=filled" <|
            \_ ->
                Field.view
                    { id = "f"
                    , label = Label.fromHtml (Html.text "L")
                    , control = inputElement
                    }
                    [ Field.variant Value.filled ]
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "filled")
        , test "fix-#66: Outlined variant emits variant=outlined" <|
            \_ ->
                Field.view
                    { id = "f"
                    , label = Label.fromHtml (Html.text "L")
                    , control = inputElement
                    }
                    [ Field.variant Value.outlined ]
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "outlined")
        ]
