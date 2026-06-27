module M3e.BreadcrumbTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Breadcrumb as Breadcrumb
import M3e.Element as Element
import M3e.Node as Node
import Test exposing (Test, describe, test)


crumb1 : Element.Element { breadcrumbItem : Element.Supported } msg
crumb1 =
    Breadcrumb.item { label = "Dashboard" } [ Breadcrumb.itemHref "/dashboard" ]


crumb2 : Element.Element { breadcrumbItem : Element.Supported } msg
crumb2 =
    Breadcrumb.item { label = "Reports" } [ Breadcrumb.itemCurrent True ]


parentNode : List (Breadcrumb.BreadcrumbOption msg) -> Node.Node msg
parentNode opts =
    Breadcrumb.view { items = [ crumb1, crumb2 ] } opts
        |> Element.toNode


itemNode : List (Breadcrumb.ItemOption msg) -> Node.Node msg
itemNode opts =
    Breadcrumb.item { label = "Home" } opts
        |> Element.toNode


suite : Test
suite =
    describe "M3e.Breadcrumb — view-style port"
        [ describe "parent (<m3e-breadcrumb>)"
            [ test "renders <m3e-breadcrumb>" <|
                \_ ->
                    parentNode []
                        |> Node.tagOf
                        |> Expect.equal (Just "m3e-breadcrumb")
            , test "children are the provided items" <|
                \_ ->
                    parentNode []
                        |> Node.childrenOf
                        |> List.length
                        |> Expect.equal 2
            , test "each child renders as <m3e-breadcrumb-item>" <|
                \_ ->
                    parentNode []
                        |> Node.childrenOf
                        |> List.filterMap Node.tagOf
                        |> Expect.equal [ "m3e-breadcrumb-item", "m3e-breadcrumb-item" ]
            , test "wrap=true is a DOM property" <|
                \_ ->
                    parentNode [ Breadcrumb.wrap True ]
                        |> Node.findProperty "wrap"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            , test "wrap absent by default" <|
                \_ ->
                    parentNode []
                        |> Node.findProperty "wrap"
                        |> Expect.equal Nothing
            ]
        , describe "item child (<m3e-breadcrumb-item>)"
            [ test "renders <m3e-breadcrumb-item>" <|
                \_ ->
                    itemNode []
                        |> Node.tagOf
                        |> Expect.equal (Just "m3e-breadcrumb-item")
            , test "item-label attribute holds the label" <|
                \_ ->
                    itemNode []
                        |> Node.findAttribute "item-label"
                        |> Expect.equal (Just "Home")
            , test "label text is also a child text node" <|
                \_ ->
                    itemNode []
                        |> Node.childrenOf
                        |> List.head
                        |> Maybe.andThen textContent
                        |> Expect.equal (Just "Home")
            , test "href attribute is set when itemHref provided" <|
                \_ ->
                    itemNode [ Breadcrumb.itemHref "/home" ]
                        |> Node.findAttribute "href"
                        |> Expect.equal (Just "/home")
            , test "current=true sets the current attribute" <|
                \_ ->
                    itemNode [ Breadcrumb.itemCurrent True ]
                        |> Node.findAttribute "current"
                        |> Expect.equal (Just "true")
            , test "current attribute absent by default" <|
                \_ ->
                    itemNode []
                        |> Node.findAttribute "current"
                        |> Expect.equal Nothing
            , test "disabled is a DOM property on the item" <|
                \_ ->
                    itemNode [ Breadcrumb.itemDisabled True ]
                        |> Node.findProperty "disabled"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            ]
        ]


textContent : Node.Node msg -> Maybe String
textContent n =
    case n of
        Node.Text s ->
            Just s

        _ ->
            Nothing
