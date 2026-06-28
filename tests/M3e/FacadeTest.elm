module M3e.FacadeTest exposing (suite)

import Expect
import M3e exposing (..)
import M3e.Node as Node
import Test exposing (Test, describe, test)


type Msg
    = Clicked
    | Toggled
    | Removed


suite : Test
suite =
    describe "M3e facade — single-import entry points"
        [ test "buttonFilled renders m3e-button with variant=filled" <|
            \_ ->
                buttonFilled { label = "Save" } [ onClick Clicked, disabled False ]
                    |> toNode
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "filled")
        , test "buttonText emits the renamed token's string (text)" <|
            \_ ->
                buttonText { label = "Dismiss" } []
                    |> toNode
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "text")
        , test "buttonOutlined renders an m3e-button" <|
            \_ ->
                buttonOutlined { label = "Cancel" } []
                    |> toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-button")
        , test "chipAssist renders m3e-assist-chip" <|
            \_ ->
                chipAssist { label = "Add", onClick = Clicked } []
                    |> toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-assist-chip")
        , test "chipFilter renders m3e-filter-chip" <|
            \_ ->
                chipFilter { label = "Veg", onToggle = Toggled } []
                    |> toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-filter-chip")
        , test "chipInput renders m3e-input-chip" <|
            \_ ->
                chipInput { label = "tag", onRemove = Removed } []
                    |> toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-input-chip")
        , test "chip (display) renders m3e-chip" <|
            \_ ->
                chip { label = "Info" } []
                    |> toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-chip")
        , test "cardElevated renders m3e-card with variant=elevated" <|
            \_ ->
                cardElevated []
                    |> toNode
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "elevated")
        , test "cardOutlined renders variant=outlined" <|
            \_ ->
                cardOutlined []
                    |> toNode
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "outlined")
        ]
