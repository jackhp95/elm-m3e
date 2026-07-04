module SingularAttribute exposing (rule)

{-| D3 (attribute half): flag a call whose attrs list sets the same attribute
setter more than once. HTML attributes can hold only one value; a repeated
attr is a bug (the browser keeps one at random).

Mirrors `SingularSlot` for the content half. No multi-attributes are supported
today — every duplicate is flagged.

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
    Rule.newModuleRuleSchemaUsingContextCreator "SingularAttribute" (initContext facts)
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
                    let
                        attrsList =
                            case site.shape of
                                Shape3 ->
                                    List.head args

                                Shape4 ->
                                    case args of
                                        _ :: attrs :: _ ->
                                            Just attrs

                                        _ ->
                                            Nothing

                        attrsTrace =
                            case attrsList of
                                Just node_ ->
                                    Facts.tracedList context.lookup context.scope node_

                                Nothing ->
                                    { known = [], unresolved = True }
                    in
                    ( checkAttrs attrsTrace, context )

                Nothing ->
                    ( [], context )

        _ ->
            ( [], context )


checkAttrs : Facts.TracedList -> List (Error {})
checkAttrs trace =
    if trace.unresolved then
        []

    else
        let
            setters =
                trace.known |> List.filterMap elementSetter
        in
        setters
            |> List.filter (\( name, _ ) -> countBy name setters > 1)
            |> dedupeByName
            |> List.map (\( name, range ) -> error name range)


elementSetter :
    Node Expression
    -> Maybe ( String, { start : { row : Int, column : Int }, end : { row : Int, column : Int } } )
elementSetter element =
    case Node.value element of
        Expression.Application (setterNode :: _) ->
            case Node.value setterNode of
                Expression.FunctionOrValue _ name ->
                    Just ( name, Node.range setterNode )

                _ ->
                    Nothing

        _ ->
            Nothing


countBy : String -> List ( String, a ) -> Int
countBy name =
    List.filter (\( n, _ ) -> n == name) >> List.length


dedupeByName : List ( String, a ) -> List ( String, a )
dedupeByName =
    List.foldl
        (\(( name, _ ) as item) acc ->
            if List.any (\( n, _ ) -> n == name) acc then
                acc

            else
                acc ++ [ item ]
        )
        []


error :
    String
    -> { start : { row : Int, column : Int }, end : { row : Int, column : Int } }
    -> Error {}
error name range =
    Rule.error
        { message = "Attribute `" ++ name ++ "` is set more than once on this call"
        , details =
            [ "HTML allows only one value per attribute; the browser will silently keep one and discard the others."
            , "Merge or delete the extras."
            ]
        }
        range
