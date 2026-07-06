module PreferSpecificSlot exposing (rule)

{-| D4: prefer per-component setters over barrel shorthands, with autofix.

Two cases:

  - Attr case: `M3e.<barrelName>` inside a component's attrs list → rewrite to
    `M3e.<Comp>.<perCompName>` using `attrRewrites`.
  - Slot case: `M3e.Cem.Attr.slot "<slotName>" body` in the content list →
    rewrite to `M3e.<Comp>.<setterName> body` using `slotRewrites`.

Autofix atomically inserts `import M3e.<Comp>` when the module is not yet
imported, placing it after the last existing import (or after the module
definition line if there are no imports).

@docs rule

-}

import Dict exposing (Dict)
import Elm.Syntax.Declaration as Declaration
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Import exposing (Import)
import Elm.Syntax.Module as Module
import Elm.Syntax.Node as Node exposing (Node)
import Elm.Syntax.Range exposing (Range)
import Facts
import M3e.Review.Facts exposing (Fact, Surface(..))
import Review.Fix as Fix
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)
import Set exposing (Set)


{-| Build from the generated facts (`M3e.Review.Facts.facts`).
-}
rule : List Fact -> Rule
rule facts =
    Rule.newModuleRuleSchemaUsingContextCreator "PreferSpecificSlot" (initContext facts)
        |> Rule.withModuleDefinitionVisitor moduleDefinitionVisitor
        |> Rule.withImportVisitor importVisitor
        |> Rule.withDeclarationEnterVisitor declarationEnterVisitor
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


type alias Context =
    { lookup : ModuleNameLookupTable
    , factsIndex : Dict String Fact
    , scope : Dict String (Node Expression)
    , extractSourceCode : Range -> String
    , importedModules : Set (List String)
    , insertionRow : Int
    }


initContext : List Fact -> Rule.ContextCreator () Context
initContext facts =
    Rule.initContextCreator
        (\lookup extractSourceCode () ->
            { lookup = lookup
            , factsIndex = Facts.buildIndex facts
            , scope = Dict.empty
            , extractSourceCode = extractSourceCode
            , importedModules = Set.empty
            , insertionRow = 1
            }
        )
        |> Rule.withModuleNameLookupTable
        |> Rule.withSourceCodeExtractor


moduleDefinitionVisitor : Node Module.Module -> Context -> ( List (Error {}), Context )
moduleDefinitionVisitor node context =
    let
        endRow =
            (Node.range node).end.row
    in
    ( [], { context | insertionRow = endRow } )


importVisitor : Node Import -> Context -> ( List (Error {}), Context )
importVisitor node context =
    let
        imp =
            Node.value node

        moduleName =
            Node.value imp.moduleName

        endRow =
            (Node.range node).end.row
    in
    ( []
    , { context
        | importedModules = Set.insert moduleName context.importedModules
        , insertionRow = endRow
      }
    )


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

                                                name =
                                                    Node.value fnDecl.name
                                            in
                                            Dict.insert name fnDecl.expression acc

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


expressionVisitor : Node Expression -> Context -> ( List (Error {}), Context )
expressionVisitor node context =
    case Node.value node of
        Expression.Application (fnNode :: args) ->
            case Facts.callSite context.lookup fnNode of
                Just site ->
                    case Facts.find site.noun context.factsIndex of
                        Just fact ->
                            ( checkCall context site fact args, context )

                        Nothing ->
                            ( [], context )

                Nothing ->
                    ( [], context )

        _ ->
            ( [], context )


checkCall : Context -> Facts.CallSite -> Fact -> List (Node Expression) -> List (Error {})
checkCall context site fact args =
    let
        ( maybeAttrsList, maybeContentList ) =
            case site.surface of
                Standard ->
                    case args of
                        a :: c :: _ ->
                            ( Just a, Just c )

                        [ a ] ->
                            ( Just a, Nothing )

                        _ ->
                            ( Nothing, Nothing )

                Record ->
                    case args of
                        _ :: a :: c :: _ ->
                            ( Just a, Just c )

                        _ ->
                            ( Nothing, Nothing )

                _ ->
                    ( Nothing, Nothing )

        attrErrors =
            maybeAttrsList
                |> Maybe.map (checkAttrs context fact)
                |> Maybe.withDefault []

        slotErrors =
            maybeContentList
                |> Maybe.map (checkSlots context fact)
                |> Maybe.withDefault []

        slotUpgradeErrors =
            maybeContentList
                |> Maybe.map (checkSlotUpgrades context fact)
                |> Maybe.withDefault []
    in
    attrErrors ++ slotErrors ++ slotUpgradeErrors


checkAttrs : Context -> Fact -> Node Expression -> List (Error {})
checkAttrs context fact attrsNode =
    let
        trace =
            Facts.tracedList context.lookup context.scope attrsNode
    in
    if trace.unresolved then
        []

    else
        List.filterMap (attrErrorFor context fact) trace.known


