module Ui.ToolbarTest exposing (suite)

import Expect
import Html
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Button
import Ui.Icon
import Ui.IconButton
import Ui.Toolbar


buttons : List (Ui.Button.Button msg)
buttons =
    [ Ui.Button.new { label = "Save", variant = Ui.Button.Filled } ]


iconButtons : List (Ui.IconButton.IconButton msg)
iconButtons =
    [ Ui.IconButton.new
        { icon = Ui.Icon.material "delete"
        , label = "Delete"
        , variant = Ui.IconButton.Standard
        }
    ]


suite : Test
suite =
    describe "Ui.Toolbar"
        [ test "renders the buttons from new into the toolbar" <|
            \_ ->
                Ui.Toolbar.new buttons
                    |> Ui.Toolbar.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-toolbar"
                        , Selector.tag "m3e-button"
                        ]
        , test "withIconButtons renders icon buttons inside the toolbar" <|
            \_ ->
                Ui.Toolbar.new buttons
                    |> Ui.Toolbar.withIconButtons iconButtons
                    |> Ui.Toolbar.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.tag "m3e-icon-button" ]
                    |> Query.count (Expect.equal 1)
        , test "withExtraContent renders arbitrary html inside the toolbar" <|
            \_ ->
                Ui.Toolbar.new buttons
                    |> Ui.Toolbar.withExtraContent
                        [ Html.hr [ Attr.class "divider" ] [] ]
                    |> Ui.Toolbar.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.tag "hr" ]
                    |> Query.count (Expect.equal 1)
        , test "withShape emits the shape attribute" <|
            \_ ->
                Ui.Toolbar.new buttons
                    |> Ui.Toolbar.withShape Ui.Toolbar.Rounded
                    |> Ui.Toolbar.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-toolbar"
                        , Selector.attribute (Attr.attribute "shape" "rounded")
                        ]
        , test "withVariant emits the variant attribute" <|
            \_ ->
                Ui.Toolbar.new buttons
                    |> Ui.Toolbar.withVariant Ui.Toolbar.Vibrant
                    |> Ui.Toolbar.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-toolbar"
                        , Selector.attribute (Attr.attribute "variant" "vibrant")
                        ]
        ]
