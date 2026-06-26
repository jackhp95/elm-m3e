module Ui.DialogTest exposing (suite)

import Expect
import Html
import Html.Attributes as Attr
import M3e.Dialog
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Button
import Ui.Dialog
import Ui.Icon


suite : Test
suite =
    describe "Ui.Dialog"
        [ test "renders an open m3e-dialog when shown" <|
            \_ ->
                dialog
                    |> Ui.Dialog.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-dialog" ]
        , test "never emits the non-CEM full-screen attribute" <|
            \_ ->
                dialog
                    |> Ui.Dialog.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.attribute (Attr.attribute "full-screen" "true") ]
                    |> Query.count (Expect.equal 0)
        , test "title lands in the header slot" <|
            \_ ->
                dialog
                    |> Ui.Dialog.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.attribute (Attr.attribute "slot" "header") ]
                    |> Query.has [ Selector.text "Discard changes?" ]
        , test "actions land in the actions slot" <|
            \_ ->
                dialog
                    |> Ui.Dialog.withActions [ actionButton ]
                    |> Ui.Dialog.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.attribute (Attr.attribute "slot" "actions") ]
                    |> Query.has [ Selector.tag "m3e-button" ]
        , test "no ds-dialog-headline class" <|
            \_ ->
                dialog
                    |> Ui.Dialog.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.class "ds-dialog-headline" ]
                    |> Query.count (Expect.equal 0)
        , test "no ds-dialog-body class" <|
            \_ ->
                dialog
                    |> Ui.Dialog.withBody (Html.text "body")
                    |> Ui.Dialog.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.class "ds-dialog-body" ]
                    |> Query.count (Expect.equal 0)
        , test "no ds-dialog-actions class" <|
            \_ ->
                dialog
                    |> Ui.Dialog.withActions [ actionButton ]
                    |> Ui.Dialog.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.class "ds-dialog-actions" ]
                    |> Query.count (Expect.equal 0)
        , test "dismissible by default: disable-close is False (Escape/scrim allowed)" <|
            \_ ->
                dialog
                    |> Ui.Dialog.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-dialog"
                        , Selector.attribute (M3e.Dialog.disableClose False)
                        ]
        , test "withDismissible False emits disable-close (blocks Escape/scrim)" <|
            \_ ->
                dialog
                    |> Ui.Dialog.withDismissible False
                    |> Ui.Dialog.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-dialog"
                        , Selector.attribute (M3e.Dialog.disableClose True)
                        ]
        , test "no close button by default (dismissible attr is False)" <|
            \_ ->
                dialog
                    |> Ui.Dialog.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-dialog"
                        , Selector.attribute (M3e.Dialog.dismissible False)
                        ]
        , test "withCloseButton True presents a close button (dismissible attr)" <|
            \_ ->
                dialog
                    |> Ui.Dialog.withCloseButton True
                    |> Ui.Dialog.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-dialog"
                        , Selector.attribute (M3e.Dialog.dismissible True)
                        ]
        , test "withCloseIcon emits the close-icon slot" <|
            \_ ->
                dialog
                    |> Ui.Dialog.withCloseButton True
                    |> Ui.Dialog.withCloseIcon (Ui.Icon.material "close")
                    |> Ui.Dialog.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.attribute (Attr.attribute "slot" "close-icon") ]
                    |> Query.has [ Selector.tag "m3e-icon" ]
        , test "no close-icon slot when unset" <|
            \_ ->
                dialog
                    |> Ui.Dialog.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.attribute (Attr.attribute "slot" "close-icon") ]
                    |> Query.count (Expect.equal 0)
        ]


dialog : Ui.Dialog.Dialog ()
dialog =
    Ui.Dialog.new { title = "Discard changes?", open = True, onClose = () }


actionButton : Ui.Button.Button ()
actionButton =
    Ui.Button.new { label = "OK", variant = Ui.Button.Filled }
