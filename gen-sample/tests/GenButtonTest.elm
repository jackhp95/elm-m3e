module GenButtonTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Button as Button
import M3e.Element as Element
import M3e.Node as Node
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "generated M3e.Button (top layer) produces correct IR"
        [ test "tag is m3e-button" <|
            \_ -> Button.view [] [] |> Element.toNode |> Node.tagOf |> Expect.equal (Just "m3e-button")
        , test "disabled True -> disabled DOM property = true" <|
            \_ ->
                Button.view [ Button.disabled True ] []
                    |> Element.toNode
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "href -> href attribute (introspectable)" <|
            \_ ->
                Button.view [ Button.href "/x" ] []
                    |> Element.toNode
                    |> Node.findAttribute "href"
                    |> Expect.equal (Just "/x")
        , test "boolean reset: default emits disabled=false (not absent)" <|
            \_ ->
                Button.view [] []
                    |> Element.toNode
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        ]
