module Translate.Parse exposing
    ( identifySurface, parseCall
    )

{-| Per-surface parsers producing the canonical intermediate.

`identifySurface` classifies an expression's outer application against the
five surface module prefixes and looks up the matching Fact. `parseCall`
dispatches to the appropriate per-surface parser.

Task 6 lands only `parseStandard` fully; the other four surfaces fall through
to a minimal Canonical (empty attrs/content) which the emitters then treat as
a whole-node Seam escape. Tasks 11 fill them in.

@docs identifySurface, parseCall

-}

import Dict
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Elm.Syntax.Range as Range
import M3e.Review.Facts exposing (Fact, Surface(..))
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Translate.Canonical exposing (..)


{-| Identify whether an expression is a call to one of the five surfaces. If
so, return the surface and the matching Fact.
-}
identifySurface : List Fact -> ModuleNameLookupTable -> Node Expression -> Maybe ( Surface, Fact )
identifySurface facts lookup node =
    case Node.value node of
        Expression.Application (head :: _) ->
            classifyModule facts lookup head

        Expression.OperatorApplication "|>" _ _ right ->
            -- ⑤ Build calls terminate in `... |> M3e.Build.<Comp>.build`.
            -- Detect via the right operand of the outermost `|>`.
            classifyModule facts lookup right

        _ ->
            Nothing


classifyModule : List Fact -> ModuleNameLookupTable -> Node Expression -> Maybe ( Surface, Fact )
classifyModule facts lookup head =
    case Lookup.moduleNameFor lookup head of
        Just parts ->
            let
                m =
                    String.join "." parts

                surface =
                    if String.startsWith "M3e.Cem.Html." m then
                        Just Html

                    else if String.startsWith "M3e.Build." m then
                        Just Build

                    else if String.startsWith "M3e.Record." m then
                        Just Record

                    else if String.startsWith "M3e.Cem." m then
                        Just Cem

                    else if String.startsWith "M3e." m then
                        Just Standard

                    else
                        Nothing

                -- Map any surface's per-component module back to the canonical
                -- Standard module name (e.g. M3e.Build.Button → M3e.Button)
                -- so the Fact lookup by `module_` field works uniformly.
                canonicalModule =
                    m
                        |> stripPrefix "M3e.Cem.Html."
                        |> stripPrefix "M3e.Build."
                        |> stripPrefix "M3e.Record."
                        |> stripPrefix "M3e.Cem."
                        |> stripPrefix "M3e."
                        |> (\rest -> "M3e." ++ rest)

                fact =
                    List.filter (\f -> f.module_ == canonicalModule) facts |> List.head
            in
            Maybe.map2 Tuple.pair surface fact

        Nothing ->
            Nothing


stripPrefix : String -> String -> String
stripPrefix prefix s =
    if String.startsWith prefix s then
        String.dropLeft (String.length prefix) s

    else
        s


{-| Dispatch to the correct per-surface parser.
-}
parseCall : Surface -> Fact -> Node Expression -> Canonical
parseCall surface fact node =
    case Node.value node of
        Expression.Application (_ :: args) ->
            case ( surface, args ) of
                ( Standard, [ attrList, contentList ] ) ->
                    parseStandard fact (Node.range node) (extractLiteralList attrList) (extractLiteralList contentList)

                _ ->
                    -- Task 11 covers Html/Cem/Record parsers and pipeline Build.
                    -- Fall-through: minimal Canonical → emitter falls back to
                    -- whole-node Seam escape.
                    emptyCanonical fact surface (Node.range node)

        _ ->
            emptyCanonical fact surface (Node.range node)


{-| Extract literal list arg contents. Non-literal lists (variables, ++, map)
fall through to a single DynamicAttrTail/Content behind the escape route.
-}
extractLiteralList : Node Expression -> List (Node Expression)
extractLiteralList listNode =
    case Node.value listNode of
        Expression.ListExpr items ->
            items

        _ ->
            []


