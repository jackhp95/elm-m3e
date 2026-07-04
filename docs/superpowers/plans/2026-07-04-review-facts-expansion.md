# Review Facts Expansion — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Finalize `M3e.Review.Facts` schema so the five first-ship rules (D1–D5)
have every fact they need. Replaces Task 7's PROVISIONAL fields with a
stable, shape-agnostic schema, sourced from `config/slots.json`.

**Architecture:** `M3e.Review.Facts` is per-COMPONENT and shape-agnostic. The
generator (`elm-cem/codegen/Generate.elm::generateReviewFacts`) is rewritten
to emit new fields: `attrRewrites`, `slotRewrites`, typed `shapes : List Shape`,
and config-sourced `requiredAttrs`. Existing rules (`ValidEnumValue`,
`SingularSlot`, `RequireSlot`) touch none of the new fields and require no
migration.

**Tech Stack:** Elm 0.19.1; `mdgriffith/elm-codegen@0.6.3`; `elm-cem` generator
(Node.js CLI + Elm codegen); pnpm; existing `M3e.Review.Facts` module.

## Global Constraints

- Governing spec: `docs/superpowers/specs/2026-07-04-review-facts-expansion-design.md`.
- Governing ADR: `docs/adr/0012-codegen-aware-elm-review.md`.
- Cross-spec invariants: `docs/superpowers/specs/2026-07-03-epic-138-shipping-coordination.md`.
- Facts is per-component, shape-agnostic. Every `requiredAttrs` fact is drawn
  from `config/slots.json` — no CEM-inspection heuristics in the generator.
- Existing rules (`ValidEnumValue`, `SingularSlot`, `RequireSlot`) must
  continue to compile and pass their existing `review/tests/` suite without
  modification.
- Generator changes land in the `/elm-cem/` working clone (upstream repo,
  gitignored here); the outer repo's commit is limited to (a) the config
  authoring in `config/slots.json` and (b) the regenerated
  `packages/m3e/src/M3e/Review/Facts.elm`.
- The regen command (see HANDOFF.md L59-63):
  ```
  PATH="/Users/jhp/code/jackhp95/elm-m3e/elm-cem/node_modules/.bin:$PATH" \
    node elm-cem/bin/elm-cem.js \
      --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json \
      --config-from=config/slots.json \
      --config-from=config/examples.generated.json \
      --output=packages/m3e/src
  ```
  Use the ABSOLUTE PATH prefix — relative paths break when elm-codegen changes
  cwd internally.

---

### Task 1: Emit the new Fact schema with `Shape` type

**Files:**
- Modify: `elm-cem/codegen/Generate.elm::generateReviewFacts` (~L828-958)

**Interfaces:**
- Consumes: existing `shapesFor : Config -> LibraryInfo -> Cem.Declaration -> List Shape`, existing `Config` type.
- Produces: `Fact` schema with new fields (`attrRewrites : List (String, String)`, `slotRewrites : List (String, String)`, `shapes : List Shape`, `requiredAttrs : List String`). For this task, `attrRewrites` and `slotRewrites` are emitted as empty lists (populated in Tasks 2-3). `shapes` uses the real `Shape` constructor (not string names). `requiredAttrs` uses the existing PROVISIONAL heuristic for now (replaced in Task 4).

- [ ] **Step 1: Update the emitted Fact type alias**

In `generateReviewFacts`'s `contents` string, replace the `type alias Fact` block. Find the lines that emit:

```elm
"type alias Fact =\n"
    ++ "    { component : String\n"
    ++ "    , module_ : String\n"
    ++ "    , enums : List ( String, List String )\n"
    ++ "    , requiredSlots : List String\n"
    ++ "    , multiSlots : List String\n"
    ++ "    , shapes : List String -- PROVISIONAL, may change\n"
    ++ "    , requiredAttrs : List String -- PROVISIONAL, may change\n"
    ++ "    }\n\n\n"
```

Replace with:

```elm
"type alias Fact =\n"
    ++ "    { component : String\n"
    ++ "    , module_ : String\n"
    ++ "    , enums : List ( String, List String )\n"
    ++ "    , requiredSlots : List String\n"
    ++ "    , multiSlots : List String\n"
    ++ "    , attrRewrites : List ( String, String )\n"
    ++ "    , slotRewrites : List ( String, String )\n"
    ++ "    , shapes : List Shape\n"
    ++ "    , requiredAttrs : List String\n"
    ++ "    }\n\n\n"
```

- [ ] **Step 2: Emit the `Shape` type above `Fact`**

Immediately before the emitted `type alias Fact` block, add:

