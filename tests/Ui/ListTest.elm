module Ui.ListTest exposing (suite)

import Html
import Html.Attributes
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.List


type Msg
    = Clicked
    | Toggled Bool


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
        , test "option renders a selectable <m3e-list-option> element" <|
            \_ ->
                Ui.List.new
                    [ Ui.List.option "Wi-Fi"
                        |> Ui.List.withItemSelected True
                        |> Ui.List.withItemOnChange Toggled
                    ]
                    |> Ui.List.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-list-option" ]
        , test "option reflects the selected state" <|
            \_ ->
                Ui.List.new
                    [ Ui.List.option "Wi-Fi"
                        |> Ui.List.withItemSelected True
                    ]
                    |> Ui.List.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-list-option" ]
                    |> Query.has
                        [ Selector.attribute (Html.Attributes.selected True) ]
        , test "option carries its submission value" <|
            \_ ->
                Ui.List.new
                    [ Ui.List.option "Wi-Fi"
                        |> Ui.List.withItemValue "wifi"
                    ]
                    |> Ui.List.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-list-option" ]
                    |> Query.has
                        [ Selector.attribute (Html.Attributes.value "wifi") ]
        , test "divider renders an <m3e-divider> row" <|
            \_ ->
                Ui.List.new [ Ui.List.item "A", Ui.List.divider, Ui.List.item "B" ]
                    |> Ui.List.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-divider" ]
        , test "expandable renders an <m3e-expandable-list-item> element" <|
            \_ ->
                Ui.List.new
                    [ Ui.List.expandable "Folders"
                        |> Ui.List.withItemOpen True
                        |> Ui.List.withItemChildren
                            [ Ui.List.item "Drafts", Ui.List.item "Sent" ]
                    ]
                    |> Ui.List.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-expandable-list-item" ]
        , test "expandable nests its children in the items slot" <|
            \_ ->
                Ui.List.new
                    [ Ui.List.expandable "Folders"
                        |> Ui.List.withItemChildren [ Ui.List.item "Drafts" ]
                    ]
                    |> Ui.List.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-expandable-list-item" ]
                    |> Query.findAll [ Selector.tag "m3e-list-item" ]
                    |> Query.each
                        (Query.has
                            [ Selector.attribute
                                (Html.Attributes.attribute "slot" "items")
                            ]
                        )
        , test "leading Html escape hatch lands in the leading slot" <|
            \_ ->
                Ui.List.new
                    [ Ui.List.item "Account"
                        |> Ui.List.withItemLeadingHtml
                            (Html.span [ Html.Attributes.class "avatar" ] [])
                    ]
                    |> Ui.List.view
                    |> Query.fromHtml
                    |> Query.find
                        [ Selector.attribute
                            (Html.Attributes.attribute "slot" "leading")
                        ]
                    |> Query.has [ Selector.class "avatar" ]
        ]
