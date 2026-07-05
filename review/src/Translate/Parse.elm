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
    case ( Node.value head, Lookup.moduleNameFor lookup head ) of
        ( Expression.FunctionOrValue _ name, Just parts ) ->
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

                -- Only fire on view / seed / build-terminal functions — not
                -- on individual setter calls. Standard/Record use `.view`;
                -- Html/Cem/Build use the component name; Build's terminal
                -- is `.build`.
                isEntry surf f =
                    case surf of
                        Standard ->
                            name == "view"

                        Record ->
                            name == "view"

                        Cem ->
                            name == f.component

                        Html ->
                            name == f.component

                        Build ->
                            -- A ⑤ Build call is only ever a `... |> <Comp>.build`
                            -- pipeline (matched via the `|>` right operand). A bare
                            -- seed application (`<Comp>.<comp> { ... }`) is a nested
                            -- sub-expression of that pipeline, not an entry of its
                            -- own — matching it on the component name would fire a
                            -- spurious second error and wrap the seed in a Seam
                            -- escape. Only the terminal `build` marks the entry.
                            name == "build"
            in
            case ( surface, fact ) of
                ( Just s, Just f ) ->
                    if isEntry s f then
                        Just ( s, f )

                    else
                        Nothing

                _ ->
                    Nothing

        _ ->
            Nothing


stripPrefix : String -> String -> String
stripPrefix prefix s =
    if String.startsWith prefix s then
        String.dropLeft (String.length prefix) s

    else
        s


{-| Dispatch to the correct per-surface parser.
-}
parseCall : Dict String (Node Expression) -> Surface -> Fact -> Node Expression -> Canonical
parseCall scope surface fact node =
    case ( surface, Node.value node ) of
        ( Standard, Expression.Application (_ :: [ attrList, contentList ]) ) ->
            parseStandard scope fact (Node.range node) (splitListArg attrList) (splitListArg contentList)

        ( Record, Expression.Application (_ :: [ recordArg, attrList, contentList ]) ) ->
            parseRecord fact (Node.range node) recordArg (splitListArg attrList) (splitListArg contentList)

        ( Build, Expression.OperatorApplication "|>" _ _ _ ) ->
            parseBuild fact (Node.range node) node

        ( Html, Expression.Application (_ :: [ attrList, contentList ]) ) ->
            parseHtmlOrCem Html fact (Node.range node) (splitListArg attrList) (splitListArg contentList)

        ( Cem, Expression.Application (_ :: [ attrList, contentList ]) ) ->
            parseHtmlOrCem Cem fact (Node.range node) (splitListArg attrList) (splitListArg contentList)

        _ ->
            -- Unrecognised call structure at this surface — whole-node Seam
            -- escape via the emitter's fallback path.
            emptyCanonical fact surface (Node.range node)


