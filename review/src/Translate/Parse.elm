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

import Dict exposing (Dict)
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
    case ( surface, Node.value node ) of
        ( Standard, Expression.Application (_ :: [ attrList, contentList ]) ) ->
            parseStandard fact (Node.range node) (extractLiteralList attrList) (extractLiteralList contentList)

        ( Record, Expression.Application (_ :: [ recordArg, attrList, contentList ]) ) ->
            parseRecord fact (Node.range node) recordArg (extractLiteralList attrList) (extractLiteralList contentList)

        ( Build, Expression.OperatorApplication "|>" _ _ _ ) ->
            parseBuild fact (Node.range node) node

        ( Html, Expression.Application (_ :: [ attrList, contentList ]) ) ->
            parseHtmlOrCem Html fact (Node.range node) (extractLiteralList attrList) (extractLiteralList contentList)

        ( Cem, Expression.Application (_ :: [ attrList, contentList ]) ) ->
            parseHtmlOrCem Cem fact (Node.range node) (extractLiteralList attrList) (extractLiteralList contentList)

        _ ->
            -- Unrecognised call structure at this surface — whole-node Seam
            -- escape via the emitter's fallback path.
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


{-| Parse a ④ Record call: `M3e.Record.<Comp>.view { content = ..., action = ... } [ attrs ] [ content ]`.

Reads the first-arg record via `Expression.RecordExpr`. `content` becomes
`requiredContent`; `action` becomes `requiredAction = RecordStyle {raw}`. Any
other record fields land in `otherRequired` keyed by their setter name.
-}
parseRecord : Fact -> Range.Range -> Node Expression -> List (Node Expression) -> List (Node Expression) -> Canonical
parseRecord fact range recordArg attrItems contentItems =
    let
        recordFields =
            extractRecordFields recordArg

        requiredContent_ =
            Dict.get "content" recordFields

        requiredAction_ =
            Dict.get "action" recordFields
                |> Maybe.map (\expr -> RecordStyle { raw = expr })

        otherRequired_ =
            recordFields
                |> Dict.remove "content"
                |> Dict.remove "action"

        attrs =
            List.map (classifyStandardAttr fact) attrItems

        content =
            List.map (classifyStandardSlot fact) contentItems
    in
    { component = fact.component
    , sourceSurface = Record
    , sourceRange = range
    , attrs = attrs
    , content = content
    , requiredContent = requiredContent_
    , requiredAction = requiredAction_
    , otherRequired = otherRequired_
    }


extractRecordFields : Node Expression -> Dict String (Node Expression)
extractRecordFields node =
    case Node.value node of
        Expression.RecordExpr setters ->
            setters
                |> List.map
                    (\setter ->
                        let
                            ( nameNode, valueNode ) =
                                Node.value setter
                        in
                        ( Node.value nameNode, valueNode )
                    )
                |> Dict.fromList

        _ ->
            Dict.empty


{-| Parse a ⑤ Build call: `M3e.Build.<Comp>.<seed> { ... } |> setters |> build`.

Walks the left-associative `|>` pipeline. Head is the seed application with a
required record argument; each stage is either an attr-style setter, a slot
setter, or the terminal `build`.
-}
parseBuild : Fact -> Range.Range -> Node Expression -> Canonical
parseBuild fact range node =
    let
        stages =
            flattenPipe node

        ( seed, setterStages, hasBuild ) =
            case List.reverse stages of
                terminal :: rest ->
                    let
                        term =
                            isBuildTerminal terminal
                    in
                    case List.reverse rest of
                        head :: setters ->
                            ( Just head, setters, term )

                        [] ->
                            ( Just terminal, [], False )

                [] ->
                    ( Nothing, [], False )

        recordFields =
            case seed of
                Just s ->
                    case Node.value s of
                        Expression.Application (_ :: recordArg :: _) ->
                            extractRecordFields recordArg

                        _ ->
                            Dict.empty

                Nothing ->
                    Dict.empty

        requiredContent_ =
            Dict.get "content" recordFields

        requiredAction_ =
            Dict.get "action" recordFields
                |> Maybe.map (\expr -> RecordStyle { raw = expr })

        otherRequired_ =
            recordFields
                |> Dict.remove "content"
                |> Dict.remove "action"

        ( attrs, content ) =
            classifyBuildStages fact setterStages
    in
    if hasBuild then
        { component = fact.component
        , sourceSurface = Build
        , sourceRange = range
        , attrs = attrs
        , content = content
        , requiredContent = requiredContent_
        , requiredAction = requiredAction_
        , otherRequired = otherRequired_
        }

    else
        -- No `build` terminal — malformed Build call; fall through to escape.
        emptyCanonical fact Build range


