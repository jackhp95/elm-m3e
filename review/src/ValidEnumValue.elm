module ValidEnumValue exposing (rule)

{-| Codegen-aware rule (ADR 0012): flag a **loose** enum setter given an `M3e.Value`
token the target component does not accept — e.g. `M3e.button [ variant circular ] …`
(a Button has no `circular` variant). The loose top-layer vocabulary accepts every
component's tokens at the type level on purpose; this rule is the correctness backstop
the types deliberately don't enforce.

Per-component validity comes from `M3e.Review.Facts` (generated from the CEM), injected
into the rule — so it stays correct as `@m3e/web` changes without editing rule logic.

@docs rule

-}

import Dict exposing (Dict)
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import M3e.Review.Facts exposing (Fact)
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


{-| Build the rule from the generated facts (pass `M3e.Review.Facts.facts`). -}
rule : List Fact -> Rule
rule facts =
    Rule.newModuleRuleSchemaUsingContextCreator "ValidEnumValue" (initContext (buildIndex facts))
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


{-| component noun (e.g. "button") -> attr setter name (e.g. "variant") -> valid tokens. -}
type alias Index =
    Dict String (Dict String (List String))


buildIndex : List Fact -> Index
buildIndex facts =
    facts
        |> List.map (\f -> ( f.component, Dict.fromList f.enums ))
        |> Dict.fromList


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
                        Just enums ->
                            ( List.concatMap (checkArg context enums) args, context )

                        Nothing ->
                            ( [], context )

                Nothing ->
                    ( [], context )

        _ ->
            ( [], context )


{-| If `fnNode` is a component constructor, return the component noun. Handles both the
barrel (`M3e.button` → module `["M3e"]`, name `"button"`) and the component module
(`M3e.Button.view` → module `["M3e","Button"]`, name `"view"`). -}
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


{-| Within a constructor argument that is an attribute list, check each enum setter. -}
checkArg : Context -> Dict String (List String) -> Node Expression -> List (Error {})
checkArg context enums argNode =
    case Node.value argNode of
        Expression.ListExpr elements ->
            List.filterMap (checkSetter context enums) elements

        _ ->
            []


{-| An `<enumSetter> <valueToken>` application whose token isn't valid for this
component is the error. -}
checkSetter : Context -> Dict String (List String) -> Node Expression -> Maybe (Error {})
checkSetter context enums elementNode =
    case Node.value elementNode of
        Expression.Application (setterNode :: tokenNode :: _) ->
            case ( setterName setterNode, Dict.get (setterNameString setterNode) enums, valueToken context tokenNode ) of
                ( _, Just validTokens, Just token ) ->
                    if List.member token validTokens then
                        Nothing

                    else
                        Just (error validTokens token (Node.range tokenNode))

                _ ->
                    Nothing

        _ ->
            Nothing


setterName : Node Expression -> Maybe String
setterName n =
    case Node.value n of
        Expression.FunctionOrValue _ name ->
            Just name

        _ ->
            Nothing


setterNameString : Node Expression -> String
setterNameString n =
    Maybe.withDefault "" (setterName n)


{-| The token name a `Value.<token>` (or exposed `<token>`) reference names. -}
valueToken : Context -> Node Expression -> Maybe String
valueToken context tokenNode =
    case Node.value tokenNode of
        Expression.FunctionOrValue _ name ->
            case Lookup.moduleNameFor context.lookup tokenNode of
                Just [ "M3e", "Value" ] ->
                    Just name

                _ ->
                    -- also accept an unqualified token that resolves nowhere useful;
                    -- be conservative and only flag when we resolved it to M3e.Value.
                    Nothing

        _ ->
            Nothing


error : List String -> String -> { start : { row : Int, column : Int }, end : { row : Int, column : Int } } -> Error {}
error validTokens token range =
    Rule.error
        { message = "`" ++ token ++ "` is not a valid value for this component"
        , details =
            [ "This component's enum only accepts: " ++ String.join ", " validTokens ++ "."
            , "The loose top-layer vocabulary lets any token type-check; use one this component actually supports, or the component-module's strict setter (which rejects the wrong token at compile time)."
            ]
        }
        range


decapitalize : String -> String
decapitalize s =
    case String.uncons s of
        Just ( c, rest ) ->
            String.cons (Char.toLower c) rest

        Nothing ->
            s
