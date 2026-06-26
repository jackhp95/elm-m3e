module Ui.SideSheetTest exposing (suite)

import Expect
import Html
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Button
import Ui.SideSheet


suite : Test
suite =
    describe "Ui.SideSheet"
        [ test "renders an m3e-drawer-container" <|
            \_ ->
                Ui.SideSheet.new { open = True, onClose = () }
                    |> Ui.SideSheet.withBody (Html.text "body")
                    |> Ui.SideSheet.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-drawer-container" ]
        , test "End side routes body through the end slot" <|
            \_ ->
                Ui.SideSheet.new { open = True, onClose = () }
                    |> Ui.SideSheet.withSide Ui.SideSheet.End
                    |> Ui.SideSheet.withBody (Html.text "end body")
                    |> Ui.SideSheet.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.attribute (Attr.attribute "slot" "end") ]
                    |> Query.has [ Selector.text "end body" ]
        , test "Start side routes body through the start slot" <|
            \_ ->
                Ui.SideSheet.new { open = True, onClose = () }
                    |> Ui.SideSheet.withSide Ui.SideSheet.Start
                    |> Ui.SideSheet.withBody (Html.text "start body")
                    |> Ui.SideSheet.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.attribute (Attr.attribute "slot" "start") ]
                    |> Query.has [ Selector.text "start body" ]
        , test "actions route through the same slot as the body (end)" <|
            \_ ->
                Ui.SideSheet.new { open = True, onClose = () }
                    |> Ui.SideSheet.withSide Ui.SideSheet.End
                    |> Ui.SideSheet.withActions [ actionButton ]
                    |> Ui.SideSheet.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.attribute (Attr.attribute "slot" "end") ]
                    |> Query.has [ Selector.tag "m3e-button" ]
        , test "no ds-side-sheet-body class" <|
            \_ ->
                Ui.SideSheet.new { open = True, onClose = () }
                    |> Ui.SideSheet.withBody (Html.text "body")
                    |> Ui.SideSheet.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.class "ds-side-sheet-body" ]
                    |> Query.count (Expect.equal 0)
        , test "no ds-side-sheet-actions class" <|
            \_ ->
                Ui.SideSheet.new { open = True, onClose = () }
                    |> Ui.SideSheet.withActions [ actionButton ]
                    |> Ui.SideSheet.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.class "ds-side-sheet-actions" ]
                    |> Query.count (Expect.equal 0)
        , test "uses the typed end-mode attribute (over when modal)" <|
            \_ ->
                Ui.SideSheet.new { open = True, onClose = () }
                    |> Ui.SideSheet.withSide Ui.SideSheet.End
                    |> Ui.SideSheet.withModal True
                    |> Ui.SideSheet.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-drawer-container"
                        , Selector.attribute (Attr.attribute "end-mode" "over")
                        ]
        , test "withContent projects main content into the container default slot" <|
            \_ ->
                Ui.SideSheet.new { open = True, onClose = () }
                    |> Ui.SideSheet.withBody (Html.text "sheet body")
                    |> Ui.SideSheet.withContent [ Html.main_ [] [ Html.text "page" ] ]
                    |> Ui.SideSheet.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "main" ]
                    |> Query.has [ Selector.text "page" ]
        , test "still renders the container (with content) when closed" <|
            \_ ->
                Ui.SideSheet.new { open = False, onClose = () }
                    |> Ui.SideSheet.withContent [ Html.main_ [] [ Html.text "page" ] ]
                    |> Ui.SideSheet.view
                    |> Query.fromHtml
                    |> Expect.all
                        [ Query.has [ Selector.tag "m3e-drawer-container" ]
                        , Query.find [ Selector.tag "main" ]
                            >> Query.has [ Selector.text "page" ]
                        ]
        ]


actionButton : Ui.Button.Button ()
actionButton =
    Ui.Button.new { label = "Apply", variant = Ui.Button.Filled }
