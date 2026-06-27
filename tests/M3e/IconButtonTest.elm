module M3e.IconButtonTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element
import M3e.Icon as Icon
import M3e.IconButton as IB
import M3e.Node as Node exposing (Node)
import Test exposing (Test, describe, test)


node : String -> String -> List (IB.Option msg) -> Node msg
node icon name opts =
    IB.view { icon = icon, name = name } opts |> Element.toNode


suite : Test
suite =
    describe "M3e.IconButton — expanded surface"
        [ test "required a11y name lands as aria-label" <|
            \_ ->
                node "delete" "Delete" []
                    |> Node.findAttribute "aria-label"
                    |> Expect.equal (Just "Delete")
        , test "selected is a DOM property (introspectable)" <|
            \_ ->
                node "fav" "Favourite" [ IB.selected True ]
                    |> Node.findProperty "selected"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disabled is a DOM property" <|
            \_ ->
                node "del" "Delete" [ IB.disabled True ]
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "toggle is a DOM property" <|
            \_ ->
                node "fav" "Favourite" [ IB.toggle True ]
                    |> Node.findProperty "toggle"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "href lands as an attribute" <|
            \_ ->
                node "link" "Open" [ IB.href "/dashboard" ]
                    |> Node.findAttribute "href"
                    |> Expect.equal (Just "/dashboard")
        , test "the default icon child is an <m3e-icon> carrying the glyph name" <|
            \_ ->
                node "add" "Add" []
                    |> Node.childrenOf
                    |> List.head
                    |> Maybe.map (\n -> ( Node.tagOf n, Node.findAttribute "name" n ))
                    |> Expect.equal (Just ( Just "m3e-icon", Just "add" ))
        , test "selectedIcon is slotted into slot=selected" <|
            \_ ->
                node "heart" "Favourite" [ IB.selectedIcon (Icon.view { name = "heart_filled" }) ]
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "selected")
                    |> List.length
                    |> Expect.equal 1
        ]
