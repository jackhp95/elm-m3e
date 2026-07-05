module TranslateToStandardTest exposing (all)

import M3e.Review.Facts
import Review.Test
import Test exposing (Test, describe, test)
import TranslateToStandard


all : Test
all =
    describe "TranslateToStandard"
        [ test "same-surface identity: a Standard call gets no fix" <|
            \() ->
                """module A exposing (view)

import M3e.Button

view =
    M3e.Button.view [] []
"""
                    |> Review.Test.run (TranslateToStandard.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectNoErrors
        , test "no error on unrecognised module" <|
            \() ->
                """module A exposing (view)

import Some.Other

view =
    Some.Other.thing [] []
"""
                    |> Review.Test.run (TranslateToStandard.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectNoErrors
        , test "flags a Cem call and emits an autofix (residue emitter until Task 11 parses Cem specifically)" <|
            \() ->
                """module A exposing (view)

import M3e.Cem.Button

view =
    M3e.Cem.Button.button [] []
"""
                    |> Review.Test.run (TranslateToStandard.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Translate M3e.Button call to TranslateToStandard"
                            , details =
                                [ "Auto-fixable rewrite between the five API surfaces (D6 translator)."
                                , "Residue paths (unknown enum tokens, dynamic tails, missing required) escape through `Seam.*` — those will trigger `NoSeamOutsideAllowedModules` in a subsequent pass."
                                ]
                            , under = "M3e.Cem.Button.button [] []"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (view)

import M3e.Cem.Button
import M3e.Button

view =
    M3e.Button.view
    [  ]
    [  ]
"""
                        ]
        ]
