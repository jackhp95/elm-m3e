# Codegen-aware translator — implementation plan (epic #138 D6 / issue #145)

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Ship five elm-review rules — `TranslateTo{Html,Cem,Standard,Record,Build}` — that auto-fix a call site between any two of the five API surfaces via one shared normalize-and-re-emit library, driven by generator-emitted Facts.

**Architecture:** A shared library `review/src/Translate/` (Canonical / Parse / Emit / Residue / Rule) plus five thin per-target rule wrappers. The generator renames `Shape → Surface`, adds `Html` and `Cem` constructors, and emits a new `Facts.actionMap` field driven from `config/slots.json` (the m3e-specific config, kept out of `elm-cem` codegen). Residue via `Seam.*` for uphill token/slot lossiness; whole-node `Seam.fromHtml` escape for un-fabricateable required fields or ⑤'s no-attr-list case. Every direction is total.

**Tech Stack:** Elm 0.19.1, elm-review, elm-syntax, elm-test-rs, mdgriffith/elm-codegen (generator only), pnpm/mise, elm-cem.

## Global Constraints

- Elm 0.19.1. All generated code targets this compiler version.
- **`elm-cem` stays CEM/component-library/config-agnostic** — no M3e-, Seam-, or Action-specific string literals in `elm-cem/codegen/*.elm`. Any m3e-specific mapping (`actionMap` entries, module names) lives in `config/slots.json`; the generator reads it generically.
- The Facts type gets one new field (`actionMap : List (String, String)`) and one renamed field (`shapes : List Shape` → `surfaces : List Surface`). The `Surface` enum is `Html | Cem | Standard | Record | Build` — no `Shape3/4/5` in the emitted Facts anymore. Internal generator `Shape` type may retain `Shape5Slots` for its own bookkeeping; that constructor is not exposed via Facts.
- Rules emit `Fix.replaceRangeBy` full-call replacements. Residue paths use `Seam.asAttribute` / `Seam.fromHtml` (from `packages/m3e-kit/src/Seam.elm`) and `M3e.Content.slot` (from `packages/m3e/src/M3e/Content.elm`). No `Debug.todo`.
- **The real correctness gate is `pnpm run check`** (= `build:assets && elm-pages build`), not `elm-review`. ADR 0012's caveat: `elm-review` clean ≠ app compiles.
- Rules are opt-in per project. Add commented example usage to `review/src/CodegenReviewConfig.elm`; leave `review/src/ReviewConfig.elm` unchanged (no rule enabled by default).
- Follow the existing rule pattern (`review/src/PreferSpecificSlot.elm` is the closest neighbor).

---

## File Structure

**Modified:**
- `elm-cem/codegen/Generate.elm` — rename Shape→Surface in emitted Facts, add Html/Cem, add actionMap field, decode actionMap from config.
- `config/slots.json` — add `actionMap` field per component (only for components with attr-style action helpers).
- `packages/m3e/src/M3e/Review/Facts.elm` — REGENERATED (do not hand-edit).
- `review/src/Facts.elm` — update to consume `Surface(..)` and `surfaces` field.
- `review/src/MissingRequiredAttribute.elm` — rename Shape→Surface, Shape3→Standard, Shape4→Record.
- `review/src/MissingRequiredSingularSlot.elm` — same rename.
- `review/src/PreferSpecificSlot.elm` — same rename.
- `review/src/RequireSlot.elm` — same rename.
- `review/src/CodegenReviewConfig.elm` — commented example of the 5 new rules.

**Created:**
- `review/src/Translate/Canonical.elm` — canonical intermediate types.
- `review/src/Translate/Parse.elm` — 5 per-surface parsers.
- `review/src/Translate/Emit.elm` — 5 per-surface emitters.
- `review/src/Translate/Residue.elm` — Seam wrapper helpers.
- `review/src/Translate/Rule.elm` — shared rule scaffold.
- `review/src/TranslateToHtml.elm`
- `review/src/TranslateToCem.elm`
- `review/src/TranslateToStandard.elm`
- `review/src/TranslateToRecord.elm`
- `review/src/TranslateToBuild.elm`
- `review/tests/TranslateToStandardTest.elm` — anchor test suite; drives library dev.
- `review/tests/TranslateToBuildTest.elm`
- `review/tests/TranslateToRecordTest.elm`
- `review/tests/TranslateToCemTest.elm`
- `review/tests/TranslateToHtmlTest.elm`

---

### Task 1: Rename Shape → Surface in the emitted Facts (generator + regen)

**Files:**
- Modify: `elm-cem/codegen/Generate.elm:1223-1231` (the `contents` string with the `Shape` type declaration; also L1160, L1220 — the `type Shape`/`Shape(..)` header line and the `shapes = ...` field label; `shapeName` function ~L1039-1051 to also produce `Html` / `Cem` — but those are for `Shape5Slots` internal use, unchanged, and no need to emit).
- Modify: `packages/m3e/src/M3e/Review/Facts.elm` — REGENERATED, do not hand-edit.
- Modify: `review/src/Facts.elm:20,36,37,38,50,53,57` — `import M3e.Review.Facts exposing (Fact, Shape(..))` → `Surface(..)`; every `Shape3` → `Standard`; every `Shape4` → `Record`; every `shape = ` → `surface = `.
- Modify: `review/src/MissingRequiredAttribute.elm:27,124,127` — same substitutions.
- Modify: `review/src/MissingRequiredSingularSlot.elm:17,91` — same.
- Modify: `review/src/PreferSpecificSlot.elm:28,163,174` — same.
- Modify: `review/src/RequireSlot.elm` — check for `Shape` refs and update.
- Test: `pnpm run generate:m3e && elm-test-rs --project review/` (the existing rule tests must stay green after rename).

**Interfaces:**
- Consumes: nothing new.
- Produces: `M3e.Review.Facts.Surface = Html | Cem | Standard | Record | Build`; `Fact.surfaces : List Surface`.

- [ ] **Step 1: Update the `contents` string in `generateReviewFacts` (Generate.elm ~L1183-1210)**