```elm
"{-| Which top-layer surface a component emits at. `Shape3` is the double-list\n"
    ++ "(`M3e.<Comp>.view [attrs] [content]`); `Shape4` is the record + double-list\n"
    ++ "(`M3e.Record.<Comp>.view {required} [attrs] [content]`).\n-}\n"
    ++ "type Shape\n    = Shape3\n    | Shape4\n\n\n"
```

Insert this in the `contents` string right after the `@docs Fact, facts\n-}\n\n\n` line and before the current `{-| Per-component facts: ... -}\n` comment. Also update the module exposing line:

```elm
"module "
    ++ lib
    ++ ".Review.Facts exposing (Fact, Shape(..), facts)\n\n"
```

And update the `@docs` line to `@docs Fact, Shape, facts`.

- [ ] **Step 3: Remove the PROVISIONAL header block**

Remove these lines from the emitted module docstring:

```
++ "PROVISIONAL: the `shapes` and `requiredAttrs` fields are pending the facts\n"
++ "spec (see docs/superpowers/specs/2026-07-03-epic-138-shipping-coordination.md).\n"
++ "Their schema may change; consumers should not rely on stability yet.\n\n"
```

The header should now read:

```elm
"{-| GENERATED — per-component facts for the codegen-aware elm-review rules\n"
    ++ "(ADR 0012). Do not edit by hand; regenerate via `bin/elm-cem.js`.\n\n"
    ++ "@docs Fact, Shape, facts\n-}\n\n\n"
```

- [ ] **Step 4: Update the `factRecord` to emit the new fields**

Replace the `factRecord` function's body. The current version emits:

```elm
"{ component = "
    ++ quote (Naming.decapitalize moduleName)
    ++ ", module_ = "
    ++ quote (lib ++ "." ++ moduleName)
    ++ ", enums = "
    ++ enumsStr
    ++ ", requiredSlots = "
    ++ strList (slots |> List.filter .required |> List.map .name)
    ++ ", multiSlots = "
    ++ strList (slots |> List.filter .multi |> List.map .name)
    ++ ", shapes = "
    ++ strList shapes
    ++ ", requiredAttrs = "
    ++ strList requiredAttrs
    ++ " }"
```

Replace with:

```elm
let
    shapesList =
        shapesFor config libraryInfo c
            |> List.map shapeName
            |> String.join ", "
            |> (\s ->
                if String.isEmpty s then
                    "[]"

                else
                    "[ " ++ s ++ " ]"
               )
in
"{ component = "
    ++ quote (Naming.decapitalize moduleName)
    ++ ", module_ = "
    ++ quote (lib ++ "." ++ moduleName)
    ++ ", enums = "
    ++ enumsStr
    ++ ", requiredSlots = "
    ++ strList (slots |> List.filter .required |> List.map .name)
    ++ ", multiSlots = "
    ++ strList (slots |> List.filter .multi |> List.map .name)
    ++ ", attrRewrites = []"
    ++ ", slotRewrites = []"
    ++ ", shapes = "
    ++ shapesList
    ++ ", requiredAttrs = "
    ++ strList requiredAttrs
    ++ " }"
```

Note the change to `shapes`: was `strList shapes` (emitting quoted strings like `[ "Shape3", "Shape4" ]`), now emits unquoted `Shape` constructors (`[ Shape3, Shape4 ]`). The existing `shapeName` helper (`Shape3 -> "Shape3"`, `Shape4 -> "Shape4"`) is reused but the output is joined without quotes.

Also add a local `shapesList` binding INSIDE `factRecord`'s `let` (before the current `let ... in` output) so the join computation is scoped to the function.

- [ ] **Step 5: Regen and verify**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
cp packages/m3e/src/M3e/Review/Facts.elm /tmp/facts-pre-task1.elm && \
PATH="/Users/jhp/code/jackhp95/elm-m3e/elm-cem/node_modules/.bin:$PATH" \
  node elm-cem/bin/elm-cem.js \
    --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json \
    --config-from=config/slots.json \
    --config-from=config/examples.generated.json \
    --output=packages/m3e/src
```

Inspect the new file:

```bash
head -30 packages/m3e/src/M3e/Review/Facts.elm && grep -A 1 "m3e-button" packages/m3e/src/M3e/Review/Facts.elm | head -6
```

Expected:
- Module header no longer contains PROVISIONAL block.
- `type Shape = Shape3 | Shape4` present.
- `type alias Fact` has 9 fields, in order: `component`, `module_`, `enums`, `requiredSlots`, `multiSlots`, `attrRewrites`, `slotRewrites`, `shapes`, `requiredAttrs`.
- Button's fact row shows `attrRewrites = []`, `slotRewrites = []`, `shapes = [ Shape3, Shape4 ]` (unquoted Shape constructors).

Compile check:

```bash
cd packages/m3e && PATH="/Users/jhp/code/jackhp95/elm-m3e/node_modules/.bin:$PATH" \
  elm make src/M3e/Review/Facts.elm --output=/dev/null
