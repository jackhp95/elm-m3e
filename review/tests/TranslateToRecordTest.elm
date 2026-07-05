module TranslateToRecordTest exposing (all)

import M3e.Review.Facts
import Review.Test
import Test exposing (Test, describe, test)
import TranslateToRecord


all : Test
all =
    describe "TranslateToRecord"
        [ test "identity: a Record call gets no fix" <|
            \() ->
                """module A exposing (view)

import M3e.Record.Button

view =
    M3e.Record.Button.view { content = c, action = a } [] []
"""
                    |> Review.Test.run (TranslateToRecord.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectNoErrors
        , test "Standard call missing required (no action lifted) falls back to whole-node Seam escape" <|
            \() ->
                """module A exposing (view)

import M3e.Button

view =
    M3e.Button.view [] []
"""
                    |> Review.Test.run (TranslateToRecord.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Translate M3e.Button call to TranslateToRecord"
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
    Seam.fromHtml (M3e.Cem.Html.Button.button [] [])
"""
                        ]
        , test "Standard with action-attr (onClick) upgrades to Record with M3e.Action.onClick" <|
            \() ->
                """module A exposing (Msg, view)

import M3e.Button

type Msg
    = DoThing

view =
    M3e.Button.view [ M3e.Button.onClick DoThing ] [ M3e.Button.child c ]
"""
                    |> Review.Test.run (TranslateToRecord.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Translate M3e.Button call to TranslateToRecord"
                            , details =
                                [ "Auto-fixable rewrite between the five API surfaces (D6 translator)."
                                , "Residue paths (unknown enum tokens, dynamic tails, missing required) escape through `Seam.*` — those will trigger `NoSeamOutsideAllowedModules` in a subsequent pass."
                                ]
                            , under = "M3e.Button.view [ M3e.Button.onClick DoThing ] [ M3e.Button.child c ]"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (Msg, view)

import M3e.Button
import M3e.Action
import M3e.Record.Button

type Msg
    = DoThing

view =
    M3e.Record.Button.view { content = c, action = M3e.Action.onClick DoThing } [] []
"""
                        ]
        , test "lifts a let-bound required-content variable into the record (#153)" <|
            \() ->
                """module A exposing (Msg, view)

import M3e.Button

type Msg
    = DoThing

view =
    let
        label =
            M3e.Button.child c
    in
    M3e.Button.view [ M3e.Button.onClick DoThing ] [ label ]
"""
                    |> Review.Test.run (TranslateToRecord.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Translate M3e.Button call to TranslateToRecord"
                            , details =
                                [ "Auto-fixable rewrite between the five API surfaces (D6 translator)."
                                , "Residue paths (unknown enum tokens, dynamic tails, missing required) escape through `Seam.*` — those will trigger `NoSeamOutsideAllowedModules` in a subsequent pass."
                                ]
                            , under = "M3e.Button.view [ M3e.Button.onClick DoThing ] [ label ]"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (Msg, view)

import M3e.Button
import M3e.Action
import M3e.Record.Button

type Msg
    = DoThing

view =
    let
        label =
            M3e.Button.child c
    in
    M3e.Record.Button.view { content = c, action = M3e.Action.onClick DoThing } [] []
"""
                        ]
        , test "Standard → Record preserves a dynamic attr tail alongside a lifted action (#152)" <|
            \() ->
                """module A exposing (Msg, view)

import M3e.Button

type Msg
    = DoThing

view =
    M3e.Button.view (extra ++ [ M3e.Button.onClick DoThing ]) [ M3e.Button.child c ]
"""
                    |> Review.Test.run (TranslateToRecord.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Translate M3e.Button call to TranslateToRecord"
                            , details =
                                [ "Auto-fixable rewrite between the five API surfaces (D6 translator)."
                                , "Residue paths (unknown enum tokens, dynamic tails, missing required) escape through `Seam.*` — those will trigger `NoSeamOutsideAllowedModules` in a subsequent pass."
                                ]
                            , under = "M3e.Button.view (extra ++ [ M3e.Button.onClick DoThing ]) [ M3e.Button.child c ]"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (Msg, view)

import M3e.Button
import M3e.Action
import M3e.Record.Button

type Msg
    = DoThing

view =
    M3e.Record.Button.view { content = c, action = M3e.Action.onClick DoThing } ([] ++ extra) []
"""
                        ]
        ]
