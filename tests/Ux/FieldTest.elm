module Ux.FieldTest exposing (suite)

import Expect
import Html
import Test exposing (Test, describe, test)
import Ux.Field as Field
import Ux.Label as Label
import Ux.Node as Node
import Ux.Search as Search


suite : Test
suite =
    describe "Ux.Field — relational composition over the IR"
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