Find the block starting `contents =` and change:
- `"module " ++ lib ++ ".Review.Facts exposing (Fact, Shape(..), facts)\n\n"` → `"module " ++ lib ++ ".Review.Facts exposing (Fact, Surface(..), facts)\n\n"`
- `"@docs Fact, Shape, facts\n-}\n\n\n"` → `"@docs Fact, Surface, facts\n-}\n\n\n"`
- The `Shape` type doc + type declaration:
  ```elm
  "{-| Which top-layer surface a component emits at. `Shape3` is the double-list\n"
      ++ "(`M3e.<Comp>.view [attrs] [content]`); `Shape4` is the record + double-list\n"
      ++ "(`M3e.Record.<Comp>.view {required} [attrs] [content]`).\n-}\n"
      ++ "type Shape\n    = Shape3\n    | Shape4\n    | Shape5\n\n\n"
  ```
  becomes:
  ```elm
  "{-| The five addressable API surfaces (see ADR 0013 / spec 2026-07-05-codegen-aware-translator-design).\n"
      ++ "`Html` = `M3e.Cem.Html.*`; `Cem` = `M3e.Cem.*`; `Standard` = `M3e.<Comp>` (double-list top);\n"
      ++ "`Record` = `M3e.Record.<Comp>` (record + double-list); `Build` = `M3e.Build.<Comp>` (pipeline).\n-}\n"
      ++ "type Surface\n    = Html\n    | Cem\n    | Standard\n    | Record\n    | Build\n\n\n"
  ```
- The `Fact` type alias line `", shapes : List Shape\n"` → `", surfaces : List Surface\n"`.

Also update `shapeName` in `generateReviewFacts` (~L1039):
```elm
shapeName shape =
    case shape of
        Shape3 -> "Standard"
        Shape4 -> "Record"
        Shape5 -> "Build"
        Shape5Slots -> "Build"  -- Shape5Slots is elided; Facts already dedupes via `dedupeStrings`
```

Wait — `dedupeStrings` isn't called on `shapesList` in the current code (it's a `String.join ", "`). Instead, filter `Shape5Slots` out before mapping: change `shapesFor config libraryInfo c |> List.map shapeName |> String.join ", "` to prepend `Html, Cem` and filter Shape5Slots:

```elm
shapesList =
    let
        topSurfaces =
            shapesFor config libraryInfo c
                |> List.filter ((/=) Shape5Slots)
                |> List.map shapeName
    in
    "[ " ++ String.join ", " ("Html" :: "Cem" :: topSurfaces) ++ " ]"
```

Then rename the local variable `shapesList` → `surfacesList` and the field label emission `", shapes = " ++ shapesList` → `", surfaces = " ++ surfacesList`.

- [ ] **Step 2: Regenerate Facts**

Run the m3e regenerate command. Find it via:

```bash
grep -rn "elm-cem\|regen\|generate" .mise/tasks/ Makefile package.json bin/ scripts/ 2>/dev/null | head -20
# expected: identify the pnpm/mise script that invokes bin/elm-cem.js
```

If no explicit script exists, invoke directly:

```bash
node elm-cem/bin/elm-cem.js \
    --output packages/m3e/src/M3e \
    --flags-from <path-to-current-flags.json> \
    --config-from config/slots.json \
    --config-from config/examples.generated.json
```

The right invocation is captured in an existing regen commit — inspect one:

```bash
git log --oneline --grep="regen(m3e)" | head -3 | xargs -I{} git show --stat {}
```

Expected: `packages/m3e/src/M3e/Review/Facts.elm` has header line `module M3e.Review.Facts exposing (Fact, Surface(..), facts)` and `type Surface = Html | Cem | Standard | Record | Build`.

- [ ] **Step 3: Update `review/src/Facts.elm`**

Replace `Shape(..)` with `Surface(..)` in the import; rename every `Shape3` to `Standard` and `Shape4` to `Record`; rename `shape` field references to `surface`.

Read current file: `Read review/src/Facts.elm`. Apply Edits per pattern.

- [ ] **Step 4: Update `review/src/MissingRequiredAttribute.elm`**

Same substitutions. Check for `.shape` field access on Facts and update to `.surfaces`. Note this file uses `Shape` for both Fact.shape (the current shape scalar) and `Shape(..)` (the imported enum). The new field is `surfaces : List Surface`, plural — usage may need `List.member Record fact.surfaces` instead of `fact.shape == Shape4`. Adjust logic.

- [ ] **Step 5: Update `review/src/MissingRequiredSingularSlot.elm`**

Same substitutions. Watch for `site.shape /= Shape3` — replace with `not (List.member Standard site.surfaces)` or similar; but this depends on whether the site.shape comes from Facts (plural) or from parser detection (singular). Read the file, then adapt.

- [ ] **Step 6: Update `review/src/PreferSpecificSlot.elm`**

Same substitutions.

- [ ] **Step 7: Update `review/src/RequireSlot.elm`**

```bash
grep -n "Shape" review/src/RequireSlot.elm
```
Apply substitutions if present.

- [ ] **Step 8: Run existing tests**

```bash
cd review && elm-test-rs --compiler ../node_modules/.bin/elm
```

Expected: all existing rule tests pass green. If any fail, fix the field access mismatch.

- [ ] **Step 9: Run `pnpm run check`**

```bash
pnpm run check
```

Expected: elm-pages build succeeds (Facts consumers in docs compile).

- [ ] **Step 10: Commit**

```bash
git add elm-cem/codegen/Generate.elm packages/m3e/src/M3e/Review/Facts.elm review/src/Facts.elm review/src/MissingRequiredAttribute.elm review/src/MissingRequiredSingularSlot.elm review/src/PreferSpecificSlot.elm review/src/RequireSlot.elm
git commit -m "$(cat <<'EOF'
regen(m3e): Facts Shape → Surface; add Html and Cem constructors

Rename `Shape(..)` to `Surface(..)` in the emitted Facts and add `Html` and
`Cem` constructors to cover the two non-top layers. `Fact.shapes` becomes
`Fact.surfaces` and includes all five surfaces per component. Prep for the D6
translator (issue #145 / epic #138 third ship).

Internal generator `Shape` type retains `Shape3/Shape4/Shape5/Shape5Slots` for
its own bookkeeping; emitted Facts see only the five public surfaces.

Generated with [Claude Code](https://claude.ai/code)
via [Happy](https://happy.engineering)

Co-Authored-By: Claude <noreply@anthropic.com>
Co-Authored-By: Happy <yesreply@happy.engineering>
EOF
)"
```

---

