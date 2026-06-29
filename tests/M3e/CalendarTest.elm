module M3e.CalendarTest exposing (suite)

import Expect
import M3e.Calendar as Calendar
import M3e.Element as Element
import M3e.Node as Node exposing (Node)
import M3e.Value as Value
import Test exposing (Test, describe, test)



-- Helpers ---------------------------------------------------------------------


viewNode : List (Calendar.Option String) -> Node String
viewNode opts =
    Calendar.view opts
        |> Element.toNode



-- Tests -----------------------------------------------------------------------


suite : Test
suite =
    describe "M3e.Calendar — view-style port (fix #14 change channel)"
        [ -- Tag
          test "view renders <m3e-calendar>" <|
            \_ ->
                viewNode []
                    |> Node.tagOf
                    |> Expect.equal (Just "m3e-calendar")

        -- date seeds via attribute
        , test "date sets 'date' attribute on <m3e-calendar>" <|
            \_ ->
                viewNode [ Calendar.date "2026-06-25" ]
                    |> Node.findAttribute "date"
                    |> Expect.equal (Just "2026-06-25")
        , test "date attribute absent when date not used" <|
            \_ ->
                viewNode []
                    |> Node.findAttribute "date"
                    |> Expect.equal Nothing

        -- Min/max date
        , test "minDate sets 'min-date' attribute" <|
            \_ ->
                viewNode [ Calendar.minDate "2026-01-01" ]
                    |> Node.findAttribute "min-date"
                    |> Expect.equal (Just "2026-01-01")
        , test "maxDate sets 'max-date' attribute" <|
            \_ ->
                viewNode [ Calendar.maxDate "2026-12-31" ]
                    |> Node.findAttribute "max-date"
                    |> Expect.equal (Just "2026-12-31")

        -- Range
        , test "rangeStart sets 'range-start' attribute" <|
            \_ ->
                viewNode [ Calendar.rangeStart "2026-06-01" ]
                    |> Node.findAttribute "range-start"
                    |> Expect.equal (Just "2026-06-01")
        , test "rangeEnd sets 'range-end' attribute" <|
            \_ ->
                viewNode [ Calendar.rangeEnd "2026-06-30" ]
                    |> Node.findAttribute "range-end"
                    |> Expect.equal (Just "2026-06-30")

        -- Start view
        , test "startView month sets start-view='month'" <|
            \_ ->
                viewNode [ Calendar.startView Value.month ]
                    |> Node.findAttribute "start-view"
                    |> Expect.equal (Just "month")
        , test "startView year sets start-view='year'" <|
            \_ ->
                viewNode [ Calendar.startView Value.year ]
                    |> Node.findAttribute "start-view"
                    |> Expect.equal (Just "year")
        , test "startView multiYear sets start-view='multi-year'" <|
            \_ ->
                viewNode [ Calendar.startView Value.multiYear ]
                    |> Node.findAttribute "start-view"
                    |> Expect.equal (Just "multi-year")

        -- id
        , test "id sets the 'id' attribute" <|
            \_ ->
                viewNode [ Calendar.id "event-cal" ]
                    |> Node.findAttribute "id"
                    |> Expect.equal (Just "event-cal")

        -- onChange wired (IR-level check: the handler is registered as a RawAttr
        -- event listener — we can't inspect RawAttr values, but we verify no
        -- attributes were accidentally created with the wrong name)
        , test "onChange does not leak as an inspectable attribute" <|
            \_ ->
                viewNode [ Calendar.onChange identity ]
                    |> Node.findAttribute "onchange"
                    |> Expect.equal Nothing

        -- Nav labels
        , test "previousMonthLabel sets 'previous-month-label'" <|
            \_ ->
                viewNode [ Calendar.previousMonthLabel "Prev month" ]
                    |> Node.findAttribute "previous-month-label"
                    |> Expect.equal (Just "Prev month")
        , test "nextMonthLabel sets 'next-month-label'" <|
            \_ ->
                viewNode [ Calendar.nextMonthLabel "Next month" ]
                    |> Node.findAttribute "next-month-label"
                    |> Expect.equal (Just "Next month")

        -- Fix #14 — change channel documented (no attribute decoding attempted)
        , test "fix-#14: date is an attribute, not a property (correct channel for seeding)" <|
            \_ ->
                -- The element's dateConverter reads from the 'date' attribute.
                -- We must NOT set it as a Node.property here (that bypasses
                -- the converter and leaves a raw ISO string, not a Date).
                viewNode [ Calendar.date "2026-06-25" ]
                    |> Node.findProperty "date"
                    |> Expect.equal Nothing

        -- Fix #63 — header slot is now reachable
        , test "fix-#63: header option emits a child with slot='header'" <|
            \_ ->
                viewNode [ Calendar.header (Element.text "March 2026") ]
                    |> Node.childrenOf
                    |> List.any (\n -> Node.findAttribute "slot" n == Just "header")
                    |> Expect.equal True
        , test "no header child by default" <|
            \_ ->
                viewNode []
                    |> Node.childrenOf
                    |> List.isEmpty
                    |> Expect.equal True
        ]
