# Component Builder Redesign — Acceptance Criteria & Execution Waves

> **STATUS (2026-06-22):** Historical execution tracker from Casey's branch
> (`origin/VOLT-2003-figma-code-connect`). Authoritative phasing is in
> `M3E_SPLIT_REDESIGN.md` §7. The "completed waves" below represent Casey's
> branch state, not this branch — those components are seed/reference for the
> strict-split rewrite, not yet integrated as code on `VOLT-2003`.

Companion to `COMPONENT_BUILDER_REDESIGN.md`. Tracks the sequenced implementation.

## Key reconnaissance finding (drives sequencing)

Blast-radius audit (ripgrep over `src/elm`, excluding the module itself):

| Component | Production call sites | Risk |
|---|---|---|
| Ui.Avatar | **0** (only generated catalog + code-connect) | low |
| Ui.Badge | **0** | low |
| Ui.Progress | **0** | low |
| Ui.Chip | **0** | low |
| Ui.Search | **0** (playground only) | low |
| Ui.Snackbar | **0** (playground only) | low |
| Ui.Button | ~31 real infra sites (Listing/Overlay/Card/Toolbar) + large `App/Play/UiNextPlayground.elm` demo | **high** |

So the "audit every call site / large blast radius" concern in the spec is real only for **Button**. Every other Bucket-A component is a near-isolated rewrite whose only downstream consumers are the generated catalog and the Code Connect `.figma.ts` (both regenerated from annotations).

## The fixed pipeline for every component change

Annotations in Elm doc-comments → `DesignSystem.ExtractUiComponents` (elm-review) → JSON taxonomy
(`code-connect/lib.mjs`) → **two** emitters: `generate.mjs` (`.figma.ts`) and `generate-ui-catalog.mjs`
(`/play`). Per component:

1. Rewrite `src/elm/Ui/<C>.elm` (API + `@figma-code-connect` doc annotations).
2. `node code-connect/generate.mjs` → sync `_generated/*` into committed `code-connect/*.figma.ts`.
3. `npm run elm-gen:build:uiCatalog` (regenerate `/play`).
4. `npm run figma:check` (drift + orphan + catalog sync) must pass.
5. `npm run build:elm`, `npm run format:elm`, `npm run elm-review -- --fix-all-without-prompt`, `npm run test:elm`.
6. code-reviewer + acceptance-criteria subagents.

## Status (this session)

- ✅ **Wave 1 — Ui.Progress** (§7): value required; `indeterminate` only no-value path; `withValue`
  removed; linear indeterminate-mode bug fixed. Verified end-to-end.
- ✅ **Grammar extension**: bare anonymous `@figma-code-connect node=` lines may now carry
  `entry=`/`valueProp=`/`labelProp=`/`fixed=` (rule + lib.mjs + test). Unblocked Avatar/Badge without
  splitting them into named components. 234 rule tests pass.
- ✅ **Wave 2 — Ui.Avatar** (§1): `image`/`initials`/`icon`; `new`/`withContent` module-internal.
- ✅ **Wave 2 — Ui.Badge** (§2): `dot`/`count`/`label`; `999+` truncation inside `count`;
  `withSize`/`Ui.Size` dropped.
- ✅ **Wave 4 — Ui.Search** (§8): phantom `Search Bar/Results msg`; `bar`/`results` constructors;
  `withClearable` bar-only, open-state results-only; view-dispatch no longer inferred from items.
  Migrated the 4 `UiNextPlayground` call sites.
- ✅ **§10 generator (record/msg synthesis)**: the generators now synthesize runtime data inside an
  entry constructor's record arg — a `msg`-named handler field → preview no-op (`noClick`); a label
  field → `labelProp`. `classifyEntryArg` (lib.mjs), `MsgValue`/`ValueRecord` (codegen), record/msg
  rendering (generate.mjs). Output-neutral for pre-existing components.
- ✅ **Wave 3 — Ui.Chip** (§5): killed `basic`; per-kind record constructors with required
  collaborators; phantom `Filter`/`Input`/`Generic` kinds gate modifiers (`withSelected` filter-only,
  `withHref` assist/suggestion-only); outlined/elevated style axis; typed sets. Removed the orphaned
  Basic Code Connect node.