```

Expected: `Success!`

Also compile the whole package:

```bash
elm make src/M3e.elm --output=/dev/null
```

Expected: `Success! Compiled 378 modules.`

- [ ] **Step 6: Run elm-cem tests**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
PATH="./node_modules/.bin:$PATH" pnpm run test
```

Expected: `109 passing / 0 failed`.

- [ ] **Step 7: Reset outer repo (regen artifact left over from verify)**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
git checkout packages/m3e/src/M3e/Review/Facts.elm packages/m3e/elm.json && \
rm -rf packages/m3e/src/M3e/Record/  # in case regen re-created it
```

- [ ] **Step 8: Commit in elm-cem clone**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
git add codegen/Generate.elm && \
git commit -m "feat(codegen): emit Facts schema with Shape type + new field slots"
```

---

### Task 2: Compute `attrRewrites` per component

**Files:**
- Modify: `elm-cem/codegen/Generate.elm::generateReviewFacts`

**Interfaces:**
- Consumes: existing `specsOf` helper (already in generateReviewFacts's let), the barrel-alias suffixing rule (currently in `generateBarrelModule`'s `attrAlias` function ~L2265-2280), the event handler name computation (`eventHandlerName`).
- Produces: `attrRewrites : List (String, String)` per component, exhaustive: every attr/event setter the component exposes, with `(barrelName, perComponentSetterName)` pairs.

- [ ] **Step 1: Extract constructor name set into `generateReviewFacts`**

The barrel's `attrAlias` helper suffixes attribute names with `"Attr"` when they collide with any component's constructor name (e.g., `M3e.shapeAttr` because `M3e.shape` is the Shape component). The set of constructor names is built in `generateBarrelModule` as `constructorNameSet`. For Facts, replicate the same computation.

In `generateReviewFacts`'s let block, after the existing `strList` helper, add:

```elm
constructorNameSet =
    components
        |> List.map (componentModuleName libraryInfo >> Naming.decapitalize)
        |> dedupeStrings

barrelAttrName elmName =
    if List.member elmName constructorNameSet then
        elmName ++ "Attr"

    else
        elmName
```

(`dedupeStrings` is an existing helper at ~L2233 of the file; verify with grep.)

- [ ] **Step 2: Compute attr + event rewrites**

Inside `factRecord`, add:

```elm
attrRewritePairs c_ =
    let
        attrPairs =
            specsOf c_
                |> List.map (\s -> ( barrelAttrName s.elmName, s.elmName ))

        eventPairs =
            c_.events
                |> deduplicateBy .name
                |> List.map
                    (\ev ->
                        let
                            n =
                                eventHandlerName libraryInfo ev
                        in
                        ( barrelAttrName n, n )
                    )
    in
    attrPairs ++ eventPairs

pairListToString pairs =
    if List.isEmpty pairs then
        "[]"

    else
        "[ "
            ++ String.join ", "
                (List.map
                    (\( a, b ) -> "( " ++ quote a ++ ", " ++ quote b ++ " )")
                    pairs
                )
            ++ " ]"
```

Move `attrRewritePairs` and `pairListToString` into the outer `generateReviewFacts` let (not inside `factRecord`) so they're reusable in Task 3 for `slotRewrites`.

- [ ] **Step 3: Emit `attrRewrites` in factRecord**

Replace the emitted `", attrRewrites = []"` with:

```elm
", attrRewrites = "
    ++ pairListToString (attrRewritePairs c)
```

- [ ] **Step 4: Regen and verify**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
PATH="/Users/jhp/code/jackhp95/elm-m3e/elm-cem/node_modules/.bin:$PATH" \
  node elm-cem/bin/elm-cem.js \
    --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json \
    --config-from=config/slots.json \
    --config-from=config/examples.generated.json \
    --output=packages/m3e/src
```

Spot-check Button (which has `variant`, `disabled`, `onClick` etc., and `shape` collision):

```bash
grep '"m3e-button"' packages/m3e/src/M3e/Review/Facts.elm | grep -o 'attrRewrites = [^]]*\]' | head -1
```

Expected: shows pairs like `( "variant", "variant" )`, `( "disabled", "disabled" )`, `( "shapeAttr", "shape" )` (because `shape` is a constructor name), `( "onClick", "onClick" )`.

Verify compile:

```bash
cd packages/m3e && PATH="/Users/jhp/code/jackhp95/elm-m3e/node_modules/.bin:$PATH" \
  elm make src/M3e.elm --output=/dev/null
