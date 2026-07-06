module Translate.Residue exposing (wholeSeamEscape)

{-| Whole-node Seam escape — the last-resort residue path used when the target
surface can't cleanly represent a Canonical (missing required, ⑤ dynamic
attrs, un-decomposable action). Emits a valid Elm expression producing an
`Element` (via `Seam.fromHtml`) so the call still composes; the developer sees
the residue via `NoSeamOutsideAllowedModules` and hand-resolves.

Per spec 2026-07-05-codegen-aware-translator-design.md §9.6.

@docs wholeSeamEscape

-}

import Elm.Syntax.Node as Node
import Elm.Syntax.Range exposing (Range)
import M3e.Review.Facts exposing (Fact)
import Translate.Canonical exposing (..)


{-| Emit `Seam.fromHtml (M3e.Cem.Html.<Comp>.<name> [...html attrs...] [...html children...])`.

Attrs are re-rendered as `M3e.Cem.Html.<Comp>.<name>` calls when
`fact.attrRewrites` recognises them, otherwise as
`Html.Attributes.attribute "<attr>" <value>` (or a raw pass-through of an
un-classified expression). Children are pass-through since the whole-node
escape produces `Html` output; if children are typed `Element`, the caller
must handle conversion via `M3e.Element.toHtml` at higher levels.

-}
wholeSeamEscape : Fact -> (Range -> String) -> Canonical -> String
wholeSeamEscape fact source c =
    let
        htmlModule =
            "M3e.Cem.Html." ++ pascalOfComponent fact.component

        htmlCtor =
            fact.component

        ( litAttrs, dynAttrs ) =
            List.partition (not << isDynamicAttr) c.attrs

        attrsLiterals =
            renderAction fact source c.requiredAction
                ++ List.map (renderAsHtmlAttr fact source) litAttrs

        attrsText =
            listArg attrsLiterals (List.map (renderAsHtmlAttr fact source) dynAttrs)

        ( litSlots, dynSlots ) =
            List.partition (not << isDynamicSlot) c.content

        contentLiterals =
            (case c.requiredContent of
                Just r ->
                    [ source (Node.range r) ]

                Nothing ->
                    []
            )
                ++ List.map (renderAsHtmlChild fact source) litSlots

        contentText =
            listArg contentLiterals (List.map (renderAsHtmlChild fact source) dynSlots)
    in
    "Seam.fromHtml (" ++ htmlModule ++ "." ++ htmlCtor ++ " " ++ attrsText ++ " " ++ contentText ++ ")"


{-| Compose a list-argument literal, appending any dynamic tails with `++`.
-}
listArg : List String -> List String -> String
listArg literals dynamics =
    let
        base =
            case literals of
                [] ->
                    "[]"

                _ ->
                    "[ " ++ String.join ", " literals ++ " ]"
    in
    case dynamics of
        [] ->
            base

        _ ->
            "(" ++ base ++ " ++ " ++ String.join " ++ " dynamics ++ ")"


isDynamicAttr : AttrItem -> Bool
isDynamicAttr item =
    case item of
        DynamicAttrTail _ ->
            True

        _ ->
            False


isDynamicSlot : SlotItem -> Bool
isDynamicSlot item =
    case item of
        DynamicContentTail _ ->
            True

        _ ->
            False


pascalOfComponent : String -> String
pascalOfComponent s =
    case String.uncons s of
        Just ( h, t ) ->
            String.fromChar (Char.toUpper h) ++ t

        Nothing ->
            s


renderAction : Fact -> (Range -> String) -> Maybe ActionExpr -> List String
renderAction fact source ma =
    case ma of
        Just (AttrStyle { name, value }) ->
            [ "M3e.Cem.Html." ++ pascalOfComponent fact.component ++ "." ++ name ++ " " ++ source (Node.range value) ]

        Just (RecordStyle { raw }) ->
            [ source (Node.range raw) ]

        Nothing ->
            []


renderAsHtmlAttr : Fact -> (Range -> String) -> AttrItem -> String
renderAsHtmlAttr fact source item =
    case item of
        KnownAttr { name, value } ->
            "M3e.Cem.Html." ++ pascalOfComponent fact.component ++ "." ++ name ++ " " ++ source (Node.range value)

        EnumTokenLossy { name, tokenText } ->
            "Html.Attributes.attribute \"" ++ name ++ "\" \"" ++ tokenText ++ "\""

        UniversalAttr { raw } ->
            source (Node.range raw)

        EscapedAttr { raw } ->
            source (Node.range raw)

        DynamicAttrTail { raw } ->
            source (Node.range raw)


renderAsHtmlChild : Fact -> (Range -> String) -> SlotItem -> String
renderAsHtmlChild _ source item =
    case item of
        KnownSlot { body } ->
            source (Node.range body)

        UnknownSlotName { body } ->
            source (Node.range body)

        EscapedContent { raw } ->
            source (Node.range raw)

        DynamicContentTail { raw } ->
            source (Node.range raw)
