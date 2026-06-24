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
        , test "withAttributes lands a caller class on the m3e-card host" <|
            \_ ->
                Ui.Card.new Ui.Card.Outlined
                    |> Ui.Card.withAttributes [ Html.Attributes.class "h-full" ]
                    |> Ui.Card.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-card", Selector.classes [ "h-full" ] ]
        , test "the structural variant attribute survives caller withAttributes" <|
            \_ ->
                -- a caller can't clobber `variant` (structural attrs are emitted last)
                Ui.Card.new Ui.Card.Outlined
                    |> Ui.Card.withAttributes [ Html.Attributes.attribute "variant" "filled" ]
                    |> Ui.Card.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-card", Selector.attribute (Html.Attributes.attribute "variant" "outlined") ]
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
