module Ui.BottomSheetTest exposing (suite)

import Expect
import Html
import Html.Attributes as Attr
import M3e.BottomSheet
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.BottomSheet
import Ui.Button


suite : Test
suite =
    describe "Ui.BottomSheet"
        [ test "emits open=True on the element when shown" <|
            \_ ->
                Ui.BottomSheet.new { open = True, onClose = () }
                    |> Ui.BottomSheet.withBody (Html.text "body")
                    |> Ui.BottomSheet.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-bottom-sheet"
                        , Selector.attribute (M3e.BottomSheet.open True)
                        ]
        , test "renders nothing when closed" <|
            \_ ->
                Ui.BottomSheet.new { open = False, onClose = () }
                    |> Ui.BottomSheet.withBody (Html.text "body")
                    |> Ui.BottomSheet.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.tag "m3e-bottom-sheet" ]
                    |> Query.count (Expect.equal 0)
        , test "body lands in the default slot (no ds-bottom-sheet-body class)" <|
            \_ ->
                Ui.BottomSheet.new { open = True, onClose = () }
                    |> Ui.BottomSheet.withBody (Html.text "body content")
                    |> Ui.BottomSheet.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.class "ds-bottom-sheet-body" ]
                    |> Query.count (Expect.equal 0)
        , test "actions render as m3e-bottom-sheet-action elements" <|
            \_ ->
                Ui.BottomSheet.new { open = True, onClose = () }
                    |> Ui.BottomSheet.withActions [ actionButton ]
                    |> Ui.BottomSheet.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-bottom-sheet-action" ]
        , test "action marker is nested INSIDE the m3e-button (not wrapping it)" <|
            \_ ->
                Ui.BottomSheet.new { open = True, onClose = () }
                    |> Ui.BottomSheet.withActions [ actionButton ]
                    |> Ui.BottomSheet.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-button" ]
                    |> Query.has [ Selector.tag "m3e-bottom-sheet-action" ]
        , test "no m3e-bottom-sheet-action wraps the m3e-button" <|
            \_ ->
                Ui.BottomSheet.new { open = True, onClose = () }
                    |> Ui.BottomSheet.withActions [ actionButton ]
                    |> Ui.BottomSheet.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-bottom-sheet-action" ]
                    |> Query.findAll [ Selector.tag "m3e-button" ]
                    |> Query.count (Expect.equal 0)
        , test "no ds-bottom-sheet-actions div" <|
            \_ ->
                Ui.BottomSheet.new { open = True, onClose = () }
                    |> Ui.BottomSheet.withActions [ actionButton ]
                    |> Ui.BottomSheet.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.class "ds-bottom-sheet-actions" ]
                    |> Query.count (Expect.equal 0)
        , test "header content lands in the header slot" <|
            \_ ->
                Ui.BottomSheet.new { open = True, onClose = () }
                    |> Ui.BottomSheet.withHeader (Html.text "Title")
                    |> Ui.BottomSheet.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.attribute (Attr.attribute "slot" "header") ]
                    |> Query.has [ Selector.text "Title" ]
        , test "withModal emits the modal property" <|
            \_ ->
                Ui.BottomSheet.new { open = True, onClose = () }
                    |> Ui.BottomSheet.withModal True
                    |> Ui.BottomSheet.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-bottom-sheet"
                        , Selector.attribute (M3e.BottomSheet.modal True)
                        ]
        ]


actionButton : Ui.Button.Button ()
actionButton =
    Ui.Button.new { label = "OK", variant = Ui.Button.Filled }
