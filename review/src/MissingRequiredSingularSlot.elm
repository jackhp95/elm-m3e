module MissingRequiredSingularSlot exposing (rule)

{-| D2: flag Shape3 calls whose content list omits a required-singular slot.

Shape4 calls are silent (the required record's field is compile-time-enforced).
Advisory posture — silent on unresolved content lists.

@docs rule

-}

import Dict exposing (Dict)
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Facts
import M3e.Review.Facts exposing (Fact, Shape(..))
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


rule : List Fact -> Rule
rule facts =
    Rule.newModuleRuleSchemaUsingContextCreator "MissingRequiredSingularSlot" (initContext facts)
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


type alias Context =
    { lookup : ModuleNameLookupTable
    , factsIndex : Dict String Fact
    , scope : Dict String (Node Expression)
    }


initContext : List Fact -> Rule.ContextCreator () Context
initContext facts =
    Rule.initContextCreator
        (\lookup () ->
            { lookup = lookup
            , factsIndex = Facts.buildIndex facts
            , scope = Dict.empty
            }
        )
        |> Rule.withModuleNameLookupTable


expressionVisitor : Node Expression -> Context -> ( List (Error {}), Context )
expressionVisitor node context =
    case Node.value node of
        Expression.Application (fnNode :: args) ->
            case Facts.callSite context.lookup fnNode of
                Just site ->
                    if site.shape /= Shape3 then
                        ( [], context )

                    else
                        case Facts.find site.noun context.factsIndex of
                            Just fact ->
                                ( checkCall context fact fnNode args, context )

                            Nothing ->
                                ( [], context )

                Nothing ->
                    ( [], context )

        _ ->
            ( [], context )


checkCall : Context -> Fact -> Node Expression -> List (Node Expression) -> List (Error {})
checkCall context fact fnNode args =
    let
        requiredSingular =
            fact.requiredSlots
                |> List.filter (\s -> not (List.member s fact.multiSlots))

        contentTrace =
            case List.reverse args |> List.head of
                Just contentNode ->
                    Facts.tracedList context.lookup context.scope contentNode

                Nothing ->
                    { known = [], unresolved = True }

        setterForSlot slotName =
            fact.slotRewrites
                |> List.filter (\( k, _ ) -> k == slotName)
                |> List.head
                |> Maybe.map Tuple.second
                |> Maybe.withDefault (camelize slotName)

        slotFilled setter =
            List.any (elementIsCall setter) contentTrace.known
    in
    requiredSingular
        |> List.filterMap
            (\slotName ->
                let
                    setter =
                        setterForSlot slotName
                in
                if contentTrace.unresolved then
                    Nothing

                else if slotFilled setter then
                    Nothing

                else
                    Just
                        (Rule.error
                            { message =
                                "Component `"
                                    ++ fact.component
                                    ++ "` requires content slot `"
                                    ++ slotName
                                    ++ "` but the content list doesn't fill it"
                            , details =
                                [ "Add `M3e."
                                    ++ capitalize fact.component
                                    ++ "."
                                    ++ setter
                                    ++ " <value>` to the content list, or use `M3e.Record."
                                    ++ capitalize fact.component
                                    ++ ".view` which enforces this at the type level."
                                ]
                            }
                            (Node.range fnNode)
                        )
            )


elementIsCall : String -> Node Expression -> Bool
elementIsCall setter element =
    case Node.value element of
        Expression.Application (setterNode :: _) ->
            case Node.value setterNode of
                Expression.FunctionOrValue _ name ->
                    name == setter

                _ ->
                    False

        _ ->
            False


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
