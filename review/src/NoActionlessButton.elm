module NoActionlessButton exposing (rule)

{-| Ported to the Vocab API. Reports a button constructor whose attribute list wires no
action (`onClick` / `href` / `toggle`) and doesn't make the inert state explicit
(`disabled` / `disabledInteractive`).

Such a button is fully well-typed yet renders inert — the degenerate state the loose
attribute list permits. This turns it into a review smell instead. Report-only: the
author must choose the right wiring.

Matches both API forms: the barrel `M3e.button [ … ] [ … ]` and the component-module
`M3e.Button.view [ … ] [ … ]`. Only the inline form is analysed (a button stored in a
`let` and viewed elsewhere is out of scope — the documented 90% case).


## Fail

    M3e.button [ variant Value.filled ] [ text "Save" ]


## Success

    M3e.button [ onClick Save ] [ text "Save" ]

    M3e.button [ disabled True ] [ text "Save" ]

-}

import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


rule : Rule
rule =
    Rule.newModuleRuleSchemaUsingContextCreator "NoActionlessButton" initContext
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


type alias Context =
    { lookup : ModuleNameLookupTable }


initContext : Rule.ContextCreator () Context
initContext =
    Rule.initContextCreator (\lookup () -> { lookup = lookup })
        |> Rule.withModuleNameLookupTable


{-| A setter name that either wires an action or makes the inert state explicit. -}
actionSetters : List String
actionSetters =
    [ "onClick", "href", "toggle", "disabled", "disabledInteractive" ]


expressionVisitor : Node Expression -> Context -> ( List (Error {}), Context )
expressionVisitor node context =
    case Node.value node of
        Expression.Application (fnNode :: args) ->
            if isButtonConstructor context fnNode then
                case firstListArg args of
                    Just attrs ->
                        if List.any (isActionSetter attrs) actionSetters then
                            ( [], context )

                        else
                            ( [ error (Node.range fnNode) ], context )

                    Nothing ->
                        ( [], context )

            else
                ( [], context )

        _ ->
            ( [], context )


isButtonConstructor : Context -> Node Expression -> Bool
isButtonConstructor context fnNode =
    case Node.value fnNode of
        Expression.FunctionOrValue _ name ->
            case Lookup.moduleNameFor context.lookup fnNode of
                Just [ "M3e" ] ->
                    name == "button"

                Just [ "M3e", "Button" ] ->
                    name == "view"

                _ ->
                    False

        _ ->
            False


firstListArg : List (Node Expression) -> Maybe (List (Node Expression))
firstListArg args =
    case args of
        first :: rest ->
            case Node.value first of
                Expression.ListExpr elements ->
                    Just elements

                _ ->
                    firstListArg rest

        [] ->
            Nothing


isActionSetter : List (Node Expression) -> String -> Bool
isActionSetter attrs target =
    List.any (\el -> setterName el == Just target) attrs


setterName : Node Expression -> Maybe String
setterName elementNode =
    case Node.value elementNode of
        Expression.Application (setterNode :: _) ->
            case Node.value setterNode of
                Expression.FunctionOrValue _ name ->
                    Just name

                _ ->
                    Nothing

        _ ->
            Nothing


error : { start : { row : Int, column : Int }, end : { row : Int, column : Int } } -> Error {}
error range =
    Rule.error
        { message = "Button has no action and no explicit disabled state"
        , details =
            [ "A button whose attribute list reaches the constructor without onClick, href, or toggle renders a well-typed but inert button — a degenerate state the loose attribute list permits."
            , "Add one of onClick / href / toggle, or make the inert state explicit with disabled / disabledInteractive."
            ]
        }
        range
