module M3e.InternalTest exposing (suite)

import Expect
import M3e.Internal as Internal
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "M3e.Internal.slugify — the shared label↔control slug (pins #30/#44)"
        [ test "lowercases, collapses non-alphanumerics to single dashes, trims" <|
            \_ ->
                Internal.slugify "m3etf-" "Email address"
                    |> Expect.equal "m3etf-email-address"
        , test "collapses runs of punctuation/space and strips leading/trailing" <|
            \_ ->
                Internal.slugify "m3esel-" "  Plan / Tier!! "
                    |> Expect.equal "m3esel-plan-tier"
        , test "keeps digits" <|
            \_ ->
                Internal.slugify "m3etp-" "Meeting 2 time"
                    |> Expect.equal "m3etp-meeting-2-time"
        , test "the prefix is the only cross-module difference (same slug body)" <|
            \_ ->
                ( Internal.slugify "a-" "Due Date", Internal.slugify "b-" "Due Date" )
                    |> Expect.equal ( "a-due-date", "b-due-date" )
        ]
