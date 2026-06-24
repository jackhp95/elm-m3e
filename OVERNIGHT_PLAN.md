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

### Phase 3 — Library correctness & Material-exactness (verification agents vs m3e-docs)
- [ ] F15 Avatar.extractInitials fallback for non-letter input.
- [ ] Remove/replace all `ds-*` classes (Card/Dialog/BottomSheet/SideSheet/Tooltip/Shape).
- [ ] F8 List split (`Ui.List.item` vs `Ui.List.actionItem`) — no render-path-from-modifier.
- [ ] Un-park Disclosure → `Disclosure.single`/`Disclosure.accordion`, fix magic id (F16).
- [ ] F12 Select option-value key; F14 cosmetics; 34-site `Attr.attribute` audit.
- [ ] Remove non-Material `Ui.Theme` `t-*` contract → remap to M3 tokens (ADR).
- [ ] Resolve `Ui.Size` vs per-component sizes per Material spec (ADR).
- [ ] Verification agents cross-check EVERY component's emitted markup vs m3e-docs CEM.

### Phase 4 — Test suite (TDD, elm-test)
- [ ] `tests/` project; unit/fuzz tests for all pure logic (Avatar initials, Snackbar encode,
      Badge count, Select, Size, Theme, Disclosure, List, every builder's invariants).
- [ ] Snackbar end-to-end wiring documented + tested.

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
- (none yet)
