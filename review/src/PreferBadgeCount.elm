module PreferBadgeCount exposing (rule)

{-|

@docs rule

-}

import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node(..))
import Elm.Syntax.Range exposing (Range)
import Review.Fix as Fix
import Review.ModuleNameLookupTable as ModuleNameLookupTable exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


{-| Steers `Ui.Badge.label (String.fromInt n)` to `Ui.Badge.count n`.

🔧 Running with `--fix` will automatically fix all the reported errors.

`Ui.Badge.count` applies the Material "999+" truncation (max 4 chars including
the `+`) that `Ui.Badge.label` does not. Passing a stringified `Int` to `label`
is well-typed but silently skips that truncation — a semantic bug the compiler
cannot catch.


## Fail

    view n =
        Ui.Badge.label (String.fromInt n)

    viewB n =
        String.fromInt n |> Ui.Badge.label


## Success

    view n =
        Ui.Badge.count n

    status s =
        Ui.Badge.label s

    label2 n =
        Ui.Badge.label ("v" ++ String.fromInt n)

-}
rule : Rule
rule =
    Rule.newModuleRuleSchemaUsingContextCreator "PreferBadgeCount" initialContext
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


type alias Context =
    { lookupTable : ModuleNameLookupTable
    , extractSource : Range -> String
    }


initialContext : Rule.ContextCreator () Context
initialContext =
    Rule.initContextCreator
        (\lookupTable extractSource () ->
            { lookupTable = lookupTable
            , extractSource = extractSource
            }
        )
        |> Rule.withModuleNameLookupTable
        |> Rule.withSourceCodeExtractor


badgeModule : List String
badgeModule =
    [ "Ui", "Badge" ]


stringModule : List String
stringModule =
    [ "String" ]


expressionVisitor : Node Expression -> Context -> ( List (Error {}), Context )
expressionVisitor node context =
    case detect context node of
        Just { fullRange, labelNode, innerNode } ->
            ( [ makeError context fullRange labelNode innerNode ], context )

        Nothing ->
            ( [], context )


type alias Match =
    { fullRange : Range
    , labelNode : Node Expression
    , innerNode : Node Expression
    }


{-| Strip redundant parentheses so the matchers see the inner expression.
-}
unwrap : Node Expression -> Node Expression
unwrap node =
    case Node.value node of
        Expression.ParenthesizedExpression inner ->
            unwrap inner

        _ ->
            node


{-| Detect the three shapes:

  - `Ui.Badge.label (String.fromInt e)` — `Application [ label, fromIntApp ]`
  - `String.fromInt e |> Ui.Badge.label` — `OperatorApplication "|>" _ fromIntApp label`
  - `Ui.Badge.label (String.fromInt <| e)` — application whose arg is `<|`

-}
detect : Context -> Node Expression -> Maybe Match
detect context node =
    case Node.value node of
        Expression.Application (fn :: arg :: []) ->
            if isBadgeLabel context fn then
                stringFromIntArg context arg
                    |> Maybe.map
                        (\inner ->
                            { fullRange = Node.range node
                            , labelNode = fn
                            , innerNode = inner
                            }
                        )

            else
                Nothing

        Expression.OperatorApplication "|>" _ left right ->
            if isBadgeLabel context right then
                stringFromIntArg context left
                    |> Maybe.map
                        (\inner ->
                            { fullRange = Node.range node
                            , labelNode = right
                            , innerNode = inner
                            }
                        )

            else
                Nothing

        _ ->
            Nothing


{-| Is this expression a reference to `Ui.Badge.label`?
-}
isBadgeLabel : Context -> Node Expression -> Bool
isBadgeLabel context node =
    case Node.value node of
        Expression.FunctionOrValue _ "label" ->
            ModuleNameLookupTable.moduleNameFor context.lookupTable node == Just badgeModule

        _ ->
            False


{-| If the expression is exactly an application of `String.fromInt` to a single
argument (in either the `f x` or `f <| x` shape), return that argument node.

A bare `String.fromInt n` (`Application [ fromInt, n ]`) matches; a composed
string such as `"v" ++ String.fromInt n` does not.

-}
stringFromIntArg : Context -> Node Expression -> Maybe (Node Expression)
stringFromIntArg context rawNode =
    case Node.value (unwrap rawNode) of
        Expression.Application (fn :: arg :: []) ->
            if isStringFromInt context fn then
                Just arg

            else
                Nothing

        Expression.OperatorApplication "<|" _ left right ->
            if isStringFromInt context left then
                Just right

            else
                Nothing

        _ ->
            Nothing


isStringFromInt : Context -> Node Expression -> Bool
isStringFromInt context node =
    case Node.value node of
        Expression.FunctionOrValue _ "fromInt" ->
            ModuleNameLookupTable.moduleNameFor context.lookupTable node == Just stringModule

        _ ->
            False


makeError : Context -> Range -> Node Expression -> Node Expression -> Error {}
makeError context fullRange labelNode innerNode =
    let
        countRef : String
        countRef =
            qualifierOf labelNode ++ "count"

        innerSrc : String
        innerSrc =
            context.extractSource (Node.range innerNode)
    in
    Rule.errorWithFix
        { message = "Prefer Ui.Badge.count over Ui.Badge.label (String.fromInt …)"
        , details =
            [ "Ui.Badge.count applies the Material \"999+\" truncation that Ui.Badge.label does not. A stringified Int passed to label silently skips that truncation."
            , "Replace `Ui.Badge.label (String.fromInt n)` with `Ui.Badge.count n`."
            ]
        }
        fullRange
        [ Fix.replaceRangeBy fullRange (countRef ++ " " ++ innerSrc) ]


{-| The module qualifier as written in source for the `label` reference,
including the trailing dot (e.g. `"Ui.Badge."`, `"B."`, or `""` for an
unqualified import).
-}
qualifierOf : Node Expression -> String
qualifierOf node =
    case Node.value node of
        Expression.FunctionOrValue moduleName _ ->
            case moduleName of
                [] ->
                    ""

                _ ->
                    String.join "." moduleName ++ "."

        _ ->
            ""
