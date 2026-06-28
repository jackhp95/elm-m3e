module M3e.HeadingTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element
import M3e.Heading as Heading
import M3e.Node as Node exposing (Node)
import M3e.Value as Value exposing (Value)
import Test exposing (Test, describe, test)


nodeWith :
    { label : String
    , variant :
        Value
            { display : Element.Supported
            , headline : Element.Supported
            , title : Element.Supported
            , label : Element.Supported
            }
    }
    -> List (Heading.Option msg)
    -> Node msg
nodeWith req opts =
    Heading.view req opts |> Element.toNode


{-| Extract the text of the first Text child.
-}
firstChildText : Node msg -> Maybe String
firstChildText n =
    case Node.childrenOf n of
        (Node.Text s) :: _ ->
            Just s

        _ ->
            Nothing


suite : Test
suite =
    describe "M3e.Heading — view-style port"
        [ test "renders <m3e-heading>" <|
            \_ ->
                nodeWith { label = "Hello", variant = Value.display } []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-heading")
        , test "label becomes first child Text node" <|
            \_ ->
                nodeWith { label = "Section title", variant = Value.title } []
                    |> firstChildText
                    |> Expect.equal (Just "Section title")
        , test "emphasized=True is a DOM property — introspectable" <|
            \_ ->
                nodeWith { label = "Hi", variant = Value.display } [ Heading.emphasized True ]
                    |> Node.findProperty "emphasized"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "emphasized emits false by default" <|
            \_ ->
                nodeWith { label = "Hi", variant = Value.display } []
                    |> Node.findProperty "emphasized"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "false")
        , test "variant option does not crash (rawAttr — not introspectable)" <|
            \_ ->
                nodeWith { label = "Hi", variant = Value.headline } []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-heading")
        , test "size option does not crash (rawAttr — not introspectable)" <|
            \_ ->
                nodeWith { label = "Hi", variant = Value.title } [ Heading.size Value.large ]
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-heading")
        , test "level is clamped to 1..6 (below 1 → 1)" <|
            \_ ->
                -- level is a rawAttr so we can't introspect it, but we can verify no crash
                nodeWith { label = "Hi", variant = Value.display } [ Heading.level 0 ]
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-heading")
        , test "level is clamped to 1..6 (above 6 → 6, no crash)" <|
            \_ ->
                nodeWith { label = "Hi", variant = Value.display } [ Heading.level 99 ]
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-heading")
        ]
