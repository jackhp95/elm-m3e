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
        , test "triggerFor emits an <m3e-menu-trigger> with the for id" <|
            \_ ->
                Ui.Menu.triggerFor "row-actions"
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-menu-trigger"
                        , Selector.attribute
                            (Html.Attributes.attribute "for" "row-actions")
                        ]
        , test "withTriggerIcon renders both an icon-button trigger and the menu, linked by id" <|
            \_ ->
                Ui.Menu.new [ Ui.Menu.item "Edit" Clicked ]
                    |> Ui.Menu.withId "acts"
                    |> Ui.Menu.withTriggerIcon
                        { icon = Ui.Icon.material "more_vert", label = "More" }
                    |> Ui.Menu.view
                    |> Query.fromHtml
                    |> Expect.all
                        [ Query.has [ Selector.tag "m3e-icon-button" ]
                        , Query.has [ Selector.tag "m3e-menu" ]
                        , Query.find [ Selector.tag "m3e-menu-trigger" ]
                            >> Query.has
                                [ Selector.attribute
                                    (Html.Attributes.attribute "for" "acts")
                                ]
                        , Query.find [ Selector.tag "m3e-menu" ]
                            >> Query.has [ Selector.id "acts" ]
                        ]
        , test "withPositionX/Y emit the position attributes" <|
            \_ ->
                Ui.Menu.new [ Ui.Menu.item "Edit" Clicked ]
                    |> Ui.Menu.withPositionX Ui.Menu.Before
                    |> Ui.Menu.withPositionY Ui.Menu.Above
                    |> Ui.Menu.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.attribute
                            (Html.Attributes.attribute "position-x" "before")
                        , Selector.attribute
                            (Html.Attributes.attribute "position-y" "above")
                        ]
        ]
