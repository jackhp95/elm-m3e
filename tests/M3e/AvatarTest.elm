module M3e.AvatarTest exposing (suite)

import Expect
import M3e.Avatar as Avatar
import M3e.Element as Element
import M3e.Icon as Icon
import M3e.Node as Node
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "M3e.Avatar — expanded surface"
        [ test "renders m3e-avatar at root" <|
            \_ ->
                Avatar.view { ariaLabel = "Jack" } []
                    |> Element.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-avatar")
        , test "ariaLabel is emitted as aria-label" <|
            \_ ->
                Avatar.view { ariaLabel = "Jack Peterson" } []
                    |> Element.toNode
                    |> Node.findAttribute "aria-label"
                    |> Expect.equal (Just "Jack Peterson")
        , test "image option renders an img child" <|
            \_ ->
                Avatar.view { ariaLabel = "Jack" } [ Avatar.image "/photo.jpg" ]
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "img")
        , test "image child carries src attribute" <|
            \_ ->
                Avatar.view { ariaLabel = "Jack" } [ Avatar.image "/photo.jpg" ]
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "src")
                    |> Expect.equal (Just "/photo.jpg")
        , test "image child carries alt attribute from ariaLabel field" <|
            \_ ->
                Avatar.view { ariaLabel = "Jack Peterson" } [ Avatar.image "/photo.jpg" ]
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "alt")
                    |> Expect.equal (Just "Jack Peterson")
        , test "initials option renders a text child" <|
            \_ ->
                Avatar.view { ariaLabel = "Jack" } [ Avatar.initials "JP" ]
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> (\n ->
                            case n of
                                Just (Node.Text s) ->
                                    Just s

                                _ ->
                                    Nothing
                       )
                    |> Expect.equal (Just "JP")
        , test "iconChild option renders an m3e-icon child" <|
            \_ ->
                Avatar.view { ariaLabel = "Generic" } [ Avatar.iconChild (Icon.view { name = "person" } []) ]
                    |> Element.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "m3e-icon")
        ]
