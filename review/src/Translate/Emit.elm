module Translate.Emit exposing
    ( emitStandard, emitRecord, emitBuild, emitCem, emitHtml
    )

{-| Per-surface emitters. Each takes a `Canonical` and produces the target-
surface Elm text via `Fix.replaceRangeBy`-compatible string composition.

Task 7 lands `emitStandard` (target ③); Tasks 12 add Html/Cem/Record/Build.
For non-Standard targets, `Translate.Rule` currently falls through to
`Translate.Residue.wholeSeamEscape`.

@docs emitStandard

-}

import Dict
import Elm.Syntax.Expression as Expression exposing (Expression)
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


{-| Emit ④ Record: `M3e.Record.<Comp>.view { content = ..., action = ... } [ attrs ] [ content ]`.
-}
emitRecord : Fact -> (Range -> String) -> Canonical -> String
emitRecord fact source c =
    let
        recordArg =
            emitRecordArg fact source c

        attrsText =
            "[ " ++ String.join ", " (List.map (emitAttrItem fact source) c.attrs) ++ " ]"

        contentText =
            "[ " ++ String.join ", " (List.map (emitSlotItem fact source) c.content) ++ " ]"

        recordModule =
            recordModuleFor fact
    in
    recordModule ++ ".view " ++ recordArg ++ "\n    " ++ attrsText ++ "\n    " ++ contentText


emitRecordArg : Fact -> (Range -> String) -> Canonical -> String
emitRecordArg _ source c =
    let
        contentField =
            case c.requiredContent of
                Just node ->
                    [ "content = " ++ source (Node.range node) ]

                Nothing ->
                    []

        actionField =
            case c.requiredAction of
                Just (RecordStyle { raw }) ->
                    [ "action = " ++ source (Node.range raw) ]

                Just (AttrStyle a) ->
                    [ "action = " ++ actionAttrToRecordCall a.name (source (Node.range a.value)) ]

                Nothing ->
                    []

        other =
            c.otherRequired
                |> Dict.toList
                |> List.map (\( k, v ) -> k ++ " = " ++ source (Node.range v))

        allFields =
            contentField ++ actionField ++ other
    in
    "{ " ++ String.join ", " allFields ++ " }"


actionAttrToRecordCall : String -> String -> String
actionAttrToRecordCall attrName value =
    case attrName of
        "onClick" ->
            "M3e.Action.onClick " ++ value

        "href" ->
            "M3e.Action.link " ++ value

        "linkWith" ->
            "M3e.Action.linkWith " ++ value

        "remove" ->
            "M3e.Action.remove " ++ value

        "togglesNavRail" ->
            "M3e.Action.togglesNavRail " ++ value

        "togglesDrawer" ->
            "M3e.Action.togglesDrawer " ++ value

        "togglesDatepicker" ->
            "M3e.Action.togglesDatepicker " ++ value

        _ ->
            "(Seam.asAttribute (Html.Events.on \"" ++ attrName ++ "\" " ++ value ++ "))"


recordModuleFor : Fact -> String
recordModuleFor fact =
    case String.split "." fact.module_ of
        [ "M3e", comp ] ->
            "M3e.Record." ++ comp

        _ ->
            fact.module_


{-| Emit ⑤ Build: seed + setter pipeline + `|> build`.
-}
emitBuild : Fact -> (Range -> String) -> Canonical -> String
emitBuild fact source c =
    let
        buildModule =
            buildModuleFor fact

        seedName =
            fact.component

        recordArg =
            emitRecordArg fact source c

        attrSetters =
            c.attrs |> List.map (buildAttrSetter buildModule source)

        slotSetters =
            c.content |> List.map (buildSlotSetter buildModule source)

        stages =
            attrSetters ++ slotSetters
    in
    buildModule ++ "." ++ seedName ++ " " ++ recordArg ++ concatSetters stages ++ "\n        |> " ++ buildModule ++ ".build"


concatSetters : List String -> String
concatSetters ss =
    case ss of
        [] ->
            ""

        _ ->
            "\n        |> " ++ String.join "\n        |> " ss


buildAttrSetter : String -> (Range -> String) -> AttrItem -> String
buildAttrSetter buildModule source item =
    case item of
        KnownAttr { name, value } ->
            buildModule ++ "." ++ name ++ " " ++ source (Node.range value)

        _ ->
            "identity  -- residue: Build has no attr-list seam"


buildSlotSetter : String -> (Range -> String) -> SlotItem -> String
buildSlotSetter buildModule source item =
    case item of
        KnownSlot { name, body } ->
            buildModule ++ "." ++ name ++ " " ++ source (Node.range body)

        _ ->
            "identity  -- residue: Build has no content-list seam"


buildModuleFor : Fact -> String
buildModuleFor fact =
    case String.split "." fact.module_ of
        [ "M3e", comp ] ->
            "M3e.Build." ++ comp

        _ ->
            fact.module_


{-| Emit ② Cem.
-}
emitCem : Fact -> (Range -> String) -> Canonical -> String
emitCem fact source c =
    let
        cemModule =
            cemModuleFor fact

        ctor =
            fact.component

        allAttrs =
            actionAttrsForTarget cemModule fact source c ++ List.map (cemAttrItem cemModule source) c.attrs

        attrsText =
            "[ " ++ String.join ", " allAttrs ++ " ]"

        allContent =
            case c.requiredContent of
                Just node ->
                    elementToHtml (source (Node.range node)) :: List.map (cemContentItem source) c.content

                Nothing ->
                    List.map (cemContentItem source) c.content

        contentText =
            "[ " ++ String.join ", " allContent ++ " ]"
    in
    cemModule ++ "." ++ ctor ++ " " ++ attrsText ++ " " ++ contentText


