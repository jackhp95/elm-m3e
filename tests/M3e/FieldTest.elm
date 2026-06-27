module M3e.FieldTest exposing (suite)

import Expect
import Html
import M3e.Field as Field
import M3e.Label as Label
import M3e.Node as Node
import M3e.Renderable as Renderable
import Test exposing (Test, describe, test)


{-| An element-bearing control (the only kind Field accepts).
-}
inputElement : Renderable.Renderable { s | element : Renderable.Supported } msg
inputElement =
    Renderable.element { tag = "input" } [ Node.attribute "type" "email" ] []


suite : Test
suite =
    describe "M3e.Field — relational composition over the IR"
        [ test "label[for] and control[id] wired to the same generated id" <|
            \_ ->
                let
                    node : Node.Node msg
                    node =
                        Field.view
                            { id = "field-email"
                            , label = Label.fromHtml (Html.text "Email")
                            , control = inputElement
                            }

                    kids : List (Node.Node msg)
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
                    |> Node.childrenOf
                    |> List.drop 1
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "id")
                    |> Expect.equal (Just "ctrl-id")
        ]