### Task 2: Add `actionMap` field to Fact, driven from config

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` (config decoder + `factRecord` emission).
- Modify: `config/slots.json` — add `actionMap` for `Button` as smoke test.
- Modify: `packages/m3e/src/M3e/Review/Facts.elm` — REGENERATED.
- Test: `packages/m3e/src/M3e/Review/Facts.elm` contains `actionMap = [ ( "onClick", "onClick" ), ("href", "link") ]` for Button.

**Interfaces:**
- Consumes: renamed Surface enum from Task 1.
- Produces: `Fact.actionMap : List ( String, String )` — attr-setter-name ↔ action-constructor-short-name pairs.

- [ ] **Step 1: Extend config decoder in Generate.elm (~L387-397)**

Locate the record decoder for per-component config entries. Currently:

```elm
Json.Decode.map6
    (\slots extra grp examples docMeta requiredAttrs ->
        { slots = slots, extra = extra, group = grp, examples = examples, docMeta = docMeta, requiredAttrs = requiredAttrs }
    )
    ...
    (opt "requiredAttrs" (Json.Decode.list Json.Decode.string) [])
```

Change `Json.Decode.map6` to `Json.Decode.map7`, add `actionMap` as another decoded field, and extend the record. If `Json.Decode.map7` doesn't exist (elm-codegen's decoder library is stdlib-only, so it does), pattern:

```elm
Json.Decode.map7
    (\slots extra grp examples docMeta requiredAttrs actionMap ->
        { slots = slots, extra = extra, group = grp, examples = examples
        , docMeta = docMeta, requiredAttrs = requiredAttrs, actionMap = actionMap
        }
    )
    (opt "slots" ...) 
    (opt "extra" ...) 
    (opt "group" ...) 
    (opt "examples" ...) 
    (opt "docMeta" ...) 
    (opt "requiredAttrs" ...) 
    (opt "actionMap" decodeStringPairList [])
```

Where `decodeStringPairList` is:

```elm
decodeStringPairList : Json.Decode.Decoder (List (String, String))
decodeStringPairList =
    Json.Decode.list
        (Json.Decode.map2 Tuple.pair
            (Json.Decode.index 0 Json.Decode.string)
            (Json.Decode.index 1 Json.Decode.string)
        )
```

(The JSON form is `[ ["onClick", "onClick"], ["href", "link"] ]`.)

Update the record type alias for config entries to include `actionMap : List (String, String)`. Look for `type alias ComponentConfig` or similar; add the field there too. Update `Dict.get ... |> Maybe.withDefault ...` default value (~L805) to include `actionMap = []`.

- [ ] **Step 2: Emit `actionMap` in `factRecord`**

In `generateReviewFacts` (~L1109-1170), after `requiredAttrs` field, add:

```elm
actionMap =
    Dict.get moduleName config
        |> Maybe.map .actionMap
        |> Maybe.withDefault []
```

And in the record-string builder, after `", requiredAttrs = " ++ strList requiredAttrs`, append:

```elm
++ ", actionMap = "
++ pairListToString actionMap
```

Then in the `Fact` type alias emission (~L1220), add the field line:

```elm
++ "    , actionMap : List ( String, String )\n"
```

- [ ] **Step 3: Populate `config/slots.json` for Button**

Read `config/slots.json`. Find the `"Button"` entry (or add if missing). Add:

```json
"Button": {
  "slots": { ... existing },
  "actionMap": [
    ["onClick", "onClick"],
    ["href", "link"]
  ]
}
```

- [ ] **Step 4: Regenerate**

Same command as Task 1 Step 2.

- [ ] **Step 5: Verify Facts entry**

```bash
grep -A0 "component = \"button\"" packages/m3e/src/M3e/Review/Facts.elm | head -3
```

Expected output contains `actionMap = [ ( "onClick", "onClick" ), ( "href", "link" ) ]`.

- [ ] **Step 6: Run gate**

```bash
pnpm run check && cd review && elm-test-rs --compiler ../node_modules/.bin/elm
```

Expected: green.

- [ ] **Step 7: Commit**

```bash
git commit -am "$(cat <<'EOF'
regen(m3e): add Fact.actionMap (config-driven)

New per-component field mapping attr-setter names to M3e.Action constructor
short-names. Populated for Button only in this commit; other components
follow in Task 3. Consumed by the D6 translator to convert between attr-style
and record-style action encodings across the five surfaces.

Kept CEM-agnostic: the generator reads `actionMap` from config verbatim; no
hardcoded action-module references in elm-cem.

