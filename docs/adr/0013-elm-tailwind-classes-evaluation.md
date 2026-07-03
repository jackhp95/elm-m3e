# 13. elm-tailwind-classes for the visual seam: evaluation

Date: 2026-07-03

## Status

Proposed (evaluation). Records the exploration of
[dillonkearns/elm-tailwind-classes](https://github.com/dillonkearns/elm-tailwind-classes)
as a replacement for the raw Tailwind **class strings** inside the visual seam.
Builds on [ADR 12](0012-codegen-aware-elm-review.md) (the Seam gate) and
[ADR 9](0009-composition-over-injection.md). **Recommendation: adopt narrowly, or
not yet — see below.** No code changes ship with this ADR; it exists to show the
work and the trade-offs.

## Context

The design system already contains a **visual seam**: raw Tailwind lives only in a
few blessed adapter modules — `Kit`, `Kit.Surface`, `Kit.Shape`, plus `Native` /
`Layout` — and `NoSeamOutsideAllowedModules` (ADR 12) keeps feature code from
writing Tailwind directly. Inside those modules the tokens are plain strings:

- `Kit.elm` — `TextColor "text-on-surface"`, `"hover:underline"`,
  `"text-label-lg uppercase tracking-wide"`, and the dynamically-built
  `"text-" ++ role ++ "-" ++ sizeSuffix size` in `typescale`.
- `Kit/Surface.elm` — surface roles as `bg-*` / `text-on-*` pairs
  (`bg-primary` + `text-on-primary`, `bg-surface-container`, …).
- `Kit/Shape.elm` — seven corner tokens (`rounded-md-corner-medium`, …,
  `rounded-full`, `rounded-none`).

That is roughly **41 class-string literals**, all custom M3 theme tokens defined in
the Tailwind **v4** `@theme` block (`docs/vendor/tailwind-m3e-web/src/theme.css`).

These strings are **unchecked**. A typo — `TextColor "text-on-surfce"` — compiles
cleanly and silently renders no colour; drift between a renamed theme token and its
Kit reference is invisible until someone eyeballs the pixels. The proposal is to
replace these strings with a type-safe, generated Tailwind API so the compiler
verifies each token exists in the theme.

## What elm-tailwind-classes is

A build-time toolchain, **not** an Elm package you `elm install`:

1. A **Vite plugin** generates Elm modules (a `Tw` API, `.elm-tailwind/`) from your
   Tailwind setup via `tailwind-resolver`. It supports the **v4 CSS `@theme`**
   syntax and picks up custom tokens, so our M3 roles would generate
   (`Tw.text_on_surface`, `Tw.bg_primary`, …).
2. An **elm-review** rule statically extracts the classes your Elm actually uses and
   feeds them to Tailwind's JIT compiler for the CSS bundle.

So the API is genuinely compiler-checked and adds zero runtime cost — but it couples
styling to a **Vite + elm-review + codegen** pipeline.

## The genuine win, and its size

The tool's headline value is stopping raw Tailwind from leaking through *feature
code*. **We already have that** via the Seam gate. So the marginal win here is
narrower but real: **compile-time verification of ~41 token strings against the
actual theme**, killing the silent-typo / silent-drift failure mode inside the
seam. That is worth something for a design system whose whole job is token fidelity
— but it is a much smaller prize than the tool is built to deliver.

## Concerns

1. **We are buying a feature-code solution for a problem already solved.** The seam
   architecture is the containment mechanism; elm-tailwind-classes is a *second*
   containment mechanism aimed at the same leak. Adopting it broadly risks
   re-litigating ADR 12 rather than complementing it.

2. **Dynamic class construction must be unrolled.** `typescale` builds
   `"text-" ++ role ++ "-" ++ sizeSuffix size` — a form static extraction cannot
   see. Adoption means enumerating every variant (`Tw.text_display_lg`,
   `Tw.text_headline_md`, …) and rewriting the elegant parameterized helper into a
   lookup. That is a real refactor and, arguably, a legibility regression.

3. **Two builds, one generated module.** `Kit` compiles under *both* the root
   `elm.json` and `docs/elm.json` (it is source-directory-shared, not a package).
   The `Tw` module is generated only by the docs app's Vite run. If `Kit` imports
   `Tw`, the **root build breaks** unless the generated module is committed to the
   repo or the root build is retired. Committing generated code has its own upkeep
   cost.

4. **It forecloses publishing `m3e-kit` as a standalone Elm package.** A package
   cannot ship a consumer-generated `Tw` module; its styling would depend on the
   consumer's Tailwind build. If `m3e-kit`-as-library is ever a goal, this direction
   works against it.

5. **New pipeline dependency + toolchain risk.** elm-tailwind-classes is a
   capable but specialised single-maintainer tool. It becomes load-bearing for the
   build. Its own elm-review pass must also compose cleanly with our existing
   `review/` rules (should be fine — both are just rules — but it is another moving
   part).

## Options considered

- **A — Full adoption inside the seam.** `Kit`/`Surface`/`Shape` call `Tw.*`
  throughout; wire the Vite plugin into the docs build; commit `Tw` for the root
  build. Maximum type-safety, maximum churn, hits concerns 2–4 hardest.

- **B — Narrow: `Tw` as the checked *implementation* behind the existing named
  primitives (recommended if we adopt).** Keep the public Kit API exactly as is
  (`Kit.onSurface`, `Kit.body Large`, `Surface.primary`, `Shape.medium`). Swap only
  the *string constants* for `Tw.*` references, and unroll `typescale` into a small
  explicit table. Feature code is untouched; the seam gate still governs; the win
  (typo/drift protection) is captured with the blast radius contained to three
  modules. Still must solve the two-builds problem (concern 3).

- **C — Status quo + a cheap guardrail (recommended if we don't adopt).** Don't take
  the pipeline dependency. Instead add a tiny **check that every class literal in the
  Kit modules exists in the generated `utilities.css`** — a script, or a hand-written
  elm-review rule seeded from the theme token list. Captures ~80% of the win (catches
  typos/drift) for ~10% of the cost, and keeps `m3e-kit` publishable.

- **D — Do nothing.** The strings are already contained and change rarely; accept the
  eyeball-review status quo.

## Recommendation

The tool is well-built and v4-ready, and the safety win is real — but this codebase
has *already* paid for containment with the Seam gate, which shrinks the prize to
type-checking ~41 strings. That does not clearly justify making a
Vite + codegen + elm-review pipeline load-bearing, resolving the two-builds problem,
and giving up `m3e-kit`-as-package.

**Lead recommendation: Option C** — a lightweight theme-token check — as the
cost-appropriate way to kill the silent-typo/drift failure mode. If we later want
full parameterized type-safety on tokens (e.g. `Tw.bg_color (primary s40)` for the
tonal scale) and `m3e-kit`-as-package is off the table, **Option B** is the right
shape and this ADR is the on-ramp.

## Consequences

- If **B/A**: the docs Vite build gains the elm-tailwind-classes plugin; the root
  build needs the generated `Tw` committed (or retirement); `typescale` is unrolled;
  `NoSeamOutsideAllowedModules` still applies and the new extraction rule joins
  `review/`. `m3e-kit` becomes app-space-only for good.
- If **C**: no pipeline change; one small check added to CI that reads the theme
  token set and the Kit class literals. `m3e-kit` stays publishable.
- Either way, the failure mode being closed is **unchecked token strings drifting
  from the theme** — the thing worth fixing, independent of which mechanism we pick.

### Appendix: how to verify these claims

- Seam containment: `review/src/NoSeamOutsideAllowedModules.elm`, allow-list
  `["Native", "Layout", "Kit"]`.
- The 41 strings: `grep -rhoE '"[a-z][a-z0-9:_ -]*"' packages/m3e-kit/src` filtered
  to class-shaped tokens.
- v4 theme: `docs/vendor/tailwind-m3e-web/src/theme.css` (`@theme { … }`).
- Two-build shared source: `source-directories` in both `./elm.json` and
  `./docs/elm.json` include `packages/m3e-kit/src`; there is no
  `packages/m3e-kit/elm.json`.
- Tool shape: elm-tailwind-classes `package.json` depends on `tailwind-resolver`
  and peer-depends on `elm-review`; the plugin runs under Vite.
