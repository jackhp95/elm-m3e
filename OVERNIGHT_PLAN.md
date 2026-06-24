# OVERNIGHT_PLAN.md — m3e-builder one-shot (LIVING DOCUMENT)

> **REREAD THIS IN FULL ON EVERY COMPACTION** (see memory `overnight-mission`).
> Update the checklists as work completes. This is the single source of truth for
> phase state. Keep it honest: only check a box when verified, not when attempted.

## The contract (binding — from the user)
- NEVER stop to ask. Use judgement. Most correct solution. Don't stop until 100% done.
- Exhaustive: everything in REMAINING_WORK.md + every cleanup + anything discovered later.
- Follow Material Design 3 spec EXACTLY. Remove anything non-Material (Theme `t-*`,
  overlapping `Ui.Size`) and replace with a Material-correct equivalent.
- Every one of the 54 `Ui.*` components used **>=2x** across demo pages (build a matrix).
- Mirror matraic's m3e site closely (nav: Getting Started / Styles / Frameworks / Components,
  plus a Studies section for the demos). Fix the root-cause of the visual gap.
- Package-READY (branch + runbook), do NOT `elm publish`, do NOT touch elm-cem/elm-m3e.
- TDD (red-green-refactor). Playwright for rendered behavior. Verification agents cross-check
  Material adherence against the local `m3e-docs` repo.
- elm-review: community essentials + custom MISI rules + review src AND demos + CI gate.
- Worktrees + parallel agents for throughput; orchestrator verifies then MERGES to main.

## Baseline facts (verified)
- Toolchain (via `docs/node_modules/.bin`): elm 0.19.1, elm-format 0.8.8, elm-review 2.13.5.
  Run elm tools with `export PATH="$PWD/docs/node_modules/.bin:$PATH"` from repo root, or
  `cd docs`. Root `elm.json` is an `application` (source-dirs `src` + `vendor/elm-m3e`).
- Library compiles: barrel of all 53 `Ui.*` → "Compiled 127 modules" OK.
- m3e-docs oracle: `/Users/jhp/code/jackhp95/m3e-docs` — `scripts/lib/validate-markup.mjs`,
  `data/components.json` (CEM ground truth), `scripts/render-verify.mjs` (jsdom).
- matraic nav: Getting Started (Overview, Installation, Browser Support) · Styles (Color,
  Density, Motion, Typography) · Frameworks (React/Vue/Angular) · Components (50+). v2.5.12.
- @m3e/web is v2.5.12 (docs/package.json). Tailwind v4 + vendored `tailwind-m3e-web` bridge.

## Branch
- Working branch: `overnight-package-quality` (no ticket; personal repo). Merge to `main` when verified.
- Package-ready elm.json change lives on its own branch `package-ready` (never merged to main
  until elm-m3e is published — keep main as a working application).

---

## PHASES (check boxes as completed)

### Phase 0 — Tooling & baseline  ✅ (mostly done)
- [x] Install toolchain (docs/node_modules) — elm, elm-format, elm-review present.
- [x] Library barrel compiles (127 modules).
- [ ] Docs build succeeds (`cd docs && npm run build`) — baseline (in progress).
- [ ] Playwright screenshot of current docs vs matraic — capture the visual gap.
- [ ] Create working branch.

### Phase 1 — Research & diagnosis (durable markdown in `docs/research/`)
- [ ] `docs/research/visual-gap.md` — WHY ours doesn't look like matraic (tokens, typography,
      bridge wiring, density, missing demos). Root-cause, not symptoms.
- [ ] `docs/research/matraic-site-map.md` — full nav + page inventory to mirror.
- [ ] `docs/research/material-spec-deltas.md` — per-component, where our API/markup deviates
      from Material 3 spec & the m3e CEM (the oracle). Drives Phase 3.
- [ ] `docs/research/component-coverage-matrix.md` — 54 components × demo pages, prove >=2x.
- [ ] `docs/research/elm-review-rules.md` — every rule (community + custom) + rationale.

### Phase 2 — elm-review infrastructure (TDD on custom rules)
- [ ] `review/` project (elm-review init). Add community rules: NoUnused.*, Simplify,
      NoDebug, NoMissingTypeAnnotation, NoExposingEverything, Docs rules, NoPrematureLetComputation, etc.
- [ ] Custom rules (each TDD: failing Test → rule → green):
  - [ ] `PreferBadgeCount` (Ui.Badge.label (String.fromInt n) → Ui.Badge.count n)
  - [ ] `NoActionlessButton` smell
  - [ ] `NoRawAttributeInUi` (no raw `Attr.attribute`/string slots in src/Ui where typed exists)
  - [ ] `NoProprietaryDsClasses` (forbid `ds-*` classes)
  - [ ] slot-type discipline rule(s) as feasible
