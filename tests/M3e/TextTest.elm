module M3e.TextTest exposing (suite)

import Expect
import M3e.Node as Node
import M3e.Renderable as Renderable
import M3e.Text as Text
import Test exposing (Test, describe, test)


node : String -> Text.Role -> List (Text.Option msg) -> Node.Node msg
node content role opts =
    Text.view { content = content, role = role } opts |> Renderable.toNode


firstChildText : Node.Node msg -> Maybe String
firstChildText n =
    case Node.childrenOf n of
        (Node.Text s) :: _ ->
            Just s

        _ ->
            Nothing


suite : Test
suite =
    describe "M3e.Text — view-style port"
        [ test "renders <p> by default" <|
            \_ ->
                node "Hello" Text.BodyLarge []
                    |> Node.tagOf
                    |> Expect.equal (Just "p")
        , test "renders <span> when inline option set" <|
            \_ ->
                node "Hello" Text.BodyLarge [ Text.inline ]
                    |> Node.tagOf
                    |> Expect.equal (Just "span")
        , test "BodyLarge emits text-body-lg class" <|
            \_ ->
                node "x" Text.BodyLarge []
                    |> Node.findAttribute "class"
                    |> Expect.equal (Just "text-body-lg")
        , test "BodyMedium emits text-body-md class" <|
            \_ ->
                node "x" Text.BodyMedium []
                    |> Node.findAttribute "class"
                    |> Expect.equal (Just "text-body-md")
        , test "BodySmall emits text-body-sm class" <|
            \_ ->
                node "x" Text.BodySmall []
                    |> Node.findAttribute "class"
                    |> Expect.equal (Just "text-body-sm")
        , test "LabelLarge emits text-label-lg class" <|
            \_ ->
                node "x" Text.LabelLarge []
                    |> Node.findAttribute "class"
                    |> Expect.equal (Just "text-label-lg")
        , test "LabelMedium emits text-label-md class" <|
            \_ ->
                node "x" Text.LabelMedium []
                    |> Node.findAttribute "class"
                    |> Expect.equal (Just "text-label-md")
        , test "LabelSmall emits text-label-sm class" <|
            \_ ->
                node "x" Text.LabelSmall []
                    |> Node.findAttribute "class"
                    |> Expect.equal (Just "text-label-sm")
        , test "content becomes child Text node" <|
            \_ ->
                node "Lorem ipsum" Text.BodyLarge []
                    |> firstChildText
                    |> Expect.equal (Just "Lorem ipsum")
        , test "bodyLarge preset renders <p> with text-body-lg" <|
            \_ ->
                Text.bodyLarge "Preset text"
                    |> Renderable.toNode
                    |> (\n -> ( Node.tagOf n, Node.findAttribute "class" n ))
                    |> Expect.equal ( Just "p", Just "text-body-lg" )
        , test "labelSmall preset renders <p> with text-label-sm" <|
            \_ ->
                Text.labelSmall "tiny"
                    |> Renderable.toNode
                    |> (\n -> ( Node.tagOf n, Node.findAttribute "class" n ))
                    |> Expect.equal ( Just "p", Just "text-label-sm" )
        ]
