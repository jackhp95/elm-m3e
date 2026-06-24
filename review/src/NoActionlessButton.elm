module NoActionlessButton exposing (rule)

{-|

@docs rule

-}

import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node(..))
import Elm.Syntax.Range exposing (Range)
import Review.ModuleNameLookupTable as ModuleNameLookupTable exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


{-| Reports a `Ui.Button.new … |> Ui.Button.view` pipeline that never wires an
action (`withOnClick` / `withHref` / `withToggle`) and never makes the inert
state explicit (`withDisabled`).

Such a button is fully well-typed yet renders inert — the degenerate state the
single-`new`-constructor MISI carve-out deliberately allows at the type level.
This rule turns it into a review smell instead.

Report-only (no automatic fix): the author must choose the right wiring.

Limitation: only the inline-pipeline form is analysed. A button stored in a
`let` and viewed elsewhere is out of scope — that is the documented 90% case.


## Fail

    Ui.Button.new { label = "Save", variant = Ui.Button.Filled }
        |> Ui.Button.view


## Success

    Ui.Button.new { label = "Save", variant = Ui.Button.Filled }
        |> Ui.Button.withOnClick Save
        |> Ui.Button.view

-}
rule : Rule
rule =
    Rule.newModuleRuleSchemaUsingContextCreator "NoActionlessButton" initialContext
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


type alias Context =
    { lookupTable : ModuleNameLookupTable }


initialContext : Rule.ContextCreator () Context
initialContext =
    Rule.initContextCreator (\lookupTable () -> { lookupTable = lookupTable })
        |> Rule.withModuleNameLookupTable


buttonModule : List String
buttonModule =
    [ "Ui", "Button" ]


actionSetters : List String
actionSetters =
    [ "withOnClick", "withHref", "withToggle", "withDisabled" ]


expressionVisitor : Node Expression -> Context -> ( List (Error {}), Context )
expressionVisitor node context =
    if endsInButtonView context node then
        let
            refs : List ( String, Range )
            refs =
                collectButtonRefs context node

            names : List String
            names =
                List.map Tuple.first refs
        in
        if List.member "new" names && not (List.any (\s -> List.member s names) actionSetters) then
            case List.filter (\( name, _ ) -> name == "new") refs of
                ( _, newRange ) :: _ ->
                    ( [ actionlessError newRange ], context )

                [] ->
                    ( [], context )

        else
            ( [], context )

    else
        ( [], context )


{-| Is `node` the outermost expression of a `… |> Ui.Button.view` pipeline (or a
direct `Ui.Button.view <arg>` application)? We only fire on the outermost node
so the spine is collected once.
-}
endsInButtonView : Context -> Node Expression -> Bool
endsInButtonView context node =
    case Node.value node of
        Expression.OperatorApplication "|>" _ _ right ->
            isButtonFn context "view" right

        Expression.Application (fn :: _ :: []) ->
            isButtonFn context "view" fn

        _ ->
            False


{-| Collect every `Ui.Button.<name>` reference (name + range) anywhere in the
expression subtree, so we can inspect the whole pipeline spine at once.
-}
collectButtonRefs : Context -> Node Expression -> List ( String, Range )
collectButtonRefs context node =
    let
        here : List ( String, Range )
        here =
            case Node.value node of
                Expression.FunctionOrValue _ name ->
                    if ModuleNameLookupTable.moduleNameFor context.lookupTable node == Just buttonModule then
                        [ ( name, Node.range node ) ]

                    else
                        []

                _ ->
                    []
    in
    here ++ List.concatMap (collectButtonRefs context) (children node)


isButtonFn : Context -> String -> Node Expression -> Bool
isButtonFn context name node =
    case Node.value node of
        Expression.FunctionOrValue _ n ->
            n == name && ModuleNameLookupTable.moduleNameFor context.lookupTable node == Just buttonModule

        _ ->
            False


{-| Direct sub-expressions of a node — enough to walk pipeline/application
spines and the record/arguments hanging off them.
-}
children : Node Expression -> List (Node Expression)
children node =
    case Node.value node of
        Expression.Application nodes ->
            nodes

        Expression.OperatorApplication _ _ left right ->
            [ left, right ]

        Expression.ParenthesizedExpression inner ->
            [ inner ]

        Expression.TupledExpression nodes ->
            nodes

        Expression.ListExpr nodes ->
            nodes

        Expression.RecordExpr setters ->
            List.map (\(Node _ ( _, value )) -> value) setters

        Expression.RecordUpdateExpression _ setters ->
            List.map (\(Node _ ( _, value )) -> value) setters

        Expression.IfBlock c t e ->
            [ c, t, e ]

        Expression.Negation inner ->
            [ inner ]

        Expression.LetExpression { expression } ->
            [ expression ]

        Expression.CaseExpression { expression, cases } ->
            expression :: List.map Tuple.second cases

        Expression.LambdaExpression { expression } ->
            [ expression ]

        _ ->
            []


actionlessError : Range -> Error {}
actionlessError range =
    Rule.error
        { message = "Button has no action and no explicit disabled state"
        , details =
            [ "A Ui.Button.new pipeline that reaches Ui.Button.view without withOnClick, withHref, or withToggle renders a well-typed but inert button — a degenerate state the type system permits."
            , "Add one of withOnClick / withHref / withToggle, or make the inert state explicit with withDisabled."
            ]
        }
        range
