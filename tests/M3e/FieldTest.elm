module M3e.FieldTest exposing (suite)

import Expect
import Html
import Test exposing (Test, describe, test)
import M3e.Field as Field
import M3e.Label as Label
import M3e.Node as Node
import M3e.Search as Search


suite : Test
suite =
    describe "M3e.Field — relational composition over the IR"
        [ test "label[for] and control[id] wired to the same generated id" <|
            \_ ->
                let
                    node =
                        Field.view
                            { id = "field-email"
                            , label = Label.fromHtml (Html.text "Email")
                            , control = Search.view { placeholder = "you@example.com" } []
                            }

                    kids =
                        Node.childrenOf node
                in
                ( kids |> List.head |> Maybe.andThen (Node.findAttribute "for")
                , kids |> List.drop 1 |> List.head |> Maybe.andThen (Node.findAttribute "id")
                )
                    |> Expect.equal ( Just "field-email", Just "field-email" )
        ]
