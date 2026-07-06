module ExtractToSeam exposing (rule)

{-| **Autofix companion to `NoSeamOutsideAllowedModules`.**

Where `NoSeamOutsideAllowedModules` merely _flags_ a `Seam.*` escape used outside
the blessed adapter modules, this rule **lifts that escape into a named function
in the `Seam` module and rewrites the call site to use it** — a coordinated
cross-module autofix.

    Seam.asAttribute (class "flex-auto") -- in Feature (flagged)

becomes

    -- Feature
    Seam.flexAuto

    -- Seam  (new top-level function + added to `exposing`)
    flexAuto =
        Seam.asAttribute (class "flex-auto")

This rule is **opt-in** and is deliberately **not** part of the shipped
`ReviewConfig`: it rewrites source across two files, so a team should run it
under `elm-review --fix` on purpose, review the result, and then keep the seam
contained with `NoSeamOutsideAllowedModules`. The two rules share detection: this
rule triggers on exactly the applied `Seam.*` escapes the gate flags.

    config =
        [ ExtractToSeam.rule
            { seamModule = "Seam"
            , allowedModules = [ "Native", "Layout", "Kit" ]
            }
        ]

**How it works**

  - _Detection_ mirrors the gate: an `Expression.Application` whose head resolves
    (via the module-name lookup table) to the configured seam module, used in a
    module that is not in `allowedModules` and is not the seam module itself.
  - _Naming_ is deterministic: a camelCase slug is derived from the string
    literals inside the escape (`"flex-auto"` → `flexAuto`), falling back to
    `seam<EscapeFn>`; collisions with existing/other names get a stable hash
    suffix derived from the escape's normalized text.
  - _Dedup_ is by normalized (whitespace-collapsed) source text: two identical
    escapes lift to one function and both call sites reuse it; an escape whose
    text already matches an existing top-level `Seam` function reuses that
    function and only the call site is rewritten.
  - _Free variables_ (identifiers that resolve to nothing — locals, `msg`, a
    parameter) become **arguments** of the lifted function, threaded at the call
    site: `Seam.gridCol n` ↔ `gridCol n = Seam.asAttribute (class ("col-" ++ n))`.
  - _Convergence_: already-lifted `Seam` functions (whose body is itself a
    seam-qualified escape) are recognized and never re-extracted, so `--fix`
    terminates.

**Punted (fixless) cases** — surfaced as plain errors for manual handling rather
than emitting a broken fix:

  - point-free / bare `Seam.*` references (`List.map Seam.asElement`);
  - escapes that capture a local via a `let`/`case`/lambda/record-update inside
    the escape;
  - escapes that capture a value defined at the top level of the violating
    module (cannot be lifted into `Seam` cleanly);
  - multi-line escapes that also capture free variables.

@docs rule

-}

import Dict exposing (Dict)
import Elm.Syntax.Declaration as Declaration exposing (Declaration)
import Elm.Syntax.Exposing as Exposing exposing (Exposing)
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.File exposing (File)
import Elm.Syntax.Module as Module
import Elm.Syntax.ModuleName exposing (ModuleName)
import Elm.Syntax.Node as Node exposing (Node)
import Elm.Syntax.Range exposing (Location, Range)
import Review.Fix as Fix exposing (Fix)
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)
import Set exposing (Set)


{-| Build the autofix rule.

  - `seamModule` — the dotted name of the module lifted functions go into
    (e.g. `"Seam"`); the same module whose functions count as escapes.
  - `allowedModules` — dotted module-name prefixes allowed to use the seam
    (matching `NoSeamOutsideAllowedModules`); escapes are only extracted _outside_
    these.

-}
rule : { seamModule : String, allowedModules : List String } -> Rule
rule config =
    let
        seamModuleName : ModuleName
        seamModuleName =
            String.split "." config.seamModule
    in
    Rule.newProjectRuleSchema "ExtractToSeam" initialProjectContext
        |> Rule.withModuleVisitor moduleVisitor
        |> Rule.withModuleContextUsingContextCreator
            { fromProjectToModule = fromProjectToModule seamModuleName config.allowedModules
            , fromModuleToProject = fromModuleToProject
            , foldProjectContexts = foldProjectContexts
            }
        |> Rule.withFinalProjectEvaluation (finalEvaluation seamModuleName)
        |> Rule.fromProjectRuleSchema



