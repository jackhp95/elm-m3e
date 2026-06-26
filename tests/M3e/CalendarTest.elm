module M3e.CalendarTest exposing (suite)

import Expect
import M3e.Calendar as Calendar
import M3e.Node as Node
import M3e.Renderable as Renderable
import Test exposing (Test, describe, test)


-- Helpers ---------------------------------------------------------------------


viewNode : List (Calendar.Option String) -> Node.Node String
viewNode opts =
    Calendar.view opts
        |> Renderable.toNode


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

        -- withDate seeds via attribute
        , test "withDate sets 'date' attribute on <m3e-calendar>" <|
            \_ ->
                viewNode [ Calendar.withDate "2026-06-25" ]
                    |> Node.findAttribute "date"
                    |> Expect.equal (Just "2026-06-25")
        , test "date attribute absent when withDate not used" <|
            \_ ->
                viewNode []
                    |> Node.findAttribute "date"
                    |> Expect.equal Nothing

        -- Min/max date
        , test "withMinDate sets 'min-date' attribute" <|
            \_ ->
                viewNode [ Calendar.withMinDate "2026-01-01" ]
                    |> Node.findAttribute "min-date"
                    |> Expect.equal (Just "2026-01-01")
        , test "withMaxDate sets 'max-date' attribute" <|
            \_ ->
                viewNode [ Calendar.withMaxDate "2026-12-31" ]
                    |> Node.findAttribute "max-date"
                    |> Expect.equal (Just "2026-12-31")

        -- Range
        , test "withRangeStart sets 'range-start' attribute" <|
            \_ ->
                viewNode [ Calendar.withRangeStart "2026-06-01" ]
                    |> Node.findAttribute "range-start"
                    |> Expect.equal (Just "2026-06-01")
        , test "withRangeEnd sets 'range-end' attribute" <|
            \_ ->
                viewNode [ Calendar.withRangeEnd "2026-06-30" ]
                    |> Node.findAttribute "range-end"
                    |> Expect.equal (Just "2026-06-30")

        -- Start view
        , test "withStartView MonthView sets start-view='month'" <|
            \_ ->
                viewNode [ Calendar.withStartView Calendar.MonthView ]
                    |> Node.findAttribute "start-view"
                    |> Expect.equal (Just "month")
        , test "withStartView YearView sets start-view='year'" <|
            \_ ->
                viewNode [ Calendar.withStartView Calendar.YearView ]
                    |> Node.findAttribute "start-view"
                    |> Expect.equal (Just "year")
        , test "withStartView MultiYearView sets start-view='multi-year'" <|
            \_ ->
                viewNode [ Calendar.withStartView Calendar.MultiYearView ]
                    |> Node.findAttribute "start-view"
                    |> Expect.equal (Just "multi-year")

        -- id
        , test "withId sets the 'id' attribute" <|
            \_ ->
                viewNode [ Calendar.withId "event-cal" ]
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
        , test "withPreviousMonthLabel sets 'previous-month-label'" <|
            \_ ->
                viewNode [ Calendar.withPreviousMonthLabel "Prev month" ]
                    |> Node.findAttribute "previous-month-label"
                    |> Expect.equal (Just "Prev month")
        , test "withNextMonthLabel sets 'next-month-label'" <|
            \_ ->
                viewNode [ Calendar.withNextMonthLabel "Next month" ]
                    |> Node.findAttribute "next-month-label"
                    |> Expect.equal (Just "Next month")

        -- Fix #14 — change channel documented (no attribute decoding attempted)
        , test "fix-#14: withDate is an attribute, not a property (correct channel for seeding)" <|
            \_ ->
                -- The element's dateConverter reads from the 'date' attribute.
                -- We must NOT set it as a Node.property here (that bypasses
                -- the converter and leaves a raw ISO string, not a Date).
                viewNode [ Calendar.withDate "2026-06-25" ]
                    |> Node.findProperty "date"
                    |> Expect.equal Nothing
        ]
