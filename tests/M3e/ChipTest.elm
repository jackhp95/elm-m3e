module M3e.ChipTest exposing (suite)

import Expect
import Json.Encode as Encode
import Test exposing (Test, describe, test)
import M3e.Avatar as Avatar
import M3e.Chip as Chip
import M3e.Icon as Icon
import M3e.Node as Node
import M3e.Renderable as Renderable


suite : Test
suite =
    describe "M3e.Chip — expanded surface"
        [ test "view {label} (existing) renders m3e-chip" <|
            \_ ->
                Chip.view { label = "Tag" } []
                    |> Renderable.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-chip")
        , test "assist renders m3e-assist-chip" <|
            \_ ->
                Chip.assist { label = "Auto-fill", onClick = () } []
                    |> Renderable.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-assist-chip")
        , test "suggestion renders m3e-suggestion-chip" <|
            \_ ->
                Chip.suggestion { label = "Search", onClick = () } []
                    |> Renderable.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-suggestion-chip")
        , test "filter renders m3e-filter-chip" <|
            \_ ->
                Chip.filter { label = "Active", onToggle = () } []
                    |> Renderable.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-filter-chip")
        , test "input renders m3e-input-chip" <|
            \_ ->
                Chip.input { label = "Jack", onRemove = () } []
                    |> Renderable.toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-input-chip")
        , test "selected is a DOM property on filter chip" <|
            \_ ->
                Chip.filter { label = "Active", onToggle = () } [ Chip.selected True ]
                    |> Renderable.toNode
                    |> Node.findProperty "selected"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "disabled is a DOM property" <|
            \_ ->
                Chip.assist { label = "Auto", onClick = () } [ Chip.disabled True ]
                    |> Renderable.toNode
                    |> Node.findProperty "disabled"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "elevated emits variant=elevated attribute" <|
            \_ ->
                Chip.assist { label = "Auto", onClick = () } [ Chip.elevated True ]
                    |> Renderable.toNode
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "elevated")
        , test "default (non-elevated) emits variant=outlined attribute" <|
            \_ ->
                Chip.assist { label = "Auto", onClick = () } []
                    |> Renderable.toNode
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "outlined")
        , test "href on assist emits href attribute" <|
            \_ ->
                Chip.assist { label = "Docs", onClick = () } [ Chip.href "/docs" ]
                    |> Renderable.toNode
                    |> Node.findAttribute "href"
                    |> Expect.equal (Just "/docs")
        , test "leadingIcon child is slotted into slot=icon" <|
            \_ ->
                Chip.assist { label = "Search", onClick = () }
                    [ Chip.leadingIcon (Icon.view { name = "search" }) ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "icon")
                    |> List.length
                    |> Expect.equal 1
        , test "removeLabel emits remove-label attribute on input chip" <|
            \_ ->
                Chip.input { label = "Jack", onRemove = () }
                    [ Chip.removeLabel "Remove Jack" ]
                    |> Renderable.toNode
                    |> Node.findAttribute "remove-label"
                    |> Expect.equal (Just "Remove Jack")
        , test "input chip is removable (DOM property)" <|
            \_ ->
                Chip.input { label = "Jack", onRemove = () } []
                    |> Renderable.toNode
                    |> Node.findProperty "removable"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "avatarChild on input chip is slotted into slot=avatar" <|
            \_ ->
                Chip.input { label = "Jack", onRemove = () }
                    [ Chip.avatarChild (Avatar.view { alt = "Jack" } []) ]
                    |> Renderable.toNode
                    |> Node.childrenOf
                    |> List.filter (\n -> Node.findAttribute "slot" n == Just "avatar")
                    |> List.length
                    |> Expect.equal 1
        ]
