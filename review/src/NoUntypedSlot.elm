module NoUntypedSlot exposing (rule)

{-|

@docs rule

-}

import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.ModuleName exposing (ModuleName)
import Elm.Syntax.Node as Node exposing (Node(..))
import Review.ModuleNameLookupTable as ModuleNameLookupTable exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


{-| Reports raw `Html.Attributes.attribute "slot" "…"` strings inside the
`Ui.*` library, steering callers to the typed `M3e.<Module>.<name>Slot` helpers.

Slot names are strings, so `Attr.attribute "slot" "badge"` on an element that
has no `badge` slot is well-typed and silently drops the content — this is the
exact shape of the 6 CRITICAL spec deltas. The typed `M3e.*.<name>Slot` helpers
make the legal slots of each element discoverable and correct by construction.

This is the v1 rule: it flags _every_ raw slot string except an allowlist of
native slots that genuinely have no typed binding (`label`). It only runs on
modules whose name begins with `Ui` (the public library lives in `src/Ui/`).


## Fail (in a `Ui.*` module)

    Html.span [ Attr.attribute "slot" "badge" ] [ Html.text b ]


## Success

    Html.span [ M3e.NavMenuItem.iconSlot ] [ icon ]

    -- "label" is an allowlisted native slot with no typed binding
    Html.span [ Attr.attribute "slot" "label" ] [ Html.text t ]

-}
rule : Rule
rule =
    Rule.newModuleRuleSchemaUsingContextCreator "NoUntypedSlot" initialContext
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


type alias Context =
    { lookupTable : ModuleNameLookupTable
    , inScope : Bool
    }


initialContext : Rule.ContextCreator () Context
initialContext =
    Rule.initContextCreator
        (\lookupTable moduleName () ->
            { lookupTable = lookupTable
            , inScope = isUiModule moduleName
            }
        )
        |> Rule.withModuleNameLookupTable
        |> Rule.withModuleName


{-| The library's public surface is the `Ui.*` namespace.
-}
isUiModule : ModuleName -> Bool
isUiModule moduleName =
    case moduleName of
        "Ui" :: _ ->
            True

        _ ->
            False


{-| Slot names that have no typed M3e binding and are legitimately set raw.
-}
allowedSlots : List String
allowedSlots =
    [ "label" ]


expressionVisitor : Node Expression -> Context -> ( List (Error {}), Context )
expressionVisitor node context =
    if not context.inScope then
        ( [], context )

    else
        case Node.value node of
            Expression.Application (fn :: nameArg :: valueArg :: []) ->
                if isRawAttribute context fn && literalEquals nameArg "slot" then
                    case literalOf valueArg of
                        Just slotName ->
                            if List.member slotName allowedSlots then
                                ( [], context )

                            else
                                ( [ slotError node ], context )

                        Nothing ->
                            ( [], context )

                else
                    ( [], context )

            _ ->
                ( [], context )


isRawAttribute : Context -> Node Expression -> Bool
isRawAttribute context fn =
    case Node.value fn of
        Expression.FunctionOrValue _ "attribute" ->
            ModuleNameLookupTable.moduleNameFor context.lookupTable fn == Just [ "Html", "Attributes" ]

        _ ->
            False


literalOf : Node Expression -> Maybe String
literalOf node =
    case Node.value node of
        Expression.Literal str ->
            Just str

        _ ->
            Nothing


literalEquals : Node Expression -> String -> Bool
literalEquals node expected =
    literalOf node == Just expected


slotError : Node Expression -> Error {}
slotError node =
    Rule.error
        { message = "Untyped slot string — use the typed M3e.<Module>.<name>Slot helper"
        , details =
            [ "Slot names are strings, so `Attr.attribute \"slot\" \"…\"` is well-typed even when the element has no such slot — the content then silently never renders. This is the shape of the CRITICAL spec deltas."
            , "Set the slot via the typed `M3e.<Module>.<name>Slot` helper. If the slot genuinely has no typed binding, it must be an allowlisted native slot (e.g. \"label\")."
            ]
        }
        (Node.range node)
