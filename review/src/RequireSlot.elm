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
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import M3e.Review.Facts exposing (Fact)
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


{-| Build from the generated facts (`M3e.Review.Facts.facts`). -}
rule : List Fact -> Rule
rule facts =
    Rule.newModuleRuleSchemaUsingContextCreator "RequireSlot" (initContext (buildIndex facts))
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


{-| component noun -> content-setter names that must appear at least once (required ∩ multi). -}
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
                    |> List.map slotSetter
                )
            )
        |> List.filter (\( _, required ) -> not (List.isEmpty required))
        |> Dict.fromList


slotSetter : String -> String
slotSetter slot =
    if slot == "default" then
        "child"

    else
        camelize slot


type alias Context =
    { lookup : ModuleNameLookupTable, index : Index }


initContext : Index -> Rule.ContextCreator () Context
initContext index =
    Rule.initContextCreator (\lookup () -> { lookup = lookup, index = index })
        |> Rule.withModuleNameLookupTable


expressionVisitor : Node Expression -> Context -> ( List (Error {}), Context )
expressionVisitor node context =
    case Node.value node of
        Expression.Application (fnNode :: args) ->
            case constructorNoun context fnNode of
                Just noun ->
                    case Dict.get noun context.index of
                        Just required ->
                            ( checkCall required (Node.range fnNode) args, context )

                        Nothing ->
                            ( [], context )

                Nothing ->
                    ( [], context )

        _ ->
            ( [], context )


{-| The content list is the *last* list argument (present only when the constructor takes
two lists, `view [attrs] [content]`); flag required setters absent from it. -}
checkCall : List String -> { start : { row : Int, column : Int }, end : { row : Int, column : Int } } -> List (Node Expression) -> List (Error {})
checkCall required range args =
    let
        present =
            contentList args
                |> List.filterMap elementSetter
    in
    required
        |> List.filter (\name -> not (List.member name present))
        |> List.map (\name -> error name range)


contentList : List (Node Expression) -> List (Node Expression)
contentList args =
    case List.filter isListExpr args of
        _ :: rest ->
            case List.reverse rest of
                last :: _ ->
                    listElements last

                [] ->
                    []

        [] ->
            []


isListExpr : Node Expression -> Bool
isListExpr node =
    case Node.value node of
        Expression.ListExpr _ ->
            True

        _ ->
            False


listElements : Node Expression -> List (Node Expression)
listElements node =
    case Node.value node of
        Expression.ListExpr elements ->
            elements

        _ ->
            []


elementSetter : Node Expression -> Maybe String
elementSetter elementNode =
    case Node.value elementNode of
        Expression.Application (setterNode :: _) ->
            case Node.value setterNode of
                Expression.FunctionOrValue _ name ->
                    Just name

                _ ->
                    Nothing

        _ ->
            Nothing


constructorNoun : Context -> Node Expression -> Maybe String
constructorNoun context fnNode =
    case Node.value fnNode of
        Expression.FunctionOrValue _ name ->
            case Lookup.moduleNameFor context.lookup fnNode of
                Just [ "M3e" ] ->
                    Just name

                Just [ "M3e", comp ] ->
                    if name == "view" then
                        Just (decapitalize comp)

                    else
                        Nothing

                _ ->
                    Nothing

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


camelize : String -> String
camelize s =
    case String.split "-" s of
        [] ->
            s

        first :: rest ->
            first ++ String.concat (List.map capitalize rest)


capitalize : String -> String
capitalize s =
    case String.uncons s of
        Just ( c, rest ) ->
            String.cons (Char.toUpper c) rest

        Nothing ->
            s


decapitalize : String -> String
decapitalize s =
    case String.uncons s of
        Just ( c, rest ) ->
            String.cons (Char.toLower c) rest

        Nothing ->
            s
