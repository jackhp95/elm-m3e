module M3e.AvatarTest exposing (suite)

import Expect
import Test exposing (Test, describe, test)
import M3e.Avatar as Avatar
import M3e.Icon as Icon
import M3e.Node as Node
import M3e.Renderable as Renderable


suite : Test
suite =
    describe "M3e.Avatar — expanded surface"
        [ test "renders m3e-avatar at root" <|
            \_ ->
                Avatar.view { alt = "Jack" } []
                    |> Renderable.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-avatar")
        , test "alt is emitted as aria-label" <|
            \_ ->
                Avatar.view { alt = "Jack Peterson" } []
                    |> Renderable.toNode
                    |> Node.findAttribute "aria-label"
                    |> Expect.equal (Just "Jack Peterson")
        , test "image option renders an img child" <|
            \_ ->
                Avatar.view { alt = "Jack" } [ Avatar.image "/photo.jpg" ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "img")
        , test "image child carries src attribute" <|
            \_ ->
                Avatar.view { alt = "Jack" } [ Avatar.image "/photo.jpg" ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "src")
                    |> Expect.equal (Just "/photo.jpg")
        , test "image child carries alt attribute from required field" <|
            \_ ->
                Avatar.view { alt = "Jack Peterson" } [ Avatar.image "/photo.jpg" ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen (Node.findAttribute "alt")
                    |> Expect.equal (Just "Jack Peterson")
        , test "initials option renders a text child" <|
            \_ ->
                Avatar.view { alt = "Jack" } [ Avatar.initials "JP" ]
                    |> Renderable.toNode
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
                Avatar.view { alt = "Generic" } [ Avatar.iconChild (Icon.view { name = "person" }) ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.andThen Node.tagOf
                    |> Expect.equal (Just "m3e-icon")
        ]
