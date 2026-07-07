# Unwrap the M3e Default Slot — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** On the M3e top layer, replace the `child`/`children` `Content` wrapper with raw `Element` default children, retire `Content` on that layer, and move the composition guarantees to codegen-aware elm-review — per [ADR 15](../../adr/0015-unwrap-default-slot-phantoms-as-guidance.md).

**Architecture:** `M3e.<Comp>.view : List Attr -> List Element -> Element`. Named-slot setters become `Element -> Element` that stamp `slot="name"` (via the existing `M3e.Element.withSlot`) and drop into the *same* single `List Element` as default children. `M3e.Content`/`M3e.Content.Internal` retire; the for/id auto-wiring (`slotWithAttr`) relocates to an attribute setter. The lost guarantees (known slot names, required slots, allowed child kinds) are enforced by `elm-review-cem` — a new `slotKinds` fact + a `NoForeignSlotChild` rule, plus promoting the required-slot rules from advisory to hard errors.

**Tech Stack:** Elm (`elm-codegen` generator in `elm-cem/`), `elm-review` rules (`../elm-review-cem`, sibling repo), Node converter (`docs/scripts/examples-gen/`), elm-pages docs app.

**Decisions locked (2026-07-07):**
- **for/id relocation = Option 2 (decompose).** Delete `Content.Internal.slotWithAttr`; add a general
  `M3e.Element.Internal.withAttr : String -> String -> Element sup msg -> Element sup msg` and reuse the
  existing `withSlot`. FormField's default-slot id-wiring setter is renamed `child` → `control` and
  returns `Element`. Public top-layer signatures are unchanged vs the bundled option; keep `withAttr`
  general (not FormField-shaped).
