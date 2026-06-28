module M3e.DatePickerTest exposing (suite)

import Expect
import Json.Encode as Encode
import M3e.DatePicker as DatePicker
import M3e.Element as Element
import M3e.Node as Node exposing (Node)
import Test exposing (Test, describe, test)



-- Helpers ---------------------------------------------------------------------


viewNode : List (DatePicker.Option String) -> Node String
viewNode opts =
    DatePicker.view opts
        |> Element.toNode



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

        -- date seeds via attribute (not property — see fix #15)
        , test "date sets 'date' attribute" <|
            \_ ->
                viewNode [ DatePicker.date "2026-06-25" ]
                    |> Node.findAttribute "date"
                    |> Expect.equal (Just "2026-06-25")
        , test "fix-#15: date uses attribute channel (no property for seeding)" <|
            \_ ->
                viewNode [ DatePicker.date "2026-06-25" ]
                    |> Node.findProperty "date"
                    |> Expect.equal Nothing

        -- Variant
        , test "variant Auto sets variant='auto'" <|
            \_ ->
                viewNode [ DatePicker.variant DatePicker.Auto ]
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "auto")
        , test "variant Docked sets variant='docked'" <|
            \_ ->
                viewNode [ DatePicker.variant DatePicker.Docked ]
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "docked")
        , test "variant Modal sets variant='modal'" <|
            \_ ->
                viewNode [ DatePicker.variant DatePicker.Modal ]
                    |> Node.findAttribute "variant"
                    |> Expect.equal (Just "modal")

        -- Range (DOM property)
        , test "range True sets 'range' DOM property" <|
            \_ ->
                viewNode [ DatePicker.range True ]
                    |> Node.findProperty "range"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")
        , test "range absent by default" <|
            \_ ->
                viewNode []
                    |> Node.findProperty "range"
                    |> Expect.equal Nothing

        -- Clearable (DOM property)
        , test "clearable True sets 'clearable' DOM property" <|
            \_ ->
                viewNode [ DatePicker.clearable True ]
                    |> Node.findProperty "clearable"
                    |> Maybe.map (Encode.encode 0)
                    |> Expect.equal (Just "true")

        -- Labels
        , test "label sets 'label' attribute" <|
            \_ ->
                viewNode [ DatePicker.label "Visit date" ]
                    |> Node.findAttribute "label"
                    |> Expect.equal (Just "Visit date")
        , test "confirmLabel sets 'confirm-label' attribute" <|
            \_ ->
                viewNode [ DatePicker.confirmLabel "Apply" ]
                    |> Node.findAttribute "confirm-label"
                    |> Expect.equal (Just "Apply")
        , test "dismissLabel sets 'dismiss-label' attribute" <|
            \_ ->
                viewNode [ DatePicker.dismissLabel "Dismiss" ]
                    |> Node.findAttribute "dismiss-label"
                    |> Expect.equal (Just "Dismiss")

        -- Min/Max
        , test "minDate sets 'min-date' attribute" <|
            \_ ->
                viewNode [ DatePicker.minDate "2026-01-01" ]
                    |> Node.findAttribute "min-date"
                    |> Expect.equal (Just "2026-01-01")
        , test "maxDate sets 'max-date' attribute" <|
            \_ ->
                viewNode [ DatePicker.maxDate "2026-12-31" ]
                    |> Node.findAttribute "max-date"
                    |> Expect.equal (Just "2026-12-31")

        -- id
        , test "id sets the 'id' attribute" <|
            \_ ->
                viewNode [ DatePicker.id "visit-date" ]
                    |> Node.findAttribute "id"
                    |> Expect.equal (Just "visit-date")

        -- onChange handler wired (no inspectable attribute leakage)
        , test "onChange does not leak as an inspectable attribute" <|
            \_ ->
                viewNode [ DatePicker.onChange identity ]
                    |> Node.findAttribute "onchange"
                    |> Expect.equal Nothing

        -- Fix #66 — rangeStart / rangeEnd
        , test "fix-#66: rangeStart sets 'range-start' attribute" <|
            \_ ->
                viewNode [ DatePicker.rangeStart "2026-06-01" ]
                    |> Node.findAttribute "range-start"
                    |> Expect.equal (Just "2026-06-01")
        , test "fix-#66: rangeEnd sets 'range-end' attribute" <|
            \_ ->
                viewNode [ DatePicker.rangeEnd "2026-06-30" ]
                    |> Node.findAttribute "range-end"
                    |> Expect.equal (Just "2026-06-30")
        , test "fix-#66: rangeStart absent by default" <|
            \_ ->
                viewNode []
                    |> Node.findAttribute "range-start"
                    |> Expect.equal Nothing
        , test "fix-#66: rangeEnd absent by default" <|
            \_ ->
                viewNode []
                    |> Node.findAttribute "range-end"
                    |> Expect.equal Nothing
        ]
