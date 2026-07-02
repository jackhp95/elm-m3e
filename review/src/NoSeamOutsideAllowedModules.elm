module NoSeamOutsideAllowedModules exposing (rule)

{-| Generalized **seam gate** (successor to the Ui-era `NoRawLayoutOutsideLayoutModule`).

The `Seam` and `EscapeHatch` modules are the sanctioned holes in the type system: they
turn raw `Html` into a `Node`/`Element`/`Attr` (`Seam`) or coerce a well-typed value to a
different capability row (`EscapeHatch`). They exist so the seam between typed M3e and raw
Elm html is *possible* — but each use throws away a guarantee, so a codebase usually wants
them **contained** to a few blessed modules (a `Native`/`Layout`-style adapter layer)
rather than sprinkled through feature code.

This rule flags any reference to a `Seam.*` or `EscapeHatch.*` function from a module not
in the configured allow-list. Point-free uses (`List.map Seam.asElement`) are caught too.

    config =
        [ NoSeamOutsideAllowedModules.rule [ "Native", "Layout", "Kit" ] ]

Allow-list entries are dotted module names (`"Ui.Layout"`). An empty list gates the seam
everywhere.

@docs rule

-}

import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.ModuleName exposing (ModuleName)
import Elm.Syntax.Node as Node exposing (Node)
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


{-| Build the gate from the list of modules allowed to use the seam (dotted names). -}
rule : List String -> Rule
rule allowed =
    Rule.newModuleRuleSchemaUsingContextCreator "NoSeamOutsideAllowedModules" (initContext allowed)
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


type alias Context =
    { lookup : ModuleNameLookupTable
    , gated : Bool
    }


initContext : List String -> Rule.ContextCreator () Context
initContext allowed =
    Rule.initContextCreator
        (\lookup moduleName () ->
            { lookup = lookup
            , gated = not (List.member (String.join "." moduleName) allowed)
            }
        )
        |> Rule.withModuleNameLookupTable
        |> Rule.withModuleName


{-| The modules whose functions are considered seams. -}
seamModules : List ModuleName
seamModules =
    [ [ "Seam" ], [ "EscapeHatch" ] ]


expressionVisitor : Node Expression -> Context -> ( List (Error {}), Context )
expressionVisitor node context =
    if not context.gated then
        ( [], context )

    else
        case Node.value node of
            Expression.FunctionOrValue _ name ->
                case Lookup.moduleNameFor context.lookup node of
                    Just moduleName ->
                        if List.member moduleName seamModules then
                            ( [ error moduleName name (Node.range node) ], context )

                        else
                            ( [], context )

                    Nothing ->
                        ( [], context )

            _ ->
                ( [], context )


error : ModuleName -> String -> { start : { row : Int, column : Int }, end : { row : Int, column : Int } } -> Error {}
error moduleName name range =
    let
        qualified =
            String.join "." moduleName ++ "." ++ name
    in
    Rule.error
        { message = "`" ++ qualified ++ "` used outside an allowed module"
        , details =
            [ "`" ++ qualified ++ "` is a seam that discards a type guarantee — it should be contained to the adapter modules in this rule's allow-list, not used in feature code."
            , "Move this into an allowed module (a Native/Layout-style layer), or reach for a typed M3e API that doesn't need the escape hatch."
            ]
        }
        range
