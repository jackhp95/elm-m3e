module NoRawLayoutOutsideLayoutModule exposing (rule)

{-|

@docs rule

-}

import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.ModuleName exposing (ModuleName)
import Elm.Syntax.Node as Node exposing (Node(..))
import Review.ModuleNameLookupTable as ModuleNameLookupTable exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


{-| Reports `Node.element "div"|"section"|"span"|"nav"|"ul"|"li" [ Node.rawAttr (class …) ] …`
in `docs/app/` modules (`Route.*`, `Shared`, `ErrorPage`).

Those calls are equivalent to `Layout.div "…" […]` (or the relevant tag helper)
and should be migrated to the `Layout` module so that layout intent is always
named rather than inlined. The only call site allowed to create raw layout
elements is `Layout` itself.

The rule fires when **all four** of the following hold:

1.  The called function is `M3e.Node.element`.
2.  The tag argument is one of `"div"`, `"section"`, `"span"`, `"nav"`, `"ul"`, `"li"`.
3.  The attribute list has **exactly one** entry, and that entry is
    `M3e.Node.rawAttr (Html.Attributes.class …)`.
4.  The module is in scope (`Route.*`, `Shared`, or `ErrorPage`).

Multi-attribute elements, zero-attribute elements, and elements using
`Node.attribute "class" "…"` are all left alone.


## Fail (in `Route.*`, `Shared`, or `ErrorPage`)

    Node.element "div" [ Node.rawAttr (class "flex gap-4") ] kids

    Node.element "section" [ Node.rawAttr (class "space-y-4") ] kids


## Success

    -- Named preset (exactly right)
    Layout.row kids

    -- Exact-class escape
    Layout.div "flex gap-4" kids

    -- Multiple attributes — cannot use Layout helper
    Node.element "div" [ Node.rawAttr (class "flex"), Node.rawAttr (id "foo") ] kids

    -- No class attribute — cannot use Layout helper
    Node.element "div" [] kids

    -- Non-layout tag — not in scope
    Node.element "button" [ Node.rawAttr (class "btn") ] kids

    -- Layout module itself — allowed to create raw elements
    Node.element "div" [ Node.rawAttr (Attr.class cls) ] children

-}
rule : Rule
rule =
    Rule.newModuleRuleSchemaUsingContextCreator "NoRawLayoutOutsideLayoutModule" initialContext
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
            , inScope = isDocsAppModule moduleName
            }
        )
        |> Rule.withModuleNameLookupTable
        |> Rule.withModuleName


isDocsAppModule : ModuleName -> Bool
isDocsAppModule moduleName =
    case moduleName of
        "Route" :: _ ->
            True

        [ "Shared" ] ->
            True

        [ "ErrorPage" ] ->
            True

        _ ->
            False


layoutTags : List String
layoutTags =
    [ "div", "section", "span", "nav", "ul", "li" ]


expressionVisitor : Node Expression -> Context -> ( List (Error {}), Context )
expressionVisitor node context =
    if not context.inScope then
        ( [], context )

    else
        case Node.value node of
            Expression.Application (fn :: tagNode :: attrsNode :: _ :: []) ->
                if
                    isNodeElement context fn
                        && isLayoutTag tagNode
                        && isSingleRawClassAttr context attrsNode
                then
                    ( [ layoutError node ], context )

                else
                    ( [], context )

            _ ->
                ( [], context )


isNodeElement : Context -> Node Expression -> Bool
isNodeElement context fn =
    case Node.value fn of
        Expression.FunctionOrValue _ "element" ->
            ModuleNameLookupTable.moduleNameFor context.lookupTable fn == Just [ "M3e", "Node" ]

        _ ->
            False


isLayoutTag : Node Expression -> Bool
isLayoutTag node =
    case Node.value node of
        Expression.Literal tag ->
            List.member tag layoutTags

        _ ->
            False


isSingleRawClassAttr : Context -> Node Expression -> Bool
isSingleRawClassAttr context node =
    case Node.value node of
        Expression.ListExpr [ singleAttr ] ->
            isRawClassAttr context singleAttr

        _ ->
            False


isRawClassAttr : Context -> Node Expression -> Bool
isRawClassAttr context node =
    case Node.value node of
        Expression.Application (rawAttrFn :: innerNode :: []) ->
            isNodeRawAttr context rawAttrFn && isClassCall context innerNode

        _ ->
            False


isNodeRawAttr : Context -> Node Expression -> Bool
isNodeRawAttr context fn =
    case Node.value fn of
        Expression.FunctionOrValue _ "rawAttr" ->
            ModuleNameLookupTable.moduleNameFor context.lookupTable fn == Just [ "M3e", "Node" ]

        _ ->
            False


{-| Recognise `(class EXPR)` regardless of whether the `class` application is
parenthesised (the common form `rawAttr (class "…")`) or bare.

The `ModuleNameLookupTable` resolves both `class` (when exposed via
`Html.Attributes exposing (class)`) and `Attr.class` (qualified) to
`[ "Html", "Attributes" ]`, so both import styles are caught.

-}
isClassCall : Context -> Node Expression -> Bool
isClassCall context node =
    case Node.value node of
        Expression.Application (classFn :: _ :: []) ->
            isHtmlAttributesClass context classFn

        Expression.ParenthesizedExpression inner ->
            isClassCall context inner

        _ ->
            False


isHtmlAttributesClass : Context -> Node Expression -> Bool
isHtmlAttributesClass context fn =
    case Node.value fn of
        Expression.FunctionOrValue _ "class" ->
            ModuleNameLookupTable.moduleNameFor context.lookupTable fn == Just [ "Html", "Attributes" ]

        _ ->
            False


layoutError : Node Expression -> Error {}
layoutError node =
    Rule.error
        { message = "Hand-rolled layout element — use Layout module instead"
        , details =
            [ "This `Node.element` call uses one of the layout tags (div, section, span, nav, ul, li) with a single class attribute."
            , "Replace it with the equivalent `Layout.*` helper from `docs/src/Layout.elm`. Use a named preset when the class string matches exactly, or `Layout.div` / `Layout.section` / `Layout.span` / … for an exact-class escape."
            ]
        }
        (Node.range node)
