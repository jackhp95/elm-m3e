module PreferBarrel exposing (rule, ruleWith)

{-| Opt-in autofix: rewrite the strict Standard per-component surface
(`M3e.<Comp>.*`) to the flat `M3e` barrel, driven by `M3e.Review.Facts`.

This is the exact inverse of `PreferSpecificSlot` (barrel → per-component). It is
NOT part of the shipped `ReviewConfig`; it exists so the docs harness (and any
consumer who prefers a single flat import) can barrelise a Standard example with
`elm-review --fix`.

Four rewrite classes, all resolved through the `ModuleNameLookupTable` so only the
genuine `M3e.<Comp>.*` / `M3e.Value.*` surfaces are touched — never `M3e.Cem.*`,
`M3e.Record.*`, `M3e.Build.*`, `M3e.Cem.Html.*`, or `M3e.Aria`:

  - Constructor: `M3e.<Comp>.view` → `M3e.<noun>` (the barrel constructor).
  - Attr: `M3e.<Comp>.<attr>` → `M3e.<barrelAttr>` via `attrRewrites` (the
    barrel↔per-component map, read right-to-left here).
  - Slot: `M3e.<Comp>.<setter>` → `M3e.<generalizedSlot>` via the parallel
    `slotRewrites`/`slotUpgrades` pair (per-component setter → generalized barrel
    slot, e.g. `M3e.Button.child` → `M3e.slotDefault`).
  - Value token: `M3e.Value.<token>` → `M3e.<token>` — but ONLY for tokens the
    barrel actually re-exposes. The current barrel re-exposes NONE (every value
    token would collide with a same-named boolean attr, e.g. `M3e.filled`), so the
    production `rule` is inert for this class; `ruleWith` injects a re-expose set
    for tests and for a future barrel that surfaces non-colliding tokens.

@docs rule, ruleWith

-}

import Char
import Dict exposing (Dict)
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import M3e.Review.Facts exposing (Fact)
import Review.Fix as Fix
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)
import Set exposing (Set)


{-| Build from the generated facts (`M3e.Review.Facts.facts`). No value tokens are
re-exposed by the current barrel, so the `M3e.Value.*` class never fires.
-}
rule : List Fact -> Rule
rule facts =
    ruleWith Set.empty facts


{-| Like `rule`, but with an explicit set of `M3e.Value` token names the barrel
re-exposes under `M3e` (enabling the `M3e.Value.<token>` → `M3e.<token>` class).
Used by the tests to pin that class, and by any library whose barrel does surface
non-colliding tokens.
-}
ruleWith : Set String -> List Fact -> Rule
ruleWith reExposedValues facts =
    Rule.newModuleRuleSchemaUsingContextCreator "PreferBarrel" (initContext reExposedValues facts)
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


type alias Context =
    { lookup : ModuleNameLookupTable
    , byModule : Dict String Fact
    , reExposedValues : Set String
    }


initContext : Set String -> List Fact -> Rule.ContextCreator () Context
initContext reExposedValues facts =
    Rule.initContextCreator
        (\lookup () ->
            { lookup = lookup
            , byModule =
                facts
                    |> List.map (\f -> ( f.module_, f ))
                    |> Dict.fromList
            , reExposedValues = reExposedValues
            }
        )
        |> Rule.withModuleNameLookupTable


expressionVisitor : Node Expression -> Context -> ( List (Error {}), Context )
expressionVisitor node context =
    case Node.value node of
        -- An enum setter applied to a LITERAL token — `M3e.<Comp>.<enumAttr>
        -- M3e.Value.<tok>` — collapses to the single portmanteau constant
        -- `M3e.<enumAttr><Tok>` (`variantFilled`). A DYNAMIC arg (a bare variable /
        -- computed expression) has no static value to fold, so it is left
        -- per-component. Handled at the Application node so the whole call is
        -- replaced in one fix.
        Expression.Application (fnNode :: argNode :: []) ->
            case portmanteauCollapse context fnNode argNode of
                Just err ->
                    ( [ err ], context )

                Nothing ->
                    ( [], context )

        Expression.FunctionOrValue _ name ->
            case Lookup.moduleNameFor context.lookup node of
                Just moduleParts ->
                    ( errorsFor context node name moduleParts, context )

                Nothing ->
                    ( [], context )

        _ ->
            ( [], context )


{-| If `fnNode` resolves to a component's enum setter (`M3e.<Comp>.<enumAttr>`) and
`argNode` resolves to one of that enum's valid tokens (`M3e.Value.<tok>`), fold the
whole application to the barrel portmanteau `M3e.<enumAttr><Tok>`.
-}
portmanteauCollapse : Context -> Node Expression -> Node Expression -> Maybe (Error {})
portmanteauCollapse context fnNode argNode =
    case ( Node.value fnNode, Node.value (unwrapParens argNode) ) of
        ( Expression.FunctionOrValue _ attrName, Expression.FunctionOrValue _ tokenName ) ->
            case ( Lookup.moduleNameFor context.lookup fnNode, Lookup.moduleNameFor context.lookup (unwrapParens argNode) ) of
                ( Just fnModule, Just [ "M3e", "Value" ] ) ->
                    Dict.get (String.join "." fnModule) context.byModule
                        |> Maybe.andThen (\fact -> portmanteauName fact attrName tokenName)
                        |> Maybe.map
                            (\portmanteau ->
                                barrelError (applicationNode fnNode argNode)
                                    (String.join "." fnModule ++ "." ++ attrName ++ " M3e.Value." ++ tokenName)
                                    ("M3e." ++ portmanteau)
                                    "enum value"
                            )

                _ ->
                    Nothing

        _ ->
            Nothing


