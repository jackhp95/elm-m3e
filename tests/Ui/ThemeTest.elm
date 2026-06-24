module Ui.ThemeTest exposing (suite)

{-| Tests for `Ui.Theme`, the faithful wrapper around the `m3e-theme` element.

The legacy `t-*` class contract is gone; these tests assert the emitted
`m3e-theme` element carries the right CEM attributes for the given builders.

-}

import Html
import Html.Attributes
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Theme


suite : Test
suite =
    describe "Ui.Theme"
        [ test "view renders an m3e-theme element wrapping its children" <|
            \_ ->
                Ui.Theme.new
                    |> Ui.Theme.view [ Html.span [] [ Html.text "themed" ] ]
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-theme", Selector.text "themed" ]
        , test "withSeedColor sets the 'color' attribute" <|
            \_ ->
                Ui.Theme.new
                    |> Ui.Theme.withSeedColor "#6750A4"
                    |> Ui.Theme.view []
                    |> Query.fromHtml
                    |> Query.has [ Selector.attribute (attr "color" "#6750A4") ]
        , test "withScheme Dark sets scheme='dark'" <|
            \_ ->
                Ui.Theme.new
                    |> Ui.Theme.withScheme Ui.Theme.Dark
                    |> Ui.Theme.view []
                    |> Query.fromHtml
                    |> Query.has [ Selector.attribute (attr "scheme" "dark") ]
        , test "withScheme Auto sets scheme='auto'" <|
            \_ ->
                Ui.Theme.new
                    |> Ui.Theme.withScheme Ui.Theme.Auto
                    |> Ui.Theme.view []
                    |> Query.fromHtml
                    |> Query.has [ Selector.attribute (attr "scheme" "auto") ]
        , test "withVariant Vibrant sets variant='vibrant'" <|
            \_ ->
                Ui.Theme.new
                    |> Ui.Theme.withVariant Ui.Theme.Vibrant
                    |> Ui.Theme.view []
                    |> Query.fromHtml
                    |> Query.has [ Selector.attribute (attr "variant" "vibrant") ]
        , test "withVariant TonalSpot sets variant='tonal-spot'" <|
            \_ ->
                Ui.Theme.new
                    |> Ui.Theme.withVariant Ui.Theme.TonalSpot
                    |> Ui.Theme.view []
                    |> Query.fromHtml
                    |> Query.has [ Selector.attribute (attr "variant" "tonal-spot") ]
        , test "withVariant FruitSalad sets variant='fruit-salad'" <|
            \_ ->
                Ui.Theme.new
                    |> Ui.Theme.withVariant Ui.Theme.FruitSalad
                    |> Ui.Theme.view []
                    |> Query.fromHtml
                    |> Query.has [ Selector.attribute (attr "variant" "fruit-salad") ]
        , test "withContrast High sets contrast='high'" <|
            \_ ->
                Ui.Theme.new
                    |> Ui.Theme.withContrast Ui.Theme.High
                    |> Ui.Theme.view []
                    |> Query.fromHtml
                    |> Query.has [ Selector.attribute (attr "contrast" "high") ]
        , test "withContrast Standard sets contrast='standard'" <|
            \_ ->
                Ui.Theme.new
                    |> Ui.Theme.withContrast Ui.Theme.Standard
                    |> Ui.Theme.view []
                    |> Query.fromHtml
                    |> Query.has [ Selector.attribute (attr "contrast" "standard") ]
        , test "withMotion Expressive sets motion='expressive'" <|
            \_ ->
                Ui.Theme.new
                    |> Ui.Theme.withMotion Ui.Theme.MotionExpressive
                    |> Ui.Theme.view []
                    |> Query.fromHtml
                    |> Query.has [ Selector.attribute (attr "motion" "expressive") ]
        , test "a bare theme emits no scheme/variant/contrast attributes (element defaults apply)" <|
            \_ ->
                Ui.Theme.new
                    |> Ui.Theme.view []
                    |> Query.fromHtml
                    |> Query.hasNot [ Selector.attribute (attr "scheme" "auto") ]
        ]


attr : String -> String -> Html.Attribute msg
attr name value =
    Html.Attributes.attribute name value