-- CONTEXT


type alias ProjectContext =
    { seam : Maybe SeamInfo
    , escapes : List Escape
    , bareRefs : List BareRef
    }


initialProjectContext : ProjectContext
initialProjectContext =
    { seam = Nothing, escapes = [], bareRefs = [] }


type alias ModuleContext =
    { moduleKey : Rule.ModuleKey
    , moduleName : ModuleName
    , lookup : ModuleNameLookupTable
    , extract : Range -> String
    , ast : File
    , seamModuleName : ModuleName
    , isSeamModule : Bool
    , gated : Bool
    , escapes : List Escape
    , bareRefs : List BareRef
    , coveredHeads : Set ( Int, Int )
    }


{-| Everything the final evaluation needs about the target seam module.
-}
type alias SeamInfo =
    { moduleKey : Rule.ModuleKey
    , existingNames : Set String
    , liftedNames : Set String
    , bodyKeyToName : Dict String String
    , exposedNames : Set String
    , exposingAll : Bool
    , exposingInsertAt : Maybe Location
    , declInsertAt : Maybe Location
    }


{-| A candidate applied escape collected from a violating module.
-}
type alias Escape =
    { moduleKey : Rule.ModuleKey
    , moduleName : ModuleName
    , range : Range
    , text : String
    , key : String
    , fnName : String
    , qualifier : String
    , freeVars : List String
    , baseName : String
    , support : Support
    }


type Support
    = Fixable
    | Punt String


{-| A point-free / bare `Seam.*` reference we cannot cleanly extract.
-}
type alias BareRef =
    { moduleKey : Rule.ModuleKey
    , moduleName : ModuleName
    , range : Range
    , fnName : String
    }


fromProjectToModule : ModuleName -> List String -> Rule.ContextCreator ProjectContext ModuleContext
fromProjectToModule seamModuleName allowed =
    Rule.initContextCreator
        (\moduleKey moduleName lookup extract ast _ ->
            let
                isSeam =
                    moduleName == seamModuleName
            in
            { moduleKey = moduleKey
            , moduleName = moduleName
            , lookup = lookup
            , extract = extract
            , ast = ast
            , seamModuleName = seamModuleName
            , isSeamModule = isSeam
            , gated = not isSeam && not (isAllowed allowed (String.join "." moduleName))
            , escapes = []
            , bareRefs = []
            , coveredHeads = Set.empty
            }
        )
        |> Rule.withModuleKey
        |> Rule.withModuleName
        |> Rule.withModuleNameLookupTable
        |> Rule.withSourceCodeExtractor
        |> Rule.withFullAst


fromModuleToProject : Rule.ContextCreator ModuleContext ProjectContext
fromModuleToProject =
    Rule.initContextCreator
        (\ctx ->
            { seam =
                if ctx.isSeamModule then
                    Just (seamInfoFromModule ctx)

                else
                    Nothing
            , escapes = ctx.escapes
            , bareRefs = ctx.bareRefs
            }
        )


foldProjectContexts : ProjectContext -> ProjectContext -> ProjectContext
foldProjectContexts new previous =
    { seam =
        case new.seam of
            Just _ ->
                new.seam

            Nothing ->
                previous.seam
    , escapes = new.escapes ++ previous.escapes
    , bareRefs = new.bareRefs ++ previous.bareRefs
    }


{-| Allow-list check, identical to `NoSeamOutsideAllowedModules`: dot-boundary
prefix match.
-}
isAllowed : List String -> String -> Bool
isAllowed allowed currentModule =
    List.any
        (\prefix -> currentModule == prefix || String.startsWith (prefix ++ ".") currentModule)
        allowed



-- MODULE VISITOR (collect escapes in violating modules)


moduleVisitor : Rule.ModuleRuleSchema {} ModuleContext -> Rule.ModuleRuleSchema { hasAtLeastOneVisitor : () } ModuleContext
moduleVisitor schema =
    schema
        |> Rule.withExpressionEnterVisitor expressionVisitor


