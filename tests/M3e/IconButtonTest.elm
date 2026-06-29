module M3e.IconButtonTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.Element as Element
import M3e.Icon as Icon
import M3e.IconButton as IB
import M3e.Node as Node exposing (Node)
import M3e.Value as Value
import Test exposing (Test, describe, test)


node : String -> String -> List (IB.Option msg) -> Node msg
node icon ariaLabel opts =
    IB.view { icon = icon, ariaLabel = ariaLabel } opts |> Element.toNode


suite : Test
suite =
    describe "M3e.IconButton — expanded surface"
        [ test "required ariaLabel lands as aria-label attribute" <|
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
                node "heart" "Favourite" [ IB.selectedIcon (Icon.view { name = "heart_filled" } []) ]
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "selected")
                    |> List.length
                    |> Expect.equal 1
        , test "name option emits name attribute (FormSubmitter)" <|
            \_ ->
                node "close" "Close" [ IB.name "action" ]
                    |> Node.findAttribute "name"
                    |> Expect.equal (Just "action")
        , test "value option emits value attribute (FormSubmitter)" <|
            \_ ->
                node "close" "Close" [ IB.value "close" ]
                    |> Node.findAttribute "value"
                    |> Expect.equal (Just "close")
        , test "formType Submit emits type=submit (FormSubmitter)" <|
            \_ ->
                node "close" "Close" [ IB.formType Value.submit ]
                    |> Node.findAttribute "type"
                    |> Expect.equal (Just "submit")
        , test "formType Button emits type=button (FormSubmitter)" <|
            \_ ->
                node "close" "Close" [ IB.formType Value.button ]
                    |> Node.findAttribute "type"
                    |> Expect.equal (Just "button")
        , test "no formType — no type attribute emitted by default" <|
            \_ ->
                node "close" "Close" []
                    |> Node.findAttribute "type"
                    |> Expect.equal Nothing
        ]
