module Ui.TooltipTest exposing (suite)

import Expect
import Html
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Button
import Ui.Tooltip


suite : Test
suite =
    describe "Ui.Tooltip"
        [ test "rich tooltip actions land in the actions slot" <|
            \_ ->
                Ui.Tooltip.rich { anchorId = "a", content = Html.text "c" }
                    |> Ui.Tooltip.withActions [ actionButton ]
                    |> Ui.Tooltip.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.attribute (Attr.attribute "slot" "actions") ]
                    |> Query.has [ Selector.tag "m3e-button" ]
        , test "rich tooltip actions do not use the ds-tooltip-actions class" <|
            \_ ->
                Ui.Tooltip.rich { anchorId = "a", content = Html.text "c" }
                    |> Ui.Tooltip.withActions [ actionButton ]
                    |> Ui.Tooltip.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.class "ds-tooltip-actions" ]
                    |> Query.count (Expect.equal 0)
        , test "plain tooltip After position emits position=after" <|
            \_ ->
                Ui.Tooltip.plain { anchorId = "a", label = "L" }
                    |> Ui.Tooltip.withPosition Ui.Tooltip.After
                    |> Ui.Tooltip.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-tooltip"
                        , Selector.attribute (Attr.attribute "position" "after")
                        ]
        , test "rich tooltip Before position emits position=before" <|
            \_ ->
                Ui.Tooltip.rich { anchorId = "a", content = Html.text "c" }
                    |> Ui.Tooltip.withPosition Ui.Tooltip.Before
                    |> Ui.Tooltip.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-rich-tooltip"
                        , Selector.attribute (Attr.attribute "position" "before")
                        ]
        , test "rich tooltip After position emits position=after" <|
            \_ ->
                Ui.Tooltip.rich { anchorId = "a", content = Html.text "c" }
                    |> Ui.Tooltip.withPosition Ui.Tooltip.After
                    |> Ui.Tooltip.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-rich-tooltip"
                        , Selector.attribute (Attr.attribute "position" "after")
                        ]
        ]


actionButton : Ui.Button.Button ()
actionButton =
    Ui.Button.new { label = "More", variant = Ui.Button.Text }