expressionVisitor : Node Expression -> ModuleContext -> ( List (Error {}), ModuleContext )
expressionVisitor node ctx =
    if not ctx.gated then
        ( [], ctx )

    else
        case Node.value node of
            Expression.Application (head :: args) ->
                case seamRef ctx head of
                    Just fnName ->
                        ( []
                        , { ctx
                            | escapes = buildEscape ctx node head fnName args :: ctx.escapes
                            , coveredHeads = Set.insert (locKey (.start (Node.range head))) ctx.coveredHeads
                          }
                        )

                    Nothing ->
                        ( [], ctx )

            Expression.FunctionOrValue _ fnName ->
                case seamRef ctx node of
                    Just _ ->
                        if Set.member (locKey (.start (Node.range node))) ctx.coveredHeads then
                            ( [], ctx )

                        else
                            ( []
                            , { ctx
                                | bareRefs =
                                    { moduleKey = ctx.moduleKey
                                    , moduleName = ctx.moduleName
                                    , range = Node.range node
                                    , fnName = fnName
                                    }
                                        :: ctx.bareRefs
                              }
                            )

                    Nothing ->
                        ( [], ctx )

            _ ->
                ( [], ctx )


{-| If `node` is a `FunctionOrValue` resolving (via the lookup table) to the seam
module, return the function name.
-}
seamRef : ModuleContext -> Node Expression -> Maybe String
seamRef ctx node =
    case Node.value node of
        Expression.FunctionOrValue _ name ->
            if Lookup.moduleNameFor ctx.lookup node == Just ctx.seamModuleName then
                Just name

            else
                Nothing

        _ ->
            Nothing


buildEscape : ModuleContext -> Node Expression -> Node Expression -> String -> List (Node Expression) -> Escape
buildEscape ctx node head fnName args =
    let
        text =
            ctx.extract (Node.range node)

        analysis =
            mergeMany (List.map (analyzeExpr ctx.lookup) args)

        freeVars =
            firstOccDistinct analysis.free

        multiLine =
            (.start (Node.range node)).row /= (.end (Node.range node)).row

        support =
            if analysis.hasBinder then
                Punt "captures a value bound by a let/case/lambda/record-update inside the escape"

            else if multiLine && not (List.isEmpty freeVars) then
                Punt "multi-line escape that also captures free variables"

            else
                Fixable
    in
    { moduleKey = ctx.moduleKey
    , moduleName = ctx.moduleName
    , range = Node.range node
    , text = text
    , key = normalizeWs text
    , fnName = fnName
    , qualifier = qualifierOf head
    , freeVars = freeVars
    , baseName = deriveBaseName analysis.literals fnName
    , support = support
    }


qualifierOf : Node Expression -> String
qualifierOf head =
    case Node.value head of
        Expression.FunctionOrValue parts _ ->
            String.join "." parts

        _ ->
            ""



-- FREE-VARIABLE / LITERAL ANALYSIS


type alias Analysis =
    { free : List String
    , literals : List String
    , hasBinder : Bool
    }


emptyAnalysis : Analysis
emptyAnalysis =
    { free = [], literals = [], hasBinder = False }


mergeAnalysis : Analysis -> Analysis -> Analysis
mergeAnalysis a b =
    { free = a.free ++ b.free
    , literals = a.literals ++ b.literals
    , hasBinder = a.hasBinder || b.hasBinder
    }


mergeMany : List Analysis -> Analysis
mergeMany =
    List.foldr mergeAnalysis emptyAnalysis


