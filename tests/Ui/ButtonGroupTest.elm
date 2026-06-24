module Ui.ButtonGroupTest exposing (suite)

import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Button
import Ui.ButtonGroup


buttons : List (Ui.Button.Button msg)
buttons =
    [ Ui.Button.new { label = "Day", variant = Ui.Button.Filled }
    , Ui.Button.new { label = "Week", variant = Ui.Button.Filled }
    ]


suite : Test
suite =
    describe "Ui.ButtonGroup"
        [ test "withVariant Connected sets variant=connected on the group" <|
            \_ ->
                Ui.ButtonGroup.new buttons
                    |> Ui.ButtonGroup.withVariant Ui.ButtonGroup.Connected
                    |> Ui.ButtonGroup.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-button-group"
                        , Selector.attribute (Attr.attribute "variant" "connected")
                        ]
        , test "default variant is standard" <|
            \_ ->
                Ui.ButtonGroup.new buttons
                    |> Ui.ButtonGroup.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-button-group"
                        , Selector.attribute (Attr.attribute "variant" "standard")
                        ]
        ]
