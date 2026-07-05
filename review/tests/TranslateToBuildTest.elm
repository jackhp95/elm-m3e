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
        , test "Standard → Build: clean action + content + attr becomes a seed/setter/build pipeline" <|
            \() ->
                """module A exposing (Msg, view)

import M3e.Button

type Msg
    = DoThing

view =
    M3e.Button.view [ M3e.Button.onClick DoThing, M3e.Button.variant M3e.Value.filled ] [ M3e.Button.child c ]
"""
                    |> Review.Test.run (TranslateToBuild.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Translate M3e.Button call to TranslateToBuild"
                            , details =
                                [ "Auto-fixable rewrite between the five API surfaces (D6 translator)."
                                , "Residue paths (unknown enum tokens, dynamic tails, missing required) escape through `Seam.*` — those will trigger `NoSeamOutsideAllowedModules` in a subsequent pass."
                                ]
                            , under = "M3e.Button.view [ M3e.Button.onClick DoThing, M3e.Button.variant M3e.Value.filled ] [ M3e.Button.child c ]"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (Msg, view)

import M3e.Button
import M3e.Action
import M3e.Build.Button

type Msg
    = DoThing

view =
    M3e.Build.Button.button { content = c, action = M3e.Action.onClick DoThing }
        |> M3e.Build.Button.variant M3e.Value.filled
        |> M3e.Build.Button.build
"""
                        ]
        , test "Standard → Build: missing required content falls back to whole-node Seam escape" <|
            \() ->
                """module A exposing (view)

import M3e.Button

view =
    M3e.Button.view [] []
"""
                    |> Review.Test.run (TranslateToBuild.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Translate M3e.Button call to TranslateToBuild"
                            , details =
                                [ "Auto-fixable rewrite between the five API surfaces (D6 translator)."
                                , "Residue paths (unknown enum tokens, dynamic tails, missing required) escape through `Seam.*` — those will trigger `NoSeamOutsideAllowedModules` in a subsequent pass."
                                ]
                            , under = "M3e.Button.view [] []"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (view)

import M3e.Button
import M3e.Cem.Html.Button
import Seam

view =
    Seam.fromHtml (M3e.Cem.Html.Button.button [  ] [  ])
"""
                        ]
        ]