analyzeExpr : ModuleNameLookupTable -> Node Expression -> Analysis
analyzeExpr lookup node =
    case Node.value node of
        Expression.FunctionOrValue parts name ->
            if List.isEmpty parts && isLowerIdent name then
                case Lookup.moduleNameFor lookup node of
                    Nothing ->
                        -- Unresolved unqualified value: a captured local (parameter,
                        -- `let`/`case` binding, `msg`). Thread it as an argument.
                        { emptyAnalysis | free = [ name ] }

                    Just [] ->
                        -- Resolves to "this module": either a local binding (elm-review
                        -- reports locals as the current module) or a top-level value.
                        -- Either way it is not in scope in the seam module, so capture it.
                        { emptyAnalysis | free = [ name ] }

                    Just _ ->
                        -- Imported / qualified: assumed available where the escape lands.
                        emptyAnalysis

            else
                emptyAnalysis

        Expression.Application xs ->
            mergeMany (List.map (analyzeExpr lookup) xs)

        Expression.OperatorApplication _ _ l r ->
            mergeAnalysis (analyzeExpr lookup l) (analyzeExpr lookup r)

        Expression.ParenthesizedExpression x ->
            analyzeExpr lookup x

        Expression.Negation x ->
            analyzeExpr lookup x

        Expression.TupledExpression xs ->
            mergeMany (List.map (analyzeExpr lookup) xs)

        Expression.ListExpr xs ->
            mergeMany (List.map (analyzeExpr lookup) xs)

        Expression.IfBlock a b c ->
            mergeMany [ analyzeExpr lookup a, analyzeExpr lookup b, analyzeExpr lookup c ]

        Expression.RecordAccess x _ ->
            analyzeExpr lookup x

        Expression.Literal s ->
            { emptyAnalysis | literals = [ s ] }

        Expression.LambdaExpression _ ->
            { emptyAnalysis | hasBinder = True }

        Expression.LetExpression _ ->
            { emptyAnalysis | hasBinder = True }

        Expression.CaseExpression _ ->
            { emptyAnalysis | hasBinder = True }

        Expression.RecordExpr _ ->
            { emptyAnalysis | hasBinder = True }

        Expression.RecordUpdateExpression _ _ ->
            { emptyAnalysis | hasBinder = True }

        _ ->
            emptyAnalysis


isLowerIdent : String -> Bool
isLowerIdent name =
    case String.uncons name of
        Just ( c, _ ) ->
            Char.isLower c

        Nothing ->
            False



-- SEAM MODULE ANALYSIS


seamInfoFromModule : ModuleContext -> SeamInfo
seamInfoFromModule ctx =
    let
        decls =
            ctx.ast.declarations

        functions =
            List.filterMap asFunction decls

        exposing_ =
            Module.exposingList (Node.value ctx.ast.moduleDefinition)
    in
    { moduleKey = ctx.moduleKey
    , existingNames = Set.fromList (List.filterMap declName decls)
    , liftedNames =
        functions
            |> List.filter (\f -> isSeamQualifiedBody ctx.seamModuleName f.body)
            |> List.map .name
            |> Set.fromList
    , bodyKeyToName =
        List.foldr
            (\f acc -> Dict.insert (normalizeWs (ctx.extract (Node.range f.body))) f.name acc)
            Dict.empty
            functions
    , exposedNames = exposedNamesOf exposing_
    , exposingAll = isExposingAll exposing_
    , exposingInsertAt = exposingInsertLocation exposing_
    , declInsertAt = lastDeclarationEnd decls
    }


type alias SeamFunction =
    { name : String
    , body : Node Expression
    }


asFunction : Node Declaration -> Maybe SeamFunction
asFunction node =
    case Node.value node of
        Declaration.FunctionDeclaration f ->
            let
                impl =
                    Node.value f.declaration
            in
            Just { name = Node.value impl.name, body = impl.expression }

        _ ->
            Nothing


declName : Node Declaration -> Maybe String
declName node =
    case Node.value node of
        Declaration.FunctionDeclaration f ->
            Just (Node.value (Node.value f.declaration).name)

        Declaration.AliasDeclaration a ->
            Just (Node.value a.name)

        Declaration.CustomTypeDeclaration t ->
            Just (Node.value t.name)

        Declaration.PortDeclaration p ->
            Just (Node.value p.name)

        _ ->
            Nothing


{-| Recognize an already-lifted function: its body (unwrapping parens) is an
application whose head is written qualified with the seam module name.
-}
isSeamQualifiedBody : ModuleName -> Node Expression -> Bool
isSeamQualifiedBody seamModuleName body =
    case Node.value body of
        Expression.ParenthesizedExpression x ->
            isSeamQualifiedBody seamModuleName x

        Expression.Application (head :: _) ->
            headQualifierMatches seamModuleName head

        Expression.FunctionOrValue parts _ ->
            parts == seamModuleName

        _ ->
            False


