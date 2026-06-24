module Ui.CardTest exposing (suite)

import Html exposing (text)
import Html.Attributes
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Button
import Ui.Card
import Ui.Heading


suite : Test
suite =
    describe "Ui.Card"
        [ test "drops ds-card-media" <|
            \_ ->
                card
                    |> Query.fromHtml
                    |> Query.hasNot [ Selector.classes [ "ds-card-media" ] ]
        , test "drops ds-card-headline" <|
            \_ ->
                card
                    |> Query.fromHtml
                    |> Query.hasNot [ Selector.classes [ "ds-card-headline" ] ]
        , test "drops ds-card-subhead" <|
            \_ ->
                card
                    |> Query.fromHtml
                    |> Query.hasNot [ Selector.classes [ "ds-card-subhead" ] ]
        , test "drops ds-card-actions" <|
            \_ ->
                card
                    |> Query.fromHtml
                    |> Query.hasNot [ Selector.classes [ "ds-card-actions" ] ]
        , test "keeps the header slot container" <|
            \_ ->
                card
                    |> Query.fromHtml
                    |> Query.has [ Selector.attribute (slotAttr "header") ]
        , test "keeps the actions slot container" <|
            \_ ->
                card
                    |> Query.fromHtml
                    |> Query.has [ Selector.attribute (slotAttr "actions") ]
        ]


slotAttr : String -> Html.Attribute msg
slotAttr value =
    Html.Attributes.attribute "slot" value


card : Html.Html msg
card =
    Ui.Card.new Ui.Card.Elevated
        |> Ui.Card.withMedia (text "media")
        |> Ui.Card.withHeadline (Ui.Heading.title "Title")
        |> Ui.Card.withSubhead (Ui.Heading.label "Sub")
        |> Ui.Card.withActions
            [ Ui.Button.new { label = "Go", variant = Ui.Button.Text } ]
        |> Ui.Card.view
