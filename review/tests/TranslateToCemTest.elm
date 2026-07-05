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
    M3e.Cem.Button.button [] []
"""
                        ]
        , test "Standard → Cem preserves a dynamic attr tail via `++` (#152)" <|
            \() ->
                """module A exposing (view)

import M3e.Button

view =
    M3e.Button.view (extra ++ [ M3e.Button.variant M3e.Value.filled ]) []
"""
                    |> Review.Test.run (TranslateToCem.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Translate M3e.Button call to TranslateToCem"
                            , details =
                                [ "Auto-fixable rewrite between the five API surfaces (D6 translator)."
                                , "Residue paths (unknown enum tokens, dynamic tails, missing required) escape through `Seam.*` — those will trigger `NoSeamOutsideAllowedModules` in a subsequent pass."
                                ]
                            , under = "M3e.Button.view (extra ++ [ M3e.Button.variant M3e.Value.filled ]) []"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (view)

import M3e.Button
import M3e.Cem.Button

view =
    M3e.Cem.Button.button ([ M3e.Cem.Button.variant M3e.Value.filled ] ++ extra) []
"""
                        ]
        , test "Build → Cem: seed record action reverse-maps to an attr-style setter" <|
            \() ->
                """module A exposing (view)

import M3e.Build.Button as Button
import M3e.Action

view =
    Button.button { content = c, action = M3e.Action.onClick m }
        |> Button.variant M3e.Value.filled
        |> Button.build
"""
                    |> Review.Test.run (TranslateToCem.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Translate M3e.Button call to TranslateToCem"
                            , details =
                                [ "Auto-fixable rewrite between the five API surfaces (D6 translator)."
                                , "Residue paths (unknown enum tokens, dynamic tails, missing required) escape through `Seam.*` — those will trigger `NoSeamOutsideAllowedModules` in a subsequent pass."
                                ]
                            , under = "Button.button { content = c, action = M3e.Action.onClick m }\n        |> Button.variant M3e.Value.filled\n        |> Button.build"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (view)

import M3e.Build.Button as Button
import M3e.Action
import M3e.Cem.Button
import M3e.Element

view =
    M3e.Cem.Button.button [ M3e.Cem.Button.onClick m, M3e.Cem.Button.variant M3e.Value.filled ] [ (M3e.Element.toHtml (c)) ]
"""
                        ]
        , test "Standard → Cem: an unrecognised attr escapes through Seam.asAttribute (EscapedAttr)" <|
            \() ->
                """module A exposing (view)

import M3e.Button

view =
    M3e.Button.view [ M3e.Button.mystery x ] []
"""
                    |> Review.Test.run (TranslateToCem.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Translate M3e.Button call to TranslateToCem"
                            , details =
                                [ "Auto-fixable rewrite between the five API surfaces (D6 translator)."
                                , "Residue paths (unknown enum tokens, dynamic tails, missing required) escape through `Seam.*` — those will trigger `NoSeamOutsideAllowedModules` in a subsequent pass."
                                ]
                            , under = "M3e.Button.view [ M3e.Button.mystery x ] []"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (view)

import M3e.Button
import M3e.Cem.Button
import Seam

view =
    M3e.Cem.Button.button [ Seam.asAttribute (M3e.Button.mystery x) ] []
"""
                        ]
        , test "Standard → Cem: an unrecognised slot escapes as raw content (EscapedContent)" <|
            \() ->
                """module A exposing (view)

import M3e.Button

view =
    M3e.Button.view [] [ M3e.Button.mysterySlot y ]
"""
                    |> Review.Test.run (TranslateToCem.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Translate M3e.Button call to TranslateToCem"
                            , details =
                                [ "Auto-fixable rewrite between the five API surfaces (D6 translator)."
                                , "Residue paths (unknown enum tokens, dynamic tails, missing required) escape through `Seam.*` — those will trigger `NoSeamOutsideAllowedModules` in a subsequent pass."
                                ]
                            , under = "M3e.Button.view [] [ M3e.Button.mysterySlot y ]"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (view)

import M3e.Button
import M3e.Cem.Button

view =
    M3e.Cem.Button.button [] [ M3e.Button.mysterySlot y ]
"""
                        ]
        ]