headQualifierMatches : ModuleName -> Node Expression -> Bool
headQualifierMatches seamModuleName head =
    case Node.value head of
        Expression.FunctionOrValue parts _ ->
            parts == seamModuleName

        _ ->
            False


exposedNamesOf : Exposing -> Set String
exposedNamesOf exposing_ =
    case exposing_ of
        Exposing.All _ ->
            Set.empty

        Exposing.Explicit list ->
            list
                |> List.filterMap (topLevelExposeName << Node.value)
                |> Set.fromList


topLevelExposeName : Exposing.TopLevelExpose -> Maybe String
topLevelExposeName expose =
    case expose of
        Exposing.FunctionExpose name ->
            Just name

        Exposing.InfixExpose name ->
            Just name

        Exposing.TypeOrAliasExpose name ->
            Just name

        Exposing.TypeExpose t ->
            Just t.name


isExposingAll : Exposing -> Bool
isExposingAll exposing_ =
    case exposing_ of
        Exposing.All _ ->
            True

        Exposing.Explicit _ ->
            False


{-| Location just after the last item in an explicit exposing list — where a
`", newName"` insert goes.
-}
exposingInsertLocation : Exposing -> Maybe Location
exposingInsertLocation exposing_ =
    case exposing_ of
        Exposing.Explicit list ->
            list
                |> List.map (.end << Node.range)
                |> List.foldl maxLocation Nothing

        Exposing.All _ ->
            Nothing


lastDeclarationEnd : List (Node Declaration) -> Maybe Location
lastDeclarationEnd decls =
    decls
        |> List.map (.end << Node.range)
        |> List.foldl maxLocation Nothing


maxLocation : Location -> Maybe Location -> Maybe Location
maxLocation loc acc =
    case acc of
        Nothing ->
            Just loc

        Just current ->
            if ( loc.row, loc.column ) > ( current.row, current.column ) then
                Just loc

            else
                Just current



-- FINAL EVALUATION


finalEvaluation : ModuleName -> ProjectContext -> List (Error { useErrorForModule : () })
finalEvaluation seamModuleName project =
    case project.seam of
        Nothing ->
            []

        Just seam ->
            let
                -- Escapes that are genuinely extractable (not already lifted).
                live =
                    project.escapes
                        |> List.filter (\e -> not (Set.member e.fnName seam.liftedNames))

                fixable =
                    List.filter (\e -> e.support == Fixable) live

                punted =
                    List.filter (\e -> e.support /= Fixable) live

                bareLive =
                    project.bareRefs
                        |> List.filter (\r -> not (Set.member r.fnName seam.liftedNames))

                groups =
                    groupByKey fixable

                ( groupErrors, _ ) =
                    List.foldl
                        (assignAndEmit seamModuleName seam)
                        ( [], seam.existingNames )
                        groups
            in
            groupErrors
                ++ List.map puntError punted
                ++ List.map bareRefError bareLive


{-| Group extractable escapes by their normalized text, preserving a stable
order (sorted by key) so name assignment is deterministic.
-}
groupByKey : List Escape -> List ( String, List Escape )
groupByKey escapes =
    escapes
        |> List.foldr (\e acc -> Dict.update e.key (\m -> Just (e :: Maybe.withDefault [] m)) acc) Dict.empty
        |> Dict.toList


assignAndEmit :
    ModuleName
    -> SeamInfo
    -> ( String, List Escape )
    -> ( List (Error { useErrorForModule : () }), Set String )
    -> ( List (Error { useErrorForModule : () }), Set String )
