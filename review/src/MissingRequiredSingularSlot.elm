module MissingRequiredSingularSlot exposing (rule)

{-| D2: flag Shape3 calls whose content list omits a required-singular slot.

Shape4 calls are silent (the required record's field is compile-time-enforced).
Advisory posture — silent on unresolved content lists.

@docs rule

-}

import Dict exposing (Dict)
import Elm.Syntax.Declaration as Declaration
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Facts
import M3e.Review.Facts exposing (Fact, Shape(..))
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


rule : List Fact -> Rule
rule facts =
    Rule.newModuleRuleSchemaUsingContextCreator "MissingRequiredSingularSlot" (initContext facts)
        |> Rule.withDeclarationEnterVisitor declarationEnterVisitor
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
                |> Maybe.withDefault (Facts.camelize slotName)

        slotFilled setter =
            List.any (elementIsCall context fact.component setter) contentTrace.known
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
                                    ++ Facts.capitalize fact.component
                                    ++ "."
                                    ++ setter
                                    ++ " <value>` to the content list, or use `M3e.Record."
                                    ++ Facts.capitalize fact.component
                                    ++ ".view` which enforces this at the type level."
                                ]
                            }
                            (Node.range fnNode)
                        )
            )


{-| Check whether a content-list element calls the named setter, verifying it
resolves to the top-layer `M3e` or `M3e.<Comp>` module.
-}
elementIsCall : Context -> String -> String -> Node Expression -> Bool
elementIsCall context componentNoun setter element =
    case Node.value element of
        Expression.Application (setterNode :: _) ->
            case Node.value setterNode of
                Expression.FunctionOrValue _ name ->
                    (name == setter) && isTopLayerModule context setterNode componentNoun

                _ ->
                    False

        _ ->
            False


isTopLayerModule : Context -> Node Expression -> String -> Bool
isTopLayerModule context node componentNoun =
    case Lookup.moduleNameFor context.lookup node of
        Just [ "M3e" ] ->
            True

        Just [ "M3e", comp ] ->
            comp == Facts.capitalize componentNoun

        _ ->
            False
