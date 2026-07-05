module Translate.Canonical exposing
    ( Canonical, AttrItem(..), SlotItem(..), ActionExpr(..)
    )

{-| Canonical intermediate for the D6 codegen-aware translator. All five
parsers normalize their input into `Canonical`; all five emitters produce
target-surface Elm text from a `Canonical`.

Value expressions travel as elm-syntax nodes unmodified — the parser only
classifies each item's role. See spec 2026-07-05-codegen-aware-translator-design.md §5.

@docs Canonical, AttrItem, SlotItem, ActionExpr

-}

import Dict exposing (Dict)
import Elm.Syntax.Expression exposing (Expression)
import Elm.Syntax.Node exposing (Node)
import Elm.Syntax.Range exposing (Range)
import M3e.Review.Facts exposing (Surface)


{-| The canonical shape every parser produces and every emitter consumes.
-}
type alias Canonical =
    { component : String
    , sourceSurface : Surface
    , sourceRange : Range
    , attrs : List AttrItem
    , content : List SlotItem
    , requiredContent : Maybe (Node Expression)
    , requiredAction : Maybe ActionExpr
    , otherRequired : Dict String (Node Expression)
    }


{-| One attr-position piece.

  - `KnownAttr` — recognised setter with a value expression.
  - `EnumTokenLossy` — uphill token that Facts' `enums` doesn't cover.
  - `EscapedAttr` — parser couldn't classify; carry the raw expression.
  - `DynamicAttrTail` — variable-bound tail of an attr list.

-}
type AttrItem
    = KnownAttr { name : String, value : Node Expression }
    | EnumTokenLossy { name : String, tokenText : String, range : Range }
    | EscapedAttr { raw : Node Expression }
    | DynamicAttrTail { raw : Node Expression }


{-| One content-position piece.

  - `KnownSlot` — recognised slot setter with a body expression.
  - `UnknownSlotName` — uphill slot with no `slotRewrites` entry.
  - `EscapedContent` — parser couldn't classify; carry the raw expression.
  - `DynamicContentTail` — variable-bound tail of a content list.

-}
type SlotItem
    = KnownSlot { name : String, body : Node Expression }
    | UnknownSlotName { name : String, body : Node Expression, range : Range }
    | EscapedContent { raw : Node Expression }
    | DynamicContentTail { raw : Node Expression }


{-| Unified action representation.

  - `AttrStyle` — from ①/②/③: `onClick DoThing` / `href "..."`.
  - `RecordStyle` — from ④/⑤: `M3e.Action.onClick DoThing` passed through.

-}
type ActionExpr
    = AttrStyle { name : String, value : Node Expression }
    | RecordStyle { raw : Node Expression }