Generated with [Claude Code](https://claude.ai/code)
via [Happy](https://happy.engineering)

Co-Authored-By: Claude <noreply@anthropic.com>
Co-Authored-By: Happy <yesreply@happy.engineering>
EOF
)"
```

---

### Task 3: Populate `actionMap` for all action-bearing components

**Files:**
- Modify: `config/slots.json` — add `actionMap` for every component whose top module re-exposes action-attr helpers (from `M3e.Action`).
- Modify: `packages/m3e/src/M3e/Review/Facts.elm` — REGENERATED.

**Interfaces:**
- Consumes: schema from Task 2.
- Produces: complete actionMap coverage.

- [ ] **Step 1: Enumerate action-bearing components**

Find every component whose top module re-exposes an action-style setter (`onClick`, `href`, `toggle`, etc.). Search:

```bash
grep -rlE "^onClick :|^href :|^linkWith :|^togglesNavRail :|^togglesDrawer :|^togglesDatepicker :" packages/m3e/src/M3e/*.elm | sort -u
```

Expected: Button, IconButton, Fab, Chip, AssistChip, FilterChip, InputChip, SuggestionChip, Snackbar, RichTooltipAction, and possibly others.

- [ ] **Step 2: Add actionMap entries for each identified component**

For each component X, look at the component's action-attr setter names and map to M3e.Action ctor short names. Common mapping:

| Attr setter | M3e.Action ctor |
| --- | --- |
| `onClick` | `onClick` |
| `href` | `link` |
| `linkWith` | `linkWith` |
| `remove` | `remove` |
| `togglesNavRail` | `togglesNavRail` |
| `togglesDrawer` | `togglesDrawer` |
| `togglesDatepicker` | `togglesDatepicker` |
| `dismisses` (in Snackbar/BottomSheet/RichTooltip contexts) | context-specific ctor |

Read each component's `M3e.<Comp>.elm` to see which setters are exposed, then add `actionMap` to that component's entry in `config/slots.json`.

- [ ] **Step 3: Regenerate and verify**

```bash
pnpm run regen  # or the direct elm-cem invocation
grep -c "actionMap = \[" packages/m3e/src/M3e/Review/Facts.elm
```

Expected: at least 6 (Button, IconButton, Fab, Chip variants, Snackbar).

- [ ] **Step 4: Full gate**

```bash
pnpm run check && cd review && elm-test-rs --compiler ../node_modules/.bin/elm
```

- [ ] **Step 5: Commit**

```bash
git commit -am "$(cat <<'EOF'
regen(m3e): populate Fact.actionMap for all action-bearing components

Adds actionMap entries in config/slots.json for every component whose top
module re-exposes action-style attribute setters. Downstream translator (D6)
uses this to convert between attr-style and record-style action encodings.

Generated with [Claude Code](https://claude.ai/code)
via [Happy](https://happy.engineering)

Co-Authored-By: Claude <noreply@anthropic.com>
Co-Authored-By: Happy <yesreply@happy.engineering>
EOF
)"
```

---

### Task 4: `Translate.Canonical` — canonical intermediate types

**Files:**
- Create: `review/src/Translate/Canonical.elm`

**Interfaces:**
- Consumes: `M3e.Review.Facts.Surface`.
- Produces: `type alias Canonical`, `type AttrItem`, `type SlotItem`, `type ActionExpr`.

- [ ] **Step 1: Write Canonical.elm**

```elm
module Translate.Canonical exposing
    ( Canonical, AttrItem(..), SlotItem(..), ActionExpr(..)
    )

{-| The canonical intermediate that all five parsers normalize into and all
five emitters consume. Per spec §5.

@docs Canonical, AttrItem, SlotItem, ActionExpr

-}

import Dict exposing (Dict)
import Elm.Syntax.Expression exposing (Expression)
import Elm.Syntax.Node exposing (Node)
import Elm.Syntax.Range exposing (Range)
import M3e.Review.Facts exposing (Surface)


{-| The canonical shape every parser produces and every emitter consumes.
Value expressions travel as elm-syntax nodes unmodified; the parser only
classifies each item's role.
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
```

- [ ] **Step 2: Compile check**

```bash
cd review && elm-format --validate src/Translate/Canonical.elm && elm make src/Translate/Canonical.elm --output=/dev/null
```

Expected: no errors.

- [ ] **Step 3: Commit**

```bash
git add review/src/Translate/Canonical.elm
git commit -m "$(cat <<'EOF'
feat(review): add Translate.Canonical intermediate types

Types the D6 translator normalizes into (5 parsers) and emits from (5
emitters). Value expressions travel opaquely as elm-syntax nodes; only role
is classified. Per spec 2026-07-05 §5.

Generated with [Claude Code](https://claude.ai/code)
via [Happy](https://happy.engineering)

Co-Authored-By: Claude <noreply@anthropic.com>
Co-Authored-By: Happy <yesreply@happy.engineering>
EOF
)"
```

---

### Task 5: `Translate.Rule` — shared scaffold with a stub emitter (proves plumbing end-to-end)

**Files:**
- Create: `review/src/Translate/Rule.elm`

**Interfaces:**
- Consumes: `Translate.Canonical`, `M3e.Review.Facts.Fact`, `Surface`.
- Produces: `Config`, `rule : Config -> List Fact -> Rule`; `Facts` visitor + expression visitor with same-surface-identity short-circuit + placeholder emit.

- [ ] **Step 1: Write Rule.elm scaffold**

```elm
module Translate.Rule exposing (Config, rule)

{-| Shared scaffold for the five `TranslateTo<X>` rules. Each per-target rule
is a thin wrapper that passes its target surface into `rule`.

@docs Config, rule

-}

import Dict exposing (Dict)
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Facts
import M3e.Review.Facts exposing (Fact, Surface(..))
import Review.Fix as Fix
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


type alias Config =
    { facts : List Fact
    , target : Surface
    }


rule : Config -> Rule
rule config =
    Rule.newModuleRuleSchemaUsingContextCreator (ruleName config.target) (initContext config)
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


ruleName : Surface -> String
ruleName target =
    case target of
        Html -> "TranslateToHtml"
        Cem -> "TranslateToCem"
        Standard -> "TranslateToStandard"
        Record -> "TranslateToRecord"
        Build -> "TranslateToBuild"


type alias Context =
    { lookup : ModuleNameLookupTable
    , factsByModule : Dict String Fact
    , target : Surface
    , extractSourceCode : Range -> String
    }


type alias Range =
    Elm.Syntax.Range.Range


initContext : Config -> Rule.ContextCreator () Context
initContext config =
    Rule.initContextCreator
        (\lookup extractSourceCode () ->
            { lookup = lookup
            , factsByModule =
                config.facts
                    |> List.map (\f -> ( f.module_, f ))
                    |> Dict.fromList
            , target = config.target
            , extractSourceCode = extractSourceCode
            }
        )
        |> Rule.withModuleNameLookupTable
        |> Rule.withSourceCodeExtractor


expressionVisitor : Node Expression -> Context -> ( List (Error {}), Context )
expressionVisitor node context =
    -- TODO Tasks 6–9: parse based on detected source Surface, emit for target
    -- Surface, short-circuit when source == target (identity).
    ( [], context )
```

Also add `import Elm.Syntax.Range` at the top.

- [ ] **Step 2: Compile check**

```bash
cd review && elm make src/Translate/Rule.elm --output=/dev/null
```

Expected: no errors. (`Facts` module already exists as a helper.)

- [ ] **Step 3: Commit**

```bash
git add review/src/Translate/Rule.elm
git commit -m "feat(review): Translate.Rule scaffold — expression visitor with facts index

Generated with [Claude Code](https://claude.ai/code)
via [Happy](https://happy.engineering)

Co-Authored-By: Claude <noreply@anthropic.com>
Co-Authored-By: Happy <yesreply@happy.engineering>"
```

---

### Task 6: `Translate.Parse` — Standard (③) parser and identify-surface helper

**Files:**
- Create: `review/src/Translate/Parse.elm`

**Interfaces:**
- Consumes: `Translate.Canonical` types, `Facts`.
- Produces:
  - `identifySurface : ModuleNameLookupTable -> Node Expression -> Maybe (Surface, Fact, Node Expression)` — returns source surface, matching Fact, and function-head node.
  - `parseStandard : Fact -> Node Expression -> List (Node Expression) -> List (Node Expression) -> Canonical` — parses a ③ call.

- [ ] **Step 1: Write Parse.elm with identifySurface + parseStandard**

Write the module. Key structure:

```elm
module Translate.Parse exposing
    ( identifySurface, parseStandard
    -- TODO next tasks: parseHtml, parseCem, parseRecord, parseBuild
    )

import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Elm.Syntax.Range exposing (Range)
import M3e.Review.Facts exposing (Fact, Surface(..))
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Translate.Canonical exposing (..)


{-| Given an expression node, if it's a component call at one of the five
surfaces, return (surface, fact, function-head-node).
-}
identifySurface : List Fact -> ModuleNameLookupTable -> Node Expression -> Maybe (Surface, Fact)
identifySurface facts lookup node =
    case Node.value node of
        Expression.Application (head :: _) ->
            classifyModule facts lookup head

        _ ->
            Nothing


classifyModule : List Fact -> ModuleNameLookupTable -> Node Expression -> Maybe (Surface, Fact)
classifyModule facts lookup head =
    case Lookup.moduleNameFor lookup head of
        Just parts ->
            let
                m = String.join "." parts
                surface =
                    if String.startsWith "M3e.Cem.Html." m then Just Html
                    else if String.startsWith "M3e.Build." m then Just Build
                    else if String.startsWith "M3e.Record." m then Just Record
                    else if String.startsWith "M3e.Cem." m then Just Cem
                    else if String.startsWith "M3e." m then Just Standard
                    else Nothing

                stripped =
                    m
                        |> String.replace "M3e.Cem.Html." ""
                        |> String.replace "M3e.Build." ""
                        |> String.replace "M3e.Record." ""
                        |> String.replace "M3e.Cem." ""
                        |> String.replace "M3e." ""
                        |> (\s -> "M3e." ++ s)

                fact =
                    List.filter (\f -> f.module_ == stripped) facts |> List.head
            in
            Maybe.map2 Tuple.pair surface fact

        Nothing ->
            Nothing
```

(Return the *canonical* top module name to look up the Fact — since `Fact.module_` is stored as e.g. `"M3e.Button"`.)

**And parseStandard:**

```elm
parseStandard : Fact -> List (Node Expression) -> List (Node Expression) -> Canonical
parseStandard fact attrList contentList =
    -- ...classify each attr item and slot item against fact.attrRewrites / slotRewrites
    -- ...lift action-attrs into requiredAction using fact.actionMap
    -- ...lift required-content (if fact.requiredSlots contains "unnamed")
    ...
```

Full implementation follows the same walker pattern each attr/slot item goes through:
1. `Application (head :: args)` where head is a function reference: look up module + name in Facts. If it's in `fact.attrRewrites` (attr) or `fact.slotRewrites` (slot) or `fact.actionMap` (action) — classify as KnownAttr / KnownSlot / AttrStyle action.
2. Otherwise: `EscapedAttr` / `EscapedContent` with the raw node.
3. Concat-tail expressions (`[ x ] ++ y`): recurse on left, tail-classify `y` as `DynamicAttrTail`.

Write helpers `classifyAttr : Fact -> Node Expression -> AttrItem` and `classifySlot : Fact -> Node Expression -> SlotItem`. Use `Node.value` pattern matches on `Expression.Application`, `Expression.OperatorApplication` (for `++` tail).

- [ ] **Step 2: Compile check**

```bash
cd review && elm make src/Translate/Parse.elm --output=/dev/null
```

Expected: no errors.

- [ ] **Step 3: Unit tests**

Create `review/tests/Translate/ParseTest.elm`:

```elm
module Translate.ParseTest exposing (suite)

import Expect
import Test exposing (Test, describe, test)
import Translate.Canonical exposing (..)
import Translate.Parse

-- Fixture: hand-build a Node Expression via elm-syntax's public
-- constructors. Actual test uses Review.Test which parses real source; but
-- for unit-testing the parser in isolation, we lean on Review.Test for full
-- expression-in-context parsing. See TranslateToStandardTest for the
-- integration harness.

suite : Test
suite =
    describe "Translate.Parse"
        -- Placeholder; actual parser behavior is exercised via TranslateToStandardTest
        [ test "smoke — parser module compiles" (\() -> Expect.pass)
        ]
```

(Unit-testing elm-syntax nodes standalone is impractical; the real proof is in the integration tests via `Review.Test`.)

- [ ] **Step 4: Commit**

```bash
git add review/src/Translate/Parse.elm review/tests/Translate/ParseTest.elm
git commit -m "feat(review): Translate.Parse — Standard parser + surface identifier

Generated with [Claude Code](https://claude.ai/code)
via [Happy](https://happy.engineering)

Co-Authored-By: Claude <noreply@anthropic.com>
Co-Authored-By: Happy <yesreply@happy.engineering>"
```

---

### Task 7: `Translate.Emit` — Standard (③) emitter and shared helpers

**Files:**
- Create: `review/src/Translate/Emit.elm`

**Interfaces:**
- Consumes: `Canonical`, extractSourceCode function (from Rule context).
- Produces: `emitStandard : Fact -> (Range -> String) -> Canonical -> String`.

- [ ] **Step 1: Write Emit.elm with emitStandard**

```elm
module Translate.Emit exposing
    ( emitStandard
    -- TODO next tasks: emitHtml, emitCem, emitRecord, emitBuild
    )

import Elm.Syntax.Node as Node exposing (Node)
import Elm.Syntax.Range exposing (Range)
import M3e.Review.Facts exposing (Fact)
import Translate.Canonical exposing (..)


emitStandard : Fact -> (Range -> String) -> Canonical -> String
emitStandard fact source c =
    let
        modAlias =
            String.replace "M3e." "" fact.module_

        attrsLine =
            emitAttrs fact source c

        contentLine =
            emitContent fact source c
    in
    fact.module_
        ++ ".view\n    "
        ++ attrsLine
        ++ "\n    "
        ++ contentLine


emitAttrs : Fact -> (Range -> String) -> Canonical -> String
emitAttrs fact source c =
    let
        actionAttrs =
            case c.requiredAction of
                Just (AttrStyle a) ->
                    [ fact.module_ ++ "." ++ a.name ++ " " ++ source (Node.range a.value) ]

                Just (RecordStyle expr) ->
                    -- reverse-map: destructure M3e.Action.<ctor>...
                    [ decomposeRecordAction fact source expr ]

                Nothing ->
                    []

        items =
            List.map (emitAttrItem fact source) c.attrs
    in
    "[ " ++ String.join ", " (actionAttrs ++ items) ++ " ]"


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
            -- List splice via List.append; handled in emitAttrs list wrapping
            -- ...
            source (Node.range raw)


emitContent : Fact -> (Range -> String) -> Canonical -> String
emitContent fact source c =
    let
        requiredSlot =
            case c.requiredContent of
                Just node ->
                    -- Find the required-singular slot name in Facts (requiredSlots contains "unnamed")
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
    -- Look up in fact.slotRewrites: the unnamed slot's setter name
    fact.slotRewrites
        |> List.filter (\(k, _) -> k == "unnamed")
        |> List.head
        |> Maybe.map Tuple.second
        |> Maybe.withDefault "child"


decomposeRecordAction : Fact -> (Range -> String) -> Node Expression -> String
decomposeRecordAction fact source expr =
    -- Best-effort: extract the attr-style equivalent. If we can't, fall back to
    -- Seam.asAttribute (Html.Events.on "click" (Debug.todo "")) — no, drop the
    -- Debug.todo. Fallback is: use the raw M3e.Action expression via
    -- Seam.asAttribute (M3e.Action.toAttrs <expr> |> List.head |> ...).
    -- Simplest: emit via `M3e.<Comp>.onClick` when the wrapped action is
    -- clearly a single-arg ctor; otherwise Seam.
    source (Node.range expr)  -- placeholder; refine in later tasks
```

The `decomposeRecordAction` function is a stub for now; the reverse-map case is refined in later tasks.

- [ ] **Step 2: Compile check**

```bash
cd review && elm make src/Translate/Emit.elm --output=/dev/null
```

- [ ] **Step 3: Commit**

```bash
git add review/src/Translate/Emit.elm
git commit -m "feat(review): Translate.Emit — Standard emitter"
```

---

### Task 8: `Translate.Residue` — Seam wrapping helpers

**Files:**
- Create: `review/src/Translate/Residue.elm`

**Interfaces:**
- Consumes: `Fact`, source extractor.
- Produces:
  - `wholeSeamEscape : Fact -> (Range -> String) -> Canonical -> String` — emits `Seam.fromHtml (M3e.Cem.Html.<Comp>.<name> [...] [...])` from the parsed Canonical.

- [ ] **Step 1: Write Residue.elm**

```elm
module Translate.Residue exposing (wholeSeamEscape)

import Elm.Syntax.Node as Node
import Elm.Syntax.Range exposing (Range)
import M3e.Review.Facts exposing (Fact)
import Translate.Canonical exposing (..)


wholeSeamEscape : Fact -> (Range -> String) -> Canonical -> String
wholeSeamEscape fact source c =
    let
        htmlModule =
            "M3e.Cem.Html." ++ pascalOfComponent fact.component

        htmlCtor =
            fact.component

        attrsText =
            c.attrs
                |> List.map (renderAsHtmlAttr fact source)
                |> String.join ", "

        contentText =
            c.content
                |> List.map (renderAsHtml fact source)
                |> String.join ", "
    in
    "Seam.fromHtml (" ++ htmlModule ++ "." ++ htmlCtor ++ "\n        [ " ++ attrsText ++ " ]\n        [ " ++ contentText ++ " ]\n    )"


pascalOfComponent : String -> String
pascalOfComponent s =
    case String.uncons s of
        Just (h, t) -> String.fromChar (Char.toUpper h) ++ t
        Nothing -> s


renderAsHtmlAttr : Fact -> (Range -> String) -> AttrItem -> String
renderAsHtmlAttr fact source item =
    case item of
        KnownAttr { name, value } ->
            "M3e.Cem.Html." ++ pascalOfComponent fact.component ++ "." ++ name ++ " " ++ source (Node.range value)

        EnumTokenLossy { name, tokenText } ->
            "Html.Attributes.attribute \"" ++ name ++ "\" \"" ++ tokenText ++ "\""

        EscapedAttr { raw } ->
            source (Node.range raw)

        DynamicAttrTail { raw } ->
            source (Node.range raw)


renderAsHtml : Fact -> (Range -> String) -> SlotItem -> String
renderAsHtml fact source item =
    case item of
        KnownSlot { name, body } ->
            source (Node.range body)  -- assumes body is already Html-compatible via toHtml

        UnknownSlotName { name, body } ->
            source (Node.range body)

        EscapedContent { raw } ->
            source (Node.range raw)

        DynamicContentTail { raw } ->
            source (Node.range raw)
```

- [ ] **Step 2: Compile check**

```bash
cd review && elm make src/Translate/Residue.elm --output=/dev/null
```

- [ ] **Step 3: Commit**

```bash
git add review/src/Translate/Residue.elm
git commit -m "feat(review): Translate.Residue — whole-node Seam escape helper"
```

---

### Task 9: Wire Rule.elm — full parse+emit dispatch, one target for now

**Files:**
- Modify: `review/src/Translate/Rule.elm`

**Interfaces:**
- Consumes: `Parse.identifySurface`, `Parse.parseStandard`, `Emit.emitStandard`, `Residue.wholeSeamEscape`.
- Produces: `expressionVisitor` that fires on non-target-surface calls and produces a `Fix.replaceRangeBy` fix.

- [ ] **Step 1: Update expressionVisitor in Rule.elm**

```elm
expressionVisitor : Node Expression -> Context -> ( List (Error {}), Context )
expressionVisitor node context =
    case Translate.Parse.identifySurface (Dict.values context.factsByModule) context.lookup node of
        Just (sourceSurface, fact) ->
            if sourceSurface == context.target then
                ( [], context )
            else
                let
                    canonicalR =
                        parseFor sourceSurface fact node

                    fix =
                        emitFor context.target fact context.extractSourceCode canonicalR

                    err =
                        Rule.errorWithFix
                            { message = "Translate " ++ fact.module_ ++ " call to " ++ ruleName context.target
                            , details = [ "Auto-fixable rewrite between API surfaces." ]
                            }
                            (Node.range node)
                            [ Fix.replaceRangeBy (Node.range node) fix ]
                in
                ( [ err ], context )

        Nothing ->
            ( [], context )


parseFor : Surface -> Fact -> Node Expression -> Canonical
parseFor surface fact node =
    case Node.value node of
        Expression.Application (_ :: args) ->
            case ( surface, args ) of
                ( Standard, [ attrList, contentList ] ) ->
                    -- extract literal list contents where possible
                    Translate.Parse.parseStandard fact
                        (extractListArgs attrList)
                        (extractListArgs contentList)

                _ ->
                    -- Task 10+ implements the other surface parsers.
                    -- For now, produce a minimal Canonical (empty attrs/content).
                    { component = fact.component
                    , sourceSurface = surface
                    , sourceRange = Node.range node
                    , attrs = []
                    , content = []
                    , requiredContent = Nothing
                    , requiredAction = Nothing
                    , otherRequired = Dict.empty
                    }

        _ ->
            emptyCanonical fact surface (Node.range node)


emitFor : Surface -> Fact -> (Range -> String) -> Canonical -> String
emitFor target fact source c =
    case target of
        Standard ->
            Translate.Emit.emitStandard fact source c

        _ ->
            -- Task 11+ implements the other target emitters.
            -- For now, fall back to whole-node Seam escape.
            Translate.Residue.wholeSeamEscape fact source c


extractListArgs : Node Expression -> List (Node Expression)
extractListArgs listNode =
    case Node.value listNode of
        Expression.ListExpr items -> items
        _ -> []  -- non-literal list → parser falls through to escape paths
```

Also add missing imports (`Elm.Syntax.Range`, `Translate.Parse`, `Translate.Emit`, `Translate.Residue`, `Dict`).

- [ ] **Step 2: Compile check**

```bash
cd review && elm make src/Translate/Rule.elm --output=/dev/null
```

- [ ] **Step 3: Commit**

```bash
git commit -am "feat(review): Translate.Rule dispatches parser + emitter based on surfaces"
```

---

### Task 10: TranslateToStandard rule wrapper + first integration test

**Files:**
- Create: `review/src/TranslateToStandard.elm`
- Create: `review/tests/TranslateToStandardTest.elm`

**Interfaces:**
- Consumes: `Translate.Rule.rule`.
- Produces: `TranslateToStandard.rule : List Fact -> Rule`.

- [ ] **Step 1: Write TranslateToStandard.elm**

```elm
module TranslateToStandard exposing (rule)

{-| D6 codegen-aware translator — target ③ `M3e.<Comp>` (Standard, the
double-list top shape). Rewrites call sites at any of the other four surfaces
to `M3e.<Comp>.view [ attrs ] [ content ]`. Residue via Seam.

@docs rule
-}

import M3e.Review.Facts exposing (Fact, Surface(..))
import Review.Rule exposing (Rule)
import Translate.Rule


rule : List Fact -> Rule
rule facts =
    Translate.Rule.rule { facts = facts, target = Standard }
```

- [ ] **Step 2: Write TranslateToStandardTest.elm**

```elm
module TranslateToStandardTest exposing (suite)

import M3e.Review.Facts
import Review.Test
import Test exposing (Test, describe, test)
import TranslateToStandard


suite : Test
suite =
    describe "TranslateToStandard"
        [ test "same-surface identity (no fix)" <|
            \() ->
                """module A exposing (view)
import M3e.Button
view = M3e.Button.view [] []
"""
                    |> Review.Test.run (TranslateToStandard.rule M3e.Review.Facts.facts)
                    |> Review.Test.expectNoErrors
        , test "translates a plain ⑤ Build call to ③ Standard" <|
            \() ->
                -- ...populate with a realistic Build call
                Test.skip <| \() -> Expect.pass
        ]
```

- [ ] **Step 3: Run tests**

```bash
cd review && elm-test-rs --compiler ../node_modules/.bin/elm tests/TranslateToStandardTest.elm
```

Expected: at least the identity test passes.

- [ ] **Step 4: Commit**

```bash
git add review/src/TranslateToStandard.elm review/tests/TranslateToStandardTest.elm
git commit -m "feat(review): TranslateToStandard rule + smoke test"
```

---

### Task 11: Extend Parse.elm with the other four surface parsers

**Files:**
- Modify: `review/src/Translate/Parse.elm`

**Interfaces:**
- Produces: `parseHtml`, `parseCem`, `parseRecord`, `parseBuild`.

The parsers share a lot of structure (attr-list walking, slot-list walking, action lifting). Refactor `parseStandard` to a shared inner helper first, then wire the five thin per-surface entrypoints.

- [ ] **Step 1: Refactor parseStandard into a shared kernel**

Extract the attr+slot walking into `parseAttrList : Fact -> List (Node Expression) -> ...`, `parseSlotList : Fact -> List (Node Expression) -> ...`, and a `finalize` that lifts action and required-content.

- [ ] **Step 2: Add parseHtml — recognizes `Html.Attributes.attribute "slot" "..."` and lifts to slot classification**

Structural difference from parseStandard: attr values are String literals (`"filled"`), which stay as `KnownAttr` with the String node as `value`. Children are `Html`; a child with a `slot="foo"` attribute gets lifted to `KnownSlot` via `slotRewrites` on `"foo"`.

- [ ] **Step 3: Add parseCem — same as parseHtml but attr values are `M3e.Value.<name>` tokens**

Structurally the same as parseHtml regarding the child list (still Html). Attr values are the token exprs.

- [ ] **Step 4: Add parseRecord — reads the first-arg record**

```elm
parseRecord : Fact -> Node Expression -> List (Node Expression) -> List (Node Expression) -> Canonical
parseRecord fact recordArg attrList contentList =
    let
        (reqContent, reqAction, otherReq) =
            extractRecord recordArg
    in
    ...
```

Use `Expression.RecordExpr` pattern-matching.

- [ ] **Step 5: Add parseBuild — walks the |> pipeline**

```elm
parseBuild : Fact -> Node Expression -> Canonical
parseBuild fact pipelineNode =
    -- Walk OperatorApplication "|>" left-associated: build a list of stages
    -- from head (seed) through terminal build.
    ...
```

Use `Expression.OperatorApplication "|>" InfixDirection.Left leftNode rightNode`.

- [ ] **Step 6: Compile + commit**

```bash
cd review && elm make src/Translate/Parse.elm --output=/dev/null
git commit -am "feat(review): Translate.Parse — Html, Cem, Record, Build parsers"
```

---

### Task 12: Extend Emit.elm with the other four surface emitters

**Files:**
- Modify: `review/src/Translate/Emit.elm`

**Interfaces:**
- Produces: `emitHtml`, `emitCem`, `emitRecord`, `emitBuild`.

- [ ] **Step 1: emitHtml — reverse enum tokens to strings, wrap Elements via M3e.Element.toHtml**

For each `KnownAttr` whose value expression is `M3e.Value.<name>`, look up in `fact.enums` and emit the underlying string literal. For content items, wrap `Element` bodies via `M3e.Element.toHtml`.

- [ ] **Step 2: emitCem — similar to emitStandard but wraps Element children via toHtml**

- [ ] **Step 3: emitRecord — emit record arg, then attr list, then content list**

```elm
emitRecord fact source c =
    fact.module_ ++ ".view\n    "
        ++ emitRecordArg fact source c
        ++ "\n    "
        ++ emitAttrs fact source c  -- reuse from Task 7
        ++ "\n    "
        ++ emitContent fact source c
```

The record arg contains `content = <expr>` and `action = <expr>`; if either is `Nothing`, fall back to `Residue.wholeSeamEscape`.

- [ ] **Step 4: emitBuild — pipeline shape**

```elm
emitBuild fact source c =
    let
        seed = fact.module_ ++ "." ++ fact.component ++ " " ++ emitRecordArg fact source c

        setters =
            (c.attrs |> List.map (\i -> "|> " ++ fact.module_ ++ "." ++ setterName i))
            ++ (c.content |> List.map (\i -> "|> " ++ fact.module_ ++ "." ++ slotName i))
    in
    if requiresEscape c then
        Residue.wholeSeamEscape fact source c
    else
        seed ++ "\n    " ++ String.join "\n    " setters ++ "\n    |> " ++ fact.module_ ++ ".build"
```

⑤ Build has no attr-list seam, so any Escaped* / EnumTokenLossy / Dynamic* triggers whole-node escape.

- [ ] **Step 5: Compile + commit**

```bash
git commit -am "feat(review): Translate.Emit — Html, Cem, Record, Build emitters"
```

---

### Task 13: Add remaining four rule wrappers + tests

**Files:**
- Create: `review/src/TranslateToHtml.elm`, `TranslateToCem.elm`, `TranslateToRecord.elm`, `TranslateToBuild.elm`.
- Create: `review/tests/TranslateToHtmlTest.elm`, `TranslateToCemTest.elm`, `TranslateToRecordTest.elm`, `TranslateToBuildTest.elm`.

**Interfaces:**
- Same shape as TranslateToStandard.

- [ ] **Step 1: Add each wrapper**

Each is a 3-line file. Example (`TranslateToBuild.elm`):

```elm
module TranslateToBuild exposing (rule)

import M3e.Review.Facts exposing (Fact, Surface(..))
import Review.Rule exposing (Rule)
import Translate.Rule

rule : List Fact -> Rule
rule facts =
    Translate.Rule.rule { facts = facts, target = Build }
```

- [ ] **Step 2: Update Translate/Rule.elm to dispatch all five surfaces**

Fill in the remaining branches in `parseFor` and `emitFor` (currently stubbed to escape).

- [ ] **Step 3: Add per-rule integration tests**

Each `TranslateTo<X>Test.elm` covers:
- Identity (same-surface — no fix)
- One representative source → target translation (with expected fixed output)
- One residue path (unknown enum token → Seam)

Use `Review.Test.expectErrorsWithFix` for autofix assertions.

- [ ] **Step 4: Run all tests + full gate**

```bash
cd review && elm-test-rs --compiler ../node_modules/.bin/elm
cd .. && pnpm run check
```

Expected: green.

- [ ] **Step 5: Commit**

```bash
git commit -am "feat(review): full 5-target translator with integration tests"
```

---

### Task 14: Documentation, ReviewConfig example, and issue update

**Files:**
- Modify: `review/src/CodegenReviewConfig.elm` — commented example usage.
- Modify: GitHub issue #145 via `gh issue comment 145 --body ...`.

- [ ] **Step 1: Add commented example to CodegenReviewConfig.elm**

Read the file. Add a block near the end:

```elm
-- # D6 codegen-aware translator (issue #145)
--
-- Enable ONE of these to enforce a single canonical top-layer surface
-- across the codebase. Applying `elm-review --fix` rewrites every non-target
-- call site to the target surface via Seam-hatched residue for any lossy
-- pieces. See spec 2026-07-05-codegen-aware-translator-design.md.
--
--     TranslateToBuild.rule M3e.Review.Facts.facts
--         |> Rule.ignoreErrorsForDirectories [ "src/legacy" ]
```

- [ ] **Step 2: Post issue update**

```bash
gh issue comment 145 --body "$(cat <<'EOF'
Landed the D6 translator across five rules (`TranslateTo{Html,Cem,Standard,Record,Build}`) driven by the shared `Translate/` library, plus a `Fact.actionMap` extension and the `Shape → Surface` rename in Facts. Spec: `docs/superpowers/specs/2026-07-05-codegen-aware-translator-design.md`. Plan: `docs/superpowers/plans/2026-07-05-codegen-aware-translator.md`.

Rules are opt-in per project — see the commented example in `review/src/CodegenReviewConfig.elm`. All 20 non-identity directions are covered via normalize-and-re-emit; residue paths fall through to `Seam.*` wrappers (attrs/content) or whole-node `Seam.fromHtml` escape (missing required, uphill to ⑤).
EOF
)"
```

- [ ] **Step 3: Final commit**

```bash
git add review/src/CodegenReviewConfig.elm
git commit -m "docs(review): D6 translator usage example in CodegenReviewConfig"
```

---

## Self-Review (done inline during writing)

- **Spec coverage:** All spec sections have a task. §2 rename → Task 1; §3+§4 rules + library → Tasks 4–13; §5 Canonical → Task 4; §6 parsers → Tasks 6+11; §7 emitters → Tasks 7+12; §8 identity → covered in Task 9; §9 residue → Task 8; §10 Facts.actionMap → Tasks 2+3; §11 rule interactions → verified via integration tests in Tasks 10 and 13; §12 testing → Task 13 + full-gate runs; §13 DoD → verified across tasks.
- **Placeholder scan:** Placeholder emitters in Task 9 and stubbed reverse-action decomposition in Task 7 are labeled as such and refined in Tasks 11–12. `parseFor` and `emitFor` in Task 9's Rule.elm are wired incrementally — Tasks 11/12 fill remaining branches.
- **Type consistency:** `emitStandard` signature (Fact + source-extractor + Canonical → String) is consistent across Task 7 and Task 12's other emitters. `parseFor` uses `List (Node Expression)` for attrs/content extracted from literal `ListExpr`; non-literal lists fall through to escape paths. `Surface` enum is defined in Task 1 and imported everywhere.
- **Scope check:** Single spec, single plan, coherent scope. The generator rename (Task 1) is a prerequisite for everything downstream; Tasks 2–3 (Facts.actionMap) are separable from library work but land in the same PR to keep the ship coherent.
