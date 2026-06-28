module NoMissingFacadeEntry exposing (rule)

{-|

@docs rule

-}

import Elm.Syntax.Import exposing (Import)
import Elm.Syntax.ModuleName exposing (ModuleName)
import Elm.Syntax.Node as Node exposing (Node)
import Review.Rule as Rule exposing (Error, Rule)
import Set exposing (Set)


{-| Every component module `M3e.<Name>` must be re-bound through the top-level
`M3e` facade (epic #52, single-import goal). This rule enforces that the facade
stays complete: when a new component module is added under `src/M3e/`, the
facade must gain a corresponding entry.

The check is at the module-import granularity: the `M3e` facade module must
`import M3e.<Name>` for every component `<Name>`. Importing without using is
already caught by `NoUnused.Variables`, so an import here implies a real
re-binding entry. A few foundational modules are **not** components and are
exempt:

  - `M3e.Attr`, `M3e.Element`, `M3e.Internal`, `M3e.Node`, `M3e.Value`,
    `M3e.Shape`, `M3e.Label` — shared vocabulary / IR / helper-type modules,
    not user-facing components.
  - `M3e.*Test` — the `tests/` suite modules live under the `M3e.` namespace
    too; they are not components.

A violation means a component exists that a `import M3e exposing (..)` user
cannot reach. Add the entry to `src/M3e.elm`.

-}
rule : Rule
rule =
    Rule.newProjectRuleSchema "NoMissingFacadeEntry" initialProjectContext
        |> Rule.withModuleVisitor moduleVisitor
        |> Rule.withModuleContextUsingContextCreator
            { fromProjectToModule = fromProjectToModule
            , fromModuleToProject = fromModuleToProject
            , foldProjectContexts = foldProjectContexts
            }
        |> Rule.withFinalProjectEvaluation finalEvaluation
        |> Rule.fromProjectRuleSchema


{-| Foundational, non-component `M3e.*` modules that need no facade entry.
-}
nonComponentModules : Set String
nonComponentModules =
    Set.fromList [ "Attr", "Element", "Internal", "Node", "Value", "Shape", "Label" ]


type alias ProjectContext =
    { components : Set String
    , facadeImports : Set String
    }


initialProjectContext : ProjectContext
initialProjectContext =
    { components = Set.empty
    , facadeImports = Set.empty
    }


type alias ModuleContext =
    { moduleName : ModuleName
    , facadeImports : Set String
    }


fromProjectToModule : Rule.ContextCreator ProjectContext ModuleContext
fromProjectToModule =
    Rule.initContextCreator
        (\moduleName _ ->
            { moduleName = moduleName
            , facadeImports = Set.empty
            }
        )
        |> Rule.withModuleName


fromModuleToProject : Rule.ContextCreator ModuleContext ProjectContext
fromModuleToProject =
    Rule.initContextCreator
        (\moduleContext ->
            case moduleContext.moduleName of
                [ "M3e" ] ->
                    { components = Set.empty
                    , facadeImports = moduleContext.facadeImports
                    }

                [ "M3e", name ] ->
                    if Set.member name nonComponentModules || String.endsWith "Test" name then
                        initialProjectContext

                    else
                        { components = Set.singleton name
                        , facadeImports = Set.empty
                        }

                _ ->
                    initialProjectContext
        )


foldProjectContexts : ProjectContext -> ProjectContext -> ProjectContext
foldProjectContexts a b =
    { components = Set.union a.components b.components
    , facadeImports = Set.union a.facadeImports b.facadeImports
    }


moduleVisitor : Rule.ModuleRuleSchema schemaState ModuleContext -> Rule.ModuleRuleSchema { schemaState | hasAtLeastOneVisitor : () } ModuleContext
moduleVisitor schema =
    schema
        |> Rule.withImportVisitor importVisitor


importVisitor : Node Import -> ModuleContext -> ( List (Error {}), ModuleContext )
importVisitor node context =
    if context.moduleName /= [ "M3e" ] then
        ( [], context )

    else
        case Node.value (Node.value node).moduleName of
            [ "M3e", name ] ->
                ( [], { context | facadeImports = Set.insert name context.facadeImports } )

            _ ->
                ( [], context )


finalEvaluation : ProjectContext -> List (Error { useErrorForModule : () })
finalEvaluation projectContext =
    let
        missing : List String
        missing =
            Set.diff projectContext.components projectContext.facadeImports
                |> Set.toList
    in
    if List.isEmpty missing then
        []

    else
        [ Rule.globalError
            { message = "Component module(s) missing from the M3e facade"
            , details =
                [ "The top-level `M3e` facade (src/M3e.elm) does not re-bind the following component module(s):"
                , String.join ", " (List.map (\n -> "M3e." ++ n) missing)
                , "A `import M3e exposing (..)` user cannot reach these components. Add an entry to src/M3e.elm that re-binds the component's `view` (or per-variant entry points), and `import M3e.<Name>` there."
                ]
            }
        ]
