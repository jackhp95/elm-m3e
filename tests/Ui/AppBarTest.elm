module Ui.AppBarTest exposing (suite)

import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.AppBar


suite : Test
suite =
    describe "Ui.AppBar"
        [ test "renders the title into the m3e-app-bar `title` slot (CRITICAL: m3e-app-bar has no default slot)" <|
            \_ ->
                Ui.AppBar.new "Inbox"
                    |> Ui.AppBar.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.attribute (Attr.attribute "slot" "title") ]
                    |> Query.has [ Selector.text "Inbox" ]
        ]
