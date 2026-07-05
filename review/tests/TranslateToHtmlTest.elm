module TranslateToHtmlTest exposing (all)

import M3e.Review.Facts
import Review.Test
import Test exposing (Test, describe, test)
import TranslateToHtml


all : Test
all =
    describe "TranslateToHtml"
        [ test "identity: an Html call gets no fix" <|
            \() ->
                """module A exposing (view)

import M3e.Cem.Html.Button

view =
    M3e.Cem.Html.Button.button [] []
"""
                    |> Review.Test.run (TranslateToHtml.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectNoErrors
        , test "no error on unrecognised module" <|
            \() ->
                """module A exposing (view)

view =
    other []
"""
                    |> Review.Test.run (TranslateToHtml.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectNoErrors
        , test "Standard → Html emits `M3e.Cem.Html.<Comp>.<ctor>` shape" <|
            \() ->
                """module A exposing (view)

import M3e.Button

view =
    M3e.Button.view [] []
"""
                    |> Review.Test.run (TranslateToHtml.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Translate M3e.Button call to TranslateToHtml"
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

view =
    M3e.Cem.Html.Button.button [] []
"""
                        ]
        , test "Standard → Html preserves a bare-variable dynamic content tail (#152)" <|
            \() ->
                """module A exposing (view)

import M3e.Button

view =
    M3e.Button.view [] moreKids
"""
                    |> Review.Test.run (TranslateToHtml.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Translate M3e.Button call to TranslateToHtml"
                            , details =
                                [ "Auto-fixable rewrite between the five API surfaces (D6 translator)."
                                , "Residue paths (unknown enum tokens, dynamic tails, missing required) escape through `Seam.*` — those will trigger `NoSeamOutsideAllowedModules` in a subsequent pass."
                                ]
                            , under = "M3e.Button.view [] moreKids"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (view)

import M3e.Button
import M3e.Cem.Html.Button

view =
    M3e.Cem.Html.Button.button [] ([] ++ moreKids)
"""
                        ]
        , test "Standard → Html: lifted required content emits M3e.Element.toHtml and imports M3e.Element (#149)" <|
            \() ->
                """module A exposing (view)

import M3e.TocItem

view =
    M3e.TocItem.view [] [ M3e.TocItem.child c ]
"""
                    |> Review.Test.run (TranslateToHtml.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Translate M3e.TocItem call to TranslateToHtml"
                            , details =
                                [ "Auto-fixable rewrite between the five API surfaces (D6 translator)."
                                , "Residue paths (unknown enum tokens, dynamic tails, missing required) escape through `Seam.*` — those will trigger `NoSeamOutsideAllowedModules` in a subsequent pass."
                                ]
                            , under = "M3e.TocItem.view [] [ M3e.TocItem.child c ]"
                            }
                            |> Review.Test.whenFixed
                                """module A exposing (view)

import M3e.TocItem
import M3e.Cem.Html.TocItem
import M3e.Element

view =
    M3e.Cem.Html.TocItem.tocItem [] [ (M3e.Element.toHtml (c)) ]
"""
                        ]
        ]
