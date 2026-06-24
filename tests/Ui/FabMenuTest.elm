module Ui.FabMenuTest exposing (suite)

import Expect
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.FabMenu
import Ui.Icon


type Msg
    = Compose
    | Photo


fabMenu : Ui.FabMenu.FabMenu Msg
fabMenu =
    Ui.FabMenu.new
        { triggerIcon = Ui.Icon.material "edit"
        , triggerLabel = "Create"
        , variant = Ui.FabMenu.Primary
        , items =
            [ Ui.FabMenu.item { icon = Ui.Icon.material "mail", label = "Compose", onClick = Compose }
            , Ui.FabMenu.item { icon = Ui.Icon.material "photo", label = "Photo", onClick = Photo }
            ]
        }


suite : Test
suite =
    describe "Ui.FabMenu"
        [ test "renders the m3e-fab-menu container" <|
            \_ ->
                fabMenu
                    |> Ui.FabMenu.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-fab-menu" ]
        , test "renders items as m3e-menu-item (not raw button)" <|
            \_ ->
                fabMenu
                    |> Ui.FabMenu.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.tag "m3e-menu-item" ]
                    |> Query.count (Expect.equal 2)
        , test "does not render raw button children for items" <|
            \_ ->
                fabMenu
                    |> Ui.FabMenu.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.tag "button" ]
                    |> Query.count (Expect.equal 0)
        , test "menu item label appears in the default slot" <|
            \_ ->
                fabMenu
                    |> Ui.FabMenu.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-menu-item", Selector.containing [ Selector.text "Compose" ] ]
                    |> Query.has [ Selector.text "Compose" ]
        , test "menu item glyph is projected into the icon slot" <|
            \_ ->
                fabMenu
                    |> Ui.FabMenu.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.attribute (Attr.attribute "slot" "icon") ]
                    |> Query.count (Expect.equal 2)
        , test "renders an m3e-fab-menu-trigger opener" <|
            \_ ->
                fabMenu
                    |> Ui.FabMenu.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-fab-menu-trigger" ]
        , test "renders an m3e-fab opener" <|
            \_ ->
                fabMenu
                    |> Ui.FabMenu.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-fab" ]
        , test "renders the triggerIcon (m3e-icon present in the opener)" <|
            \_ ->
                fabMenu
                    |> Ui.FabMenu.view
                    |> Query.fromHtml
                    |> Query.has [ Selector.tag "m3e-icon" ]
        ]
