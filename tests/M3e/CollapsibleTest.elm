module M3e.CollapsibleTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Collapsible as Collapsible
import M3e.Element as Element
import M3e.Node as Node exposing (Node)
import M3e.Value as Value
import Test exposing (Test, describe, test)


node : List (Collapsible.Option msg) -> Node msg
node opts =
    Collapsible.view { content = [] } opts |> Element.toNode


suite : Test
suite =
    describe "M3e.Collapsible — view-style port"
        [ test "renders <m3e-collapsible>" <|
            \_ ->
                node []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-collapsible")
        , test "open=false is always emitted as a DOM property" <|
            \_ ->
                node []
                    |> Node.findProperty "open"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "open=true is a DOM property — introspectable" <|
            \_ ->
                node [ Collapsible.open True ]
                    |> Node.findProperty "open"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "noAnimate=false is always emitted as a DOM property" <|
            \_ ->
                node []
                    |> Node.findProperty "noAnimate"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "noAnimate=true is a DOM property — introspectable" <|
            \_ ->
                node [ Collapsible.noAnimate True ]
                    |> Node.findProperty "noAnimate"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "no orientation attribute by default" <|
            \_ ->
                node []
                    |> Node.findAttribute "orientation"
                    |> Expect.equal Nothing
        , test "orientation vertical emits orientation=vertical" <|
            \_ ->
                node [ Collapsible.orientation Value.vertical ]
                    |> Node.findAttribute "orientation"
                    |> Expect.equal (Just "vertical")
        , test "orientation horizontal emits orientation=horizontal" <|
            \_ ->
                node [ Collapsible.orientation Value.horizontal ]
                    |> Node.findAttribute "orientation"
                    |> Expect.equal (Just "horizontal")
        , test "content renders into the default slot" <|
            \_ ->
                Collapsible.view
                    { content = [ Element.text "Body A", Element.text "Body B" ] }
                    []
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.length
                    |> Expect.equal 2
        ]
