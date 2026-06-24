module NoRawAttributeInUi exposing (rule)

{-|

@docs rule

-}

import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.ModuleName exposing (ModuleName)
import Elm.Syntax.Node as Node exposing (Node(..))
import Review.ModuleNameLookupTable as ModuleNameLookupTable exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


{-| Reports raw `Html.Attributes.attribute "<name>" …` strings inside `Ui.*`
that set a **Material structural attribute** for which a typed `M3e.*` binding
exists.

`Html.Attributes.attribute : String -> String -> Attribute msg` accepts any two
strings. A raw structural attribute such as `Attr.attribute "value" …` therefore
duplicates — and can silently drift from, or typo against (the real
`page-index` vs `pageIndex` delta) — the typed `M3e.*` binding the element
reads. The structural attribute names are a curated denylist below; genuine
globals (`aria-*`, `data-*`, `role`, `id`, native input attrs, wrapper-element
attrs) are allowed, and `slot` is handled by `NoUntypedSlot`.

Only runs on modules whose name begins with `Ui`.


## Fail (in a `Ui.*` module)

    Attr.attribute "value" (String.fromFloat v)

    Attr.attribute "selected" "true"


## Success

    M3e.Slider.value v

    Attr.attribute "aria-label" cfg.label

-}
rule : Rule
rule =
    Rule.newModuleRuleSchemaUsingContextCreator "NoRawAttributeInUi" initialContext
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


isUiModule : ModuleName -> Bool
isUiModule moduleName =
    case moduleName of
        "Ui" :: _ ->
            True

        _ ->
            False


{-| Material structural attribute names that always have a typed `M3e.*`
binding and must never be set as raw attribute strings. Drawn from the
spec-deltas (Slider `value`, Stepper `selected`, Search `open`, AppBar `size`,
Paginator `page-index`, etc.).

`slot` is deliberately absent — `NoUntypedSlot` owns it.

-}
structuralAttributes : List String
structuralAttributes =
    [ "value"
    , "selected"
    , "open"
    , "size"
    , "variant"
    , "checked"
    , "page-index"
    , "pageIndex"
    , "href"
    , "disabled"
    , "expanded"
    , "indeterminate"
    ]


expressionVisitor : Node Expression -> Context -> ( List (Error {}), Context )
expressionVisitor node context =
    if not context.inScope then
        ( [], context )

    else
        case Node.value node of
            Expression.Application (fn :: nameArg :: _ :: []) ->
                if isRawAttribute context fn && nameIsStructural nameArg then
                    ( [ rawError node ], context )

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


nameIsStructural : Node Expression -> Bool
nameIsStructural node =
    case Node.value node of
        Expression.Literal name ->
            List.member name structuralAttributes

        _ ->
            False


rawError : Node Expression -> Error {}
rawError node =
    Rule.error
        { message = "Raw attribute string duplicates a typed M3e binding"
        , details =
            [ "`Html.Attributes.attribute` accepts any two strings, so a raw structural attribute can drift from (or typo against) the typed `M3e.*` binding that the underlying element actually reads."
            , "Set this attribute via the typed `M3e.<Module>` binding instead of a raw attribute string."
            ]
        }
        (Node.range node)
