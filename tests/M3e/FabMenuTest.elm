module M3e.FabMenuTest exposing (suite)

import Expect
import M3e.Element as Element exposing (Element)
import M3e.FabMenu as FabMenu
import M3e.Node as Node exposing (Node)
import Test exposing (Test, describe, test)


req : { triggerIcon : String, name : String, items : List (Element { fabMenuItem : Element.Supported } ()) }
req =
    { triggerIcon = "add"
    , name = "Actions"
    , items =
        [ FabMenu.item { icon = "share", label = "Share", onClick = () }
        , FabMenu.item { icon = "delete", label = "Delete", onClick = () }
        ]
    }


node : List (FabMenu.Option ()) -> Node ()
node opts =
    FabMenu.view req opts |> Element.toNode


{-| Get the m3e-fab-menu node (second child of the root div).
-}
fabMenuNode : Node msg -> Maybe (Node msg)
fabMenuNode n =
    Node.childrenOf n
        |> List.drop 1
        |> List.head


{-| Get the m3e-fab trigger node (first child of the root div).
-}
fabTriggerNode : Node msg -> Maybe (Node msg)
fabTriggerNode n =
    Node.childrenOf n
        |> List.head


suite : Test
suite =
    describe "M3e.FabMenu — view-style port + Bug Fix #18"
        [ test "root element is a <div> wrapper" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "div")
        , test "first child of div is the <m3e-fab> trigger" <|
            \_ ->
                node []
                    |> fabTriggerNode
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "m3e-fab")
        , test "second child of div is the <m3e-fab-menu>" <|
            \_ ->
                node []
                    |> fabMenuNode
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "m3e-fab-menu")
        , test "m3e-fab has aria-label from name" <|
            \_ ->
                node []
                    |> fabTriggerNode
                    |> Maybe.andThen (Node.findAttribute "aria-label")
                    |> Expect.equal (Just "Actions")
        , test "m3e-fab-menu has the default id" <|
            \_ ->
                node []
                    |> fabMenuNode
                    |> Maybe.andThen (Node.findAttribute "id")
                    |> Expect.equal (Just "fab-menu")
        , test "menuId option overrides the relational id" <|
            \_ ->
                node [ FabMenu.menuId "my-menu" ]
                    |> fabMenuNode
                    |> Maybe.andThen (Node.findAttribute "id")
                    |> Expect.equal (Just "my-menu")
        , test "trigger's m3e-fab-menu-trigger has for=menuId" <|
            \_ ->
                node []
                    |> fabTriggerNode
                    |> Maybe.map Node.childrenOf
                    |> Maybe.andThen
                        (List.filter (\n -> Node.tagOf n == Just "m3e-fab-menu-trigger")
                            >> List.head
                        )
                    |> Maybe.andThen (Node.findAttribute "for")
                    |> Expect.equal (Just "fab-menu")
        , test "BUG FIX #18: item helper emits <m3e-fab-menu-item>, NOT <m3e-menu-item>" <|
            \_ ->
                FabMenu.item { icon = "share", label = "Share", onClick = () }
                    |> Element.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-fab-menu-item")
        , test "BUG FIX #18: items inside m3e-fab-menu are <m3e-fab-menu-item>" <|
            \_ ->
                node []
                    |> fabMenuNode
                    |> Maybe.map Node.childrenOf
                    |> Maybe.map (List.map Node.tagOf)
                    |> Expect.equal (Just [ Just "m3e-fab-menu-item", Just "m3e-fab-menu-item" ])
        , test "item icon is in a <span slot=icon>" <|
            \_ ->
                FabMenu.item { icon = "share", label = "Share", onClick = () }
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.map (\n -> ( Node.tagOf n, Node.findAttribute "slot" n ))
                    |> Expect.equal (Just ( Just "span", Just "icon" ))
        , test "item label is a text child of m3e-fab-menu-item" <|
            \_ ->
                FabMenu.item { icon = "share", label = "Share", onClick = () }
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.drop 1
                    |> List.head
                    |> Maybe.andThen
                        (\n ->
                            case n of
                                Node.Text s ->
                                    Just s

                                _ ->
                                    Nothing
                        )
                    |> Expect.equal (Just "Share")
        , test "variant option does not crash (rawAttr — not introspectable)" <|
            \_ ->
                node [ FabMenu.variant FabMenu.Tertiary ]
                    |> fabMenuNode
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "m3e-fab-menu")
        ]
