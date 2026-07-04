module MissingRequiredAttribute exposing (rule)

{-| D1: flag component calls missing a required HTML attribute.

Reads `requiredAttrs` from the generated facts. For each required attr, checks
that a satisfier is present in the call's attribute list (or, for Shape4, in
the required record's fields).

Satisfier conventions:
- `aria-*` attrs → `M3e.Aria.<lowerCamel(name)>` (e.g. `aria-label` → `M3e.Aria.label`).
- Other attrs → `M3e.<Comp>.<camelCase(name)>` (per-component setter).
- Universal escape → `M3e.Cem.Attr.attribute "<name>" ...`.

Silent when `tracedList.unresolved = True` and no static satisfier is found.
Advisory posture.

@docs rule

-}

import Dict exposing (Dict)
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Facts
import M3e.Review.Facts as MRF exposing (Fact, Shape(..))
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


rule : List Fact -> Rule
rule facts =
    Rule.newModuleRuleSchemaUsingContextCreator "MissingRequiredAttribute" (initContext facts)
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
                    case Facts.find site.noun context.factsIndex of
                        Just fact ->
                            ( checkCall context site fact fnNode args, context )

                        Nothing ->
                            ( [], context )

                Nothing ->
                    ( [], context )

        _ ->
            ( [], context )


checkCall : Context -> Facts.CallSite -> Fact -> Node Expression -> List (Node Expression) -> List (Error {})
checkCall context site fact fnNode args =
    if List.isEmpty fact.requiredAttrs then
        []

    else
        let
            ( recordArg, attrsList ) =
                case site.shape of
                    Shape3 ->
                        ( Nothing, List.head args )

                    Shape4 ->
                        case args of
                            record :: attrs :: _ ->
                                ( Just record, Just attrs )

                            _ ->
                                ( Nothing, Nothing )

            attrsTrace =
                case attrsList of
                    Just attrsNode ->
                        Facts.tracedList context.lookup context.scope attrsNode

                    Nothing ->
                        { known = [], unresolved = True }
        in
        fact.requiredAttrs
            |> List.filterMap (checkOneAttr context site fact recordArg attrsTrace fnNode)


checkOneAttr :
    Context
    -> Facts.CallSite
    -> Fact
    -> Maybe (Node Expression)
    -> Facts.TracedList
    -> Node Expression
    -> String
    -> Maybe (Error {})
checkOneAttr context site fact recordArg attrsTrace fnNode attrName =
    if satisfiedInRecord recordArg attrName || satisfiedInAttrs context attrsTrace fact.component attrName then
        Nothing

    else if attrsTrace.unresolved then
        -- Can't verify — silent per advisory posture.
        Nothing

    else
        Just
            (Rule.error
                { message =
                    "Component `"
                        ++ fact.component
                        ++ "` requires attribute `"
                        ++ attrName
                        ++ "` but this call doesn't provide it"
                , details =
                    [ "The Material 3 spec (and accessibility guidance) treats `"
                        ++ attrName
                        ++ "` as required for "
                        ++ fact.component
                        ++ "."
                    , "Add `" ++ satisfierHint attrName fact.component ++ "` to the attrs list."
                    ]
                }
                (Node.range fnNode)
            )


satisfiedInRecord : Maybe (Node Expression) -> String -> Bool
satisfiedInRecord recordArg attrName =
    case recordArg of
        Just record ->
            case Node.value record of
                Expression.RecordExpr fields ->
                    let
                        fieldName =
                            camelize attrName
                    in
                    List.any
                        (\field ->
                            case Node.value field of
                                ( name, _ ) ->
                                    Node.value name == fieldName
                        )
                        fields

                _ ->
                    False

        Nothing ->
            False


satisfiedInAttrs : Context -> Facts.TracedList -> String -> String -> Bool
satisfiedInAttrs context attrsTrace componentNoun attrName =
    List.any (attrElementSatisfies context componentNoun attrName) attrsTrace.known


attrElementSatisfies : Context -> String -> String -> Node Expression -> Bool
attrElementSatisfies context componentNoun attrName element =
    case Node.value element of
        Expression.Application (setterNode :: setterArgs) ->
            let
                canonicalAriaSatisfier =
                    if String.startsWith "aria-" attrName then
                        isCallTo context [ "M3e", "Aria" ] (String.dropLeft 5 attrName) setterNode

                    else
                        False

                perComponentSatisfier =
                    isCallTo context [ "M3e", capitalize componentNoun ] (camelize attrName) setterNode

                rawAttributeSatisfier =
                    case ( isCallTo context [ "M3e", "Cem", "Attr" ] "attribute" setterNode, setterArgs ) of
                        ( True, arg0 :: _ ) ->
                            case Node.value arg0 of
                                Expression.Literal literal ->
                                    literal == attrName

                                _ ->
                                    False

                        _ ->
                            False
            in
            canonicalAriaSatisfier || perComponentSatisfier || rawAttributeSatisfier

        _ ->
            False


isCallTo : Context -> List String -> String -> Node Expression -> Bool
isCallTo context expectedModule expectedName setterNode =
    case Node.value setterNode of
        Expression.FunctionOrValue _ name ->
            (name == expectedName)
                && (Lookup.moduleNameFor context.lookup setterNode == Just expectedModule)

        _ ->
            False


satisfierHint : String -> String -> String
satisfierHint attrName componentNoun =
    if String.startsWith "aria-" attrName then
        "M3e.Aria." ++ String.dropLeft 5 attrName ++ " \"...\""

    else
        "M3e." ++ capitalize componentNoun ++ "." ++ camelize attrName ++ " \"...\""


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
