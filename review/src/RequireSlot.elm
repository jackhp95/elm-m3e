module RequireSlot exposing (rule)

{-| Codegen-aware, **advisory** rule (ADR 0011 / 0012): a required slot should be filled.

Required-_singular_ slots live in the constructor's required record (first argument), so
Elm's own record types already enforce their presence — this rule would be redundant
there. The gap it closes is the required-_multi_ slot: a repeatable slot the component
needs at least one of, which lives in the loose content list and is **not** type-enforced.
This flags a constructor whose content list omits a required-multi slot entirely.

The required and multi slot sets come from `M3e.Review.Facts` (generated); their
intersection is the set this rule checks. Advisory: report-only.

@docs rule

-}

import Dict exposing (Dict)
import Elm.Syntax.Declaration as Declaration
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Facts
import M3e.Review.Facts exposing (Fact)
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


{-| Build from the generated facts (`M3e.Review.Facts.facts`).
-}
rule : List Fact -> Rule
rule facts =
    Rule.newModuleRuleSchemaUsingContextCreator "RequireSlot" (initContext (buildIndex facts))
        |> Rule.withDeclarationEnterVisitor declarationEnterVisitor
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


{-| component noun -> content-setter names that must appear at least once (required ∩ multi).
-}
type alias Index =
    Dict String (List String)


buildIndex : List Fact -> Index
buildIndex facts =
    facts
        |> List.map
            (\f ->
                ( f.component
                , f.requiredSlots
                    |> List.filter (\s -> List.member s f.multiSlots)
                    |> List.map (slotSetter f)
                )
            )
        |> List.filter (\( _, required ) -> not (List.isEmpty required))
        |> Dict.fromList


{-| The content-setter name for a slot. Checks slotRewrites first (e.g. "unnamed" -> "child"),
then falls back to camelCase conversion.
-}
slotSetter : Fact -> String -> String
slotSetter fact slot =
    case List.filter (\( from, _ ) -> from == slot) fact.slotRewrites of
        ( _, to ) :: _ ->
            to

        [] ->
            if slot == "default" || slot == "unnamed" then
                "child"

            else
                Facts.camelize slot


type alias Context =
    { lookup : ModuleNameLookupTable
    , index : Index
    , scope : Dict String (Node Expression)
    }


initContext : Index -> Rule.ContextCreator () Context
initContext index =
    Rule.initContextCreator (\lookup () -> { lookup = lookup, index = index, scope = Dict.empty })
        |> Rule.withModuleNameLookupTable


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
                    case Dict.get site.noun context.index of
                        Just required ->
                            ( checkCall context site.noun required (Node.range fnNode) args, context )

                        Nothing ->
                            ( [], context )

                Nothing ->
                    ( [], context )

        _ ->
            ( [], context )


{-| The content is the _last_ argument of a fully-applied constructor.
Uses `Facts.tracedList` to look through dynamic expressions (List.map, concat, etc.).
We only flag when we have enough args (>=2 for Standard, >=3 for Record).
When `unresolved = True` we still check the known setters but stay silent if
there are zero known (we can't distinguish "truly empty" from "all-dynamic").
-}
checkCall : Context -> String -> List String -> { start : { row : Int, column : Int }, end : { row : Int, column : Int } } -> List (Node Expression) -> List (Error {})
checkCall context componentNoun required range args =
    if List.length args >= 2 then
        case List.reverse args of
            last :: _ ->
                let
                    traced =
                        Facts.tracedList context.lookup context.scope last
                in
                if traced.unresolved && List.isEmpty traced.known then
                    -- Truly opaque — stay silent rather than false-positive
                    []

                else
                    let
                        present =
                            List.filterMap (elementSetter context componentNoun) traced.known
                    in
                    required
                        |> List.filter (\name -> not (List.member name present))
                        |> List.map (\name -> error name range)

            [] ->
                []

    else
        []


{-| Extract the setter name from a content-list element, verifying it resolves
to the top-layer `M3e` or `M3e.<Comp>` module so bare names from unrelated
modules don't silence the rule.
-}
elementSetter : Context -> String -> Node Expression -> Maybe String
elementSetter context componentNoun elementNode =
    let
        isTopLayer setterNode name =
            case Lookup.moduleNameFor context.lookup setterNode of
                Just [ "M3e" ] ->
                    Just name

                Just [ "M3e", comp ] ->
                    if comp == Facts.capitalize componentNoun then
                        Just name

                    else
                        Nothing

                _ ->
                    Nothing
    in
    case Node.value elementNode of
        Expression.Application (setterNode :: _) ->
            case Node.value setterNode of
                Expression.FunctionOrValue _ name ->
                    isTopLayer setterNode name

                _ ->
                    Nothing

        Expression.FunctionOrValue _ name ->
            isTopLayer elementNode name

        _ ->
            Nothing


error : String -> { start : { row : Int, column : Int }, end : { row : Int, column : Int } } -> Error {}
error name range =
    Rule.error
        { message = "Required slot `" ++ name ++ "` is not filled"
        , details =
            [ "This component needs at least one `" ++ name ++ "` in its content list, but none is present."
            , "This is a repeatable required slot, so the type system doesn't enforce it — add the missing content."
            ]
        }
        range