{-| Flatten a left-associative `|>` pipeline into an ordered list of stages.
-}
flattenPipe : Node Expression -> List (Node Expression)
flattenPipe node =
    case Node.value node of
        Expression.OperatorApplication "|>" _ left right ->
            flattenPipe left ++ [ right ]

        _ ->
            [ node ]


{-| Detect the terminal `.build` stage. Matches any FunctionOrValue named
"build" — the seed's module resolution already confirmed we're in an
M3e.Build.<Comp> context.
-}
isBuildTerminal : Node Expression -> Bool
isBuildTerminal node =
    case Node.value node of
        Expression.FunctionOrValue _ "build" ->
            True

        _ ->
            False


{-| Classify each Build pipeline stage as an attr or slot item.
-}
classifyBuildStages : Fact -> List (Node Expression) -> ( List AttrItem, List SlotItem )
classifyBuildStages fact stages =
    List.foldr
        (\stage ( attrs, slots ) ->
            case classifyBuildStage fact stage of
                Ok (Left attr) ->
                    ( attr :: attrs, slots )

                Ok (Right slot) ->
                    ( attrs, slot :: slots )

                Err rawNode ->
                    -- Unrecognised stage; treat as an escaped attr for now.
                    ( EscapedAttr { raw = rawNode } :: attrs, slots )
        )
        ( [], [] )
        stages


type Either a b
    = Left a
    | Right b


classifyBuildStage : Fact -> Node Expression -> Result (Node Expression) (Either AttrItem SlotItem)
classifyBuildStage fact stage =
    case Node.value stage of
        Expression.Application (head :: valueNode :: _) ->
            case Node.value head of
                Expression.FunctionOrValue _ name ->
                    let
                        maybeAttr =
                            fact.attrRewrites
                                |> List.filter (\( _, top ) -> top == name)
                                |> List.head

                        maybeSlot =
                            fact.slotRewrites
                                |> List.filter (\( _, top ) -> top == name)
                                |> List.head
                    in
                    case ( maybeAttr, maybeSlot ) of
                        ( Just ( _, canonicalName ), _ ) ->
                            Ok (Left (KnownAttr { name = canonicalName, value = valueNode }))

                        ( _, Just ( _, canonicalName ) ) ->
                            Ok (Right (KnownSlot { name = canonicalName, body = valueNode }))

                        _ ->
                            Err stage

                _ ->
                    Err stage

        _ ->
            Err stage


{-| Parse a ① Html or ② Cem call. Both have the shape `[ Html.Attribute | Attr ] [ Html ]`;
Html attrs carry string-literal enum values whereas Cem carries typed tokens.
Children are `Html` in both cases, with `slot="name"` raw attributes marking
named slots.
-}
parseHtmlOrCem : Surface -> Fact -> Range.Range -> List (Node Expression) -> List (Node Expression) -> Canonical
parseHtmlOrCem surface fact range attrItems contentItems =
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
            List.map (classifyHtmlChild fact) contentItems
    in
    { component = fact.component
    , sourceSurface = surface
    , sourceRange = range
    , attrs = attrs
    , content = content
    , requiredContent = Nothing
    , requiredAction = requiredAction_
    , otherRequired = Dict.empty
    }


{-| Classify an Html/Cem child. If it has an inline `slot="name"` attribute,
lift it to a KnownSlot with that name; otherwise treat it as an escaped
content piece.
-}
classifyHtmlChild : Fact -> Node Expression -> SlotItem
classifyHtmlChild fact child =
    case findSlotAttr child of
        Just slotName ->
            let
                knownSlot =
                    fact.slotRewrites
                        |> List.filter (\( from, _ ) -> from == slotName)
                        |> List.head
            in
            case knownSlot of
                Just ( _, canonicalName ) ->
                    KnownSlot { name = canonicalName, body = child }

                Nothing ->
                    UnknownSlotName { name = slotName, body = child, range = Node.range child }

        Nothing ->
            EscapedContent { raw = child }


{-| Look for `Html.Attributes.attribute "slot" "<name>"` in the child's
attribute list. Returns the slot name if found.
-}
findSlotAttr : Node Expression -> Maybe String
findSlotAttr child =
    case Node.value child of
        Expression.Application (_ :: attrsList :: _) ->
            case Node.value attrsList of
                Expression.ListExpr attrs ->
                    attrs |> List.filterMap slotAttrName |> List.head

                _ ->
                    Nothing

        _ ->
            Nothing


slotAttrName : Node Expression -> Maybe String
slotAttrName attrExpr =
    case Node.value attrExpr of
        Expression.Application (head :: name :: value :: _) ->
            case ( Node.value head, Node.value name, Node.value value ) of
                ( Expression.FunctionOrValue _ "attribute", Expression.Literal "slot", Expression.Literal slotName ) ->
                    Just slotName

                _ ->
                    Nothing

        _ ->
            Nothing