- [ ] Run review across src AND docs AND demos; drive to zero.

### Phase 3 — Library correctness & Material-exactness — ✅ DONE (7 TDD agents, all merged)
- [x] 6 CRITICAL slot bugs (AppBar, NavBar, NavRail, SideSheet, BottomSheet, SplitButton/FabMenu).
- [x] 13 HIGH + 12 MEDIUM + 4 LOW deltas fixed (form-field labels, Paginator page-index, Tabs/Tooltip
      slots, Dialog full-screen removed, RadioButton name, SegmentedButton standalone, Select native label, etc.)
- [x] F15 Avatar.extractInitials fallback. [x] all `ds-*` removed. [x] F8 List item/actionItem split.
- [x] Disclosure un-parked → single/accordion, magic id removed. [x] raw Attr.attribute audit.
- [x] Theme: non-Material `t-*` removed → wraps `<m3e-theme>` (ADR 0001). [x] Ui.Size retired into Heading (ADR 0002).
- [ ] **STILL TODO: independent verification agent re-checks all 53 emitted markups vs m3e-docs CEM (Phase 7).**

### Phase 4 — Test suite — ✅ logic done (150 tests pass; one test file per fixed module)
- [x] tests/ project (elm-explorations/test 2.2.1). 36 test files, 150 tests, all green.
- [ ] Snackbar end-to-end wiring documented + tested (revisit in Phase 5/7 with interactivity).

### Phase 5 — Docs site overhaul (mirror matraic) + theming root-cause fix
- [ ] Convert routes to `buildWithLocalState` (interactivity).
- [ ] Restructure nav: Getting Started / Styles / Frameworks(Elm) / Components / Studies.
- [ ] Per-component pages (one file each) — split the monolith Index.
- [ ] Fix theming root cause (M3 color/typography/density tokens via bridge). Zero hand-CSS.
- [ ] Self-host Material Symbols; replace pravatar with local asset; M3 baseline purple seed.

### Phase 6 — Demo studies (coverage >=2x)
- [ ] Reply (email), Shrine (commerce), Rally (finance), Crane (travel), Settings — + more
      (Owl, Fortnightly, Profile, Chat, Media player, Auth/onboarding, Dashboard) until matrix proves >=2x.
- [ ] Built by parallel agents; each verified against Material guidelines (agent + m3e-docs).

### Phase 7 — Playwright verification
- [ ] Every component renders correctly (slots in right place — F1.2/F1.3 nav & form labels).
- [ ] Every demo page renders + interactive behavior works (clicks, dialogs, snackbar, tabs).
- [ ] Screenshots captured; compared against matraic feel.

### Phase 8 — Package-readiness (branch `package-ready`, NO publish)
- [ ] package-shaped elm.json, exposed-modules (all 54), summary, license, `elm make --docs docs.json` clean.
- [ ] Every exposed module has module doc + @docs covering every exposed value (review-enforced).
- [ ] `docs/research/publish-runbook.md` (the gated elm-m3e-first steps).

### Phase 9 — CI gate
- [ ] GitHub Actions: install toolchain, `elm-format --validate`, library barrel compile,
      `elm-test`, `elm-review`, docs build, doc-example identifier check (prevents F1 rot).

### Phase 10 — Finalize
- [ ] Update REMAINING_WORK.md (mark done / re-scope). Update README (counts, status, demos).
- [ ] ADRs in `docs/adr/` for Theme removal, Size resolution, packaging decision.
- [ ] Merge working branch → main; resolve conflicts; clean tree; final verification report.

## Running discovery log (append anything found mid-flight)

### Phase 1 research complete — durable reports in `docs/research/`:
- `material-spec-deltas.md` — 35/53 modules DELTA: **6 CRITICAL, 13 HIGH, 12 MEDIUM, 4 LOW**.
- `matraic-site-map.md` + `visual-gap.md` — tokens fully wired in tailwind-m3e-web bridge;
  root cause = `app/Shared.elm` is the elm-pages starter STUB (no M3 app shell). Fix = real
  themed app bar + sidebar in Shared, single `<m3e-theme>` owner, body M3 base layer,
  theme/density/dark/direction controls, multi-page IA.
- `elm-review-rules.md` — community set + 5 custom rules (PreferBadgeCount, NoActionlessButton,
  NoRawAttributeInUi, NoProprietaryDsClasses, NoUntypedSlot) with TDD seeds + review/ setup.
- `component-coverage-matrix.md` — **13 studies**, all 54 components >=2x confirmed:
  Reply, Shrine, Rally, Crane, Settings, Owl, Fortnightly, Profile, Chat, Media, Auth, Tasks, Dashboard.