assignAndEmit seamModuleName seam ( key, escapes ) ( errorsAcc, takenNames ) =
    case sortEscapes escapes of
        [] ->
            ( errorsAcc, takenNames )

        representative :: _ ->
            let
                reuse =
                    Dict.get key seam.bodyKeyToName

                ( name, needsInsert, newTaken ) =
                    case reuse of
                        Just existing ->
                            ( existing, False, takenNames )

                        Nothing ->
                            let
                                chosen =
                                    uniqueName representative.baseName key takenNames
                            in
                            ( chosen, True, Set.insert chosen takenNames )

                needsExpose =
                    needsInsert || (not seam.exposingAll && not (Set.member name seam.exposedNames))

                callSiteFixes =
                    escapesByModule escapes
                        |> List.map
                            (\( moduleKey, moduleEscapes ) ->
                                Rule.editModule moduleKey
                                    (List.map (callSiteFix seamModuleName name) moduleEscapes)
                            )

                seamFixes =
                    if needsInsert || needsExpose then
                        [ Rule.editModule seam.moduleKey (seamFixList seam name representative needsInsert needsExpose) ]

                    else
                        []
            in
            let
                emitted =
                    Rule.errorForModule representative.moduleKey
                        { message = "`" ++ representative.qualifier ++ "." ++ representative.fnName ++ "` escape can be lifted into `" ++ String.join "." seamModuleName ++ "." ++ name ++ "`"
                        , details =
                            [ "This `" ++ representative.qualifier ++ ".*` escape discards a type guarantee in a module that is not allowed to use the seam. The fix lifts it into `" ++ String.join "." seamModuleName ++ "` as `" ++ name ++ "` and rewrites this call site to `" ++ String.join "." seamModuleName ++ "." ++ name ++ "`."
                            , "Naming and de-duplication are deterministic, so re-running `--fix` converges: identical escapes share one lifted function, and an already-lifted `" ++ String.join "." seamModuleName ++ "` function is never re-extracted."
                            ]
                        }
                        representative.range
                        |> Rule.withFixesV2 (callSiteFixes ++ seamFixes)
            in
            ( emitted :: errorsAcc, newTaken )


sortEscapes : List Escape -> List Escape
sortEscapes =
    List.sortBy (\e -> ( String.join "." e.moduleName, (.start e.range).row, (.start e.range).column ))


{-| Partition escapes by module key (keyed via module name for comparability).
-}
escapesByModule : List Escape -> List ( Rule.ModuleKey, List Escape )
escapesByModule escapes =
    escapes
        |> List.foldr
            (\e acc -> Dict.update (String.join "." e.moduleName) (\m -> Just ( e.moduleKey, e :: Maybe.withDefault [] (Maybe.map Tuple.second m) )) acc)
            Dict.empty
        |> Dict.values


callSiteFix : ModuleName -> String -> Escape -> Fix
callSiteFix seamModuleName name escape =
    let
        qualifier =
            if String.isEmpty escape.qualifier then
                String.join "." seamModuleName

            else
                escape.qualifier

        args =
            String.concat (List.map (\v -> " " ++ v) escape.freeVars)
    in
    Fix.replaceRangeBy escape.range (qualifier ++ "." ++ name ++ args)


seamFixList : SeamInfo -> String -> Escape -> Bool -> Bool -> List Fix
seamFixList seam name representative needsInsert needsExpose =
    let
        insertFix =
            if needsInsert then
                case seam.declInsertAt of
                    Just loc ->
                        [ Fix.insertAt loc (liftedDefinition name representative) ]

                    Nothing ->
                        []

            else
                []

        exposeFix =
            if needsExpose && not seam.exposingAll then
                case seam.exposingInsertAt of
                    Just loc ->
                        [ Fix.insertAt loc (", " ++ name) ]

                    Nothing ->
                        []

            else
                []
    in
    insertFix ++ exposeFix


liftedDefinition : String -> Escape -> String
liftedDefinition name escape =
    let
        params =
            String.concat (List.map (\v -> " " ++ v) escape.freeVars)
    in
    "\n\n\n" ++ name ++ params ++ " =\n    " ++ escape.text


puntError : Escape -> Error { useErrorForModule : () }
puntError escape =
    let
        reason =
            case escape.support of
                Punt r ->
                    r

                Fixable ->
                    ""
    in
    Rule.errorForModule escape.moduleKey
        { message = "`" ++ escape.qualifier ++ "." ++ escape.fnName ++ "` escape cannot be auto-extracted"
        , details =
            [ "This seam escape " ++ reason ++ ", so `ExtractToSeam` will not emit a fix that could be wrong."
            , "Lift it into the seam module by hand (as a named function taking the captured values as arguments), then use it here."
            ]
        }
        escape.range