actionAttrsForTarget : String -> Fact -> (Range -> String) -> Canonical -> List String
actionAttrsForTarget targetModule fact source c =
    case c.requiredAction of
        Just (AttrStyle a) ->
            [ targetModule ++ "." ++ a.name ++ " " ++ source (Node.range a.value) ]

        Just (RecordStyle { raw }) ->
            [ decomposeToAttrStyle targetModule fact source raw ]

        Nothing ->
            []


decomposeToAttrStyle : String -> Fact -> (Range -> String) -> Node Expression -> String
decomposeToAttrStyle targetModule fact source expr =
    case Node.value expr of
        Expression.Application (head :: valueNode :: _) ->
            case Node.value head of
                Expression.FunctionOrValue _ ctorName ->
                    let
                        reverse =
                            fact.actionMap
                                |> List.filter (\( _, ctor ) -> ctor == ctorName)
                                |> List.head
                    in
                    case reverse of
                        Just ( attrName, _ ) ->
                            targetModule ++ "." ++ attrName ++ " " ++ source (Node.range valueNode)

                        Nothing ->
                            "(Seam.asAttribute (Html.Events.on \"click\" (Json.Decode.succeed " ++ source (Node.range expr) ++ ")))"

                _ ->
                    "(Seam.asAttribute (Html.Events.on \"click\" (Json.Decode.succeed " ++ source (Node.range expr) ++ ")))"

        _ ->
            "(Seam.asAttribute (Html.Events.on \"click\" (Json.Decode.succeed " ++ source (Node.range expr) ++ ")))"


cemAttrItem : String -> (Range -> String) -> AttrItem -> String
cemAttrItem cemModule source item =
    case item of
        KnownAttr { name, value } ->
            cemModule ++ "." ++ name ++ " " ++ source (Node.range value)

        EnumTokenLossy { name, tokenText } ->
            "Seam.asAttribute (Html.Attributes.attribute \"" ++ name ++ "\" \"" ++ tokenText ++ "\")"

        EscapedAttr { raw } ->
            "Seam.asAttribute (" ++ source (Node.range raw) ++ ")"

        DynamicAttrTail { raw } ->
            source (Node.range raw)


cemContentItem : (Range -> String) -> SlotItem -> String
cemContentItem source item =
    case item of
        KnownSlot { body } ->
            elementToHtml (source (Node.range body))

        UnknownSlotName { body } ->
            source (Node.range body)

        EscapedContent { raw } ->
            source (Node.range raw)

        DynamicContentTail { raw } ->
            source (Node.range raw)


elementToHtml : String -> String
elementToHtml expr =
    "(M3e.Element.toHtml (" ++ expr ++ "))"


cemModuleFor : Fact -> String
cemModuleFor fact =
    case String.split "." fact.module_ of
        [ "M3e", comp ] ->
            "M3e.Cem." ++ comp

        _ ->
            fact.module_


{-| Emit ① Html: strings for enum tokens, slot attr on children.
-}
emitHtml : Fact -> (Range -> String) -> Canonical -> String
emitHtml fact source c =
    let
        htmlModule =
            htmlModuleFor fact

        ctor =
            fact.component

        allAttrs =
            actionAttrsForTarget htmlModule fact source c ++ List.map (htmlAttrItem htmlModule fact source) c.attrs

        attrsText =
            "[ " ++ String.join ", " allAttrs ++ " ]"

        allContent =
            case c.requiredContent of
                Just node ->
                    elementToHtml (source (Node.range node)) :: List.map (htmlContentItem fact source) c.content

                Nothing ->
                    List.map (htmlContentItem fact source) c.content

        contentText =
            "[ " ++ String.join ", " allContent ++ " ]"
    in
    htmlModule ++ "." ++ ctor ++ " " ++ attrsText ++ " " ++ contentText


htmlAttrItem : String -> Fact -> (Range -> String) -> AttrItem -> String
htmlAttrItem htmlModule fact source item =
    case item of
        KnownAttr { name, value } ->
            case tokenToLiteral fact name value of
                Just tokenStr ->
                    htmlModule ++ "." ++ name ++ " \"" ++ tokenStr ++ "\""

                Nothing ->
                    htmlModule ++ "." ++ name ++ " " ++ source (Node.range value)

        EnumTokenLossy { name, tokenText } ->
            "Html.Attributes.attribute \"" ++ name ++ "\" \"" ++ tokenText ++ "\""

        EscapedAttr { raw } ->
            source (Node.range raw)

        DynamicAttrTail { raw } ->
            source (Node.range raw)


tokenToLiteral : Fact -> String -> Node Expression -> Maybe String
tokenToLiteral fact attrName value =
    case Node.value value of
        Expression.FunctionOrValue _ tokenName ->
            fact.enums
                |> List.filter (\( a, _ ) -> a == attrName)
                |> List.head
                |> Maybe.andThen
                    (\( _, tokens ) ->
                        if List.member tokenName tokens then
                            Just tokenName

                        else
                            Nothing
                    )

        _ ->
            Nothing


htmlContentItem : Fact -> (Range -> String) -> SlotItem -> String
htmlContentItem _ source item =
    case item of
        KnownSlot { body } ->
            elementToHtml (source (Node.range body))

        UnknownSlotName { body } ->
            elementToHtml (source (Node.range body))

        EscapedContent { raw } ->
            source (Node.range raw)

        DynamicContentTail { raw } ->
            source (Node.range raw)


htmlModuleFor : Fact -> String
htmlModuleFor fact =
    case String.split "." fact.module_ of
        [ "M3e", comp ] ->
            "M3e.Cem.Html." ++ comp

        _ ->
            fact.module_
