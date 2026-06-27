module M3e.DialogTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Button as Button
import M3e.Dialog as Dialog
import M3e.Element as Element exposing (Element)
import M3e.Node as Node exposing (Node)
import Test exposing (Test, describe, test)


node : List (Dialog.Option msg) -> Node msg
node opts =
    Dialog.view { headline = "Delete item?", content = [] } opts
        |> Element.toNode


actionButton : Element { button : Element.Supported } msg
actionButton =
    Button.view { label = "Confirm", variant = Button.Filled } []


suite : Test
suite =
    describe "M3e.Dialog — view-style port"
        [ test "renders <m3e-dialog>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-dialog")
        , test "open=true is a DOM property — introspectable" <|
            \_ ->
                node [ Dialog.open True ]
                    |> Node.findProperty "open"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "open=false is a DOM property (always emitted)" <|
            \_ ->
                node []
                    |> Node.findProperty "open"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "headline lands in <span slot=\"header\">" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.map
                        (\n ->
                            ( Node.tagOf n
                            , Node.findAttribute "slot" n
                            , Node.childrenOf n |> List.head |> Maybe.andThen nodeText
                            )
                        )
                    |> Expect.equal (Just ( Just "span", Just "header", Just "Delete item?" ))
        , test "content children follow the headline in the default slot" <|
            \_ ->
                Dialog.view
                    { headline = "Confirm"
                    , content = [ Element.html (node [] |> Node.toHtml) ]
                    }
                    []
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        , test "alert=true is a DOM property" <|
            \_ ->
                node [ Dialog.alert True ]
                    |> Node.findProperty "alert"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "alert absent by default" <|
            \_ ->
                node []
                    |> Node.findProperty "alert"
                    |> Expect.equal Nothing
        , test "closeButton=true sets the dismissible DOM property" <|
            \_ ->
                node [ Dialog.closeButton True ]
                    |> Node.findProperty "dismissible"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "closeButton absent by default (no dismissible property)" <|
            \_ ->
                node []
                    |> Node.findProperty "dismissible"
                    |> Expect.equal Nothing
        , test "dismissible=false sets disable-close DOM property" <|
            \_ ->
                node [ Dialog.dismissible False ]
                    |> Node.findProperty "disableClose"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disable-close absent by default (dismissible=true)" <|
            \_ ->
                node []
                    |> Node.findProperty "disableClose"
                    |> Expect.equal Nothing
        , test "actions render inside <div slot=\"actions\">" <|
            \_ ->
                node [ Dialog.actions [ actionButton ] ]
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "actions")
                    |> List.head
                    |> Maybe.map (\n -> ( Node.tagOf n, Node.childrenOf n |> List.length ))
                    |> Expect.equal (Just ( Just "div", 1 ))
        , test "no actions slot when actions list is empty" <|
            \_ ->
                node []
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "actions")
                    |> List.length
                    |> Expect.equal 0
        ]


nodeText : Node msg -> Maybe String
nodeText n =
    case n of
        Node.Text s ->
            Just s

        _ ->
            Nothing
