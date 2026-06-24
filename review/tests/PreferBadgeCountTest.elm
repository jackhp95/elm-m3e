module PreferBadgeCountTest exposing (all)

import PreferBadgeCount exposing (rule)
import Review.Test
import Test exposing (Test, describe, test)


message : String
message =
    "Prefer Ui.Badge.count over Ui.Badge.label (String.fromInt …)"


details : List String
details =
    [ "Ui.Badge.count applies the Material \"999+\" truncation that Ui.Badge.label does not. A stringified Int passed to label silently skips that truncation."
    , "Replace `Ui.Badge.label (String.fromInt n)` with `Ui.Badge.count n`."
    ]


all : Test
all =
    describe "PreferBadgeCount"
        [ test "flags Ui.Badge.label (String.fromInt n) — application form" <|
            \() ->
                """module A exposing (view)
import Ui.Badge
view n = Ui.Badge.label (String.fromInt n)
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = "Ui.Badge.label (String.fromInt n)"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (view)
import Ui.Badge
view n = Ui.Badge.count n
"""
                        ]
        , test "flags the |> pipe form: String.fromInt n |> Ui.Badge.label" <|
            \() ->
                """module A exposing (view)
import Ui.Badge
view n = String.fromInt n |> Ui.Badge.label
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = "String.fromInt n |> Ui.Badge.label"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (view)
import Ui.Badge
view n = Ui.Badge.count n
"""
                        ]
        , test "flags the <| pipe form: Ui.Badge.label (String.fromInt <| n)" <|
            \() ->
                """module A exposing (view)
import Ui.Badge
view n = Ui.Badge.label (String.fromInt <| n)
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = "Ui.Badge.label (String.fromInt <| n)"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (view)
import Ui.Badge
view n = Ui.Badge.count n
"""
                        ]
        , test "resolves through an import alias" <|
            \() ->
                """module A exposing (view)
import Ui.Badge as B
view n = B.label (String.fromInt n)
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = message
                            , details = details
                            , under = "B.label (String.fromInt n)"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (view)
import Ui.Badge as B
view n = B.count n
"""
                        ]
        , test "passes genuine text label" <|
            \() ->
                """module A exposing (view)
import Ui.Badge
view s = Ui.Badge.label s
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "passes a composed string (not a bare conversion)" <|
            \() ->
                """module A exposing (view)
import Ui.Badge
view n = Ui.Badge.label ("v" ++ String.fromInt n)
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "passes count itself" <|
            \() ->
                """module A exposing (view)
import Ui.Badge
view n = Ui.Badge.count n
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "does not flag String.fromInt fed to a non-Badge.label function" <|
            \() ->
                """module A exposing (view)
import Html
view n = Html.text (String.fromInt n)
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        ]
