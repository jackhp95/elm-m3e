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
    M3e.Button.view [] []
"""
                        ]
        , test "Cem → Standard preserves a `list ++ variable` dynamic attr tail (#152)" <|
            \() ->
                """module A exposing (view)

import M3e.Cem.Button

view =
    M3e.Cem.Button.button ([ M3e.Cem.Button.variant M3e.Value.filled ] ++ extra) []
"""
                    |> Review.Test.run (TranslateToStandard.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Translate M3e.Button call to TranslateToStandard"
                            , details =
                                [ "Auto-fixable rewrite between the five API surfaces (D6 translator)."
                                , "Residue paths (unknown enum tokens, dynamic tails, missing required) escape through `Seam.*` — those will trigger `NoSeamOutsideAllowedModules` in a subsequent pass."
                                ]
                            , under = "M3e.Cem.Button.button ([ M3e.Cem.Button.variant M3e.Value.filled ] ++ extra) []"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (view)

import M3e.Cem.Button
import M3e.Button

view =
    M3e.Button.view ([ M3e.Button.variant M3e.Value.filled ] ++ extra) []
"""
                        ]
        , test "Record → Standard: required content becomes the child setter, attrs pass through" <|
            \() ->
                """module A exposing (view)

import M3e.Record.Button

view =
    M3e.Record.Button.view { content = c } [ M3e.Record.Button.variant M3e.Value.filled ] []
"""
                    |> Review.Test.run (TranslateToStandard.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Translate M3e.Button call to TranslateToStandard"
                            , details =
                                [ "Auto-fixable rewrite between the five API surfaces (D6 translator)."
                                , "Residue paths (unknown enum tokens, dynamic tails, missing required) escape through `Seam.*` — those will trigger `NoSeamOutsideAllowedModules` in a subsequent pass."
                                ]
                            , under = "M3e.Record.Button.view { content = c } [ M3e.Record.Button.variant M3e.Value.filled ] []"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (view)

import M3e.Record.Button
import M3e.Button

view =
    M3e.Button.view [ M3e.Button.variant M3e.Value.filled ] [ M3e.Button.child c ]
"""
                        ]
        , test "Html → Standard: a child with an unknown slot name escapes via Seam.slot (UnknownSlotName)" <|
            \() ->
                """module A exposing (view)

import M3e.Cem.Html.Button
import Html
import Html.Attributes

view =
    M3e.Cem.Html.Button.button [] [ Html.div [ Html.Attributes.attribute "slot" "bogus" ] [] ]
"""
                    |> Review.Test.run (TranslateToStandard.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Translate M3e.Button call to TranslateToStandard"
                            , details =
                                [ "Auto-fixable rewrite between the five API surfaces (D6 translator)."
                                , "Residue paths (unknown enum tokens, dynamic tails, missing required) escape through `Seam.*` — those will trigger `NoSeamOutsideAllowedModules` in a subsequent pass."
                                ]
                            , under = "M3e.Cem.Html.Button.button [] [ Html.div [ Html.Attributes.attribute \"slot\" \"bogus\" ] [] ]"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (view)

import M3e.Cem.Html.Button
import Html
import Html.Attributes
import M3e.Button
import Seam

view =
    M3e.Button.view [] [ Seam.slot "bogus" (Seam.fromHtml (Html.div [ Html.Attributes.attribute "slot" "bogus" ] [])) ]
"""
                        ]
        , test "Record → Standard: a known M3e.Action.<ctor> reverse-maps to the attr-style setter, not the Seam fallback (#145)" <|
            \() ->
                """module A exposing (view)

import M3e.Record.Button
import M3e.Action

view =
    M3e.Record.Button.view { content = c, action = M3e.Action.link "/path" } [] []
"""
                    |> Review.Test.run (TranslateToStandard.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Translate M3e.Button call to TranslateToStandard"
                            , details =
                                [ "Auto-fixable rewrite between the five API surfaces (D6 translator)."
                                , "Residue paths (unknown enum tokens, dynamic tails, missing required) escape through `Seam.*` — those will trigger `NoSeamOutsideAllowedModules` in a subsequent pass."
                                ]
                            , under = "M3e.Record.Button.view { content = c, action = M3e.Action.link \"/path\" } [] []"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (view)

import M3e.Record.Button
import M3e.Action
import M3e.Button

view =
    M3e.Button.view [ M3e.Button.href "/path" ] [ M3e.Button.child c ]
"""
                        ]
        ]
