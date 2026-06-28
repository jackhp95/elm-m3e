module M3e.ValueTest exposing (suite)

{-| Cross-component proof for M3e.Value.

The core guarantee: a single `M3e.Value.*` token is polymorphic over _any_
component whose size option's supported-row includes that key. The tests below
exercise the SAME token against components with DIFFERENT size scales —
Button (five sizes) and Fab/Heading (three sizes) — proving at compile time
(the token unifies against each closed row) and at runtime (the emitted `size`
attribute is identical) that sharing works.

Note on the "impossible" direction: there is no failing-compile test that can
live in `elm-test`, but the type boundary is clear — passing
`M3e.Value.extraSmall` to a three-size component is a type error:

    -- Does NOT compile — Heading has no `extraSmall` in its size row:
    Heading.view { label = "X", variant = Value.title }
        [ Heading.size Value.extraSmall ]

    -- DOES compile — Button's row includes `extraSmall`:
    Button.view { label = "X", variant = Value.filled }
        [ Button.size Value.extraSmall ]

-}

import Expect
import M3e.Button as Button
import M3e.Element as Element
import M3e.Fab as Fab
import M3e.Heading as Heading
import M3e.Node as Node exposing (Node)
import M3e.Value as Value
import Test exposing (Test, describe, test)



-- Helpers -----------------------------------------------------------------


buttonNode : List (Button.Option msg) -> Node msg
buttonNode opts =
    Button.view { label = "Save", variant = Value.filled } opts
        |> Element.toNode


fabNode : List (Fab.Option msg) -> Node msg
fabNode opts =
    Fab.view { icon = "add", ariaLabel = "Add" } opts
        |> Element.toNode


headingNode : List (Heading.Option msg) -> Node msg
headingNode opts =
    Heading.view { label = "Title", variant = Value.title } opts
        |> Element.toNode



-- Suite -------------------------------------------------------------------


suite : Test
suite =
    describe "M3e.Value — cross-component shared size tokens"
        [ describe "toString"
            [ test "extraSmall" <| \_ -> Value.toString Value.extraSmall |> Expect.equal "extra-small"
            , test "small" <| \_ -> Value.toString Value.small |> Expect.equal "small"
            , test "medium" <| \_ -> Value.toString Value.medium |> Expect.equal "medium"
            , test "large" <| \_ -> Value.toString Value.large |> Expect.equal "large"
            , test "extraLarge" <| \_ -> Value.toString Value.extraLarge |> Expect.equal "extra-large"
            ]

        -- A single token drives multiple components ------------------------
        , describe "shared token emits the same size attribute"
            [ test "Value.large on Button (5-size) emits size=large" <|
                \_ ->
                    buttonNode [ Button.size Value.large ]
                        |> Node.findAttribute "size"
                        |> Expect.equal (Just "large")
            , test "Value.large on Fab (3-size) emits size=large" <|
                \_ ->
                    fabNode [ Fab.size Value.large ]
                        |> Node.findAttribute "size"
                        |> Expect.equal (Just "large")
            , test "Value.large on Heading (3-size, optional) emits size=large" <|
                \_ ->
                    headingNode [ Heading.size Value.large ]
                        |> Node.findAttribute "size"
                        |> Expect.equal (Just "large")
            , test "Button, Fab, and Heading all emit the same string for Value.large" <|
                \_ ->
                    let
                        viaButton : Maybe String
                        viaButton =
                            buttonNode [ Button.size Value.large ] |> Node.findAttribute "size"

                        viaFab : Maybe String
                        viaFab =
                            fabNode [ Fab.size Value.large ] |> Node.findAttribute "size"

                        viaHeading : Maybe String
                        viaHeading =
                            headingNode [ Heading.size Value.large ] |> Node.findAttribute "size"
                    in
                    Expect.equal ( viaButton, viaButton ) ( viaFab, viaHeading )
            ]

        -- Five-size-only token works on Button -----------------------------
        , describe "extra sizes reach the wide-scale components"
            [ test "Value.extraSmall on Button emits size=extra-small" <|
                \_ ->
                    buttonNode [ Button.size Value.extraSmall ]
                        |> Node.findAttribute "size"
                        |> Expect.equal (Just "extra-small")
            , test "Value.extraLarge on Button emits size=extra-large" <|
                \_ ->
                    buttonNode [ Button.size Value.extraLarge ]
                        |> Node.findAttribute "size"
                        |> Expect.equal (Just "extra-large")
            ]

        -- Defaults ---------------------------------------------------------
        , describe "defaults"
            [ test "Fab default size is medium" <|
                \_ ->
                    fabNode []
                        |> Node.findAttribute "size"
                        |> Expect.equal (Just "medium")
            , test "Heading omits size when unset (optional)" <|
                \_ ->
                    headingNode []
                        |> Node.findAttribute "size"
                        |> Expect.equal Nothing
            ]
        ]