```

Expected: `Success!`

- [ ] **Step 5: Reset outer repo**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
git checkout packages/m3e/src/M3e/Review/Facts.elm packages/m3e/elm.json && \
rm -rf packages/m3e/src/M3e/Record/
```

- [ ] **Step 6: Run elm-cem tests**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
PATH="./node_modules/.bin:$PATH" pnpm run test
```

Expected: `109 passing / 0 failed`.

- [ ] **Step 7: Commit in elm-cem**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
git add codegen/Generate.elm && \
git commit -m "feat(codegen): emit attrRewrites in Facts (barrel↔per-component setter names)"
```

---

### Task 3: Compute `slotRewrites` per component

**Files:**
- Modify: `elm-cem/codegen/Generate.elm::generateReviewFacts`

**Interfaces:**
- Consumes: `SharedCtx.slots` (per-component slot list from `buildSharedCtx`), the slot setter naming rules (currently in `generateShape3Module`'s `setterName` inline helper).
- Produces: `slotRewrites : List (String, String)` per component, exhaustive: every slot the component exposes, with `(kebabSlotName, perComponentSetterName)` pairs.

- [ ] **Step 1: Extract slot setter naming to a top-level helper**

The slot setter naming logic currently lives inline in `generateShape3Module` (and duplicated in `generateShape4Module`). The rules:
- `unnamed` slot → `"child"`.
- Other slots → `slotField` (kebab-to-camel of the slot name).
- Collision-suffix: if the setter name collides with an attr, event, or constructor name (in `reservedNames`), suffix with `"Slot"`.

The generator has `slotField` inline in both shape emitters. Extract to a top-level helper.

Above `generateReviewFacts`, add:

```elm
{-| The kebab-slot-name → per-component setter name for a component. `unnamed`
becomes `child`; other slot names are camelCased. When the setter name would
collide with an attr, event, or constructor name, it's suffixed `Slot`.
Shared by shape emitters and the facts emitter so the rewrite rule's data
matches what the emitters actually produce.
-}
slotSetterName : LibraryInfo -> Cem.Declaration -> List Cem.SlotSpec -> List Attr.AttrSpec -> Cem.SlotSpec -> String
slotSetterName libraryInfo component slots specs slot =
    let
        events =
            component.events |> deduplicateBy .name

        fnName =
            Naming.decapitalize (componentModuleName libraryInfo component)

        reservedNames =
            List.map .elmName specs
                ++ List.map (eventHandlerName libraryInfo) events
                ++ [ fnName, "view", "child", "children" ]

        base =
            if slot.name == "unnamed" then
                "child"

            else
                safeField (Naming.decapitalize (Naming.pascal slot.name))
    in
    if slot.name /= "unnamed" && List.member base reservedNames then
        base ++ "Slot"

    else
        base
```

(Verify `safeField` is available at the top-level; grep to confirm.)

- [ ] **Step 2: Compute slot rewrites in `generateReviewFacts`**

Inside `factRecord`, add (near the existing bindings for `moduleName`, `slots`, `extra`):

```elm
slotRewritePairs =
    let
        specs =
            specsOf c
    in
    slots
        |> List.map
            (\s ->
                ( s.name, slotSetterName libraryInfo c slots specs s )
            )
```

- [ ] **Step 3: Emit `slotRewrites` in factRecord**

Replace the emitted `", slotRewrites = []"` (from Task 1) with:

```elm
", slotRewrites = "
    ++ pairListToString slotRewritePairs
```

- [ ] **Step 4: Regen and verify**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
PATH="/Users/jhp/code/jackhp95/elm-m3e/elm-cem/node_modules/.bin:$PATH" \
  node elm-cem/bin/elm-cem.js \
    --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json \
    --config-from=config/slots.json \
    --config-from=config/examples.generated.json \
    --output=packages/m3e/src
```

Spot-check Card (has `unnamed`, `media`, `header`, `trailing-icon` slots):

```bash
grep '"m3e-card"' packages/m3e/src/M3e/Review/Facts.elm | grep -o 'slotRewrites = [^]]*\]'
```

Expected: `slotRewrites = [ ( "unnamed", "child" ), ( "media", "media" ), ( "header", "header" ), ( "trailing-icon", "trailingIcon" ) ]` (exact slot list may differ; check `config/slots.json` for Card's slot list).

Spot-check Button (has `selected` slot which collides with `selected` attr → should suffix):

```bash
grep '"m3e-button"' packages/m3e/src/M3e/Review/Facts.elm | grep -o 'slotRewrites = [^]]*\]'
```

Expected: entry for `"selected"` maps to `"selectedSlot"` (suffixed because `selected` is also an attr).

Verify compile:

```bash
cd packages/m3e && PATH="/Users/jhp/code/jackhp95/elm-m3e/node_modules/.bin:$PATH" \
  elm make src/M3e.elm --output=/dev/null
```

Expected: `Success!`

- [ ] **Step 5: Verify byte-identity of existing shape emitters**

The `slotSetterName` extraction must produce the same names as the inline logic in the shape emitters. Diff-check the emitted per-component modules to confirm no drift:

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
diff packages/m3e/src/M3e/Card.elm <(git show HEAD:packages/m3e/src/M3e/Card.elm) | head
diff packages/m3e/src/M3e/Button.elm <(git show HEAD:packages/m3e/src/M3e/Button.elm) | head
```

Expected: empty output. If not, the extraction introduced a naming drift; investigate `slotSetterName` vs the inline logic and fix.

Optionally, update the shape emitters (`generateShape3Module`, `generateShape4Module`) to call `slotSetterName` instead of their inline duplicates — the byte-identity check above already covers the correctness. This is a DRY cleanup, safe to defer to a follow-up.

- [ ] **Step 6: Reset outer repo**

```bash
git checkout packages/m3e/src/M3e/Review/Facts.elm packages/m3e/src/M3e/Card.elm packages/m3e/src/M3e/Button.elm packages/m3e/elm.json && \
rm -rf packages/m3e/src/M3e/Record/
```

- [ ] **Step 7: Run elm-cem tests**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
PATH="./node_modules/.bin:$PATH" pnpm run test
```

Expected: `109 passing / 0 failed`.

- [ ] **Step 8: Commit in elm-cem**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
git add codegen/Generate.elm && \
git commit -m "feat(codegen): emit slotRewrites in Facts (kebab-slot↔per-component setter names)"
```

---

### Task 4: Config-sourced `requiredAttrs` (replace heuristic)

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — `Config` type alias (~L57-65), `componentDecoder` (~L369-378), `generateReviewFacts`'s `factRecord` (~L871-919).

**Interfaces:**
- Consumes: new optional `requiredAttrs : [name…]` field in per-component config JSON (default `[]`).
- Produces: `Fact.requiredAttrs` sourced verbatim from config, with the existing PROVISIONAL heuristic REMOVED from the generator.

- [ ] **Step 1: Add `requiredAttrs` to the `Config` type alias**

Update the record shape (Generate.elm ~L57-65) from:

```elm
type alias Config =
    Dict.Dict
        String
        { slots : List SlotSpec
        , extra : List ( String, String )
        , group : List ( String, String )
        , examples : List ExampleRecord
        , docMeta : List ( String, String )
        }
```

to:

```elm
type alias Config =
    Dict.Dict
        String
        { slots : List SlotSpec
        , extra : List ( String, String )
        , group : List ( String, String )
        , examples : List ExampleRecord
        , docMeta : List ( String, String )
        , requiredAttrs : List String
        }
```

- [ ] **Step 2: Update `componentDecoder`**

Change `componentDecoder` (~L369-378) from `Json.Decode.map5` to `Json.Decode.map6`:

```elm
componentDecoder =
    Json.Decode.map6
        (\slots extra grp examples docMeta requiredAttrs ->
            { slots = slots
            , extra = extra
            , group = grp
            , examples = examples
            , docMeta = docMeta
            , requiredAttrs = requiredAttrs
            }
        )
        (optStrict "slots" slotsDecoder [])
        (opt "required" (Json.Decode.keyValuePairs Json.Decode.string) [])
        (opt "group" (Json.Decode.keyValuePairs Json.Decode.string) [])
        (opt "examples" (Json.Decode.list exampleDecoder) [])
        (opt "docMeta" (Json.Decode.keyValuePairs Json.Decode.string) [])
        (opt "requiredAttrs" (Json.Decode.list Json.Decode.string) [])
```

Note the addition of the sixth field decoder using `opt` (default `[]`) — components that omit the field emit an empty list.

- [ ] **Step 3: Replace the heuristic in `generateReviewFacts`**

Locate the current heuristic in `factRecord`:

```elm
-- PROVISIONAL: conservative first cut — only ariaLabel extras map
-- to the `aria-label` HTML attribute. ...
requiredAttrs =
    if List.any (\( _, k ) -> k == "ariaLabel") extra then
        [ "aria-label" ]

    else
        []
```

Replace with:

```elm
requiredAttrs =
    Dict.get moduleName config
        |> Maybe.map .requiredAttrs
        |> Maybe.withDefault []
```

The `moduleName` binding already exists in `factRecord`'s let.

- [ ] **Step 4: Update `shapesFor` if it references the Config record**

Grep to confirm `shapesFor` doesn't destructure or reference the Config record's fields that changed:

```bash
grep -n "\.requiredAttrs\|{ slots\|{ extra" elm-cem/codegen/Generate.elm | head -10
```

If any function pattern-matches on the config's record type (e.g., `{ slots, extra } = ...`), extend those patterns to include `requiredAttrs`. In practice this shouldn't happen — most access is via `.slots` field access — but verify.

- [ ] **Step 5: Update `ShapesForTest` fixture to include the new field**

The test file `elm-cem/tests/src/ShapesForTest.elm` constructs fake Config entries. Each test's fake config record needs the new field.

Locate `buttonConfig` (line ~63) and `cardConfig` (line ~90). Each currently has 5 fields (slots, extra, group, examples, docMeta). Add `requiredAttrs = []` to each. Also update the type annotations at lines ~55-62 and ~82-89 to include the new field.

Locate `extraOnlyConfig` in the "component with extra fields only" test (line ~124) — same treatment.

- [ ] **Step 6: Regen and verify**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
PATH="/Users/jhp/code/jackhp95/elm-m3e/elm-cem/node_modules/.bin:$PATH" \
  node elm-cem/bin/elm-cem.js \
    --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json \
    --config-from=config/slots.json \
    --config-from=config/examples.generated.json \
    --output=packages/m3e/src
```

Verify all `requiredAttrs` fields are now `[]` (since no config has the field yet):

```bash
grep -c "requiredAttrs = \[\]" packages/m3e/src/M3e/Review/Facts.elm
grep -c "requiredAttrs = \[ \"aria-label\" \]" packages/m3e/src/M3e/Review/Facts.elm
```

Expected: first count is ~128 (every component); second count is 0.

Compile check:

```bash
cd packages/m3e && PATH="/Users/jhp/code/jackhp95/elm-m3e/node_modules/.bin:$PATH" \
  elm make src/M3e.elm --output=/dev/null
```

Expected: `Success!`

- [ ] **Step 7: Reset outer repo**

```bash
git checkout packages/m3e/src/M3e/Review/Facts.elm packages/m3e/elm.json && \
rm -rf packages/m3e/src/M3e/Record/
```

- [ ] **Step 8: Run elm-cem tests**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
PATH="./node_modules/.bin:$PATH" pnpm run test
```

Expected: `109 passing / 0 failed`. If ShapesForTest fails with a decode error, revisit Step 5 — the fixture records must match the new `Config` type.

- [ ] **Step 9: Commit in elm-cem**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
git add codegen/Generate.elm tests/src/ShapesForTest.elm && \
git commit -m "feat(codegen): source requiredAttrs from config (drop heuristic)"
```

---

### Task 5: Populate `config/slots.json` + regen + commit outer repo

**Files:**
- Modify: `config/slots.json` — add `requiredAttrs` to `IconButton` and `Fab`.
- Regenerate: `packages/m3e/src/M3e/Review/Facts.elm` and any other files affected by regen.

**Interfaces:**
- Produces: Emitted `Facts.elm` with `IconButton.requiredAttrs = [ "aria-label" ]` and `Fab.requiredAttrs = [ "aria-label" ]`.

- [ ] **Step 1: Identify affected components**

Confirm identification: the components whose default (unnamed) slot's `kinds` list excludes `"text"` AND whose config includes an `action` extra. Run:

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
jq -r 'to_entries[] | select(.value.required.action) | select((.value.slots.unnamed.kinds // []) | index("text") | not) | .key' config/slots.json
```

Expected today: `IconButton`, `Fab`.

- [ ] **Step 2: Edit `config/slots.json` — add `requiredAttrs` to IconButton**

Locate the `"IconButton"` block. Add a top-level `"requiredAttrs": ["aria-label"]` field alongside `"required"` and `"slots"`. E.g., the block becomes:

```json
"IconButton": {
    "required": { "action": "action:click,link,menuTrigger,dialogTrigger,fabMenuTrigger,bottomSheetTrigger,navRailToggle,drawerToggle,datepickerToggle,dialogAction,bottomSheetAction,richTooltipAction,stepperReset,stepperPrevious" },
    "requiredAttrs": ["aria-label"],
    "slots": {
        "unnamed": { "kinds": ["icon"], "multi": false, "required": true }
    }
}
```

(Exact structure of the `required` and `slots` fields will differ per component — preserve what's there; only add the new field.)

- [ ] **Step 3: Edit `config/slots.json` — add `requiredAttrs` to Fab**

Same treatment for the `"Fab"` block:

```json
"Fab": {
    "required": { "action": "..." },
    "requiredAttrs": ["aria-label"],
    "slots": { ... }
}
```

- [ ] **Step 4: Regen**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
PATH="/Users/jhp/code/jackhp95/elm-m3e/elm-cem/node_modules/.bin:$PATH" \
  node elm-cem/bin/elm-cem.js \
    --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json \
    --config-from=config/slots.json \
    --config-from=config/examples.generated.json \
    --output=packages/m3e/src
```

- [ ] **Step 5: Verify emitted Facts**

```bash
grep '"m3e-icon-button"' packages/m3e/src/M3e/Review/Facts.elm | grep -o 'requiredAttrs = [^]]*\]'
grep '"m3e-fab"' packages/m3e/src/M3e/Review/Facts.elm | grep -o 'requiredAttrs = [^]]*\]'
grep '"m3e-button"' packages/m3e/src/M3e/Review/Facts.elm | grep -o 'requiredAttrs = [^]]*\]'
grep '"m3e-card"' packages/m3e/src/M3e/Review/Facts.elm | grep -o 'requiredAttrs = [^]]*\]'
```

Expected:
- IconButton: `requiredAttrs = [ "aria-label" ]`
- Fab: `requiredAttrs = [ "aria-label" ]`
- Button: `requiredAttrs = []`
- Card: `requiredAttrs = []`

- [ ] **Step 6: Full compile check**

```bash
cd packages/m3e && PATH="/Users/jhp/code/jackhp95/elm-m3e/node_modules/.bin:$PATH" \
  elm make src/M3e.elm --output=/dev/null
```

Expected: `Success!`

Docs-app compile:

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/docs && \
PATH="./node_modules/.bin:$PATH" elm make app/Shared.elm src/Doc.elm --output=/dev/null
```

Expected: `Success!`

- [ ] **Step 7: Verify elm-review still passes**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
PATH="./docs/node_modules/.bin:$PATH" \
  elm-review --config review/ docs/app 2>&1 | tail -20
```

Expected: `I found no errors!` (or the same output as before the change — this task's changes to Facts should not affect existing rule behavior).

- [ ] **Step 8: Commit outer repo**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
git add config/slots.json packages/m3e/src/M3e/Review/Facts.elm packages/m3e/elm.json && \
git commit -m "$(cat <<'EOF'
feat(m3e): finalize Review.Facts schema for D1–D5 rules

Sources requiredAttrs from config (IconButton + Fab now declare aria-label
required). Regenerates M3e.Review.Facts.elm from the elm-cem generator that
emits the new Fact schema: attrRewrites, slotRewrites, typed shapes : List Shape,
and requiredAttrs sourced verbatim from config.

Per docs/superpowers/specs/2026-07-04-review-facts-expansion-design.md.

Existing rules (ValidEnumValue, SingularSlot, RequireSlot) read only fields
that were already present; no rule migration needed.

Generated with [Claude Code](https://claude.ai/code)
via [Happy](https://happy.engineering)

Co-Authored-By: Claude <noreply@anthropic.com>
Co-Authored-By: Happy <yesreply@happy.engineering>
EOF
)"
```

---

### Task 6: Verify Definition of Done

**Files:** none modified — checkpoint against the spec's §10 DoD.

- [ ] **Step 1: Schema check**

```bash
head -30 /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/src/M3e/Review/Facts.elm
```

Expected: module exposing `(Fact, Shape(..), facts)`; `type Shape = Shape3 | Shape4`; `type alias Fact` has 9 fields (`component`, `module_`, `enums`, `requiredSlots`, `multiSlots`, `attrRewrites`, `slotRewrites`, `shapes`, `requiredAttrs`); no PROVISIONAL header.

- [ ] **Step 2: Field-population sample**

```bash
grep '"m3e-button"' /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/src/M3e/Review/Facts.elm
```

Expected: a single-line record with all 9 fields, non-empty enums/attrRewrites/slotRewrites/shapes, empty requiredAttrs.

- [ ] **Step 3: `requiredAttrs` correctness**

```bash
grep -c "requiredAttrs = \[ \"aria-label\" \]" /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/src/M3e/Review/Facts.elm
```

Expected: `2` (IconButton and Fab).

- [ ] **Step 4: `attrRewrites` and `slotRewrites` exhaustiveness spot-check**

For Button, the top module `M3e.Button` exposes these attribute setters (from Task 5 of the shape-selector refactor): `variant`, `disabled`, `disabledInteractive`, `name`, `selected`, `shape`, `size`, `toggle`, `type_`, `value`, plus events. Verify each appears in Button's `attrRewrites`:

```bash
grep '"m3e-button"' /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/src/M3e/Review/Facts.elm | grep -o "attrRewrites = [^]]*\]"
```

Expected: contains pairs for each of the setters above. Because `shape` is a component constructor name, expect `( "shapeAttr", "shape" )`.

Similarly for slots, Button exposes `child` (unnamed), `icon`, `selectedSlot` (collision), `selectedIcon`, `trailingIcon`:

```bash
grep '"m3e-button"' /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/src/M3e/Review/Facts.elm | grep -o "slotRewrites = [^]]*\]"
```

Expected: `( "unnamed", "child" )`, `( "icon", "icon" )`, `( "selected", "selectedSlot" )`, `( "selected-icon", "selectedIcon" )`, `( "trailing-icon", "trailingIcon" )`.

- [ ] **Step 5: `shapes` field type**

```bash
grep -c "shapes = \[ Shape3 \]" /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/src/M3e/Review/Facts.elm
grep -c "shapes = \[ Shape3, Shape4 \]" /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/src/M3e/Review/Facts.elm
```

Expected: first count ≈ 107 (optional-only components); second count = 21 (required-bearing).

- [ ] **Step 6: Existing rules still pass**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
PATH="./docs/node_modules/.bin:$PATH" \
  elm-test-rs --project review review/tests/*.elm 2>&1 | tail -10
```

Expected: 24/24 (or whatever the current baseline is) tests pass.

Also `elm-review` clean on the docs app:

```bash
PATH="./docs/node_modules/.bin:$PATH" \
  elm-review --config review/ docs/app 2>&1 | tail -3
```

Expected: `I found no errors!`

- [ ] **Step 7: elm-cem tests still pass**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
PATH="./node_modules/.bin:$PATH" pnpm run test
```

Expected: `109 passing`.

- [ ] **Step 8: Working trees clean**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && git status
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && git status
```

Expected: both report `nothing to commit`.

---

## Self-Review Notes

**Spec coverage:**
- §2 In-scope items map to tasks:
  - Extend Fact record → Tasks 1-4.
  - Remove PROVISIONAL fields → Task 1.
  - Add config `requiredAttrs` field → Task 4 (decoder) + Task 5 (data).
  - Update `generateReviewFacts` → Tasks 1-4.
  - `Shape` first-class type → Task 1.
- §3 Schema — exactly matches Task 1's emitted type alias.
- §4 Field semantics — every field has a task:
  - `component`, `module_`, `enums`, `requiredSlots`, `multiSlots`: unchanged (existing).
  - `attrRewrites`: Task 2.
  - `slotRewrites`: Task 3.
  - `shapes`: Task 1.
  - `requiredAttrs`: Task 4 (source) + Task 5 (data).
- §5 Config source — Task 4 (decoder) + Task 5 (data).
- §6 Rule-mapping — no code, but Task 6 verifies existing rules stay green.
- §7 Generator changes — Tasks 1-4 cover every bullet.
- §8 Cross-spec invariants — Task 6 Step 6 verifies.
- §9 Migration story — Task 6 Step 6 verifies existing rules unchanged.
- §10 DoD — Task 6 verifies each item.

**Placeholder scan:**
- No TBD/TODO in tasks. Every code snippet is concrete.
- Verification commands include expected outputs.

**Type consistency:**
- `Fact` fields consistent across Tasks 1, 2, 3, 4.
- `Shape` constructors (`Shape3`, `Shape4`) match the existing `Shape` type in `elm-cem/codegen/Generate.elm` (introduced in Task 1 of the shape-selector plan).
- `slotSetterName` signature matches its callers in Task 3.
- `barrelAttrName` helper introduced in Task 2 is scoped to `generateReviewFacts` — no cross-task consumers.

## Execution Handoff

Plan complete and saved to `docs/superpowers/plans/2026-07-04-review-facts-expansion.md`. Two execution options:

**1. Subagent-Driven (recommended)** — I dispatch a fresh subagent per task, review between tasks, fast iteration.

**2. Inline Execution** — Execute tasks in this session using executing-plans, batch execution with checkpoints.

Which approach?