emptyCanonical : Fact -> Surface -> Range.Range -> Canonical
emptyCanonical fact surface range =
    { component = fact.component
    , sourceSurface = surface
    , sourceRange = range
    , attrs = []
    , content = []
    , requiredContent = Nothing
    , requiredAction = Nothing
    , otherRequired = Dict.empty
    }


{-| Parse a ③ Standard call: `M3e.<Comp>.view [ attrs ] [ content ]`. Action
attrs (per fact.actionMap) are lifted out of the attrs list. The unnamed slot's
first child element (if fact.requiredSlots contains "unnamed") is lifted to
`requiredContent`.
-}
parseStandard : Fact -> Range.Range -> List (Node Expression) -> List (Node Expression) -> Canonical
parseStandard fact range attrItems contentItems =
    let
        actionAttrNames =
            List.map Tuple.first fact.actionMap

        ( actionAttrs, plainAttrs ) =
            List.partition (isActionAttr actionAttrNames) attrItems

        requiredAction_ =
            actionAttrs
                |> List.filterMap (classifyActionAttr fact)
                |> List.head

        attrs =
            List.map (classifyStandardAttr fact) plainAttrs

        content =
            List.map (classifyStandardSlot fact) contentItems
    in
    { component = fact.component
    , sourceSurface = Standard
    , sourceRange = range
    , attrs = attrs
    , content = content

    -- Standard doesn't split out requiredContent; the required-singular slot
    -- (if any) lives in the content list as e.g. `M3e.Button.label ...`.
    -- The record/build emitters look it up by slot name when they need it.
    , requiredContent = Nothing
    , requiredAction = requiredAction_
    , otherRequired = Dict.empty
    }


isActionAttr : List String -> Node Expression -> Bool
isActionAttr actionNames item =
    case Node.value item of
        Expression.Application (head :: _) ->
            case Node.value head of
                Expression.FunctionOrValue _ name ->
                    List.member name actionNames

                _ ->
                    False

        _ ->
            False


classifyActionAttr : Fact -> Node Expression -> Maybe ActionExpr
classifyActionAttr _ item =
    case Node.value item of
        Expression.Application (head :: valueNode :: _) ->
            case Node.value head of
                Expression.FunctionOrValue _ name ->
                    Just (AttrStyle { name = name, value = valueNode })

                _ ->
                    Nothing

        _ ->
            Nothing


classifyStandardAttr : Fact -> Node Expression -> AttrItem
classifyStandardAttr fact item =
    case Node.value item of
        Expression.Application (head :: valueNode :: _) ->
            case Node.value head of
                Expression.FunctionOrValue _ name ->
                    -- Check if this attr name is in fact.attrRewrites
                    let
                        knownAttr =
                            fact.attrRewrites
                                |> List.filter (\( _, top ) -> top == name)
                                |> List.head
                    in
                    case knownAttr of
                        Just ( _, canonicalName ) ->
                            KnownAttr { name = canonicalName, value = valueNode }

                        Nothing ->
                            EscapedAttr { raw = item }

                _ ->
                    EscapedAttr { raw = item }

        _ ->
            EscapedAttr { raw = item }


classifyStandardSlot : Fact -> Node Expression -> SlotItem
classifyStandardSlot fact item =
    case Node.value item of
        Expression.Application (head :: bodyNode :: _) ->
            case Node.value head of
                Expression.FunctionOrValue _ name ->
                    let
                        knownSlot =
                            fact.slotRewrites
                                |> List.filter (\( _, top ) -> top == name)
                                |> List.head
                    in
                    case knownSlot of
                        Just ( _, canonicalName ) ->
                            KnownSlot { name = canonicalName, body = bodyNode }

                        Nothing ->
                            EscapedContent { raw = item }

                _ ->
                    EscapedContent { raw = item }

        _ ->
            EscapedContent { raw = item }
