module Ui.TextTest exposing (suite)

{-| Tests for `Ui.Text`: that it emits a semantic `<p>` (or `<span>` when
inline), carries the M3 typescale class for the chosen role, and stays distinct
from `Ui.Heading` (no element delegation, no heading semantics).
-}

import Html
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Text


suite : Test
suite =
    describe "Ui.Text"
        [ describe "element"
            [ test "renders a <p> by default" <|
                \_ ->
                    Ui.Text.bodyLarge "hello"
                        |> Ui.Text.view
                        |> Query.fromHtml
                        |> Query.has [ Selector.tag "p" ]
            , test "renders a <span> when inline" <|
                \_ ->
                    Ui.Text.new Ui.Text.BodyMedium
                        |> Ui.Text.withInline
                        |> Ui.Text.withContent (Html.text "inline")
                        |> Ui.Text.view
                        |> Query.fromHtml
                        |> Query.has [ Selector.tag "span" ]
            ]
        , describe "typescale role class"
            [ test "BodyLarge emits text-body-lg" <|
                \_ ->
                    Ui.Text.bodyLarge "hello"
                        |> Ui.Text.view
                        |> Query.fromHtml
                        |> Query.has [ Selector.class "text-body-lg" ]
            , test "BodySmall emits text-body-sm" <|
                \_ ->
                    Ui.Text.bodySmall "small"
                        |> Ui.Text.view
                        |> Query.fromHtml
                        |> Query.has [ Selector.class "text-body-sm" ]
            , test "LabelMedium emits text-label-md" <|
                \_ ->
                    Ui.Text.labelMedium "label"
                        |> Ui.Text.view
                        |> Query.fromHtml
                        |> Query.has [ Selector.class "text-label-md" ]
            , test "withRole overrides the role class" <|
                \_ ->
                    Ui.Text.bodyLarge "hello"
                        |> Ui.Text.withRole Ui.Text.LabelSmall
                        |> Ui.Text.view
                        |> Query.fromHtml
                        |> Query.has [ Selector.class "text-label-sm" ]
            ]
        , describe "content"
            [ test "renders the provided text content" <|
                \_ ->
                    Ui.Text.bodyMedium "the body copy"
                        |> Ui.Text.view
                        |> Query.fromHtml
                        |> Query.has [ Selector.text "the body copy" ]
            ]
        ]
