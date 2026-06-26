module M3e.SideSheetTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Button as Button
import M3e.Node as Node
import M3e.Renderable as Renderable
import M3e.SideSheet as SideSheet
import Test exposing (Test, describe, test)


node : List (SideSheet.Option msg) -> Node.Node msg
node opts =
    SideSheet.view { content = [] } opts
        |> Renderable.toNode


suite : Test
suite =
    describe "M3e.SideSheet — view-style port"
        [ test "renders <m3e-drawer-container>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-drawer-container")
        , test "open=true on End side sets the 'end' DOM property" <|
            \_ ->
                node [ SideSheet.open True, SideSheet.side SideSheet.End ]
                    |> Node.findProperty "end"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "open=false on End side is also emitted (always present)" <|
            \_ ->
                node [ SideSheet.side SideSheet.End ]
                    |> Node.findProperty "end"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "open=true on Start side sets the 'start' DOM property" <|
            \_ ->
                node [ SideSheet.open True, SideSheet.side SideSheet.Start ]
                    |> Node.findProperty "start"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "default side is End — 'end' property present, 'start' absent" <|
            \_ ->
                let
                    n =
                        node []
                in
                ( Node.findProperty "end" n /= Nothing
                , Node.findProperty "start" n
                )
                    |> Expect.equal ( True, Nothing )
        , test "body content lands inside the end-slot div" <|
            \_ ->
                SideSheet.view
                    { content = [] }
                    [ SideSheet.body [ Renderable.html (Node.toHtml (Node.text "sidebar")) ]
                    , SideSheet.side SideSheet.End
                    ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.map
                        (\n ->
                            ( Node.tagOf n, Node.findAttribute "slot" n )
                        )
                    |> Expect.equal (Just ( Just "div", Just "end" ))
        , test "page content comes after the panel in default slot" <|
            \_ ->
                SideSheet.view
                    { content =
                        [ Renderable.html (Node.toHtml (Node.text "main"))
                        , Renderable.html (Node.toHtml (Node.text "more"))
                        ]
                    }
                    []
                    |> Renderable.toNode
                    |> Node.childrenOf
                    -- first child is the panel div, rest is page content
                    |> List.length
                    |> Expect.equal 3
        , test "action buttons land inside the panel slot div" <|
            \_ ->
                SideSheet.view
                    { content = [] }
                    [ SideSheet.actions
                        [ Button.view { label = "Close", variant = Button.Text } [] ]
                    ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.map (Node.childrenOf >> List.length)
                    |> Expect.equal (Just 1)
        , test "Fix A8: onClose wires a 'change' handler (RawAttr present)" <|
            -- We cannot inspect the decoder internals, but we can verify the
            -- component compiles and has a change handler node by checking that
            -- the attrs list is non-empty (open + mode + change = 3 attrs).
            \_ ->
                let
                    -- A simple count: open + mode + onClose = 3 attrs total
                    attrCount =
                        SideSheet.view { content = [] } [ SideSheet.onClose () ]
                            |> Renderable.toNode
                            |> attrsOf
                            |> List.length
                in
                attrCount
                    |> Expect.equal 3
        ]


attrsOf : Node.Node msg -> List (Node.Attr msg)
attrsOf n =
    case n of
        Node.Element el ->
            el.attrs

        _ ->
            []