### THE 6 CRITICAL RENDERING BUGS (fix first, TDD via Test.Html):
1. AppBar.elm:133 — title has no slot → dropped. Use `M3e.AppBar.titleSlot`.
2. NavigationBar.elm — emits `m3e-nav-menu-item` (wrong) inside nav-bar; label/badge slots don't exist.
   Use `M3e.NavItem`, label→default slot, badge composed in content (no badge slot).
3. NavigationRail.elm — same as NavBar.
4. SideSheet.elm:229,241 — body/actions in default slot not start/end → panel empty. Use start/endSlot; wire onClose.
5. BottomSheet.elm:155-166 — `open` never emitted (never opens); onClose never wired. Emit open, wire onClosed/onCancel.
6. SplitButton.elm:122-136 — buttons have no slot → not projected. Use leadingButtonSlot/trailingButtonSlot.
   FabMenu.elm:121-139 — raw <button> children + no trigger + triggerIcon dropped. Use m3e-menu-item + m3e-fab-menu-trigger.

### Judgement calls I'm locking (human-flagged deltas — user said use judgement, most-correct):
- **Form-field labels** (TextField/Select/Checkbox/RadioButton/Switch/Slider/TimePicker/SegmentedButton):
  emit `<label slot="label" for="<id>">` + always auto-generate a stable control id. For `m3e-select`
  use its native `label` attr (drop the form-field double-wrap).
- **ExtendedFab**: KEEP the ergonomic split (documented M3 page, like the Button MISI carve-out) but fix
  label to use `M3e.Fab.labelSlot`.
- **SegmentedButton**: render standalone (NOT inside m3e-form-field); label via project layout if needed.
- **ScrollContainer / TextHighlight / Slide / `<m3e-slide>`**: these DO ship in @m3e/web (real vendor
  bindings) — KEEP, but rewrite doc comments to state they're utility elements outside the documented-53 set.
- **Theme**: delete `t-*`. Add faithful `Ui.Theme` wrapping `<m3e-theme>` (seed/scheme/variant/contrast/
  density/strongFocus/motion/onChange + themed subtree). Rename Danger→Error, drop Neutral. ADR.
- **Size**: retire shared `Ui.Size`; fold 3-step size into `Ui.Heading`; keep per-component sizes (already
  match CEM enums + align defaults to CEM). ADR.
- **RadioButton**: thread a shared auto-derived `name` onto group + radios.
- **Paginator**: fix `pageIndex`→`page-index` (M3e.Paginator.pageIndex).
- **Dialog.withFullScreen**: remove (not a CEM attr; silent no-op).
- **Carousel/Slide**: keep both; put items in slide-group default slot correctly.

### KNOWN BREAKAGE to fix in Phase 5 (expected, from the library refactor)
- `docs/app/Route/Index.elm` references the REMOVED `Ui.Size` and the OLD `Ui.Theme` (`Theme(..)`,
  `toAttribute`). Docs/app will NOT compile until migrated to the new APIs in Phase 5. This is expected.
- New library APIs the docs/demos MUST use: `Ui.Theme.view`/`with*` (wraps m3e-theme), `Ui.Heading.Size`,
  `Ui.List.item`/`actionItem`, `Ui.Disclosure.single`/`accordion`, `Ui.SegmentedButton` standalone,
  `Ui.Dialog` no `withFullScreen`, `Ui.ButtonGroup.withVariant`, `Ui.Shape.withName`, `Ui.SplitButton.withTriggerLabel`,
  `Ui.FabMenu.withId`, `Ui.BottomSheet.withModal`/`withHeader`.

### WORKTREE GOTCHA (remember every compaction)
Agent `isolation: worktree` branches from OLD main (f8379d3), NOT my working branch — so agents do
NOT see merged progress, and re-add the elm.json test-deps block (merges clean, identical). For work
that must SEE current src (e.g. run elm-review against the fixed library, migrate docs), use a
NON-isolated agent on the current branch, run ALONE (no parallel, to avoid elm-stuff races). For
self-contained work (library module fixes w/ inline-fixture tests, custom elm-review rule TDD), worktree
isolation is fine and merges cleanly.

### Refined execution order
Phase 2 (review scaffold) + Phase 4 scaffold (tests/) → Phase 3 library fixes via TDD (criticals→high→
med/low, incl. Theme/Size refactor + Disclosure unpark + List split) → custom review rules green →
Phase 5 docs shell/theming/IA → Phase 6 demos (parallel agents, worktrees, AFTER API stable) →
Phase 7 playwright → Phase 8 package-ready → Phase 9 CI → Phase 10 finalize+merge.
API-CHANGING fixes (Theme, Size, List split, Disclosure, SegmentedButton, Select) MUST land before demos.
