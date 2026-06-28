module M3e.AttrTest exposing (suite)

{-| Cross-component proof for M3e.Attr.

The core guarantee: a single `M3e.Attr.*` builder is polymorphic over _any_
component whose `Config` has the matching field. The tests below exercise the
same builder against TWO different components, proving at compile time (and at
runtime) that the Option unifies correctly.

Note on the "impossible" direction: there is no failing-compile test that can
live in `elm-test`, but the type boundary is clear — passing `Attr.disabled`
to a component that has no `disabled : Bool` field in its Config is a type
error. For example:

    -- This does NOT compile — M3e.Avatar has no `disabled` field in its Config:
    Avatar.view { name = "A" } [ Attr.disabled True ]

    -- This DOES compile:
    Button.view { label = "X", variant = Value.filled } [ Attr.disabled True ]

    Checkbox.view { ariaLabel = "Y" } [ Attr.disabled True ]

-}

import Expect
import Json.Encode as Encode
import M3e.Attr as Attr
import M3e.Button as Button
import M3e.Checkbox as Checkbox
import M3e.Chip as Chip
import M3e.Element as Element
import M3e.IconButton as IconButton
import M3e.Node as Node exposing (Node)
import M3e.Value as Value
import Test exposing (Test, describe, test)



-- Helpers -----------------------------------------------------------------


buttonNode : List (Button.Option msg) -> Node msg
buttonNode opts =
    Button.view { label = "Save", variant = Value.filled } opts
        |> Element.toNode


checkboxNode : List (Checkbox.Option msg) -> Node msg
checkboxNode opts =
    Checkbox.view { ariaLabel = "Accept terms" } opts
        |> Element.toNode


chipNode : List (Chip.Option ()) -> Node ()
chipNode opts =
    Chip.assist { label = "Auto-fill", onClick = () } opts
        |> Element.toNode


iconButtonNode : List (IconButton.Option msg) -> Node msg
iconButtonNode opts =
    IconButton.view { icon = "delete", ariaLabel = "Delete" } opts
        |> Element.toNode



-- Suite -------------------------------------------------------------------


suite : Test
suite =
    describe "M3e.Attr — cross-component polymorphic builders"
        [ -- disabled -------------------------------------------------------
          describe "disabled"
            [ test "Attr.disabled True on Button emits disabled DOM property" <|
                \_ ->
                    buttonNode [ Attr.disabled True ]
                        |> Node.findProperty "disabled"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            , test "Attr.disabled False on Button emits disabled=false DOM property" <|
                \_ ->
                    buttonNode [ Attr.disabled False ]
                        |> Node.findProperty "disabled"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "false")
            , test "Attr.disabled True on Checkbox emits disabled DOM property" <|
                \_ ->
                    checkboxNode [ Attr.disabled True ]
                        |> Node.findProperty "disabled"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            , test "Attr.disabled False on Checkbox emits disabled=false DOM property" <|
                \_ ->
                    checkboxNode [ Attr.disabled False ]
                        |> Node.findProperty "disabled"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "false")
            , test "Attr.disabled True on Chip emits disabled DOM property" <|
                \_ ->
                    chipNode [ Attr.disabled True ]
                        |> Node.findProperty "disabled"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            , test "Attr.disabled True on IconButton emits disabled DOM property" <|
                \_ ->
                    iconButtonNode [ Attr.disabled True ]
                        |> Node.findProperty "disabled"
                        |> Maybe.map (Encode.encode 0)
                        |> Expect.equal (Just "true")
            , test "Attr.disabled result is identical to the component's own disabled" <|
                -- The delegated alias is a transparent re-export: same value, same effect
                \_ ->
                    let
                        viaAttr : Maybe Encode.Value
                        viaAttr =
                            buttonNode [ Attr.disabled True ]
                                |> Node.findProperty "disabled"

                        viaDirect : Maybe Encode.Value
                        viaDirect =
                            buttonNode [ Button.disabled True ]
                                |> Node.findProperty "disabled"
                    in
                    Expect.equal viaAttr viaDirect
            ]

        -- onClick ---------------------------------------------------------
        , describe "onClick"
            [ test "Attr.onClick on Button does not break rendering (tag is preserved)" <|
                \_ ->
                    buttonNode [ Attr.onClick () ]
                        |> Node.tagOf
                        |> Expect.equal (Just "m3e-button")
            , test "Attr.onClick on Chip does not break rendering (tag is preserved)" <|
                \_ ->
                    chipNode [ Attr.onClick () ]
                        |> Node.tagOf
                        |> Expect.equal (Just "m3e-assist-chip")
            , test "Attr.onClick on IconButton does not break rendering" <|
                \_ ->
                    iconButtonNode [ Attr.onClick () ]
                        |> Node.tagOf
                        |> Expect.equal (Just "m3e-icon-button")
            ]

        -- href ------------------------------------------------------------
        -- Note: some components (Button, Fab, ExtendedFab) emit `href` through
        -- an opaque Cem rawAttr — `Node.findAttribute` cannot reach those.
        -- IconButton and Chip emit href as a plain Node.attribute, so they ARE
        -- introspectable in unit tests.
        , describe "href"
            [ test "Attr.href on Chip emits href attribute (introspectable)" <|
                \_ ->
                    chipNode [ Attr.href "/docs" ]
                        |> Node.findAttribute "href"
                        |> Expect.equal (Just "/docs")
            , test "Attr.href on IconButton emits href attribute (introspectable)" <|
                \_ ->
                    iconButtonNode [ Attr.href "/profile" ]
                        |> Node.findAttribute "href"
                        |> Expect.equal (Just "/profile")
            , test "Attr.href on Chip and IconButton yield the same string — cross-component invariant" <|
                \_ ->
                    let
                        viaChip : Maybe String
                        viaChip =
                            chipNode [ Attr.href "/shared" ]
                                |> Node.findAttribute "href"

                        viaIB : Maybe String
                        viaIB =
                            iconButtonNode [ Attr.href "/shared" ]
                                |> Node.findAttribute "href"
                    in
                    Expect.equal viaChip viaIB
            ]
        ]
