# Spec — Component API naming convention: `view`→`&lt;name&gt;`/`el`→`required` rename + elm-review rule

Date: 2026-08-13 (revised same day — Part A retargeted after confirming codegen ownership)
Repo: `elm-cem` (generator fix) + `elm-m3e` (regenerated output + one hand-written script)
+ `elm-review-cem` (new rule)
Status: approved design, not yet planned
Related: `src/M3e/Component/*.elm`, `src/M3e.elm`, `.gitattributes`, `CONTRIBUTING.md`,
`docs/ARCHITECTURE-GROUND-TRUTH.md` (elm-m3e); `codegen/Generate/Phantom/Emit.elm`
(elm-cem); `elm-review-cem/src/NoInternalImportOutsideAllowed.elm`

## Problem

Every `M3e.Component.X` module (130 of them, `src/M3e/Component/*.elm`) exposes its
standard constructor as `view` and its required-content constructor as `el`
(e.g. `M3e.Component.Button.elm:1-7`). Jack wants these renamed to read naturally
under either import style:

```elm
import M3e.Components.Button as Button exposing (Button, button)
```

i.e. `view` → the module's own lowercase name (`button` for `Button`, `checkbox` for
`Checkbox`, ...), `el` → `required`. This also gives every module the property that
`Button.button`/`Button.required` read correctly when imported `as X`. (Note: this
spec keeps the existing module namespace `M3e.Component.*` — the user's example used
`M3e.Components.Button`, but no repo module rename is in scope here, see Non-goals.)

**Correction from the first draft of this spec**: `src/M3e/Component/*.elm`,
`src/M3e.elm`, `src/M3e/Build/*.elm`, and `src/M3e/Internal/Types/*.elm` are elm-cem
**codegen output**, not hand-written source — confirmed via `.gitattributes:21`
(`src/** linguist-generated=true`), `CONTRIBUTING.md:10-14` ("The per-component
modules under `src/M3e/` are emitted by `elm-cem`... Do not hand-edit them — change
the generator... and regenerate"), and `docs/ARCHITECTURE-GROUND-TRUTH.md:17-22`. A
130-file codemod against these files (the original Part A) would be silently
reverted by the next `npm run gen:src`. The fix belongs in the generator.

Once the convention exists, it needs a guard so it can't silently drift as new
components are added or existing ones are (re)generated — an elm-review rule in the
sibling `elm-review-cem` package, run against elm-m3e's generated output same as any
other elm-review rule already is.

## Non-goals

- No `M3e.Component` → `M3e.Components` module-namespace rename. The user's example
  import used the plural form; this spec only renames the two functions, not the
  module path. (Flag for Jack to confirm separately if the plural rename is also
  wanted — out of scope here, and if wanted later, is *also* an `elm-cem` generator
  change, not an elm-m3e one.)
- No new `type Button` (or equivalent per-component concrete type) to pair with the
  renamed function — explicitly deferred by Jack, "I'll figure out what that should
  be later." The rule below checks value-naming only, not a type/value pair.
- No rename of `build` (`M3e.Build.X`'s builder-pipe entry point) — it's a different
  module, already correctly named, not part of this ask.
- No behavior change to `view`/`el` themselves — pure rename, signatures and bodies
  untouched.
- No change to `elm-cem`'s config/CEM-manifest inputs — this is purely an emitter
  (`Emit.elm`) change, not a change to what data drives generation.

## Design

### Part A — the rename (elm-cem generator, NOT elm-m3e directly)

All three generator entry points live in one file,
`/Users/jack/Documents/code/elm-cem/codegen/Generate/Phantom/Emit.elm`:

- **`compModule : Brand -> Comp -> Elm.File`** (~line 2681) — emits each
  `M3e.Component.X` module. Currently hardcodes the literal string `"view"` in the
  `exposeGroups`/exposing-list construction (~line 2787) and `"el"` (~line 2789),
  gated by an existing `hasEl` decision point (~lines 2703-2704) that already knows
  whether a component needs the required-content constructor. Also hardcodes `"view"`
  in the function signature/body emission (~lines 3025-3033) and `"el"` in its
  equivalent (~lines 3096-3107). Change: compute the lowercased component base name
  once (`comp.name` lowercased — the same value already used elsewhere for module
  naming) and substitute it everywhere the literal `"view"` appears; substitute the
  literal `"el"` with `"required"` everywhere it appears. Also update any doc-comment
  string templates that say "the `view` function" / "Standard constructor:" etc. to
  reference the new name.
- **`generalModule : Brand -> Elm.File`** (~line 4438) — emits the `M3e` barrel.
  References each component's constructor via `comp.resolvedCtor` (~lines 4496-4507)
  plus one direct `.view` reference (~line 4455) — the `resolvedCtor` path already
  looks designed to be name-agnostic; confirm during implementation whether it
  auto-follows the `compModule` rename or needs its own one-line fix at line 4455.
- **`buildModule : Brand -> List Comp -> Elm.File`** (~line 2595) — emits
  `M3e.Build.X`. Calls into the Component module's constructor internally; expected
  to auto-follow once `compModule`'s emitted names change (verify by regenerating and
  diffing, not by hand-tracing — this file is large, ~276KB, and grep-verification is
  cheaper than manual line tracing here).

**Rollout**: fix `Emit.elm`, run elm-cem's own test/snapshot suite (if one exists —
check during implementation), then run elm-m3e's `npm run gen:src` (the actual
regeneration entry point, `package.json:9`, confirmed to shell out to
`elm-cem.js --output=src`) to regenerate all of `src/M3e/`. Diff the regenerated
output against the pre-change tree to confirm the ONLY changes are the intended
name substitutions (a large diff touching unrelated content would indicate the
generator change had a wider blast radius than intended). Commit the regenerated
`src/` as a normal generated-output commit, same as any other elm-cem bump.

