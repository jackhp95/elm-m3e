module TranslateToCemTest exposing (all)

import M3e.Review.Facts
import Review.Test
import Test exposing (Test, describe, test)
import TranslateToCem


all : Test
all =
    describe "TranslateToCem"
        [ test "identity: a Cem call gets no fix" <|
            \() ->
                """module A exposing (view)

import M3e.Cem.Button

view =
    M3e.Cem.Button.button [] []
"""
                    |> Review.Test.run (TranslateToCem.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectNoErrors
        , test "Standard → Cem emits `M3e.Cem.<Comp>.<ctor>` shape" <|
            \() ->
                """module A exposing (view)

import M3e.Button

view =
    M3e.Button.view [] []
"""
                    |> Review.Test.run (TranslateToCem.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Translate M3e.Button call to TranslateToCem"
                            , details =
                                [ "Auto-fixable rewrite between the five API surfaces (D6 translator)."
                                , "Residue paths (unknown enum tokens, dynamic tails, missing required) escape through `Seam.*` — those will trigger `NoSeamOutsideAllowedModules` in a subsequent pass."
                                ]
                            , under = "M3e.Button.view [] []"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (view)

import M3e.Button
import M3e.Cem.Button

view =
    M3e.Cem.Button.button [  ] [  ]
"""
                        ]
        ]
