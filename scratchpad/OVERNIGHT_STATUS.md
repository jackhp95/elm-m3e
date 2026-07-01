# Overnight status — 2026-07-01 (night)

Morning handoff. Everything below is **committed and pushed to `main`** on both
repos (`elm-m3e` and the gitignored generator `elm-cem`) unless noted. Nothing is
half-broken; each commit compiles.

## What I shipped tonight (verified)

1. **Ornith harness refit** (`scratchpad/ornith-agent.mjs`) — committed/pushed:
   - SYSTEM prompt retargeted to the **built Vocab API**: constructor is always
     `view` (not `Comp.comp`/`Icon.icon`); setters via component module or barrel;
     read `exposing` for exact names; enum inputs are `M3e.Value` tokens.
   - Added the **HARD single-file / signature-preserving constraint** to the prompt.
   - **Signature-lock guard**: snapshots exposed type annotations before/after; on
     drift it reverts and exits `3` (→ opus lane). Tested the extractor (handles
     multi-line annotations). Optional whole-project compile via `ORNITH_ENTRYPOINTS`.
   - Parked `ornith-migrate.mjs` (whole-file regurgitation) in favour of the agent.

2. **`M3e.Review.Facts`** — generated + compiled + committed/pushed:
   - New generator function `generateReviewFacts` emits a data module: per component,
     the **valid enum token names per attribute**, plus **required** and **multi**
     slot names. This is ADR 0012's facts substrate for the codegen-aware rules.
   - Verified: `elm make src/M3e/Review/Facts.elm` green; full lib still 379 modules.

3. **Docs from the grill** (earlier, pushed): ADR 0012 (codegen-aware elm-review),
   `docs/ORNITH_MIGRATION_PLAN.md`, CONTEXT.md terms.

## A finding that de-risks the migration

While reading the generated facts I caught my own earlier mistake: the new
`<m3e-theme>` **does** expose a `scheme` attribute accepting `auto | dark | light`
(the facts prove it) — that's the old `Theme.Scheme = Auto | Light | Dark`. So the
docs app's **dark-mode toggle maps cleanly**: `Theme.scheme model.scheme` →
`M3e.Theme.scheme (Value.auto | Value.light | Value.dark)`. The `variant` attr is
the color-generation algorithm (`tonalSpot`, `vibrant`, …). So `Shared.elm` is less
fuzzy than I feared — its Theme, Contrast, and Density controls all map to real
`M3e.Theme` setters.

## What I deliberately did NOT do, and why

- **The `ValidEnumValue` rule itself** (task #8). It must `import M3e.Review.Facts`,
  which means adding `../packages/m3e/src` to `review/elm.json` source-dirs, and the
  old-era review config must be ported first (task #7). Writing an elm-review rule I
  can't run + unit-test tonight would be unverified — against the discipline this
  project holds. The facts substrate it needs is done and waiting.
- **The docs-app migration / tunnel.** A running app needs *all* routes compiling
  (~1073 sites). `Shared.elm` alone is a 763-line near-total rewrite off the deleted
  hand API. It's tractable now (Theme de-fuzzed), but it's the opus lane and wants
  your eyes on the result — which is exactly what the tunnel was for. Doing it blind
  overnight risked a large wrong rewrite. It's teed up, not started.

## Concrete next steps (in order)

1. **Port the review config to the new world** (task #7): re-point `review/` off the
   dead `src/M3e/` + `vendor/` + `Ui.*` paths; generalize `NoRawLayoutOutsideLayoutModule`
   into the configurable Seam gate; retire `NoMissingFacadeEntry` (the barrel is
   generated now — it currently misfires on `M3e.Progress`, which surfaces a *real*
   gap: variant-group modules aren't in the barrel).
2. **Write `ValidEnumValue`** (task #8) against `M3e.Review.Facts`, unit-tested via
   `review/tests`.
3. **Migrate `Shared.elm`** (opus lane) — Theme/Contrast/Density → `M3e.Theme.*`;
   AppBar/Card/Icon/IconButton/Heading → their `view [attrs] [content]`; the drawer +
   segmented controls are the remaining genuine unknowns (new `DrawerContainer` /
   `SegmentedButton` APIs differ — surface, don't guess). Then the mechanical routes
   compile and a tunnel becomes possible.

## Task board

`#5` facts module ✅ · `#6` ornith refit ✅ · `#7` port review config (next) ·
`#8` ValidEnumValue rule (needs #7) · plus the docs migration (opus lane).