bareRefError : BareRef -> Error { useErrorForModule : () }
bareRefError ref =
    Rule.errorForModule ref.moduleKey
        { message = "`Seam." ++ ref.fnName ++ "` is used point-free and cannot be auto-extracted"
        , details =
            [ "This is a bare (point-free) reference to a seam function rather than an applied escape expression, so there is nothing self-contained to lift."
            , "Refactor it into an applied escape, or lift the surrounding expression into the seam module by hand."
            ]
        }
        ref.range



-- NAMING


{-| Derive a readable camelCase base name from the escape's string literals,
falling back to `seam<EscapeFn>`.
-}
deriveBaseName : List String -> String -> String
deriveBaseName literals fnName =
    let
        fromLiterals =
            slugify (String.join " " literals)
    in
    if String.isEmpty fromLiterals then
        "seam" ++ capitalizeFirst fnName

    else
        fromLiterals


slugify : String -> String
slugify raw =
    let
        words =
            raw
                |> String.map
                    (\c ->
                        if Char.isAlphaNum c then
                            c

                        else
                            ' '
                    )
                |> String.words
    in
    case words of
        [] ->
            ""

        first :: rest ->
            let
                joined =
                    lowerFirst first ++ String.concat (List.map capitalizeFirst rest)
            in
            case String.uncons joined of
                Just ( c, _ ) ->
                    if Char.isDigit c then
                        "s" ++ joined

                    else
                        joined

                Nothing ->
                    ""


{-| Ensure `base` is unique among `taken`; if not, append a stable hash of the
escape's normalized text (and a counter as a last resort).
-}
uniqueName : String -> String -> Set String -> String
uniqueName base key taken =
    if not (Set.member base taken) then
        base

    else
        let
            withHash =
                base ++ capitalizeFirst (hashString key)
        in
        if not (Set.member withHash taken) then
            withHash

        else
            bumpName withHash 2 taken


bumpName : String -> Int -> Set String -> String
bumpName base n taken =
    let
        candidate =
            base ++ String.fromInt n
    in
    if not (Set.member candidate taken) then
        candidate

    else if n > 500 then
        candidate

    else
        bumpName base (n + 1) taken


lowerFirst : String -> String
lowerFirst s =
    case String.uncons s of
        Just ( c, rest ) ->
            String.cons (Char.toLower c) rest

        Nothing ->
            s


capitalizeFirst : String -> String
capitalizeFirst s =
    case String.uncons s of
        Just ( c, rest ) ->
            String.cons (Char.toUpper c) rest

        Nothing ->
            s


normalizeWs : String -> String
normalizeWs =
    String.words >> String.join " "


{-| A small deterministic base36 hash of a string (stable across runs).
-}
hashString : String -> String
hashString s =
    s
        |> String.toList
        |> List.foldl (\c acc -> modBy 2147483647 (acc * 31 + Char.toCode c)) 7
        |> toBase36
        |> String.left 4


toBase36 : Int -> String
toBase36 n =
    if n <= 0 then
        "0"

    else
        toBase36Help n ""


toBase36Help : Int -> String -> String
toBase36Help n acc =
    if n <= 0 then
        acc

    else
        toBase36Help (n // 36) (String.cons (base36Digit (modBy 36 n)) acc)


base36Digit : Int -> Char
base36Digit d =
    if d < 10 then
        Char.fromCode (Char.toCode '0' + d)

    else
        Char.fromCode (Char.toCode 'a' + (d - 10))


locKey : Location -> ( Int, Int )
locKey loc =
    ( loc.row, loc.column )


firstOccDistinct : List String -> List String
firstOccDistinct xs =
    List.foldl
        (\x ( seen, acc ) ->
            if Set.member x seen then
                ( seen, acc )

            else
                ( Set.insert x seen, acc ++ [ x ] )
        )
        ( Set.empty, [] )
        xs
        |> Tuple.second
