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
        Expression.FunctionOrValue _ name ->
            case Lookup.moduleNameFor context.lookup node of
                Just moduleParts ->
                    ( errorsFor context node name moduleParts, context )

                Nothing ->
                    ( [], context )

        _ ->
            ( [], context )


errorsFor : Context -> Node Expression -> String -> List String -> List (Error {})
errorsFor context node name moduleParts =
    case moduleParts of
        [ "M3e", "Value" ] ->
            if Set.member name context.reExposedValues then
                [ barrelError node ("M3e.Value." ++ name) ("M3e." ++ name) "value token" ]

            else
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
