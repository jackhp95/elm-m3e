# Integration findings (cross-cutting)

Recorded during integration + browser verification of the five example apps, after
the per-app agents ran. These are systemic, higher-value than the per-app notes.

## 1. elm-review gave FALSE GREENS — it is not a compile gate here

Three of the five committed apps (shop, mail, travel) contained **real type errors**
yet `elm-review` reported "I found no errors!" in their worktrees — and again when the
parent re-ran it post-integration. The errors only surfaced under the actual
`elm-pages` dev server (a Lamdera compile), where every route 500'd.

Likely cause: elm-review's incremental cache / its compile step did not re-typecheck
the changed route bodies against the generated `.elm-pages/Main.elm` wiring (the
project is Lamdera-based; `.elm-pages/Main.elm` imports `Lamdera.Wire3`). Whatever the
mechanism, the practical lesson is strong:

> **`elm-review` clean ≠ the app compiles.** The authoritative gate is the elm-pages
> dev server (or `lamdera make` / a real `elm-pages build`). Verify examples by
> loading the route, not by elm-review alone.

Every route was fixed and now serves HTTP 200 with 0 console errors at both 1280px and
390px; the visual result is MUI-grade.

## 2. Recurring trap: helper annotations must name the component's phantom kind

The dominant error class (all of travel's, half of mail's): a `let`/top-level helper
that returns a component was annotated `Element { s | html : Supported } msg`, but the
component produces its own kind, e.g. `AppBar.view -> { a | appBar, html }`,
`Tabs.view -> { a | tabs, html }`, `AssistChip.view -> { a | assistChip, html }`,
`List_.view -> { a | list, html }`, `SearchBar.view -> { a | searchBar, html }`. The
fix is to annotate with the component's kind (`{ s | appBar : Supported }` etc.), which
absorbs `html` via the row variable. This is easy to get wrong because:
- `NoMissingTypeAnnotation` forces you to write the signature, but
- you can't know the exact kind tag without grepping the component module's `view`
  return row, and
- the natural guess (`{ s | html }`, since everything "is html") is wrong for anything
  that is a real m3e component.

A **component → phantom-kind cheat-sheet** (or letting these helpers stay unannotated)
would remove this whole class of error. See dashboard.md #2 for the same observation.

## 3. Container children need the `.children` wrapper (shop)

`NavRail.view attrs (List.map item xs)` fails — the second arg must be
`NavRail.children (List.map item xs)` (it wraps `List (Element {navItem})` into the
`List (Content {default})` the view wants). Shop omitted it for both nav components.
The wrapper is discoverable only by copying a working call (settings did it right).

## 4. `Native.span` vs `Layout.span` (mail)

`Native.span` takes `List (Attr …)`; `Layout.span` takes a class `String`. Mail wrote
`Native.span "block" [...]` (passing a class string to the attrs slot). The two same-
named helpers with different first-arg types are an easy mix-up; the fix was
`Layout.span "block"`.

## 5. Content vs Element for set-child helpers (shop)

`FilterChipSet.child (FilterChip.view …)` returns `Content { r | default }`, not an
`Element` — so a helper built from it must be annotated as `Content …`, and it drops
straight into `FilterChipSet.view`'s children list. Annotating it as `Element {filterChip}`
(the natural guess) is wrong.

## Tooling
- `scripts/extract-reference.mjs` uses a **fixed `/tmp/m3e-docs-gen`** scratch dir, not
  worktree/PID-scoped, so parallel worktrees corrupt each other's `build:assets`
  (mail.md #1 hit this). Should be scoped.
- A fresh worktree lacks gitignored `node_modules`/`.elm-pages`; both must be
  provisioned (symlink deps + `npm run build:assets && elm-pages gen`) before any
  compile/review. `elm-pages gen` is silent on success.
- `elm-pages dev` treats a missing `elm-review` on `PATH` as fatal (exit 1); launch via
  `npm run` or with `node_modules/.bin` on `PATH`.
