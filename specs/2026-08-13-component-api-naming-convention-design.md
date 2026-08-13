# Spec — Component API naming convention: `view`→`&lt;name&gt;`/`el`→`required` rename + elm-review rule

Date: 2026-08-13
Repo: `elm-m3e` (rename) + `elm-review-cem` (new rule)
Status: approved design, not yet planned
Related: `src/M3e/Component/*.elm`, `src/M3e.elm`, `elm-review-cem/src/NoInternalImportOutsideAllowed.elm`

## Problem

Every `M3e.Component.X` module (130 of them, `src/M3e/Component/*.elm`) exposes its
standard constructor as `view` and its required-content constructor as `el`
(e.g. `M3e.Component.Button.elm:1-7`). Jack wants these renamed to read naturally
under either import style:

```elm
import M3e.Components.Button exposing (Button, button)
import M3e.Components.Button as Button
```

i.e. `view` → the module's own lowercase name (`button` for `Button`, `checkbox` for
`Checkbox`, ...), `el` → `required`. This also gives every module the property that
`Button.button`/`Button.required` read correctly when imported `as X`. (Note: this
spec keeps the existing module namespace `M3e.Component.*` — the user's example used
`M3e.Components.Button`, but no repo module rename is in scope here, see Non-goals.)

Once the convention exists, it needs a guard so it can't silently drift as new
components are added or existing ones are edited — an elm-review rule in the sibling
`elm-review-cem` package.

## Non-goals

- No `M3e.Component` → `M3e.Components` module-namespace rename. The user's example
  import used the plural form; this spec only renames the two functions, not the
  module path. (Flag for Jack to confirm separately if the plural rename is also
  wanted — out of scope here.)
- No new `type Button` (or equivalent per-component concrete type) to pair with the
  renamed function — explicitly deferred by Jack, "I'll figure out what that should
  be later." The rule below checks value-naming only, not a type/value pair.
- No rename of `build` (`M3e.Build.X`'s builder-pipe entry point) — it's a different
  module, already correctly named, not part of this ask.
- No behavior change to `view`/`el` themselves — pure rename, signatures and bodies
  untouched.

## Design

### Part A — the rename (elm-m3e)

Mechanical, repo-wide, across all 130 `src/M3e/Component/*.elm` modules:

- `view` → lowercase module name (`Button.elm` → `button`, `IconButton.elm` →
  `iconButton`, etc. — camelCase of the module's own base name).
- `el` → `required`.

Update at each call site:
- The module's own `exposing (...)` list and `@docs` block (`Button.elm:2,13`).
- Doc comments referencing `view`/`el` by name (e.g. "Standard constructor:", "The
  `view` function", any `{-| ... -}` cross-references).
- `src/M3e.elm` (the barrel) — every barrel function that calls
  `M3e.Component.X.view`/`.el` and every `{-| See \`M3e.Component.X.view\`. -}`-style
  doc comment (confirmed pattern at `src/M3e.elm:295-302`).
- `src/M3e/Build/*.elm`, if any builder module calls `.view`/`.el` directly rather
  than reimplementing (needs a repo-wide grep during implementation — not confirmed
  either way here).
- `docs/scripts/extract-reference.mjs`'s `roleOf` classifier (`line 305`), which
  currently special-cases `name === "view"` to assign the `ctor` role — this must
  become "name equals the module's lowercase name" (it already has the module name in
  scope) rather than a literal `"view"` string match, or every component's
  constructor silently stops being classified as `ctor`.
- Every docs example/snippet under `docs/` that spells `M3e.Component.X.view` or
  `.el` literally (Usage.elm's generated code strings, any hand-written examples).
- `CHANGELOG.md` entry noting the breaking rename.

Given 130 modules, implementation should be a scripted codemod (e.g. a small Elm or
Node script doing per-file `view`→name / `el`→`required` substitution driven off each
file's own module name) rather than 130 hand-edits — verified after by `elm make`
across the package (renames that miss a call site fail to compile, which is the
correctness backstop here) plus running elm-review with the new rule (Part B) to
confirm 0 violations.

### Part B — the elm-review rule (elm-review-cem)

New rule file `src/NoMissingComponentApiNames.elm` (name open to a better fit at
implementation time), following the visitor pattern in
`src/NoInternalImportOutsideAllowed.elm:45-50`:

```elm
rule : Rule
rule =
    Rule.newModuleRuleSchemaUsingContextCreator "NoMissingComponentApiNames" initContext
        |> Rule.withModuleDefinitionVisitor moduleDefinitionVisitor
        |> Rule.withDeclarationListVisitor declarationListVisitor
        |> Rule.fromModuleRuleSchema
```

- **Scope gate**: only activates for modules under `M3e.Component.*` (mirrors the
  prefix-matching approach in the existing rule's context/module-definition visitor).
  The module's own base name (last segment, lowercased) is the "expected ctor name."
- **Check**: the module's exposing list (or, if it exposes everything via `(..)` —
  which none of these modules do today per the confirmed `Button.elm` exposing list —
  the full declaration list) must contain a value named `<expectedCtorName>` AND a
  value named `required`. Report a violation on the module definition/exposing-list
  range naming which of the two is missing (they can be missing independently — a
  partial migration should still get flagged specifically).
- **No autofix in v1** — the rename (Part A) ships as a one-time codemod, not through
  this rule; the rule's job from that point on is drift prevention only. (An autofix
  could be added later if a genuinely fresh component module is scaffolded without
  the right names, but that's speculative — YAGNI for this spec.)
- **Registration**: add to `review/src/ReviewConfig.elm` (both the elm-review-cem
  package's own dev config, for its test suite, and elm-m3e's `review/src/ReviewConfig.elm`,
  which is the actual consumer).
- **Tests**: new `tests/NoMissingComponentApiNamesTest.elm`, following the shape of
  `tests/NoInternalImportOutsideAllowedTest.elm` — cases: module exposing both names
  (no error), missing ctor name only, missing `required` only, missing both, a
  non-`M3e.Component.*` module with neither (no error, out of scope).

## Testing

- `elm-review-cem`: new rule's own test module, `elm-test` green.
- `elm-m3e`: `elm make` across `src/M3e.elm` (compiles ⇒ every call site of the old
  names was caught), then `elm-review` with the updated `ReviewConfig.elm` reports 0
  violations of the new rule across all 130 component modules.
- Spot-check the docs site still builds and a couple of Usage.elm examples still
  render the renamed calls correctly (`M3e.Component.Button.button`,
  `M3e.Component.Button.required`).