- ✅ **PreferBadgeCount elm-review rule** (§2): flags `Ui.Badge.label (String.fromInt n)` → steers to
  `Ui.Badge.count`. Built in an isolated worktree (background), integrated, 239 rule tests pass.
- ✅ **Wave 5 — Ui.Button** (§3): single `Button msg` type (no phantom types); `labeled`/`iconOnly`
  constructors with the variant in the record (distinct LabeledVariant/IconVariant); iconOnly a11y
  label type-required; added Size; explicit Action (no auto-disable); FAB/group/segmented take
  `List (Button msg)`. Migrated 31 UiNextPlayground sites.
- ✅ **Generator (enum + icon constructor-arg axes)**: a Figma enum property can feed an entry
  constructor's enum arg (`variantProp=`/`variantStripPrefix=`), injected into the constructor and
  surfaced as a /play control; a `Ui.Icon.Icon` field renders the `iconContent=` placeholder glyph.
- ⏸ **Remaining: Snackbar (§9, JS ports); the rest of §10 (sample select options, tristate/progress
  value knob, snackbar trigger) + Field Bucket-B (§6); no-action-Button rule (§3, optional +
  needs design — static dataflow over builder pipelines); Card browser-verify (§4, needs running app).**

Commits: `b8bde8adc9` (Progress/Avatar/Badge/Search + grammar), `fcd28cd1d3` (Chip + §10 record/msg),
`95d4930a0b` (PreferBadgeCount rule), `4115c69918` (Button + enum/icon constructor-arg axes).

Every completed wave passed: `figma:check`, `npm run build:elm`, `npm run format:elm`,
`npm run elm-review -- --fix-all-without-prompt`, `npm run test:elm` (2018), rule tests (234), and a
clean code-reviewer pass.

## Waves

- **Wave 1 (safe, this session): Ui.Progress** — value required on `linear`/`circular`; `indeterminate`
  the only no-value path; drop `withValue`. Real bug fix (linear never set indeterminate mode). No
  generator-grammar change (both Figma components already use `entry=`).
- **Wave 2: Ui.Avatar, Ui.Badge** — both need a Code Connect decision: their redesign removes `new`,
  so the bare anonymous `node=` binding (which can only build from `new`) no longer works. Either
  (a) extend the grammar so a bare `node=` can carry `entry=`/`labelProp=`/`valueProp=` (shared-tool
  change), or (b) restructure to named `component=` bindings (changes file names + ids, needs Figma
  variant info). **Decision needed before starting.**
- **Wave 3: Ui.Chip** — kill `basic`; per-kind constructors with required collaborators; typed sets;
  outlined/elevated style axis; `withHref` on assist/suggestion. Larger API surface.
- **Wave 4: Ui.Search** — explicit constructors so no setter is silently ignored.
- **Wave 5: Ui.Button** — largest; the only one with real call-site migration. Single `Button msg`
  type, variant in constructor record, `labeled`/`iconOnly`, add Size, explicit action, FAB/group/
  segmented take `List (Button msg)`.
- **Wave 6: Ui.Snackbar** — needs JS `<avt-snackbar>` custom element + Elm port (imperative `show`
  Effect + declarative `view`). Deepest; browser-verify.
- **Wave 7 (cross-cutting): generator sample-data grammar (§10)** + Ui.Field Bucket-B previews +
  new elm-review rules (Badge.count, no-action Button). Several independent sub-projects.
- **Card (§4): browser-verify only** — confirm whether it renders wrong only in `/play` or app-wide.

## Per-component acceptance criteria

### Ui.Progress (Wave 1)
- [ ] `linear : Int -> Progress msg` and `circular : Int -> Progress msg` (value required).
- [ ] `indeterminate : Shape -> Progress msg` is the only no-value path.
- [ ] `withValue` removed from the public API.
- [ ] `withMax`, `withId` retained.
- [ ] **Bug fixed:** linear with no value renders indeterminate (animated), not an invisible
      determinate bar — `view` sets `modeIndeterminate` for value-absent linear, mirroring circular's
      `indeterminate True`.
- [ ] `@figma-code-connect entry=linear`/`entry=circular` annotations still valid; `.figma.ts`
      regenerated; `figma:check` green; catalog regenerated.
- [ ] Build, format, elm-review, tests pass.