{-| The portmanteau constant name for `M3e.<enumAttr><Tok>`, or `Nothing` if
`attrName` is not one of `fact`'s enum attributes or `tokenName` is not one of its
valid tokens. `fact.enums` keys are the per-component setter identifiers (keyword
attrs carry a trailing `_`, e.g. `type_`); the portmanteau base strips that so it
matches the barrel (`typeButton`, not `type_Button`).
-}
portmanteauName : Fact -> String -> String -> Maybe String
portmanteauName fact attrName tokenName =
    fact.enums
        |> List.filter (\( a, _ ) -> a == attrName)
        |> List.head
        |> Maybe.andThen
            (\( _, tokens ) ->
                if List.member tokenName tokens then
                    Just (dropTrailingUnderscore attrName ++ capitalizeFirst tokenName)

                else
                    Nothing
            )


dropTrailingUnderscore : String -> String
dropTrailingUnderscore s =
    if String.endsWith "_" s then
        String.dropRight 1 s

    else
        s


capitalizeFirst : String -> String
capitalizeFirst s =
    case String.uncons s of
        Just ( c, rest ) ->
            String.cons (Char.toUpper c) rest

        Nothing ->
            s


unwrapParens : Node Expression -> Node Expression
unwrapParens node =
    case Node.value node of
        Expression.ParenthesizedExpression inner ->
            unwrapParens inner

        _ ->
            node


{-| A synthetic node spanning `fn arg`, used as the fix range for a collapse.
-}
applicationNode : Node Expression -> Node Expression -> Node Expression
applicationNode fnNode argNode =
    Node.Node
        { start = (Node.range fnNode).start
        , end = (Node.range argNode).end
        }
        (Expression.Application [ fnNode, argNode ])


errorsFor : Context -> Node Expression -> String -> List String -> List (Error {})
errorsFor context node name moduleParts =
    case moduleParts of
        [ "M3e", "Value" ] ->
            if Set.member name context.reExposedValues then
                [ barrelError node ("M3e.Value." ++ name) ("M3e." ++ name) "value token" ]

            else
                []

        [ "M3e", "Aria" ] ->
            case ariaUniversalBarrel name of
                Just barrelName ->
                    [ barrelError node ("M3e.Aria." ++ name) ("M3e." ++ barrelName) "aria setter" ]

                Nothing ->
                    []

        _ ->
            case Dict.get (String.join "." moduleParts) context.byModule of
                Just fact ->
                    barrelReplacement fact name
                        |> Maybe.map
                            (\( replacement, kind ) ->
                                [ barrelError node (fact.module_ ++ "." ++ name) replacement kind ]
                            )
                        |> Maybe.withDefault []

                Nothing ->
                    []


{-| Given a per-component reference name, decide its flat barrel form (and a label
for the message), or `Nothing` if the name has no barrel equivalent.
-}
barrelReplacement : Fact -> String -> Maybe ( String, String )
barrelReplacement fact name =
    if name == "view" then
        Just ( "M3e." ++ fact.component, "constructor" )

    else
        case attrBarrelName fact name of
            Just barrelName ->
                Just ( "M3e." ++ barrelName, "attribute setter" )

            Nothing ->
                case slotBarrelName fact name of
                    Just generalized ->
                        Just ( "M3e." ++ generalized, "slot setter" )

                    Nothing ->
                        Nothing


{-| The universal `M3e.Aria.<setter>` functions are re-exposed flat under the
barrel as `aria<Setter>` (`M3e.Aria.label` → `M3e.ariaLabel`).
-}
ariaUniversalBarrel : String -> Maybe String
ariaUniversalBarrel name =
    case name of
        "label" ->
            Just "ariaLabel"

        "labelledby" ->
            Just "ariaLabelledby"

        "describedby" ->
            Just "ariaDescribedby"

        "hidden" ->
            Just "ariaHidden"

        _ ->
            Nothing


{-| `attrRewrites` maps barrel name → per-component name; read it right-to-left.
-}
attrBarrelName : Fact -> String -> Maybe String
attrBarrelName fact name =
    fact.attrRewrites
        |> List.filter (\( _, perComp ) -> perComp == name)
        |> List.head
        |> Maybe.map Tuple.first


{-| `slotRewrites` (slotName → per-component setter) and `slotUpgrades`
(generalized barrel setter → specific barrel setter) are emitted as parallel
lists, so zipping them maps a per-component setter to its generalized barrel form.
-}
slotBarrelName : Fact -> String -> Maybe String
slotBarrelName fact name =
    List.map2 (\( _, perComp ) ( generalized, _ ) -> ( perComp, generalized ))
        fact.slotRewrites
        fact.slotUpgrades
        |> List.filter (\( perComp, _ ) -> perComp == name)
        |> List.head
        |> Maybe.map Tuple.second


barrelError : Node Expression -> String -> String -> String -> Error {}
barrelError node original replacement kind =
    Rule.errorWithFix
        { message =
            "`" ++ original ++ "` can be flattened to the barrel " ++ kind ++ " `" ++ replacement ++ "`"
        , details =
            [ "The `M3e` barrel re-exports this "
                ++ kind
                ++ " so a single `import M3e` covers the whole example. The per-component surface stays available for callers who want the tighter type."
            ]
        }
        (Node.range node)
        [ Fix.replaceRangeBy (Node.range node) replacement ]
