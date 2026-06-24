# `review/` — elm-review for `m3e-builder`

The cleanest-possible review setup for the MISI component library (`src/Ui/*`),
which wraps the generated `vendor/elm-m3e/M3e/*` bindings. This project holds the
`elm-review` configuration plus five custom rules that enforce the
Material-correctness invariants the Elm type system cannot reach.

## Running

From the **repo root** (elm lives in the docs install):

```bash
docs/node_modules/.bin/elm-review src \
  --config review \
  --compiler docs/node_modules/.bin/elm
```

`elm-review src` reviews the library + generated bindings (the application
`elm.json` lists `src` and `vendor/elm-m3e` as source directories). `docs/` is
**not** reviewed yet — its app is mid-migration and does not compile; a later
phase wires a second pass at `docs/elm.json`.

## Custom-rule tests (TDD harness)

The five custom rules are built test-first; their suites are normal `elm-test`
suites under `review/tests/`:

```bash
cd review
../node_modules/.bin/elm-test --compiler ../docs/node_modules/.bin/elm
```

| Rule | Tests | Fix? | Scope |
|---|---|---|---|
| `PreferBadgeCount` | 8 | auto-fix | repo-wide |
| `NoProprietaryDsClasses` | 7 | report-only | repo-wide |
| `NoUntypedSlot` | 6 | report-only | `Ui.*` only |
| `NoRawAttributeInUi` | 7 | report-only | `Ui.*` only |
| `NoActionlessButton` | 8 | report-only | repo-wide |

## Rule manifest

**Unused** (`jfmengels/elm-review-unused`) — `NoUnused.Variables`,
`.CustomTypeConstructors`, `.CustomTypeConstructorArgs`, `.Exports`, `.Modules`,
`.Parameters`, `.Patterns`.

**Common** (`jfmengels/elm-review-common`) — `NoExposingEverything`,
`NoImportingEverything`, `NoMissingTypeAnnotation`,
`NoMissingTypeAnnotationInLetIn`, `NoMissingTypeExpose`,
`NoConfusingPrefixOperator`, `NoPrematureLetComputation`.

**Documentation** (`jfmengels/elm-review-documentation`) — `Docs.ReviewAtDocs`,
`Docs.ReviewLinksAndSections`, `Docs.UpToDateReadmeLinks`.

**Correctness** — `Simplify` (`elm-review-simplify`), `NoDebug.Log`,
`NoDebug.TodoOrToString` (`elm-review-debug`). These run on `vendor/` too.

**Material discipline (custom)** — `PreferBadgeCount`, `NoActionlessButton`,
`NoRawAttributeInUi`, `NoProprietaryDsClasses`, `NoUntypedSlot`.

Generated `vendor/elm-m3e/` is excluded from every style/doc rule via
`ignoreVendor`; the correctness and Material rules still run on it.

## Relaxed / adjusted rules

Each relaxation below is a deliberate, documented decision — not blind
suppression.

### `NoUnused.Exports` / `NoUnused.Modules` / `NoUnused.CustomTypeConstructors` — ignored for `src/Ui/`

A published library's whole point is exports, modules, and `Variant(..)`-style
constructors that are **unused by itself** — they exist for consumers we cannot
see in this repo. Reviewing the library in isolation (no docs app, no consuming
app) would make all three rules fire on the entire public API. They are scoped
to ignore `src/Ui/` (and `vendor/`) so they still catch genuinely-dead code in
any non-public helper directory while leaving the public surface alone. The
design doc's preferred alternative — reviewing `src` + `tests` + `docs`
together so consumers exist — is the eventual end state; until `docs/` compiles
again, the scope-out is the honest interim.

### `NoUnused.Dependencies` — **not enabled** in the `src`-only pass

This rule analyses the whole dependency graph against the reviewed modules. In a
`src`-only pass it cannot see `tests/`, so it false-flags `elm-explorations/test`
(used only by the test suite) and its `--fix` deletes it from `elm.json`,
breaking the build. It must run in a `src` + `tests` pass instead. It is
omitted here and should be added once the docs/test-inclusive pass exists.

Note: the rule did correctly identify four direct deps that the library never
imports (`elm/browser`, `elm/time`, `elm-community/list-extra`,
`elm-community/maybe-extra`). They are intentionally left in `elm.json` for now —
`elm/time` is still required transitively by the test toolchain
(`elm-explorations/test` → `elm/random` → `elm/time`), so trimming the direct
list needs the same `src` + `tests` graph the rule itself needs. Tracked as a
pre-publish cleanup.

### `Docs.NoMissing` / `Documentation.Readme` — not used

The design doc named `Docs.UpToDateReadmeExample` and `Documentation.Readme`;
neither exists in the installed `elm-review-documentation@2.0.4`. The modern
equivalents are `Docs.UpToDateReadmeLinks` (enabled) and `Docs.NoMissing`.
`Docs.NoMissing` enforces a doc comment on **every** exposed declaration, which
is stricter than the package bar the task targets and conflicts with the
modules' existing `@docs`-block documentation style; it is left out. The
`@docs` consistency that `package.elm-lang.org` actually requires is covered by
`Docs.ReviewAtDocs`.

### Material rules — `tests/` ignored, `Ui.*` self-scoping

`NoUntypedSlot` and `NoRawAttributeInUi` only run on modules named `Ui.*` (the
public library) and additionally ignore `tests/`, because `Ui.*Test` modules
legitimately reference raw slot/attribute strings inside `elm-test` selectors
(e.g. `Selector.attribute (Attr.attribute "slot" "title")`).

`NoUntypedSlot` allows the slot name `label`: the underlying M3e elements
(Checkbox, Switch, RadioButton, Slider, TimePicker, TextField) expose **no**
typed `labelSlot` binding, so `Attr.attribute "slot" "label"` is the correct
raw form there. Every other raw slot string is flagged.

## Fixes applied to `src/Ui/` while driving the run to zero

The library was already clean of `ds-*`/`t-*` classes and stringified-Int
badges. The run surfaced five real, safe issues, all fixed in place:

- `Ui/Search.elm` — raw `Attr.attribute "slot" "input"` replaced with the typed
  `M3e.SearchView.inputSlot` (caught by `NoUntypedSlot`).
- `Ui/Checkbox.elm` — `List.filterMap identity [ Just …, Just … ]` collapsed to a
  plain list (caught by `Simplify`).
- `Ui/Stepper.elm` — added type annotations to the `prefix` and `stepId` `let`
  bindings (caught by `NoMissingTypeAnnotationInLetIn`).
- `Ui/TextField.elm` — removed the unused `Json.Decode as Decode` import
  (caught by `NoUnused.Variables`).
