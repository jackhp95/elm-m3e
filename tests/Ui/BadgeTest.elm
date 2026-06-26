module Ui.BadgeTest exposing (suite)

import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Badge


suite : Test
suite =
    describe "Ui.Badge"
        [ test "withPosition emits the position attribute" <|
            \_ ->
                Ui.Badge.count 5
                    |> Ui.Badge.withPosition Ui.Badge.BelowBefore
                    |> Ui.Badge.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-badge"
                        , Selector.attribute (Attr.attribute "position" "below-before")
                        ]
        , test "defaults to the m3e 'above-after' position" <|
            \_ ->
                Ui.Badge.count 5
                    |> Ui.Badge.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-badge"
                        , Selector.attribute (Attr.attribute "position" "above-after")
                        ]
        ]
