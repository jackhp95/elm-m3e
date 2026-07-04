module PreferSpecificSlot exposing (rule)

{-| D4: prefer per-component setters over barrel shorthands, with autofix.

Two cases:

  - Attr case: `M3e.<barrelName>` inside a component's attrs list → rewrite to
    `M3e.<Comp>.<perCompName>` using `attrRewrites`.
  - Slot case: `M3e.Cem.Attr.slot "<slotName>" body` in the content list →
    rewrite to `M3e.<Comp>.<setterName> body` using `slotRewrites`.

Import insertion is deferred: the autofix assumes `M3e.<Comp>` is already
imported in the file (the test fixtures all import it explicitly).

@docs rule

-}

import Dict exposing (Dict)
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Elm.Syntax.Range exposing (Range)
import Facts
import M3e.Review.Facts exposing (Fact, Shape(..))
import Review.Fix as Fix
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


{-| Build from the generated facts (`M3e.Review.Facts.facts`).
-}
rule : List Fact -> Rule
rule facts =
    Rule.newModuleRuleSchemaUsingContextCreator "PreferSpecificSlot" (initContext facts)
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


type alias Context =
    { lookup : ModuleNameLookupTable
    , factsIndex : Dict String Fact
    , scope : Dict String (Node Expression)
    , extractSourceCode : Range -> String
    }


initContext : List Fact -> Rule.ContextCreator () Context
initContext facts =
    Rule.initContextCreator
        (\lookup extractSourceCode () ->
            { lookup = lookup
            , factsIndex = Facts.buildIndex facts
            , scope = Dict.empty
            , extractSourceCode = extractSourceCode
            }
        )
        |> Rule.withModuleNameLookupTable
        |> Rule.withSourceCodeExtractor


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
            case site.shape of
                Shape3 ->
                    case args of
                        a :: c :: _ ->
                            ( Just a, Just c )

                        [ a ] ->
                            ( Just a, Nothing )

                        _ ->
                            ( Nothing, Nothing )

                Shape4 ->
                    case args of
                        _ :: a :: c :: _ ->
                            ( Just a, Just c )

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
    in
    attrErrors ++ slotErrors


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
                                        "M3e." ++ capitalize fact.component

                                    replacement =
                                        compModule ++ "." ++ perCompName
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
                                    [ Fix.replaceRangeBy (Node.range setterNode) replacement ]
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
                                                        "M3e." ++ capitalize fact.component

                                                    bodySource =
                                                        context.extractSourceCode (Node.range bodyNode)

                                                    replacement =
                                                        compModule ++ "." ++ perCompSetter ++ " (" ++ bodySource ++ ")"
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
                                                    [ Fix.replaceRangeBy (Node.range element) replacement ]
                                            )

                                _ ->
                                    Nothing

                        _ ->
                            Nothing

                _ ->
                    Nothing

        _ ->
            Nothing


capitalize : String -> String
capitalize s =
    case String.uncons s of
        Just ( c, rest ) ->
            String.cons (Char.toUpper c) rest

        Nothing ->
            s
