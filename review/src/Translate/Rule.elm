module Translate.Rule exposing (Config, rule)

{-| Shared scaffold for the five `TranslateTo<X>` rules. Each per-target rule
is a thin wrapper that passes its target surface into `rule`.

Per spec 2026-07-05-codegen-aware-translator-design.md §4. Dispatches to per-
surface parsers and emitters (Task 6+7 for Standard; Tasks 11-12 for the
other four).

@docs Config, rule

-}

import Dict exposing (Dict)
import Elm.Syntax.Declaration as Declaration
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Import exposing (Import)
import Elm.Syntax.Module as Module
import Elm.Syntax.Node as Node exposing (Node)
import Elm.Syntax.Range as Range
import M3e.Review.Facts exposing (Fact, Surface(..))
import Review.Fix as Fix
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)
import Set exposing (Set)
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
        |> Rule.withModuleDefinitionVisitor moduleDefinitionVisitor
        |> Rule.withImportVisitor importVisitor
        |> Rule.withDeclarationEnterVisitor declarationEnterVisitor
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
    , importedModules : Set (List String)
    , insertionRow : Int
    , scope : Dict String (Node Expression)
    }


initContext : Config -> Rule.ContextCreator () Context
initContext config =
    Rule.initContextCreator
        (\lookup extractSourceCode () ->
            { lookup = lookup
            , facts = config.facts
            , target = config.target
            , extractSourceCode = extractSourceCode
            , importedModules = Set.empty
            , insertionRow = 1
            , scope = Dict.empty
            }
        )
        |> Rule.withModuleNameLookupTable
        |> Rule.withSourceCodeExtractor


