module Ui.BreadcrumbTest exposing (suite)

import Expect
import Html.Attributes as Attr
import M3e.Breadcrumb
import M3e.BreadcrumbItem
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Breadcrumb
import Ui.Icon


suite : Test
suite =
    describe "Ui.Breadcrumb"
        [ test "renders items as m3e-breadcrumb-item children of m3e-breadcrumb" <|
            \_ ->
                Ui.Breadcrumb.new
                    |> Ui.Breadcrumb.withItems
                        [ Ui.Breadcrumb.link "Home" "/"
                        , Ui.Breadcrumb.current "Settings"
                        ]
                    |> Ui.Breadcrumb.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.tag "m3e-breadcrumb-item" ]
                    |> Query.count (Expect.equal 2)
        , test "withItemIcon emits the item icon slot" <|
            \_ ->
                Ui.Breadcrumb.new
                    |> Ui.Breadcrumb.withItem
                        (Ui.Breadcrumb.link "Home" "/"
                            |> Ui.Breadcrumb.withItemIcon (Ui.Icon.material "home")
                        )
                    |> Ui.Breadcrumb.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.attribute (Attr.attribute "slot" "icon") ]
                    |> Query.has [ Selector.tag "m3e-icon" ]
        , test "withSeparator emits the host separator slot" <|
            \_ ->
                Ui.Breadcrumb.new
                    |> Ui.Breadcrumb.withSeparator (Ui.Icon.material "chevron_right" |> Ui.Icon.view)
                    |> Ui.Breadcrumb.withItem (Ui.Breadcrumb.current "Now")
                    |> Ui.Breadcrumb.view
                    |> Query.fromHtml
                    |> Query.findAll [ Selector.attribute (Attr.attribute "slot" "separator") ]
                    |> Query.count (Expect.equal 1)
        , test "withWrap emits wrap on the host m3e-breadcrumb" <|
            \_ ->
                Ui.Breadcrumb.new
                    |> Ui.Breadcrumb.withWrap True
                    |> Ui.Breadcrumb.withItem (Ui.Breadcrumb.current "Now")
                    |> Ui.Breadcrumb.view
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.tag "m3e-breadcrumb"
                        , Selector.attribute (M3e.Breadcrumb.wrap True)
                        ]
        , test "per-item link attrs emit target/rel/download/disabled" <|
            \_ ->
                Ui.Breadcrumb.new
                    |> Ui.Breadcrumb.withItem
                        (Ui.Breadcrumb.link "Home" "/"
                            |> Ui.Breadcrumb.withItemTarget "_blank"
                            |> Ui.Breadcrumb.withItemRel "noopener"
                            |> Ui.Breadcrumb.withItemDownload "home.html"
                            |> Ui.Breadcrumb.withItemDisabled True
                        )
                    |> Ui.Breadcrumb.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "m3e-breadcrumb-item" ]
                    |> Expect.all
                        [ Query.has [ Selector.attribute (Attr.attribute "target" "_blank") ]
                        , Query.has [ Selector.attribute (Attr.attribute "rel" "noopener") ]
                        , Query.has [ Selector.attribute (Attr.attribute "download" "home.html") ]
                        , Query.has [ Selector.attribute (M3e.BreadcrumbItem.disabled True) ]
                        ]
        , test "no icon/separator slots when unset" <|
            \_ ->
                Ui.Breadcrumb.new
                    |> Ui.Breadcrumb.withItem (Ui.Breadcrumb.current "Now")
                    |> Ui.Breadcrumb.view
                    |> Query.fromHtml
                    |> Expect.all
                        [ Query.findAll [ Selector.attribute (Attr.attribute "slot" "icon") ]
                            >> Query.count (Expect.equal 0)
                        , Query.findAll [ Selector.attribute (Attr.attribute "slot" "separator") ]
                            >> Query.count (Expect.equal 0)
                        ]
        ]