### Part A.1 — the one hand-written call site in elm-m3e

`docs/scripts/extract-reference.mjs` is confirmed **hand-written tooling that lives
permanently in elm-m3e** (no generation markers, normal authored JS, not part of the
elm-cem pipeline) — this one file IS edited directly, not regenerated. Its `roleOf`
classifier at **line 308** (corrected from this spec's earlier `line 305`, which is
the function's own declaration line) special-cases `m.name === "view"` to assign the
`ctor` role. Change to compare against the module's own lowercased base name (already
in scope at that point in the script) instead of the literal string `"view"`, or
every component's constructor silently stops being classified as `ctor` the moment
the generator starts emitting the new names.

Also update: any hand-written docs prose/snippets under `docs/` that spell
`M3e.Component.X.view`/`.el` literally outside of generated example strings (Usage
example strings are themselves generated from the live modules and will follow
automatically once regeneration happens — verify this assumption during
implementation rather than hand-auditing every example), and a `CHANGELOG.md` entry
in elm-cem (breaking generator-output change) plus one in elm-m3e (breaking
`src/M3e` bump, same as any other elm-cem-driven release).

### Part B — the elm-review rule (elm-review-cem)

**Prior-art check (researched before finalizing this design)**: no published
elm-review rule already does this. The closest cousins —
`jfmengels/elm-review-common`'s `NoMissingTypeExpose` (checks that types used in
exposed signatures are themselves exposed — different axis, but the best template to
read for exposing-list-vs-declaration-list set comparison), `NoExposingEverything`
(forbids `exposing (..)`, useful sibling since none of these modules use it today),
`Arkham/elm-review-no-missing-type-constructor` (misleadingly named — it's actually
exhaustiveness-checking for `all...` list functions, not a smart-constructor check),
and `lue-bird/elm-review-import-simple` (enforces `import Module exposing (Module)`
at import sites — the mirror image of this rule, applied at usage sites rather than
definition sites) — none solve "module exposes a value whose name matches a
convention derived from the module's own name." Writing from scratch is confirmed as
the right call; no rule to fork.

New rule file `src/NoMissingComponentApiNames.elm` (name open to a better fit at
implementation time), following the standard visitor pattern used by both
`NoInternalImportOutsideAllowed.elm:45-50` (this package's own convention) and
`NoMissingTypeExpose` (the closest external cousin):

```elm
rule : Rule
rule =
    Rule.newModuleRuleSchemaUsingContextCreator "NoMissingComponentApiNames" initContext
        |> Rule.withModuleDefinitionVisitor moduleDefinitionVisitor
        |> Rule.withDeclarationListVisitor declarationListVisitor
        |> Rule.fromModuleRuleSchema
```

- **`withModuleDefinitionVisitor`**: grab the module's `Elm.Syntax.ModuleName` (a
  `List String`); the last segment, lowercased, is the "expected ctor name." Also
  grab the `Exposing` value from here.
- **`withDeclarationListVisitor`** (not a per-declaration enter visitor — this rule
  needs the FULL declaration list before it can conclude anything is missing):
  collect all top-level declaration names into a `Set String` (or, since these
  modules never use `exposing (..)` today per the confirmed `Button.elm` exposing
  list, just diff against the explicit exposing-list names directly, which is
  simpler and matches what `NoMissingTypeExpose` does).
- **Scope gate**: only activates for modules under `M3e.Component.*` (mirrors the
  prefix-matching approach already in `NoInternalImportOutsideAllowed`'s context).
- **Check**: the module's exposing list must contain a value named
  `<expectedCtorName>` AND a value named `required`. Report a violation on the
  module-definition/exposing-list range naming which of the two is missing — they can
  be missing independently (e.g. a component the generator hasn't regenerated yet
  after a partial elm-cem rollout should get a specific, actionable message).
- **No autofix in v1** — the rename ships through elm-cem regeneration (Part A), not
  through this rule; the rule's job from that point on is drift prevention only
  (e.g. catching a future hand-authored exception to the generator, or a generator
  regression). An autofix could be added later if that turns out to be a recurring
  need — speculative for now, YAGNI.
- **Registration**: add to `review/src/ReviewConfig.elm` in elm-m3e (the actual
  consumer, run against the regenerated `src/`), plus elm-review-cem's own dev config
  for its test suite.
- **Tests**: new `tests/NoMissingComponentApiNamesTest.elm`, following the shape of
  `tests/NoInternalImportOutsideAllowedTest.elm` — cases: module exposing both names
  (no error), missing ctor name only, missing `required` only, missing both, a
  non-`M3e.Component.*` module with neither (no error, out of scope).

## Testing

- `elm-cem`: whatever snapshot/golden-output test suite exists for `Emit.elm` (check
  during implementation) stays green with updated expected output; if none exists,
  this is a gap worth flagging to Jack before or during planning — a codegen change
  with no regression test is exactly the kind of thing that silently breaks later.
- `elm-m3e`: regenerate via `npm run gen:src`, `elm make` across `src/M3e.elm`
  (compiles ⇒ every internal call site tracked the rename correctly — the generator
  itself is the correctness backstop here, not a codemod's grep coverage), then
  `elm-review` with the updated `ReviewConfig.elm` reports 0 violations of the new
  rule across all 130 regenerated component modules.
- `elm-review-cem`: new rule's own test module, `elm-test` green.
- Spot-check the docs site still builds and a couple of Usage.elm examples still
  render the renamed calls correctly (`M3e.Component.Button.button`,
  `M3e.Component.Button.required`).
