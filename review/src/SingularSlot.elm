module SingularSlot exposing (rule)

{-| Codegen-aware, **advisory** rule (ADR 0011 / 0012): a singular slot should be filled
at most once. In the double-list top shape, nothing stops a caller passing two
`trailing` items to a slot that renders only one — the extra silently wins or is
dropped. This flags a content-slot setter used 2+ times on one constructor when that
slot is **not** in the component's multi (repeatable) set.

Multi-slot names come from `M3e.Review.Facts` (generated); everything not listed multi
is treated as singular. Advisory: report-only.

@docs rule

-}

import Dict exposing (Dict)
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import M3e.Review.Facts exposing (Fact)
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


{-| Build from the generated facts (`M3e.Review.Facts.facts`).
-}
rule : List Fact -> Rule
rule facts =
    Rule.newModuleRuleSchemaUsingContextCreator "SingularSlot" (initContext (buildIndex facts))
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


{-| component noun -> set of setter names that MAY repeat (the multi slots, camelCased).
-}
type alias Index =
    Dict String (List String)


buildIndex : List Fact -> Index
buildIndex facts =
    facts
        |> List.map (\f -> ( f.component, List.map slotSetter f.multiSlots ))
        |> Dict.fromList


{-| The content-setter name for a slot: the default slot's setter is `child`/`children`;
a named slot's setter is its camelCased name (e.g. `trailing-icon` -> `trailingIcon`).
-}
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
                        Just multi ->
                            case contentElements args of
                                Just elements ->
                                    ( checkArg multi elements, context )

                                Nothing ->
                                    ( [], context )

                        Nothing ->
                            ( [], context )

                Nothing ->
                    ( [], context )

        _ ->
            ( [], context )


{-| The content is the _last_ argument of a fully-applied constructor (`view [attrs]
[content]`). We only analyze it when it's a **list literal**: a void component
(`img [attrs]`, one arg) has no content, and dynamically-built content (`List.map …`)
can't be seen into — in both cases we stay silent rather than mistake attrs (or nothing)
for repeated slots.
-}
contentElements : List (Node Expression) -> Maybe (List (Node Expression))
contentElements args =
    if List.length args >= 2 then
        case List.reverse args of
            last :: _ ->
                case Node.value last of
                    Expression.ListExpr elements ->
                        Just elements

                    _ ->
                        Nothing

            [] ->
                Nothing

    else
        Nothing


{-| Flag any singular setter that appears more than once in the content list.
-}
checkArg : List String -> List (Node Expression) -> List (Error {})
checkArg multi elements =
    let
        setters =
            List.filterMap elementSetter elements

        repeated =
            setters
                |> List.filter (\( name, _ ) -> countBy name setters > 1)
                |> List.filter (\( name, _ ) -> not (List.member name multi))
    in
    -- report each repeated singular setter once (dedupe by name via a fold)
    repeated
        |> dedupeByName
        |> List.map (\( name, range ) -> error name range)


elementSetter : Node Expression -> Maybe ( String, { start : { row : Int, column : Int }, end : { row : Int, column : Int } } )
elementSetter elementNode =
    case Node.value elementNode of
        Expression.Application (setterNode :: _) ->
            case Node.value setterNode of
                Expression.FunctionOrValue _ name ->
                    Just ( name, Node.range elementNode )

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
        { message = "Singular slot `" ++ name ++ "` is filled more than once"
        , details =
            [ "This slot renders a single element, but it's set multiple times here — the extra will silently win or be dropped."
            , "Keep one, or (if this component genuinely repeats the slot) it should be in the multi set — check the component's slot config."
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
