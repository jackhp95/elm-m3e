module Translate.Emit exposing (emitStandard)

{-| Per-surface emitters. Each takes a `Canonical` and produces the target-
surface Elm text via `Fix.replaceRangeBy`-compatible string composition.

Task 7 lands `emitStandard` (target ③); Tasks 12 add Html/Cem/Record/Build.
For non-Standard targets, `Translate.Rule` currently falls through to
`Translate.Residue.wholeSeamEscape`.

@docs emitStandard

-}

import Elm.Syntax.Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Elm.Syntax.Range exposing (Range)
import M3e.Review.Facts exposing (Fact)
import Translate.Canonical exposing (..)


{-| Emit ③ Standard: `M3e.<Comp>.view [ attrs ] [ content ]`.

Action-attrs (either AttrStyle from ①/②/③ source or RecordStyle from ④/⑤
source) are re-emitted as attr-style setters in the attrs list.
`requiredContent` (if the source was ④/⑤) is prepended into the content list
via the required-slot setter name from `slotRewrites`.

-}
emitStandard : Fact -> (Range -> String) -> Canonical -> String
emitStandard fact source c =
    let
        attrsText =
            emitAttrsList fact source c

        contentText =
            emitContentList fact source c
    in
    fact.module_ ++ ".view\n    " ++ attrsText ++ "\n    " ++ contentText


emitAttrsList : Fact -> (Range -> String) -> Canonical -> String
emitAttrsList fact source c =
    let
        actionAttr =
            case c.requiredAction of
                Just (AttrStyle a) ->
                    [ fact.module_ ++ "." ++ a.name ++ " " ++ source (Node.range a.value) ]

                Just (RecordStyle { raw }) ->
                    -- Reverse-map: destructure `M3e.Action.<ctor> <arg>` back to
                    -- attr-style via fact.actionMap. If the outer application
                    -- can't be destructured (e.g. it's a variable), fall back
                    -- to Seam.asAttribute wrapping the raw expression.
                    [ decomposeRecordAction fact source raw ]

                Nothing ->
                    []

        items =
            List.map (emitAttrItem fact source) c.attrs
    in
    "[ " ++ String.join ", " (actionAttr ++ items) ++ " ]"


emitAttrItem : Fact -> (Range -> String) -> AttrItem -> String
emitAttrItem fact source item =
    case item of
        KnownAttr { name, value } ->
            fact.module_ ++ "." ++ name ++ " " ++ source (Node.range value)

        EnumTokenLossy { name, tokenText } ->
            "Seam.asAttribute (Html.Attributes.attribute \"" ++ name ++ "\" \"" ++ tokenText ++ "\")"

        EscapedAttr { raw } ->
            "Seam.asAttribute (" ++ source (Node.range raw) ++ ")"

        DynamicAttrTail { raw } ->
            -- Best-effort: emit as inline splice; the surrounding list makes
            -- this syntactically invalid unless the emitter wraps everything
            -- in List.append. Kept as raw for now; refinement in Task 12.
            source (Node.range raw)


emitContentList : Fact -> (Range -> String) -> Canonical -> String
emitContentList fact source c =
    let
        requiredSlot =
            case c.requiredContent of
                Just node ->
                    [ fact.module_ ++ "." ++ requiredSlotSetter fact ++ " " ++ source (Node.range node) ]

                Nothing ->
                    []

        items =
            List.map (emitSlotItem fact source) c.content
    in
    "[ " ++ String.join ", " (requiredSlot ++ items) ++ " ]"


emitSlotItem : Fact -> (Range -> String) -> SlotItem -> String
emitSlotItem fact source item =
    case item of
        KnownSlot { name, body } ->
            fact.module_ ++ "." ++ name ++ " " ++ source (Node.range body)

        UnknownSlotName { name, body } ->
            "M3e.Content.slot \"" ++ name ++ "\" (Seam.fromHtml (" ++ source (Node.range body) ++ "))"

        EscapedContent { raw } ->
            "M3e.Content.slot \"\" (Seam.fromHtml (" ++ source (Node.range raw) ++ "))"

        DynamicContentTail { raw } ->
            source (Node.range raw)


requiredSlotSetter : Fact -> String
requiredSlotSetter fact =
    fact.slotRewrites
        |> List.filter (\( from, _ ) -> from == "unnamed")
        |> List.head
        |> Maybe.map Tuple.second
        |> Maybe.withDefault "child"


{-| Destructure a `M3e.Action.<ctor> <value>` expression back to a
target-surface attr-style setter using fact.actionMap in reverse.
-}
decomposeRecordAction : Fact -> (Range -> String) -> Node Expression -> String
decomposeRecordAction fact source expr =
    -- Fallback: emit the whole expression through Seam. Full destructuring is
    -- a Task 12 refinement.
    "Seam.asAttribute (Html.Events.on \"click\" (Json.Decode.succeed " ++ source (Node.range expr) ++ "))"
