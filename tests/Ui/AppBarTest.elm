module Ui.AppBarTest exposing (suite)

import Html
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.AppBar
import Ui.Heading
import Ui.Icon
import Ui.IconButton


suite : Test
suite =
    describe "Ui.AppBar"
        [ test "title (typed Ui.Heading) carries slot=title on the heading itself — no wrapper" <|
            \_ ->
                Ui.AppBar.new
                    |> Ui.AppBar.withTitle (Ui.Heading.title "Inbox")
                    |> Ui.AppBar.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-heading", Selector.attribute (Attr.attribute "slot" "title") ]
                    |> Query.has [ Selector.text "Inbox" ]
        , test "leading typed icon-button carries slot=leading on the m3e-icon-button (no span wrapper)" <|
            \_ ->
                Ui.AppBar.new
                    |> Ui.AppBar.withLeadingIconButton
                        (Ui.IconButton.new { icon = Ui.Icon.material "menu", label = "Menu", variant = Ui.IconButton.Standard })
                    |> Ui.AppBar.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-icon-button" ]
                    |> Query.has [ Selector.attribute (Attr.attribute "slot" "leading") ]
        , test "the title element escape hatch puts slot=title on the caller's chosen element (a header), not a span" <|
            \_ ->
                Ui.AppBar.new
                    |> Ui.AppBar.withTitleHtmlElementEscapeHatch Html.h1 [] [ Html.text "Inbox" ]
                    |> Ui.AppBar.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "h1", Selector.attribute (Attr.attribute "slot" "title") ]
                    |> Query.has [ Selector.text "Inbox" ]
        ]
