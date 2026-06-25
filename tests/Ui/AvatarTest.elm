module Ui.AvatarTest exposing (suite)

{-| Tests for `Ui.Avatar`, focused on the F15 initials-fallback bug:
`extractInitials` previously returned "" for non-letter input (e.g. "123"),
producing the empty colored circle the module claims to prevent.
-}

import Expect
import Fuzz
import Test exposing (Test, describe, fuzz, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Ui.Avatar


suite : Test
suite =
    describe "Ui.Avatar"
        [ describe "initials"
            [ test "extracts up to two letter initials from a full name" <|
                \_ ->
                    Ui.Avatar.initials "Jack Peterson"
                        |> Ui.Avatar.view
                        |> Query.fromHtml
                        |> Query.has [ Selector.text "JP" ]
            , test "non-letter input falls back to the first character(s)" <|
                \_ ->
                    Ui.Avatar.initials "123"
                        |> Ui.Avatar.view
                        |> Query.fromHtml
                        |> Query.has [ Selector.text "12" ]
            , test "single non-letter word falls back to its first character" <|
                \_ ->
                    Ui.Avatar.initials "7"
                        |> Ui.Avatar.view
                        |> Query.fromHtml
                        |> Query.has [ Selector.text "7" ]
            , test "empty name yields a safe non-crashing fallback glyph" <|
                \_ ->
                    Ui.Avatar.initials ""
                        |> Ui.Avatar.view
                        |> Query.fromHtml
                        |> Query.has [ Selector.text "?" ]
            , test "whitespace-only name yields the safe fallback glyph" <|
                \_ ->
                    Ui.Avatar.initials "   "
                        |> Ui.Avatar.view
                        |> Query.fromHtml
                        |> Query.has [ Selector.text "?" ]
            , fuzz Fuzz.string "any non-empty name produces non-empty avatar content" <|
                \s ->
                    let
                        trimmed : String
                        trimmed =
                            String.trim s
                    in
                    if String.isEmpty trimmed then
                        Expect.pass

                    else
                        Ui.Avatar.extractInitials s
                            |> String.isEmpty
                            |> Expect.equal False
            ]
        ]