attrErrorFor : Context -> Fact -> Node Expression -> Maybe (Error {})
attrErrorFor context fact element =
    case Node.value element of
        Expression.Application (setterNode :: _) ->
            case ( Node.value setterNode, Lookup.moduleNameFor context.lookup setterNode ) of
                ( Expression.FunctionOrValue _ name, Just [ "M3e" ] ) ->
                    fact.attrRewrites
                        |> List.filter (\( barrelName, _ ) -> barrelName == name)
                        |> List.head
                        |> Maybe.map
                            (\( _, perCompName ) ->
                                let
                                    compModule =
                                        "M3e." ++ Facts.capitalize fact.component

                                    compModuleParts =
                                        [ "M3e", Facts.capitalize fact.component ]

                                    replacement =
                                        compModule ++ "." ++ perCompName

                                    fixes =
                                        Fix.replaceRangeBy (Node.range setterNode) replacement
                                            :: importFixIfMissing context compModule compModuleParts
                                in
                                Rule.errorWithFix
                                    { message =
                                        "`"
                                            ++ name
                                            ++ "` can be replaced with the per-component setter `"
                                            ++ replacement
                                            ++ "` for tighter type safety"
                                    , details =
                                        [ "The barrel-level setter accepts every component's tokens; the per-component form only accepts "
                                            ++ fact.component
                                            ++ "'s."
                                        ]
                                    }
                                    (Node.range setterNode)
                                    fixes
                            )

                _ ->
                    Nothing

        _ ->
            Nothing


checkSlots : Context -> Fact -> Node Expression -> List (Error {})
checkSlots context fact contentNode =
    let
        trace =
            Facts.tracedList context.lookup context.scope contentNode
    in
    if trace.unresolved then
        []

    else
        List.filterMap (slotErrorFor context fact) trace.known


slotErrorFor : Context -> Fact -> Node Expression -> Maybe (Error {})
slotErrorFor context fact element =
    case Node.value element of
        Expression.Application (setterNode :: setterArgs) ->
            case ( Node.value setterNode, Lookup.moduleNameFor context.lookup setterNode ) of
                ( Expression.FunctionOrValue _ "slot", Just [ "M3e", "Content" ] ) ->
                    case setterArgs of
                        firstArg :: bodyNode :: _ ->
                            case Node.value firstArg of
                                Expression.Literal slotName ->
                                    fact.slotRewrites
                                        |> List.filter (\( k, _ ) -> k == slotName)
                                        |> List.head
                                        |> Maybe.map
                                            (\( _, perCompSetter ) ->
                                                let
                                                    compModule =
                                                        "M3e." ++ Facts.capitalize fact.component

                                                    compModuleParts =
                                                        [ "M3e", Facts.capitalize fact.component ]

                                                    bodySource =
                                                        context.extractSourceCode (Node.range bodyNode)

                                                    replacement =
                                                        compModule ++ "." ++ perCompSetter ++ " (" ++ bodySource ++ ")"

                                                    fixes =
                                                        Fix.replaceRangeBy (Node.range element) replacement
                                                            :: importFixIfMissing context compModule compModuleParts
                                                in
                                                Rule.errorWithFix
                                                    { message =
                                                        "`.slot \""
                                                            ++ slotName
                                                            ++ "\"` can be replaced with the typed setter `"
                                                            ++ compModule
                                                            ++ "."
                                                            ++ perCompSetter
                                                            ++ "`"
                                                    , details =
                                                        [ "The typed setter enforces the slot's kinds at compile time."
                                                        ]
                                                    }
                                                    (Node.range element)
                                                    fixes
                                            )

                                _ ->
                                    Nothing

                        _ ->
                            Nothing

                _ ->
                    Nothing

        _ ->
            Nothing


{-| Upgrade case: a GENERALIZED barrel slot setter used as content of a known
enclosing constructor is promoted to the component-SPECIFIC barrel setter, using
the enclosing component's `slotUpgrades` map (generalized → specific). Example:
`M3e.button [] [ M3e.slotIcon (…) ]` → `M3e.button [] [ M3e.buttonSlotIcon (…) ]`.

Unlike the attr/`.slot` cases this stays entirely within the `M3e` barrel — the
specific setter is a re-export too — so there is no import to insert. A bare
`M3e.slotIcon` outside any known call site is left alone (the component, and thus
the right specific setter, is unknown).

-}
checkSlotUpgrades : Context -> Fact -> Node Expression -> List (Error {})
checkSlotUpgrades context fact contentNode =
    let
        trace =
            Facts.tracedList context.lookup context.scope contentNode
    in
    if trace.unresolved then
        []

    else
        List.filterMap (slotUpgradeErrorFor context fact) trace.known


slotUpgradeErrorFor : Context -> Fact -> Node Expression -> Maybe (Error {})
slotUpgradeErrorFor context fact element =
    case Node.value element of
        Expression.Application (setterNode :: _) ->
            case ( Node.value setterNode, Lookup.moduleNameFor context.lookup setterNode ) of
                ( Expression.FunctionOrValue _ generalized, Just [ "M3e" ] ) ->
                    fact.slotUpgrades
                        |> List.filter (\( g, _ ) -> g == generalized)
                        |> List.head
                        |> Maybe.map
                            (\( _, specific ) ->
                                Rule.errorWithFix
                                    { message =
                                        "`M3e."
                                            ++ generalized
                                            ++ "` can be upgraded to the "
                                            ++ fact.component
                                            ++ "-specific slot `M3e."
                                            ++ specific
                                            ++ "`"
                                    , details =
                                        [ "Inside `M3e."
                                            ++ fact.component
                                            ++ "` the specific setter constrains the slot body to the kinds this component actually accepts, catching mismatched content at compile time."
                                        ]
                                    }
                                    (Node.range setterNode)
                                    [ Fix.replaceRangeBy (Node.range setterNode) ("M3e." ++ specific) ]
                            )

                _ ->
                    Nothing

        _ ->
            Nothing


importFixIfMissing : Context -> String -> List String -> List Fix.Fix
importFixIfMissing context compModule compModuleParts =
    if Set.member compModuleParts context.importedModules then
        []

    else
        [ Fix.insertAt
            { row = context.insertionRow + 1, column = 1 }
            ("import " ++ compModule ++ "\n")
        ]