- **slotKinds rule severity = a rule flag, not a baked-in choice.** `Cem.ValidSlotKind` takes
  `Unresolved = Lenient | Strict` (`ruleWith`), `rule` defaults to `Lenient` (silent when a child's kind
  can't be statically resolved). `Cem.all` uses the lenient default; add `Cem.allWith { validSlotKind }`
  so a consumer can opt into `Strict` in `ReviewConfig.elm`.

**THE ONE HARD RULE — no guarantee-gap window:** the elm-review rules that replace the phantom check (Phase 1) MUST be green in `review/` before the regenerated library that drops the phantom (Phase 3) is merged. Phases 1→2→3 land together or not at all. Do not merge a half-state to `main`.

---

## Pre-read (context an engineer needs)

- **The layers:** `M3e.*` (top, this refactor), `M3e.Record.*` / `M3e.Build.*` (strict shapes — **unchanged**), `M3e.Cem.*` / `M3e.Cem.Html.*` (already raw children — **unchanged**).
- **Codegen** is `elm-cem/codegen/Generate.elm` run via `node elm-cem/bin/elm-cem.js --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json --config-from=config/slots.json --config-from=config/native-mdn.json --config-from=config/examples.generated.json --output=packages/m3e/src` (from repo root). Runtime Elm under `elm-cem/runtime/M3e/` is copied verbatim into the library.
- **Golden test** `elm-cem/tests/src/GoldenTest.elm` hard-asserts exact codegen output — it is the executable spec for codegen. Change the golden expectation first (TDD), then make codegen match.
- **elm-review-cem** is at sibling repo `/Users/jack/Documents/code/elm-review-cem` (wired into `review/elm.json` via source-dir `../../elm-review-cem/src`). Facts generated to `packages/m3e/src/M3e/Review/Facts.elm`. Rules bundled in `Cem.all` (`elm-review-cem/src/Cem.elm`), consumed by `review/src/ReviewConfig.elm`.
- **Converter** `docs/scripts/examples-gen/lib/to-elm.mjs` emits the top-layer example strings; `oracle.mjs` supplies slot data. Tests: `to-elm.test.mjs`, `oracle.test.mjs`.
- **Verification bar (every phase):** `cd docs && npm run build:ci` → exit 0; `elm-format --validate app src` → `[]`; new/changed tests pass; regen is byte-reproducible.

---

## Files

- `elm-review-cem/src/Cem/Facts.elm` — add `slotKinds` to the `Fact` record (breaking).
- `elm-review-cem/src/Cem/ValidSlotKind.elm` — **new** rule (foreign-slot + kind check).
- `elm-review-cem/src/Cem.elm` — expose + add to `Cem.all`.
- `elm-review-cem/tests/Cem/ValidSlotKindTest.elm` — **new** rule tests.
- `elm-cem/codegen/Generate.elm` — `generateShape3Module`, `generateShape4Module` (default content), `generateCemVocabModule`, `generateBarrelModule`, `generateReviewFacts` (emit `slotKinds`), `slotSetterName` (default-slot handling).
- `elm-cem/runtime/M3e/Content.elm`, `.../Content/Internal.elm` — **delete**.
- `elm-cem/runtime/M3e/Element/Internal.elm` — absorb `slotWithAttr` (for/id) if kept as an Element combinator, else move to an attr setter in codegen.
- `elm-cem/tests/src/GoldenTest.elm` — rewrite Content/child/children expectations.
- `packages/m3e/**` — regenerated (do not hand-edit).
- `docs/scripts/examples-gen/lib/to-elm.mjs` — stop wrapping default children; relocate idWiring `id`→`for`.
- `docs/scripts/examples-gen/lib/to-elm.test.mjs`, `oracle.test.mjs` — update expectations.
- `packages/m3e-kit/src/Seam.elm` — `Content.Internal` → `Element.Internal`.
- ~24 userland files under `docs/app/`, `packages/m3e-kit/` — migrate call sites (Phase 5 lists them).
- `docs/adr/0008|0009|0013|0014-*.md`, `docs/ADOPTION_AND_SLOTS.md`, `docs/THREE_LAYER_PATTERN.md`, `docs/app/Route/Concepts/Layers.elm` (`topShapesCode`) — housekeeping.

---

## Phase 0 — Pre-flight

### Task 0.1: Worktree + baselines

**Files:** none (setup).

- [ ] **Step 1: Create an isolated worktree** (this refactor spans repos; keep it off `main`).

Run: `git worktree add ../elm-m3e-unwrap -b refactor/unwrap-m3e-slot main` (and note the sibling `elm-cem/` and `elm-review-cem/` are their own repos — branch each: `cd elm-cem && git checkout -b refactor/unwrap-m3e-slot`; same for `../elm-review-cem`).

- [ ] **Step 2: Capture green baselines.**

Run: `cd docs && npm run build:ci; echo EXIT=$?` → EXIT=0. `cd elm-cem && npx elm-test` (GoldenTest passes). `cd ../elm-review-cem && npx elm-test` (rules pass). Record the outputs.

- [ ] **Step 3: Snapshot the regen is reproducible.** Run the regen command (Pre-read) with NO code changes; `git -C packages/m3e status` should be clean (proves regen is deterministic before you start).

- [ ] **Step 4: Pin the mechanism** (ADR 15 open question 1). Confirm the single-`List Element` shape against `M3e.Record.*`'s required-content shape by reading `generateShape4Module` — verify Record's default content can also become `List Element` without breaking its required record. Write the finding into the plan's Task 2 notes. Do NOT proceed to Phase 2 until confirmed.

- [ ] **Step 5: Commit the branch setup** (empty or a NOTES.md). `git commit --allow-empty -m "chore: start unwrap-m3e-slot refactor"`.

---

## Phase 1 — elm-review-cem: land the replacement guarantees FIRST

Goal: the rules that replace the phantom check exist, tested, and ready — before codegen drops the phantom. These run against the CURRENT (still-wrapped) library too, so they must pass on it.

### Task 1.1: Add `slotKinds` to the Fact contract

**Files:**
- Modify: `elm-review-cem/src/Cem/Facts.elm` (the `Fact` type alias)

- [ ] **Step 1: Extend the `Fact` record** with `slotKinds : List ( String, List String )` — per component tag (or per the existing keying), the map from raw slot name → the list of allowed child kind strings. Match the existing field style (`requiredSlots`, `multiSlots`, `slotRewrites`).

- [ ] **Step 2: Update the decoder/accessor** if `Facts.elm` decodes or exposes fields individually; keep back-compat helpers if other rules pattern-match the record.

- [ ] **Step 3: Compile.** Run: `cd elm-review-cem && npx elm make src/Cem/Facts.elm --output=/dev/null` → Success. (The generated `M3e/Review/Facts.elm` won't provide `slotKinds` yet — that's Phase 2; keep this compiling by making the field's consumers tolerate its absence only via the generated side, i.e. don't force it until regen. If the record is constructed positionally in generated code, this is a breaking change that lands WITH Phase 2 — note that coupling.)

- [ ] **Step 4: Commit.** `git add src/Cem/Facts.elm && git commit -m "feat(facts): add slotKinds to the Fact contract"`.

### Task 1.2: `NoForeignSlotChild` / `ValidSlotKind` rule (TDD)

**Files:**
- Create: `elm-review-cem/tests/Cem/ValidSlotKindTest.elm`
- Create: `elm-review-cem/src/Cem/ValidSlotKind.elm`

- [ ] **Step 1: Write the failing rule tests.** The rule is configurable — `type Unresolved = Lenient | Strict`, `rule = ruleWith Lenient`. Cover, under **`Lenient`**: (a) a child stamped with a `slot=` the container doesn't declare → error; (b) a child whose kind isn't in that slot's `slotKinds` → error; (c) a child in a valid slot with an allowed kind → no error; (d) a child whose kind can't be statically resolved → **NO error** (default). Then under **`Strict`**: (d') the same unresolvable child → a warning. Use `elm-review`'s `Review.Test` with a small fact fixture that includes `slotKinds`. Model the post-refactor call shape (`M3e.Card.control …`, named `M3e.Card.actions (M3e.iconButton …)`, raw default `M3e.Card.view [] [ M3e.fabMenuItem … ]`).

- [ ] **Step 2: Run — verify fail.** Run: `cd elm-review-cem && npx elm-test tests/Cem/ValidSlotKindTest.elm` → FAIL (rule module missing).

- [ ] **Step 3: Implement the rule.** Expose `type Unresolved = Lenient | Strict`, `rule = ruleWith Lenient`, and `ruleWith : Unresolved -> List Fact -> Rule`. Trace named-slot setter calls (`M3e.<Comp>.<slot>`) and raw default children on `M3e.<Comp>.view`; resolve each child's kind where possible; check against `facts` `slotRewrites` (known slot) + `slotKinds` (allowed kinds). Reuse `PreferSpecificSlot.slotErrorFor`'s call-site tracing (the negative of it). On an unresolvable child kind: `Lenient` → no report; `Strict` → a warning naming the slot.

- [ ] **Step 4: Run — verify pass.** Run: `npx elm-test tests/Cem/ValidSlotKindTest.elm` → PASS.

- [ ] **Step 5: Commit.** `git commit -m "feat(rule): NoForeignSlotChild / ValidSlotKind"`.

### Task 1.3: Wire the rule + promote required-slot rules

**Files:**
- Modify: `elm-review-cem/src/Cem.elm` (expose + `Cem.all`)
- Modify: `elm-review-cem/src/Cem/RequireSlot.elm` / `MissingRequiredSingularSlot.elm` (severity/coverage)

- [ ] **Step 1: Expose `Cem.ValidSlotKind` and wire it.** `Cem.all` includes `ValidSlotKind.rule` (Lenient default). Add `Cem.allWith : { validSlotKind : Cem.Unresolved } -> List Fact -> List Rule` (re-exporting `Cem.Lenient`/`Cem.Strict`) so a consumer can opt into `Strict` from `ReviewConfig.elm` without hand-assembling the rule list.

- [ ] **Step 2: Promote required-slot enforcement.** Confirm `RequireSlot` + `MissingRequiredSingularSlot` cover what the phantom required-record used to guarantee on the ③ shape; strengthen fixtures so a missing required slot is a hard error. (Record shape keeps its compile-time guarantee — these rules backstop the ③ shape.)

- [ ] **Step 3: Run the full rule suite.** Run: `cd elm-review-cem && npx elm-test` → all PASS.

- [ ] **Step 4: Run the rules against the CURRENT library** (still wrapped) to ensure no false positives before regen: `cd docs && npx elm-review --config ../review` (or the repo's review invocation) → confirm the new rule doesn't flag the existing valid code. (`slotKinds` fact is absent pre-regen, so `ValidSlotKind` should no-op cleanly — verify it degrades gracefully when the fact field is empty/missing.)

- [ ] **Step 5: Commit.** `git commit -m "feat(rule): wire ValidSlotKind + promote required-slot rules"`.

---

## Phase 2 — Codegen: emit the new shape (golden-test-driven)

### Task 2.1: Emit the `slotKinds` fact

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — `generateReviewFacts` / `factRecord` (~2299–2554)
- Modify: `elm-cem/tests/src/GoldenTest.elm` — Facts expectation

- [ ] **Step 1: Update the golden expectation** for the Facts module to include `slotKinds` (sourced from each `SlotSpec.kinds`, already in scope at `Generate.elm:62,68`). Write the exact expected substring first.

- [ ] **Step 2: Run golden — verify fail.** Run: `cd elm-cem && npx elm-test` → FAIL on the Facts golden.

- [ ] **Step 3: Emit `slotKinds` in `factRecord`.** Add the field with the per-slot kind lists.

- [ ] **Step 4: Run golden — verify pass** for the Facts portion.

- [ ] **Step 5: Commit.** `git commit -m "feat(codegen): emit slotKinds fact"`.

### Task 2.2: ③ Standard `view` takes `List Element`; setters return `Element`

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — `generateShape3Module` (~4200–4521): `contentSetter` (4329–4371), `childrenHelper` (4373–4384), `defaultHelpers` (4386–4392), `viewType`/`viewDecl` (4419–4445), `contentNodes` (4412); `slotSetterName` (~1269–1306)
- Modify: `elm-cem/tests/src/GoldenTest.elm` — ③ expectations (~500, 576–642, 816–831)

- [ ] **Step 1: Rewrite the ③ golden expectations (TDD).** For a representative component, the expected output changes from `view : … -> List (Content { … }) -> Element` + `child`/`children`/`Content.Internal.slot` to: `view : … -> List Element -> Element`; each named-slot setter `slot : Element { kind } -> Element` whose body is `M3e.Element.withSlot "slot-name"`; NO `child`/`children`; NO `Content` import. Include an `any`-default component (Toolbar/Card) and a kind-restricted one (Menu) and a named-slot component (Tabs). Write the exact expected strings.

- [ ] **Step 2: Run golden — verify fail.** Run: `cd elm-cem && npx elm-test` → FAIL on ③.

- [ ] **Step 3: Change `generateShape3Module`.** `view`'s content param type → `List (Element <kindConstraint>)` (constrained where the default slot has kinds; `Element any` otherwise). Named-slot setters emit `\el -> M3e.Element.withSlot "name" el` returning `Element`. Delete `childrenHelper`/`defaultHelpers`. Remove the `Content` import and the `contentNodes` unwrap (children are already `Node`-able `Element`s → map `Element.toNode`). Update `slotSetterName` so the default slot no longer reserves `child`/`children`.

- [ ] **Step 4: Run golden — verify pass** for ③.

- [ ] **Step 5: Commit.** `git commit -m "feat(codegen): M3e ③ view takes List Element; slot setters return Element"`.

### Task 2.3: ④ Record default content → `List Element`

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — `generateShape4Module` (4524–4806): `contentSetter` (4654–4696), `childrenHelper` (4698–4709), `viewType` (4764–4787)
- Modify: `elm-cem/tests/src/GoldenTest.elm` — ④ expectations

- [ ] **Step 1: Update ④ golden** — Record keeps its required record; the *default content list* param flips to `List Element`, named-slot setters return `Element`. (Confirm against Task 0.1 Step 4 finding.)

- [ ] **Step 2–4: Fail → implement → pass** (same loop as 2.2 for `generateShape4Module`).

- [ ] **Step 5: Commit.** `git commit -m "feat(codegen): M3e.Record default content is List Element"`.

### Task 2.4: Vocab + barrel return `Element`; retire `Content` runtime; relocate for/id

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — `generateCemVocabModule` (3786–3892; `slotSetter` 3871–3886), `generateBarrelModule` (6131–6320; `slotAlias` 6192, `specificSlotAliases` 6220–6260, `rebind` 6266–6284)
- Delete: `elm-cem/runtime/M3e/Content.elm`, `elm-cem/runtime/M3e/Content/Internal.elm`
- Modify: `elm-cem/runtime/M3e/Element/Internal.elm` (absorb `slotWithAttr` for/id) OR add an attr setter in codegen
- Modify: `elm-cem/tests/src/GoldenTest.elm` — vocab/barrel expectations

- [ ] **Step 1: Golden first** — vocab `slotSetter` and barrel `slotAlias`/`specificSlotAliases` return `Element` (via `withSlot`); barrel `view` type anns regenerate with `List Element`. Expected strings written.

- [ ] **Step 2: Relocate the for/id auto-wiring (Option 2 — decided).** Delete `Content.Internal.slotWithAttr`; add `M3e.Element.Internal.withAttr : String -> String -> Element sup msg -> Element sup msg` (mirrors `withSlot`, adds a raw `name="value"` attr). FormField's id-wiring default setter is renamed `child` → `control`: `control id_ el = el |> withAttr "id" id_`; `label id_ el = el |> withAttr "for" id_ |> withSlot "label"`. Add goldens for the renamed `control` + these bodies + the new `withAttr` in the runtime.

- [ ] **Step 3: Delete the Content runtime files.** Remove `elm-cem/runtime/M3e/Content.elm` and `Content/Internal.elm`.

- [ ] **Step 4: Fail → implement → pass.** Run: `cd elm-cem && npx elm-test` → all golden PASS. Ensure the generator no longer references `Content`.

- [ ] **Step 5: Commit.** `git commit -m "feat(codegen): retire Content runtime; vocab/barrel return Element; relocate for/id"`.

---

## Phase 3 — Regenerate + verify the library (lands WITH Phases 1–2)

### Task 3.1: Regenerate and compile

**Files:** `packages/m3e/**` (generated — do not hand-edit).

- [ ] **Step 1: Regenerate.** Run the regen command (Pre-read) from repo root.

- [ ] **Step 2: Compile the library.** Run: `cd packages/m3e && docs/node_modules/.bin/elm make src/M3e.elm --output=/dev/null` → Success. Confirm `M3e/Content*.elm` are GONE and no module imports `M3e.Content`.

- [ ] **Step 3: Grep the surface.** `child`/`children` no longer exposed by ③ modules; a representative `view` reads `List (M3e.Element.Element …)`; `M3e.Review.Facts` has `slotKinds`.

- [ ] **Step 4: Regenerate the docs reference.** Run: `cd docs && npm run build:reference` → succeeds.

- [ ] **Step 5: Commit** the regenerated library. `git commit -m "regen(m3e): unwrap default slot — raw Element children, Content retired"`.

### Task 3.2: Green the review config against the regenerated library

**Files:** `review/` config (already wired to `elm-review-cem`).

- [ ] **Step 1: Run elm-review** against the regenerated library + userland (userland still uses `child` — expect failures that Phase 5 fixes; that's OK *within the branch*, NOT on main). Confirm `ValidSlotKind`/required-slot rules now have `slotKinds` data and behave.

- [ ] **Step 2: Confirm the guarantee is live** — hand-write a bad composition (a fab-menu-item where a slot forbids it; a foreign `slot=`) in a scratch module and verify elm-review flags it. Delete the scratch after.

- [ ] **Step 3: Commit** any review-config wiring. `git commit -m "chore(review): confirm slot guarantees live on regenerated library"`.

---

## Phase 4 — Docs converter: stop wrapping default children

### Task 4.1: Emit raw default children (TDD via converter tests)

**Files:**
- Modify: `docs/scripts/examples-gen/lib/to-elm.mjs` — emission sites `:436` (idWiring `child`), `:439` (`child (…)`), `:443` (`children [ … ]`); assembly `:418–471`
- Modify: `docs/scripts/examples-gen/lib/to-elm.test.mjs` (~11 assertions), `oracle.test.mjs` (1)

- [ ] **Step 1: Update the converter test expectations first.** Default children become raw element exprs directly in the `view`'s second list; named-slot setters stay (`M3e.Tabs.panel (…)`) and sit in the SAME list. E.g. `M3e.Toolbar.view [] [ M3e.iconButton [] [ … ], … ]`. Write the exact expected strings for the ~11 cases + the oracle default-helper-name case.

- [ ] **Step 2: Run — verify fail.** Run: `cd docs && node --test scripts/examples-gen/lib/to-elm.test.mjs` → failures.

- [ ] **Step 3: Change the converter.** Delete the `child`/`children` wrapping (`:430–444`) and the idWiring `child` variant; push `defaultExprs` as raw element exprs into the single content list alongside `slottedExprs`. Relocate the idWiring control-`id`→`for` to the attr path (mirror the Phase-2 for/id decision).

- [ ] **Step 4: Run — verify pass.** Run: `node --test scripts/examples-gen/lib/to-elm.test.mjs && node --test scripts/examples-gen/lib/oracle.test.mjs` → all PASS. Full: `npm run test:examples-gen` → PASS.

- [ ] **Step 5: Regenerate examples + build.** Run the examples regen, then `npm run build:ci` → exit 0. The 329 `top` strings now show raw children. Spot-check `config/examples.rich.json`.

- [ ] **Step 6: Commit.** `git commit -m "feat(docs): converter emits raw default children (no child wrapper)"`.

---

## Phase 5 — Migrate userland call sites

71 `.child`/`.children` calls across 24 files. Batches by risk. Each file: edit → `elm-format --yes` → `elm make`/`build:ci` slice → commit.

### Task 5.1: The seam (do first — everything else depends on it compiling)

**Files:** `packages/m3e-kit/src/Seam.elm:40` (imports `M3e.Content.Internal`)

- [ ] **Step 1:** Rewrite the seam onto `M3e.Element.Internal` (`withSlot`/`slotWithAttr` new home). The public `M3e.Content` site in `docs/app/Route/Examples/Shop.elm:34` also drops.
- [ ] **Step 2:** `elm-format --yes` + compile the kit. Run: `cd packages/m3e-kit && elm make src/*.elm --output=/dev/null` (or the kit's build) → Success.
- [ ] **Step 3: Commit.** `git commit -m "refactor(kit): Seam uses Element.Internal (Content retired)"`.

### Task 5.2: Heavy files (52 of 71 calls)

**Files (one commit each):** `docs/app/Route/Concepts/TextField.elm` (10 — mind the prose samples), `Route/Examples/Settings.elm` (9), `docs/app/Shared.elm` (7), `Route/Examples/Travel.elm` (6), `Route/Examples/Mail.elm` (6), `Route/Components/Name_.elm` (6), `Route/Examples/Shop.elm` (5), `Route/Examples/Dashboard.elm` (5).

For EACH file, per call site:
- [ ] **Step 1:** Replace `M3e.<Comp>.child x` → `x`, `M3e.<Comp>.children xs` → `xs` (splice the list), keep named-slot setters as-is (they still exist, now `Element`). Mixed lists like `NavMenuItem.icon i :: NavMenuItem.children xs` become `M3e.navMenuItem.icon i :: xs` (both are `Element`s) — simplifies.
- [ ] **Step 2:** `docs/node_modules/.bin/elm-format --yes <file>`.
- [ ] **Step 3:** `cd docs && npm run build:ci` slice or `elm make` the route → compiles.
- [ ] **Step 4: Commit** per file: `git commit -m "refactor(docs): unwrap slot children in <file>"`.

### Task 5.3: Remaining files (19 calls, ~16 files incl. `packages/m3e-kit/src/Kit/Avatar.elm`)

- [ ] **Step 1–4:** same per-file loop for the tail. After the last, `grep -rn "\.child\b\|\.children\b" docs/app docs/src packages/m3e-kit` returns only legitimate non-M3e hits (verify each).
- [ ] **Step 5: Full gate.** `cd docs && npm run build:ci` → exit 0; `elm-format --validate app src` → `[]`; `npx elm-review` (from review dir) → the `ValidSlotKind`/required rules now green across userland (the guarantees are live and satisfied).

---

## Phase 6 — Tests + docs housekeeping

### Task 6.1: Remaining tests

**Files:** `elm-cem/tests/src/GoldenTest.elm` (final pass), `packages/m3e/tests/BuildShapeTest.elm` (verify Build layer still green), `docs/tests-browser/contract.spec.ts` (runtime — slot attr still stamped, expect green), elm-review-cem fixtures.

- [ ] **Step 1:** `cd elm-cem && npx elm-test` → all golden PASS. `cd packages/m3e && npx elm-test` → Build shape tests PASS (unchanged layer). `cd elm-review-cem && npx elm-test` → PASS.
- [ ] **Step 2:** Run the browser contract tests if runnable; confirm DOM slot behavior unchanged (unmatched-slot children were the only risk and the rule now forbids them). Note any pre-existing stale failures (7 known unrelated) vs new ones.
- [ ] **Step 3: Commit** test updates.

### Task 6.2: ADRs + docs prose

**Files:** `docs/adr/0009-composition-over-injection.md` (+ note in 0008/0013, 0014 §2), `docs/ADOPTION_AND_SLOTS.md`, `docs/THREE_LAYER_PATTERN.md`, `docs/COMPONENT_AGNOSTIC_API.md`, `docs/app/Route/Concepts/Layers.elm` (`topShapesCode` still shows `Content.default`), `PhantomRows.elm` (`handshakeCode` shows `Content { r | content }`).

- [ ] **Step 1:** Add a "Superseded in part by ADR 15" note to 0009 (and cross-refs in 0008/0013/0014). Update the prose docs to describe raw default children. Update the two concept-page CODE samples to the unwrapped shape (the direction sections added in ADR-15 commit `b8940f0` already explain the *why*; now the samples match the shipped code).
- [ ] **Step 2:** `elm-format --validate app src` → `[]`; `npm run build:ci` → exit 0.
- [ ] **Step 3: Commit.** `git commit -m "docs: reconcile ADRs + concept samples with the unwrapped slot"`.

---

## Phase 7 — Final verification + integration

### Task 7.1: Whole-suite green + merge

- [ ] **Step 1: Full bar.** From each repo: `elm-cem` `npx elm-test` PASS; `elm-review-cem` `npx elm-test` PASS; `packages/m3e` compiles + Build tests PASS; `docs` `npm run build:ci` exit 0 + `elm-format --validate` `[]` + `npx elm-review` clean + `npm run test:examples-gen` PASS.
- [ ] **Step 2: Playwright** — build+serve `dist`; confirm a component page renders correctly, the M3e code tab now shows raw children (no `child`/`children`), B2 folds + C slider still work, at mobile + desktop.
- [ ] **Step 3: Reproducibility.** Re-run regen with no changes → `packages/m3e` git-clean (deterministic).
- [ ] **Step 4: Merge order (atomic).** Merge the three sibling-repo branches in dependency order and push: `elm-review-cem` (rules) → `elm-cem` (codegen) → `elm-m3e` (regen + userland + docs). The elm-m3e merge to `main` must include the regenerated library AND the migrated userland AND the green review config in ONE `--no-ff` merge, so `main` never sees the guarantee-gap window.
- [ ] **Step 5:** Push all three; delete the feature branches; remove the worktree (`git worktree remove ../elm-m3e-unwrap`).

---

## Risks & guardrails

- **Guarantee-gap window (highest):** never land regen without the elm-review rules green. Phases 1–3 are one atomic integration (Task 7.1 Step 4). If splitting across sessions, keep everything on the feature branch.
- **`slotKinds` unresolved-child handling:** configurable — `Lenient` (default, silent on unresolved) vs `Strict` (warns). Ship both; consumer picks in `ReviewConfig.elm`. Don't fake precision on unresolved kinds either way.
- **Golden-test churn:** `GoldenTest.elm` is large and exact. Treat it as the executable spec — change expectations first, per component-shape, and let failures drive codegen. Don't chase line numbers; grep symbols.
- **Cross-repo coupling:** `Fact` is a breaking change consumed by generated `Facts.elm`. The `elm-review-cem` field add (1.1) and the codegen emission (2.1) must be compatible at the moment `review` runs — verify with Task 3.2.
- **for/id auto-wiring regression (ADR 10 R6):** the FormField label↔control association threaded through `Content.slotWithAttr` must be preserved by whatever replaces it — cover with a converter test (a FormField example) and a browser check that `for`/`id` still pair.
- **Reproducible regen:** if a fresh regen diffs against the committed library, codegen is non-deterministic — stop and fix before trusting the diff.

---

## Self-review notes

- **Spec coverage:** all 8 impact areas from the recon map to phases (codegen→2, generated lib→3, elm-review→1, converter→4, userland→5, tests→6, config/data→3/4, ADRs→6). ✓
- **Ordering:** Phase 1 (rules) precedes Phase 3 (regen) precedes Phase 5 (userland), enforced by the "one atomic integration" merge. ✓
- **Type consistency:** `slotKinds : List (String, List String)` used identically in 1.1, 1.2, 2.1. Named-slot setters `Element -> Element` (via `withSlot`) consistent across 2.2/2.4/4.1. ✓
- **Open items handed to execution:** the for/id relocation home (Task 0.1/2.4) and `slotKinds` severity (1.2) are flagged decisions, not placeholders — each has a concrete default.
