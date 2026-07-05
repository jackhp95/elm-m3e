module Translate.Rule exposing (Config, rule)

{-| Shared scaffold for the five `TranslateTo<X>` rules. Each per-target rule
is a thin wrapper that passes its target surface into `rule`.

Per spec 2026-07-05-codegen-aware-translator-design.md §4. Dispatches to per-
surface parsers and emitters (Task 6+7 for Standard; Tasks 11-12 for the
other four).

@docs Config, rule

-}

import Dict exposing (Dict)
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Elm.Syntax.Range as Range
import M3e.Review.Facts exposing (Fact, Surface(..))
import Review.Fix as Fix
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)
import Translate.Canonical exposing (Canonical)
import Translate.Emit
import Translate.Parse
import Translate.Residue


type alias Config =
    { facts : List Fact
    , target : Surface
    }


rule : Config -> Rule
rule config =
    Rule.newModuleRuleSchemaUsingContextCreator (ruleName config.target) (initContext config)
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


ruleName : Surface -> String
ruleName target =
    case target of
        Html ->
            "TranslateToHtml"

        Cem ->
            "TranslateToCem"

        Standard ->
            "TranslateToStandard"

        Record ->
            "TranslateToRecord"

        Build ->
            "TranslateToBuild"


type alias Context =
    { lookup : ModuleNameLookupTable
    , facts : List Fact
    , target : Surface
    , extractSourceCode : Range.Range -> String
    }


initContext : Config -> Rule.ContextCreator () Context
initContext config =
    Rule.initContextCreator
        (\lookup extractSourceCode () ->
            { lookup = lookup
            , facts = config.facts
            , target = config.target
            , extractSourceCode = extractSourceCode
            }
        )
        |> Rule.withModuleNameLookupTable
        |> Rule.withSourceCodeExtractor


expressionVisitor : Node Expression -> Context -> ( List (Error {}), Context )
expressionVisitor node context =
    case Translate.Parse.identifySurface context.facts context.lookup node of
        Just ( sourceSurface, fact ) ->
            if sourceSurface == context.target then
                -- Same-surface identity: no fix, no error.
                ( [], context )

            else
                let
                    canonical =
                        Translate.Parse.parseCall sourceSurface fact node

                    fix =
                        emitFor context.target fact context.extractSourceCode canonical

                    err =
                        Rule.errorWithFix
                            { message = "Translate " ++ fact.module_ ++ " call to " ++ ruleName context.target
                            , details =
                                [ "Auto-fixable rewrite between the five API surfaces (D6 translator)."
                                , "Residue paths (unknown enum tokens, dynamic tails, missing required) escape through `Seam.*` — those will trigger `NoSeamOutsideAllowedModules` in a subsequent pass."
                                ]
                            }
                            (Node.range node)
                            [ Fix.replaceRangeBy (Node.range node) fix ]
                in
                ( [ err ], context )

        Nothing ->
            ( [], context )


emitFor : Surface -> Fact -> (Range.Range -> String) -> Canonical -> String
emitFor target fact source c =
    case target of
        Standard ->
            Translate.Emit.emitStandard fact source c

        Html ->
            -- Tasks 11-12 will implement dedicated emitters; until then, the
            -- whole-node Seam escape is a valid fallback (produces a
            -- composable Element/Attr via Seam).
            Translate.Residue.wholeSeamEscape fact source c

        Cem ->
            Translate.Residue.wholeSeamEscape fact source c

        Record ->
            Translate.Residue.wholeSeamEscape fact source c

        Build ->
            Translate.Residue.wholeSeamEscape fact source c
