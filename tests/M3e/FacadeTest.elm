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
        , test "iconButton (req + options re-bind) renders m3e-icon-button" <|
            \_ ->
                iconButton { icon = "add", ariaLabel = "Add" } []
                    |> toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-icon-button")
        , test "badge (options-only re-bind) renders m3e-badge" <|
            \_ ->
                badge []
                    |> toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-badge")
        , test "extendedFabSecondary bakes variant=secondary" <|
            \_ ->
                extendedFabSecondary { icon = "add", label = "Compose" } []
                    |> toNode
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "secondary")
        , test "headingTitle bakes variant=title" <|
            \_ ->
                headingTitle { label = "Section" } []
                    |> toNode
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "title")
        , test "navigationBar (container re-bind) renders m3e-navigation-bar" <|
            \_ ->
                navigationBar { items = [] } []
                    |> toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-nav-bar")
        , test "tooltipPlain (multi-constructor re-bind) renders m3e-tooltip" <|
            \_ ->
                tooltipPlain { anchorId = "anchor", label = "Hint" } []
                    |> toNode
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-tooltip")
        ]
