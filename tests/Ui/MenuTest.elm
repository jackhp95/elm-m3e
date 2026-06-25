module Ui.MenuTest exposing (suite)

import Expect
import Html.Attributes
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Icon
import Ui.Menu


type Msg
    = Clicked
    | Toggled Bool


suite : Test
suite =
    describe "Ui.Menu"
        [ test "item renders a plain <m3e-menu-item> element" <|
            \_ ->
                Ui.Menu.new [ Ui.Menu.item "Edit" Clicked ]
                    |> Ui.Menu.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-menu-item" ]
        , test "checkboxItem renders a <m3e-menu-item-checkbox> element" <|
            \_ ->
                Ui.Menu.new
                    [ Ui.Menu.checkboxItem "Show grid" Toggled
                        |> Ui.Menu.withItemChecked True
                    ]
                    |> Ui.Menu.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-menu-item-checkbox" ]
        , test "checkboxItem reflects the checked state" <|
            \_ ->
                Ui.Menu.new
                    [ Ui.Menu.checkboxItem "Show grid" Toggled
                        |> Ui.Menu.withItemChecked True
                    ]
                    |> Ui.Menu.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-menu-item-checkbox" ]
                    |> Query.has
                        [ Selector.attribute (Html.Attributes.checked True) ]
        , test "radioItem renders a <m3e-menu-item-radio> element" <|
            \_ ->
                Ui.Menu.new
                    [ Ui.Menu.radioItem "Left" Clicked
                        |> Ui.Menu.withItemSelected True
                    ]
                    |> Ui.Menu.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-menu-item-radio" ]
        , test "radioItem reflects the selected state as checked" <|
            \_ ->
                Ui.Menu.new
                    [ Ui.Menu.radioItem "Left" Clicked
                        |> Ui.Menu.withItemSelected True
                    ]
                    |> Ui.Menu.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-menu-item-radio" ]
                    |> Query.has
                        [ Selector.attribute (Html.Attributes.checked True) ]
        , test "group renders a <m3e-menu-item-group> wrapping its radios" <|
            \_ ->
                Ui.Menu.new
                    [ Ui.Menu.group "Alignment"
                        [ Ui.Menu.radioItem "Left" Clicked
                        , Ui.Menu.radioItem "Right" Clicked
                        ]
                    ]
                    |> Ui.Menu.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-menu-item-group" ]
                    |> Query.findAll [ Selector.tag "m3e-menu-item-radio" ]
                    |> Query.count (Expect.equal 2)
        , test "group renders its label in the label slot" <|
            \_ ->
                Ui.Menu.new
                    [ Ui.Menu.group "Alignment" [ Ui.Menu.radioItem "Left" Clicked ] ]
                    |> Ui.Menu.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.attribute
                            (Html.Attributes.attribute "slot" "label")
                        ]
        , test "trailing icon lands in the trailing-icon slot" <|
            \_ ->
                Ui.Menu.new
                    [ Ui.Menu.item "Open" Clicked
                        |> Ui.Menu.withItemTrailingIcon
                            (Ui.Icon.material "open_in_new")
                    ]
                    |> Ui.Menu.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.attribute
                            (Html.Attributes.attribute "slot" "trailing-icon")
                        ]
        ]
