module Ui.HeadingTest exposing (suite)

{-| Tests for `Ui.Heading`: its own (no longer shared) `Size`, the CEM
`m3e-heading` defaults, the 1..6 level clamp, and that a variant is always
emitted.
-}

import Expect
import Fuzz
import Html
import Html.Attributes
import M3e.Heading
import Test exposing (Test, describe, fuzz, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Heading


suite : Test
suite =
    describe "Ui.Heading"
        [ describe "defaults (CEM m3e-heading)"
            [ test "default variant is 'display'" <|
                \_ ->
                    Ui.Heading.new
                        |> Ui.Heading.view
                        |> Query.fromHtml
                        |> Query.has [ Selector.attribute (htmlAttr "variant" "display") ]
            , test "always emits a variant attribute" <|
                \_ ->
                    Ui.Heading.new
                        |> Ui.Heading.withVariant Ui.Heading.Title
                        |> Ui.Heading.view
                        |> Query.fromHtml
                        |> Query.has [ Selector.attribute (htmlAttr "variant" "title") ]
            ]
        , describe "withSize"
            [ test "maps Small to the m3e-heading 'small' enum" <|
                \_ ->
                    Ui.Heading.new
                        |> Ui.Heading.withSize Ui.Heading.Small
                        |> Ui.Heading.view
                        |> Query.fromHtml
                        |> Query.has [ Selector.attribute (htmlAttr "size" "small") ]
            , test "maps Large to the m3e-heading 'large' enum" <|
                \_ ->
                    Ui.Heading.new
                        |> Ui.Heading.withSize Ui.Heading.Large
                        |> Ui.Heading.view
                        |> Query.fromHtml
                        |> Query.has [ Selector.attribute (htmlAttr "size" "large") ]
            ]
        , test "withEmphasized True emits the emphasized property" <|
            \_ ->
                Ui.Heading.new
                    |> Ui.Heading.withEmphasized True
                    |> Ui.Heading.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.attribute (M3e.Heading.emphasized True) ]
        , describe "withLevel clamps to the CEM 1..6 range"
            [ test "level below 1 clamps to 1" <|
                \_ ->
                    Ui.Heading.new
                        |> Ui.Heading.withLevel 0
                        |> Ui.Heading.view
                        |> Query.fromHtml
                        |> Query.has [ Selector.attribute (htmlAttr "level" "1") ]
            , test "level above 6 clamps to 6" <|
                \_ ->
                    Ui.Heading.new
                        |> Ui.Heading.withLevel 9
                        |> Ui.Heading.view
                        |> Query.fromHtml
                        |> Query.has [ Selector.attribute (htmlAttr "level" "6") ]
            , test "level within range is preserved" <|
                \_ ->
                    Ui.Heading.new
                        |> Ui.Heading.withLevel 3
                        |> Ui.Heading.view
                        |> Query.fromHtml
                        |> Query.has [ Selector.attribute (htmlAttr "level" "3") ]
            , fuzz (Fuzz.intRange -20 20) "clampLevel result is always within 1..6" <|
                \n ->
                    Ui.Heading.clampLevel n
                        |> Expect.all
                            [ Expect.atLeast 1
                            , Expect.atMost 6
                            ]
            ]
        ]


htmlAttr : String -> String -> Html.Attribute msg
htmlAttr name value =
    Html.Attributes.attribute name value
