module Ui.ListTest exposing (suite)

import Html.Attributes
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.List


type Msg
    = Clicked


suite : Test
suite =
    describe "Ui.List"
        [ test "item renders the static <m3e-list-item> element" <|
            \_ ->
                Ui.List.new [ Ui.List.item "Inbox" ]
                    |> Ui.List.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-list-item" ]
        , test "actionItem renders the interactive <m3e-list-item-button> element" <|
            \_ ->
                Ui.List.new
                    [ Ui.List.actionItem "Open"
                        |> Ui.List.withItemOnClick Clicked
                    ]
                    |> Ui.List.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-list-item-button" ]
        , test "a plain item never becomes an interactive button" <|
            \_ ->
                Ui.List.new [ Ui.List.item "Inbox" ]
                    |> Ui.List.view
                    |> Query.fromHtml
                    |> Query.hasNot [ Selector.tag "m3e-list-item-button" ]
        , test "disabled is not emitted on the non-interactive m3e-list-item" <|
            \_ ->
                Ui.List.new
                    [ Ui.List.item "Inbox"
                        |> Ui.List.withItemDisabled True
                    ]
                    |> Ui.List.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-list-item" ]
                    |> Query.hasNot
                        [ Selector.attribute (Html.Attributes.disabled True) ]
        ]
