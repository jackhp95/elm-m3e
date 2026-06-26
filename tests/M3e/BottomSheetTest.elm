module M3e.BottomSheetTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.BottomSheet as BottomSheet
import M3e.Button as Button
import M3e.Node as Node
import M3e.Renderable as Renderable
import Test exposing (Test, describe, test)


node : List (BottomSheet.Option msg) -> Node.Node msg
node opts =
    BottomSheet.view { content = [] } opts
        |> Renderable.toNode


actionButton : Renderable.Renderable { button : Renderable.Supported } msg
actionButton =
    Button.view { label = "Share", variant = Button.Tonal } []


suite : Test
suite =
    describe "M3e.BottomSheet — view-style port"
        [ test "renders <m3e-bottom-sheet>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-bottom-sheet")
        , test "open=true is a DOM property — introspectable" <|
            \_ ->
                node [ BottomSheet.open True ]
                    |> Node.findProperty "open"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "open=false is always emitted" <|
            \_ ->
                node []
                    |> Node.findProperty "open"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "handle=true is a DOM property" <|
            \_ ->
                node [ BottomSheet.handle True ]
                    |> Node.findProperty "handle"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "handle absent by default" <|
            \_ ->
                node []
                    |> Node.findProperty "handle"
                    |> Expect.equal Nothing
        , test "modal=true is a DOM property" <|
            \_ ->
                node [ BottomSheet.modal True ]
                    |> Node.findProperty "modal"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "header content renders in <div slot=\"header\">" <|
            \_ ->
                BottomSheet.view
                    { content = [] }
                    [ BottomSheet.header [ Renderable.html (Node.toHtml (Node.text "Title")) ] ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.map
                        (\n ->
                            ( Node.tagOf n, Node.findAttribute "slot" n )
                        )
                    |> Expect.equal (Just ( Just "div", Just "header" ))
        , test "Fix F12: action button contains m3e-bottom-sheet-action as child" <|
            \_ ->
                node [ BottomSheet.actions [ actionButton ] ]
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen
                        (\btn ->
                            btn
                                |> Node.childrenOf
                                |> List.filter (\n -> Node.tagOf n == Just "m3e-bottom-sheet-action")
                                |> List.head
                                |> Maybe.map Node.tagOf
                        )
                    |> Expect.equal (Just (Just "m3e-bottom-sheet-action"))
        , test "Fix F12: action button is the outer element (m3e-button), not wrapped" <|
            \_ ->
                node [ BottomSheet.actions [ actionButton ] ]
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.map Node.tagOf
                    |> Expect.equal (Just (Just "m3e-button"))
        , test "content renders in default slot (no slot attribute)" <|
            \_ ->
                BottomSheet.view
                    { content = [ Renderable.html (Node.toHtml (Node.text "body")) ] }
                    []
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 1
        ]
