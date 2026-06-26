module M3e.DatePickerTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.DatePicker as DatePicker
import M3e.Node as Node
import M3e.Renderable as Renderable
import Test exposing (Test, describe, test)


-- Helpers ---------------------------------------------------------------------


viewNode : List (DatePicker.Option String) -> Node.Node String
viewNode opts =
    DatePicker.view opts
        |> Renderable.toNode


-- Tests -----------------------------------------------------------------------


suite : Test
suite =
    describe "M3e.DatePicker — view-style port (fix #15 change channel)"
        [ -- Tag
          test "view renders <m3e-datepicker>" <|
            \_ ->
                viewNode []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-datepicker")

        -- withDate seeds via attribute (not property — see fix #15)
        , test "withDate sets 'date' attribute" <|
            \_ ->
                viewNode [ DatePicker.withDate "2026-06-25" ]
                    |> Node.findAttribute "date"
                    |> Expect.equal (Just "2026-06-25")
        , test "fix-#15: withDate uses attribute channel (no property for seeding)" <|
            \_ ->
                viewNode [ DatePicker.withDate "2026-06-25" ]
                    |> Node.findProperty "date"
                    |> Expect.equal Nothing

        -- Variant
        , test "withVariant Auto sets variant='auto'" <|
            \_ ->
                viewNode [ DatePicker.withVariant DatePicker.Auto ]
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "auto")
        , test "withVariant Docked sets variant='docked'" <|
            \_ ->
                viewNode [ DatePicker.withVariant DatePicker.Docked ]
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "docked")
        , test "withVariant Modal sets variant='modal'" <|
            \_ ->
                viewNode [ DatePicker.withVariant DatePicker.Modal ]
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "modal")

        -- Range (DOM property)
        , test "withRange True sets 'range' DOM property" <|
            \_ ->
                viewNode [ DatePicker.withRange True ]
                    |> Node.findProperty "range"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "range absent by default" <|
            \_ ->
                viewNode []
                    |> Node.findProperty "range"
                    |> Expect.equal Nothing

        -- Clearable (DOM property)
        , test "withClearable True sets 'clearable' DOM property" <|
            \_ ->
                viewNode [ DatePicker.withClearable True ]
                    |> Node.findProperty "clearable"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")

        -- Labels
        , test "withLabel sets 'label' attribute" <|
            \_ ->
                viewNode [ DatePicker.withLabel "Visit date" ]
                    |> Node.findAttribute "label"
                    |> Expect.equal (Just "Visit date")
        , test "withConfirmLabel sets 'confirm-label' attribute" <|
            \_ ->
                viewNode [ DatePicker.withConfirmLabel "Apply" ]
                    |> Node.findAttribute "confirm-label"
                    |> Expect.equal (Just "Apply")
        , test "withDismissLabel sets 'dismiss-label' attribute" <|
            \_ ->
                viewNode [ DatePicker.withDismissLabel "Dismiss" ]
                    |> Node.findAttribute "dismiss-label"
                    |> Expect.equal (Just "Dismiss")

        -- Min/Max
        , test "withMinDate sets 'min-date' attribute" <|
            \_ ->
                viewNode [ DatePicker.withMinDate "2026-01-01" ]
                    |> Node.findAttribute "min-date"
                    |> Expect.equal (Just "2026-01-01")
        , test "withMaxDate sets 'max-date' attribute" <|
            \_ ->
                viewNode [ DatePicker.withMaxDate "2026-12-31" ]
                    |> Node.findAttribute "max-date"
                    |> Expect.equal (Just "2026-12-31")

        -- id
        , test "withId sets the 'id' attribute" <|
            \_ ->
                viewNode [ DatePicker.withId "visit-date" ]
                    |> Node.findAttribute "id"
                    |> Expect.equal (Just "visit-date")

        -- onChange handler wired (no inspectable attribute leakage)
        , test "onChange does not leak as an inspectable attribute" <|
            \_ ->
                viewNode [ DatePicker.onChange identity ]
                    |> Node.findAttribute "onchange"
                    |> Expect.equal Nothing
        ]