{-| Split an attrs/content list argument into its literal item nodes plus any
variable-bound dynamic tail. Recognises three shapes (#152):

  - `[ a, b ]` → literals `[a, b]`, no dynamic tail
  - `[ a, b ] ++ extra` → literals `[a, b]`, dynamic tail `extra`
  - `extra ++ [ a, b ]` → literals `[a, b]`, dynamic tail `extra`
  - a bare variable / anything else `extra` → no literals, dynamic tail `extra`

The dynamic tail is carried as `DynamicAttrTail`/`DynamicContentTail` by the
callers so the emitter can re-emit `([ literals ] ++ extra)` instead of
silently dropping the variable part.
-}
splitListArg : Node Expression -> ( List (Node Expression), Maybe (Node Expression) )
splitListArg listNode =
    case Node.value listNode of
        Expression.ParenthesizedExpression inner ->
            splitListArg inner

        Expression.ListExpr items ->
            ( items, Nothing )

        Expression.OperatorApplication "++" _ left right ->
            case ( Node.value left, Node.value right ) of
                ( Expression.ListExpr items, _ ) ->
                    ( items, Just right )

                ( _, Expression.ListExpr items ) ->
                    ( items, Just left )

                _ ->
                    ( [], Just listNode )

        _ ->
            ( [], Just listNode )


dynAttrTail : Maybe (Node Expression) -> List AttrItem
dynAttrTail m =
    case m of
        Just raw ->
            [ DynamicAttrTail { raw = raw } ]

        Nothing ->
            []


dynContentTail : Maybe (Node Expression) -> List SlotItem
dynContentTail m =
    case m of
        Just raw ->
            [ DynamicContentTail { raw = raw } ]

        Nothing ->
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
parseStandard : Dict String (Node Expression) -> Fact -> Range.Range -> ( List (Node Expression), Maybe (Node Expression) ) -> ( List (Node Expression), Maybe (Node Expression) ) -> Canonical
parseStandard scope fact range ( attrItems, attrDyn ) ( contentItems, contentDyn ) =
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
            List.map (classifyStandardAttr fact) plainAttrs ++ dynAttrTail attrDyn

        -- Required-singular-slot lifting: if fact.requiredSlots contains
        -- "unnamed" and one content-list item calls the unnamed slot's
        -- setter (per slotRewrites), lift that item's body into
        -- requiredContent so Record/Build emitters can use it.
        unnamedSetter =
            fact.slotRewrites
                |> List.filter (\( from, _ ) -> from == "unnamed")
                |> List.head
                |> Maybe.map Tuple.second

        hasRequiredUnnamed =
            List.member "unnamed" fact.requiredSlots

        ( requiredContent_, remainingContent ) =
            if hasRequiredUnnamed then
                case unnamedSetter of
                    Just setterName ->
                        liftRequiredContent scope setterName contentItems

                    Nothing ->
                        ( Nothing, contentItems )

            else
                ( Nothing, contentItems )

        content =
            List.map (classifyStandardSlot fact) remainingContent ++ dynContentTail contentDyn
    in
    { component = fact.component
    , sourceSurface = Standard
    , sourceRange = range
    , attrs = attrs
    , content = content
    , requiredContent = requiredContent_
    , requiredAction = requiredAction_
    , otherRequired = Dict.empty
    }


{-| Find the first content-list item that calls `setterName` and return its
argument as the required content. The item is removed from the remaining list.

Recognises both the literal call form (`M3e.Button.child body`) and a bare
variable bound to that call in an enclosing `let` (`label` where
`label = M3e.Button.child body`) — the latter resolved through `scope`, which is
the common shape when reusable label/icon content is bound above the view call
(#153). Falls back to leaving the item in place (→ Seam escape) for anything not
resolvable (e.g. function-parameter-bound content).
-}
liftRequiredContent : Dict String (Node Expression) -> String -> List (Node Expression) -> ( Maybe (Node Expression), List (Node Expression) )
liftRequiredContent scope setterName items =
    let
        -- The body if `expr` is a `setterName <body>` application, else Nothing.
        setterBody expr =
            case Node.value expr of
                Expression.Application (head :: body :: _) ->
                    case Node.value head of
                        Expression.FunctionOrValue _ name ->
                            if name == setterName then
                                Just body

                            else
                                Nothing

                        _ ->
                            Nothing

                _ ->
                    Nothing

        -- Resolve a content item to the setter's body: directly, or by looking a
        -- bare variable up in the enclosing let-scope and testing its binding.
        liftedBody item =
            case setterBody item of
                Just body ->
                    Just body

                Nothing ->
                    case Node.value item of
                        Expression.FunctionOrValue _ varName ->
                            Dict.get varName scope
                                |> Maybe.andThen setterBody

                        _ ->
                            Nothing

        go remaining seen =
            case remaining of
                [] ->
                    ( Nothing, List.reverse seen )

                item :: rest ->
                    case liftedBody item of
                        Just body ->
                            ( Just body, List.reverse seen ++ rest )

                        Nothing ->
                            go rest (item :: seen)
    in
    go items []


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
parseRecord : Fact -> Range.Range -> Node Expression -> ( List (Node Expression), Maybe (Node Expression) ) -> ( List (Node Expression), Maybe (Node Expression) ) -> Canonical
parseRecord fact range recordArg ( attrItems, attrDyn ) ( contentItems, contentDyn ) =
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
            List.map (classifyStandardAttr fact) attrItems ++ dynAttrTail attrDyn

        content =
            List.map (classifyStandardSlot fact) contentItems ++ dynContentTail contentDyn
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
parseHtmlOrCem : Surface -> Fact -> Range.Range -> ( List (Node Expression), Maybe (Node Expression) ) -> ( List (Node Expression), Maybe (Node Expression) ) -> Canonical
parseHtmlOrCem surface fact range ( attrItems, attrDyn ) ( contentItems, contentDyn ) =
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
            List.map (classifyStandardAttr fact) plainAttrs ++ dynAttrTail attrDyn

        content =
            List.map (classifyHtmlChild fact) contentItems ++ dynContentTail contentDyn
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
