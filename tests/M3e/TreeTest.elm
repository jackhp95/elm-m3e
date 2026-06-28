module M3e.TreeTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element exposing (Element)
import M3e.Node as Node exposing (Attr(..), Node(..))
import M3e.Tree as Tree
import Test exposing (Test, describe, test)



-- Helpers ---------------------------------------------------------------------


treeNode : List (Tree.Option msg) -> List (Element { treeItem : Element.Supported } msg) -> Node msg
treeNode opts items =
    Tree.view { items = items } opts
        |> Element.toNode


leafItem : String -> Element { treeItem : Element.Supported } msg
leafItem label =
    Tree.treeItem { label = label, children = [] } []


countRawAttrs : Node msg -> Int
countRawAttrs node =
    case node of
        Element { attrs } ->
            List.length
                (List.filter
                    (\a ->
                        case a of
                            RawAttr _ ->
                                True

                            _ ->
                                False
                    )
                    attrs
                )

        _ ->
            0



-- Suite -----------------------------------------------------------------------


suite : Test
suite =
    describe "M3e.Tree"
        [ -- ── Container tag ────────────────────────────────────────────────
          describe "view (<m3e-tree>)"
            [ test "view renders <m3e-tree>" <|
                \_ ->
                    treeNode [] []
                        |> Node.tagOf
                        |> Expect.equal (Just "m3e-tree")
            , test "multi=False is emitted unconditionally" <|
                \_ ->
                    treeNode [] []
                        |> Node.findProperty "multi"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "false")
            , test "multi=True sets multi DOM property" <|
                \_ ->
                    treeNode [ Tree.multi True ] []
                        |> Node.findProperty "multi"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            , test "cascade=False is emitted unconditionally" <|
                \_ ->
                    treeNode [] []
                        |> Node.findProperty "cascade"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "false")
            , test "cascade=True sets cascade DOM property" <|
                \_ ->
                    treeNode [ Tree.cascade True ] []
                        |> Node.findProperty "cascade"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            , test "children count matches items list" <|
                \_ ->
                    treeNode []
                        [ leafItem "A"
                        , leafItem "B"
                        , leafItem "C"
                        ]
                        |> Node.childrenOf
                        |> List.length
                        |> Expect.equal 3
            ]

        -- ── onChange event ───────────────────────────────────────────────
        , describe "onChange"
            [ test "onChange registers a RawAttr event listener" <|
                \_ ->
                    let
                        withoutHandler : Int
                        withoutHandler =
                            treeNode [] [] |> countRawAttrs

                        withHandler : Int
                        withHandler =
                            treeNode [ Tree.onChange () ] [] |> countRawAttrs
                    in
                    Expect.all
                        [ \_ -> withoutHandler |> Expect.equal 0
                        , \_ -> withHandler |> Expect.greaterThan 0
                        ]
                        ()
            ]

        -- ── treeItem tag ─────────────────────────────────────────────────
        , describe "treeItem (<m3e-tree-item>)"
            [ test "treeItem renders <m3e-tree-item>" <|
                \_ ->
                    leafItem "Leaf"
                        |> Element.toNode
                        |> Node.tagOf
                        |> Expect.equal (Just "m3e-tree-item")
            , test "label text is rendered in a slot='label' span" <|
                \_ ->
                    leafItem "Hello"
                        |> Element.toNode
                        |> Node.childrenOf
                        |> List.head
                        |> Maybe.andThen (Node.findAttribute "slot")
                        |> Expect.equal (Just "label")
            , test "disabled=False emitted unconditionally" <|
                \_ ->
                    leafItem "X"
                        |> Element.toNode
                        |> Node.findProperty "disabled"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "false")
            , test "itemDisabled=True sets disabled DOM property" <|
                \_ ->
                    Tree.treeItem { label = "X", children = [] }
                        [ Tree.itemDisabled True ]
                        |> Element.toNode
                        |> Node.findProperty "disabled"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            , test "indeterminate=False emitted unconditionally" <|
                \_ ->
                    leafItem "X"
                        |> Element.toNode
                        |> Node.findProperty "indeterminate"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "false")
            , test "itemIndeterminate=True sets indeterminate DOM property" <|
                \_ ->
                    Tree.treeItem { label = "X", children = [] }
                        [ Tree.itemIndeterminate True ]
                        |> Element.toNode
                        |> Node.findProperty "indeterminate"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            , test "open=False emitted unconditionally" <|
                \_ ->
                    leafItem "X"
                        |> Element.toNode
                        |> Node.findProperty "open"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "false")
            , test "itemOpen=True sets open DOM property" <|
                \_ ->
                    Tree.treeItem { label = "X", children = [] }
                        [ Tree.itemOpen True ]
                        |> Element.toNode
                        |> Node.findProperty "open"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            , test "selected=False emitted unconditionally" <|
                \_ ->
                    leafItem "X"
                        |> Element.toNode
                        |> Node.findProperty "selected"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "false")
            , test "itemSelected=True sets selected DOM property" <|
                \_ ->
                    Tree.treeItem { label = "X", children = [] }
                        [ Tree.itemSelected True ]
                        |> Element.toNode
                        |> Node.findProperty "selected"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            ]

        -- ── Nesting (treeItem inside treeItem) ───────────────────────────
        , describe "nesting"
            [ test "a treeItem with children has them as sibling nodes after the label" <|
                \_ ->
                    Tree.treeItem
                        { label = "Parent"
                        , children =
                            [ leafItem "Child A"
                            , leafItem "Child B"
                            ]
                        }
                        []
                        |> Element.toNode
                        |> Node.childrenOf
                        -- first child is the label span; then the two tree-item children
                        |> List.length
                        |> Expect.equal 3
            , test "nested child is itself a <m3e-tree-item>" <|
                \_ ->
                    Tree.treeItem
                        { label = "Parent"
                        , children = [ leafItem "Child" ]
                        }
                        []
                        |> Element.toNode
                        |> Node.childrenOf
                        |> List.drop 1
                        |> List.head
                        |> Maybe.andThen Node.tagOf
                        |> Expect.equal (Just "m3e-tree-item")
            , test "deeply nested tree item (grandchild) is reachable" <|
                \_ ->
                    Tree.treeItem
                        { label = "Root"
                        , children =
                            [ Tree.treeItem
                                { label = "Parent"
                                , children = [ leafItem "Grandchild" ]
                                }
                                []
                            ]
                        }
                        []
                        |> Element.toNode
                        -- root → children → [label, parentItem]; parentItem → children → [label, grandchild]
                        |> Node.childrenOf
                        |> List.drop 1
                        |> List.head
                        |> Maybe.map Node.childrenOf
                        |> Maybe.withDefault []
                        |> List.drop 1
                        |> List.head
                        |> Maybe.andThen Node.tagOf
                        |> Expect.equal (Just "m3e-tree-item")
            ]

        -- ── Icon slots ───────────────────────────────────────────────────
        , describe "icon slots"
            [ test "itemIcon adds a child with slot='icon'" <|
                \_ ->
                    let
                        icon : Element { element : Element.Supported } msg
                        icon =
                            Element.text "★"
                    in
                    Tree.treeItem { label = "X", children = [] }
                        [ Tree.itemIcon icon ]
                        |> Element.toNode
                        |> Node.childrenOf
                        |> List.filterMap (Node.findAttribute "slot")
                        |> List.member "icon"
                        |> Expect.equal True
            , test "itemSelectedIcon adds a child with slot='selected-icon'" <|
                \_ ->
                    let
                        icon : Element { element : Element.Supported } msg
                        icon =
                            Element.text "★"
                    in
                    Tree.treeItem { label = "X", children = [] }
                        [ Tree.itemSelectedIcon icon ]
                        |> Element.toNode
                        |> Node.childrenOf
                        |> List.filterMap (Node.findAttribute "slot")
                        |> List.member "selected-icon"
                        |> Expect.equal True
            ]

        -- ── Item events ──────────────────────────────────────────────────
        , describe "item events"
            [ test "itemOnOpening registers a RawAttr" <|
                \_ ->
                    let
                        withoutHandler : Int
                        withoutHandler =
                            leafItem "X" |> Element.toNode |> countRawAttrs

                        withHandler : Int
                        withHandler =
                            Tree.treeItem { label = "X", children = [] }
                                [ Tree.itemOnOpening () ]
                                |> Element.toNode
                                |> countRawAttrs
                    in
                    Expect.all
                        [ \_ -> withoutHandler |> Expect.equal 0
                        , \_ -> withHandler |> Expect.greaterThan 0
                        ]
                        ()
            , test "itemOnClick registers a RawAttr" <|
                \_ ->
                    Tree.treeItem { label = "X", children = [] }
                        [ Tree.itemOnClick () ]
                        |> Element.toNode
                        |> countRawAttrs
                        |> Expect.greaterThan 0
            , test "multiple item events each add a RawAttr" <|
                \_ ->
                    Tree.treeItem { label = "X", children = [] }
                        [ Tree.itemOnOpening ()
                        , Tree.itemOnOpened ()
                        , Tree.itemOnClosing ()
                        , Tree.itemOnClosed ()
                        , Tree.itemOnClick ()
                        ]
                        |> Element.toNode
                        |> countRawAttrs
                        |> Expect.equal 5
            ]
        ]
