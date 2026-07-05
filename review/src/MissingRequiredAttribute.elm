module MissingRequiredAttribute exposing (rule)

{-| D1: flag component calls missing a required HTML attribute.

Reads `requiredAttrs` from the generated facts. For each required attr, checks
that a satisfier is present in the call's attribute list (or, for Record, in
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
import Elm.Syntax.Declaration as Declaration
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Facts
import M3e.Review.Facts exposing (Fact, Surface(..))
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


rule : List Fact -> Rule
rule facts =
    Rule.newModuleRuleSchemaUsingContextCreator "MissingRequiredAttribute" (initContext facts)
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
            ( recordArg, attrsList, contentList ) =
                case site.surface of
                    Standard ->
                        ( Nothing, List.head args, args |> List.drop 1 |> List.head )

                    Record ->
                        case args of
                            record :: attrs :: content :: _ ->
                                ( Just record, Just attrs, Just content )

                            record :: attrs :: _ ->
                                ( Just record, Just attrs, Nothing )

                            _ ->
                                ( Nothing, Nothing, Nothing )

                    _ ->
                        -- Facts.callSite only produces Standard or Record;
                        -- Html/Cem/Build never reach here. Exhaustiveness only.
                        ( Nothing, Nothing, Nothing )

            attrsTrace =
                case attrsList of
                    Just attrsNode ->
                        Facts.tracedList context.lookup context.scope attrsNode

                    Nothing ->
                        { known = [], unresolved = True }

            contentTrace =
                case contentList of
                    Just contentNode ->
                        Facts.tracedList context.lookup context.scope contentNode

                    Nothing ->
                        { known = [], unresolved = False }
        in
        fact.requiredAttrs
            |> List.filterMap (checkOneAttr context site fact recordArg attrsTrace contentTrace fnNode)


checkOneAttr :
    Context
    -> Facts.CallSite
    -> Fact
    -> Maybe (Node Expression)
    -> Facts.TracedList
    -> Facts.TracedList
    -> Node Expression
    -> String
    -> Maybe (Error {})
checkOneAttr context site fact recordArg attrsTrace contentTrace fnNode attrName =
    if
        satisfiedInRecord recordArg attrName
            || satisfiedInAttrs context attrsTrace fact.component attrName
            || satisfiedByLabelSlot context fact contentTrace attrName
    then
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


{-| True when `aria-label` is required but the component's label slot is filled
in the content list. A filled label slot provides the accessible name, making
aria-label redundant.

Detects `("label", setterName)` in `fact.slotRewrites` and then looks for a
call to `M3e.<Comp>.setterName` in the content list.

-}
satisfiedByLabelSlot : Context -> Fact -> Facts.TracedList -> String -> Bool
satisfiedByLabelSlot context fact contentTrace attrName =
    if attrName /= "aria-label" then
        False

    else
        case List.filter (\( slotName, _ ) -> slotName == "label") fact.slotRewrites of
            ( _, labelSetterName ) :: _ ->
                let
                    compModule =
                        [ "M3e", Facts.capitalize fact.component ]

                    isLabelCall element =
                        case Node.value element of
                            Expression.Application (setterNode :: _) ->
                                isCallTo context compModule labelSetterName setterNode

                            Expression.FunctionOrValue _ _ ->
                                -- Bare function reference (partial application, e.g. List.map M3e.Fab.label items)
                                isCallTo context compModule labelSetterName element

                            _ ->
                                False
                in
                List.any isLabelCall contentTrace.known

            [] ->
                False


satisfiedInRecord : Maybe (Node Expression) -> String -> Bool
satisfiedInRecord recordArg attrName =
    case recordArg of
        Just record ->
            case Node.value record of
                Expression.RecordExpr fields ->
                    let
                        fieldName =
                            Facts.camelize attrName
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
                    isCallTo context [ "M3e", Facts.capitalize componentNoun ] (Facts.camelize attrName) setterNode

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
        "M3e." ++ Facts.capitalize componentNoun ++ "." ++ Facts.camelize attrName ++ " \"...\""