{-| Collect the top-level declaration's `let` bindings (name → bound expression)
so a required-content item that is a bare variable can be resolved to its setter
call (#153). Mirrors the scope pattern in ValidEnumValue / SingularSlot.
-}
declarationEnterVisitor : Node Declaration.Declaration -> Context -> ( List (Error {}), Context )
declarationEnterVisitor node context =
    case Node.value node of
        Declaration.FunctionDeclaration { declaration } ->
            case Node.value (Node.value declaration).expression of
                Expression.LetExpression { declarations } ->
                    let
                        scope =
                            List.foldl
                                (\dec acc ->
                                    case Node.value dec of
                                        Expression.LetFunction fn ->
                                            let
                                                fnDecl =
                                                    Node.value fn.declaration
                                            in
                                            Dict.insert (Node.value fnDecl.name) fnDecl.expression acc

                                        _ ->
                                            acc
                                )
                                Dict.empty
                                declarations
                    in
                    ( [], { context | scope = scope } )

                _ ->
                    ( [], { context | scope = Dict.empty } )

        _ ->
            ( [], context )


{-| Track the last row occupied by the module header / imports so an added
`import` can be inserted just after the existing import block.
-}
moduleDefinitionVisitor : Node Module.Module -> Context -> ( List (Error {}), Context )
moduleDefinitionVisitor node context =
    ( [], { context | insertionRow = (Node.range node).end.row } )


importVisitor : Node Import -> Context -> ( List (Error {}), Context )
importVisitor node context =
    ( []
    , { context
        | importedModules = Set.insert (Node.value (Node.value node).moduleName) context.importedModules
        , insertionRow = (Node.range node).end.row
      }
    )


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
                        Translate.Parse.parseCall context.scope sourceSurface fact node

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
                            (Fix.replaceRangeBy (Node.range node) fix :: importFixes context fact fix)
                in
                ( [ err ], context )

        Nothing ->
            ( [], context )


{-| The modules an emitted rewrite may reference: this component's five surface
modules plus the support/residue modules the emitters can produce. Which ones
are actually needed depends on the emitted text (a clean Record conversion
references `M3e.Record.<C>`; a Seam fallback references `Seam` +
`M3e.Cem.Html.<C>` instead), so `importFixes` filters by literal occurrence.
-}
candidateModules : Fact -> List String
candidateModules fact =
    let
        comp =
            case String.split "." fact.module_ of
                [ "M3e", c ] ->
                    c

                _ ->
                    ""
    in
    [ "M3e." ++ comp
    , "M3e.Record." ++ comp
    , "M3e.Build." ++ comp
    , "M3e.Cem." ++ comp
    , "M3e.Cem.Html." ++ comp
    , "Seam"
    , "M3e.Action"
    , "M3e.Aria"
    , "M3e.Element"
    , "Html.Attributes"
    , "Html.Events"
    , "Json.Decode"
    ]


{-| Emit a single `import` fix for every module the rewritten text references
that the file does not already import — otherwise `--fix` produces code that
fails `elm make` with "unknown module" (issue #149). Inserted just after the
existing import block; sorted so the block stays elm-format-friendly.
-}
importFixes : Context -> Fact -> String -> List Fix.Fix
importFixes context fact fixText =
    let
        missing =
            candidateModules fact
                |> List.filter (\m -> String.contains (m ++ ".") fixText)
                |> List.filter (\m -> not (Set.member (String.split "." m) context.importedModules))
                |> List.sort
    in
    if List.isEmpty missing then
        []

    else
        [ Fix.insertAt { row = context.insertionRow + 1, column = 1 }
            (missing |> List.map (\m -> "import " ++ m ++ "\n") |> String.concat)
        ]


emitFor : Surface -> Fact -> (Range.Range -> String) -> Canonical -> String
emitFor target fact source c =
    case target of
        Standard ->
            Translate.Emit.emitStandard fact source c

        Cem ->
            Translate.Emit.emitCem fact source c

        Html ->
            Translate.Emit.emitHtml fact source c

        Record ->
            if canEmitRecord fact c then
                Translate.Emit.emitRecord fact source c

            else
                -- Missing required content/action — fall back to whole-node
                -- Seam escape so the result still composes.
                Translate.Residue.wholeSeamEscape fact source c

        Build ->
            if canEmitBuild fact c then
                Translate.Emit.emitBuild fact source c

            else
                Translate.Residue.wholeSeamEscape fact source c


{-| Record shape requires the required content to be present in the canonical
form. The `action` field, for components whose record carries one
(`fact.usesAction`), is always satisfiable: a lifted action is emitted directly,
and its ABSENCE (an aria-only / icon-only call) is filled with the no-op
`M3e.Action.none` by `emitRecordArg`. Components without an action record (e.g.
AssistChip) satisfy the record from `content` alone. Only a missing required
content forces the whole-node Seam escape.
-}
canEmitRecord : Fact -> Canonical -> Bool
canEmitRecord _ c =
    c.requiredContent /= Nothing


{-| Build shape has the same required-content/action requirement as Record.
Additionally, `Build` has no attr-list or content-list seam — any residue in
attrs/content (EnumTokenLossy, EscapedAttr, DynamicAttrTail, UnknownSlotName,
EscapedContent, DynamicContentTail) triggers whole-node escape.
-}
canEmitBuild : Fact -> Canonical -> Bool
canEmitBuild fact c =
    canEmitRecord fact c
        && List.all isCleanAttrForBuild c.attrs
        && List.all isCleanSlotForBuild c.content


isCleanAttrForBuild : Translate.Canonical.AttrItem -> Bool
isCleanAttrForBuild item =
    case item of
        Translate.Canonical.KnownAttr _ ->
            True

        -- Universal `Attr` setters (`M3e.Aria.*`) inject cleanly through the
        -- Build module's generic `attr` seam — not residue.
        Translate.Canonical.UniversalAttr _ ->
            True

        _ ->
            False


isCleanSlotForBuild : Translate.Canonical.SlotItem -> Bool
isCleanSlotForBuild item =
    case item of
        Translate.Canonical.KnownSlot _ ->
            True

        _ ->
            False
