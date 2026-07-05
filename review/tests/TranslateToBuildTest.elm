module TranslateToBuildTest exposing (all)

import M3e.Review.Facts
import Review.Test
import Test exposing (Test, describe, test)
import TranslateToBuild


all : Test
all =
    describe "TranslateToBuild"
        [ test "same-surface identity: ⑤ Build pipeline gets no fix" <|
            \() ->
                """module A exposing (view)

import M3e.Build.Button as Button
import M3e.Action

view =
    Button.button { content = c, action = M3e.Action.onClick m }
        |> Button.build
"""
                    |> Review.Test.run (TranslateToBuild.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectNoErrors
        , test "no error on unrecognised module" <|
            \() ->
                """module A exposing (view)

view =
    other []
"""
                    |> Review.Test.run (TranslateToBuild.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectNoErrors
        ]
