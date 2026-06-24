# elm-review Rule Set — `m3e-builder`

> **Status:** design doc. No rule code is written yet — this is the durable spec that the
> later TDD session implements against. Each custom rule below ships failing/passing examples
> precisely so they can be pasted into `…Test.elm` as the first red test.
>
> **Goal:** the cleanest Elm repo possible. The MISI builder library (`src/Ui/*` — 53
> component modules) wraps the `@m3e/web` web components through the typed bindings in
> `vendor/elm-m3e/M3e/*`. The type system enforces *shape* (a `Button` needs a label and a
> variant); elm-review enforces the **Material-correctness invariants the type system cannot
> reach** — slot names are strings, CSS classes are strings, and "a button with no action" is a
> well-typed value. Those gaps are exactly the 35 spec-deltas catalogued in
> [`material-spec-deltas.md`](./material-spec-deltas.md), of which **6 are CRITICAL** and all 6
> share one shape: *content silently routed to a slot/state the element does not have, so it
> never renders.*

---

## 0. Scope & layout reality check

A few facts that shape every decision below:

- **The repo root is an `application`, not a published `package`.** Root `elm.json` is
  `"type": "application"` with `source-directories: ["src", "vendor/elm-m3e"]`. The docs app
  lives in `docs/` and carries the `elm-review` install (`docs/node_modules/.bin/elm-review`,
  v2.13.5). There is **no `review/` project yet**.
- This matters for rule selection: the *package-judged-by-the-community* rules
  (`Docs.ReviewAtDocs`, `NoMissingTypeExpose`, `Documentation.Readme`,
  `Docs.UpToDateReadmeExample`) only fully light up when elm-review runs against an
  `elm.json` of `"type": "package"`. **Recommendation in §3:** carve `src/` + `vendor/` into a
  small *package-shaped* `elm.json` (or at minimum keep the rules that work on applications and
  treat the doc rules as the bar to clear *before* publishing to `package.elm-lang.org`).
- Slot helpers in the vendor bindings are the canonical pattern the custom rules key off:

  ```elm
  -- vendor/elm-m3e/M3e/Button.elm
  iconSlot : Html.Attribute msg
  iconSlot = Html.Attributes.attribute "slot" "icon"
  ```

  Every `M3e.*` module exposes its real slots as `xSlot : Html.Attribute msg`. A raw
  `Attr.attribute "slot" "badge"` in `src/Ui/*` is therefore *always* either (a) a slot that
  has a typed helper and should use it, or (b) a slot the element does not have (a CRITICAL
  delta). The rule cannot tell which; it flags both and the author picks the fix.

---

## 1. Community rules to adopt

Install order and rationale. Severity tags: **REQUIRED** = expected of any Elm package the
community will judge; **STRONG** = near-universal in serious Elm codebases; **OPT** = adopt
deliberately.

### 1.1 `jfmengels/elm-review-unused` — `NoUnused.*`  · REQUIRED

Dead code is the single highest-signal smell in Elm because the compiler keeps it compiling.
Run the **whole family**; each catches a distinct class.

| Rule | Catches | Notes |
|---|---|---|
| `NoUnused.Variables` | unused top-level/let bindings, unused imports | provides fixes |
| `NoUnused.CustomTypeConstructors` | constructors never built | careful with opaque types exposed for pattern-matching by consumers |
| `NoUnused.CustomTypeConstructorArgs` | constructor args never read | |
| `NoUnused.Dependencies` | deps in `elm.json` never imported | keeps the published dep list honest |
| `NoUnused.Exports` | exposed values nobody (incl. tests/docs) uses | **scope carefully** — see below |
| `NoUnused.Modules` | modules nobody imports | |
| `NoUnused.Parameters` | unused function params | |
| `NoUnused.Patterns` | unused pattern bindings | |

**Config / scope:** `NoUnused.Exports` is the dangerous one for a *library*: every `Ui.*`
public function is exposed *for consumers we cannot see*. Two options —
(a) run elm-review with `src` + `docs` + tests in one project so the docs app and the
component-catalog count as "users" of the API, keeping `NoUnused.Exports` honest without false
positives; or (b) if `src` is reviewed in isolation as a package, **disable
`NoUnused.Exports` for `src/Ui/*`** via `Rule.ignoreErrorsForDirectories` (a library's whole
point is unused-by-itself exports). Recommended: run them together (option a) so the rule still
catches genuinely-dead exports.

### 1.2 `jfmengels/elm-review-simplify` — `Simplify`  · STRONG

One rule, hundreds of fixes: `if True`, `List.map identity`, `a == True`, redundant
`Maybe.map`/`List.filterMap` chains, `String.fromInt n |> String.length`-style folds, etc.
Always-on, fully auto-fixable. Run on **all** directories (src, docs, tests, review).

### 1.3 `jfmengels/elm-review-common`  · REQUIRED-ish (per rule)

This is the sibling package studied for conventions; adopt selectively.

| Rule | Enforces | Verdict |
|---|---|---|
| `NoExposingEverything` | bans `module X exposing (..)` | **REQUIRED** — an explicit export list is the public contract of every `Ui.*` module |
| `NoImportingEverything` | bans `import X exposing (..)` | **REQUIRED** (configure an allowlist for `Html`/`Html.Attributes` if the team wants `exposing (..)` there — but prefer the qualified `Attr.`/`Html.` style already used in `src/Ui/*`) |
| `NoMissingTypeAnnotation` | top-level defs must be annotated | **REQUIRED** for a package — annotations are the docs |
| `NoMissingTypeAnnotationInLetIn` | `let` bindings annotated | **STRONG** — consider relaxing in tests |
| `NoMissingTypeExpose` | a type used in an exposed signature must itself be exposed | **REQUIRED** — prevents "you returned a `Button msg` but didn't expose `Button`" — the classic broken-package bug |
| `NoConfusingPrefixOperator` | bans `(<) x` style confusing sections | STRONG |
| `NoPrematureLetComputation` | a `let` binding computed before it's needed (e.g. only used in one branch) | STRONG — perf + clarity |
| `NoDeprecated` | flags use of things tagged `@deprecated` | OPT — adopt once we start deprecating builder APIs (e.g. `Ui.Shape.withClass "ds-…"`); configure `NoDeprecated.defaults` |

### 1.4 `jfmengels/elm-review-documentation`  · REQUIRED (this is a *documented* library)

| Rule | Enforces | Verdict |
|---|---|---|
| `Docs.ReviewAtDocs` | every exposed member appears in a `@docs` line and vice-versa; no dangling/duplicate `@docs` | **REQUIRED** — `package.elm-lang.org` *rejects* the upload otherwise. The `Ui.*` modules already carry rich `@docs` blocks; this keeps them from rotting. |
| `Docs.ReviewLinksAndSections` | internal doc links (`[count](#count)`) and section anchors resolve | **REQUIRED** — `Ui.Badge` literally links `[count](#count)`, `[label](#label)`; this rule proves they stay valid |
| `Docs.UpToDateReadmeExample` | code blocks in `README.md` actually compile against the current API | **STRONG** — prevents the README from drifting (the doc-example identifier check in `OVERNIGHT_PLAN.md` is this rule's job) |
| `Documentation.Readme` | the package has a README and it's referenced | STRONG before publish |

These four are the "judged by the community" bar. They only fully evaluate against a
`package`-typed `elm.json`; see §3 for how to give `src/` a package shape so they run.

### 1.5 `jfmengels/elm-review-the-elm-architecture` — `TheElmArchitecture.*`  · TARGETED

The `src/Ui/*` library is **view-only** (builders → `Html msg`), so the TEA rules mostly bite
in `docs/` (the catalog/playground app). Run these **only on `docs/src`**:

| Rule | Enforces |
|---|---|
| `NoMissingSubscriptionsCall` | if you define `subscriptions`, `Browser.element`/`document` actually wires it |
| `NoRecursiveUpdate` | `update` doesn't call itself (use `Cmd`/batching instead) |
| `NoUselessSubscriptions` | no `subscriptions` that always returns `Sub.none` |

### 1.6 `jfmengels/elm-review-debug` — `NoDebug.*`  · REQUIRED

`NoDebug.Log` and `NoDebug.TodoOrToString` — `Debug.log`/`Debug.todo`/`Debug.toString` must
never ship in a published package (they also break `--optimize`). Run on `src` + `vendor` +
`docs`.

### 1.7 `sparksp/elm-review-ports` / others  · OPT

Not needed: the library has no ports (web-component interop is attribute/slot-based, not port-
based). Skip. Likewise `NoMissingSubscriptionsCall`'s sibling port rules.

### 1.8 Summary — community rule manifest

```
elm-review-unused        : NoUnused.Variables, NoUnused.CustomTypeConstructors,
                           NoUnused.CustomTypeConstructorArgs, NoUnused.Dependencies,
                           NoUnused.Exports, NoUnused.Modules, NoUnused.Parameters,
                           NoUnused.Patterns
elm-review-simplify      : Simplify
elm-review-common        : NoExposingEverything, NoImportingEverything,
                           NoMissingTypeAnnotation, NoMissingTypeAnnotationInLetIn,
                           NoMissingTypeExpose, NoConfusingPrefixOperator,
                           NoPrematureLetComputation, NoDeprecated
elm-review-documentation : Docs.ReviewAtDocs, Docs.ReviewLinksAndSections,
                           Docs.UpToDateReadmeExample, Documentation.Readme
elm-review-the-elm-arch  : NoMissingSubscriptionsCall, NoRecursiveUpdate,
                           NoUselessSubscriptions          (docs/src only)
elm-review-debug         : NoDebug.Log, NoDebug.TodoOrToString
```

---

## 2. Custom rules to build

All custom rules live in `review/src/`, each with a sibling `review/tests/…Test.elm`. The
implementation sketches name the concrete `Review.Rule` visitor APIs to use. Conventions follow
`jfmengels/elm-review-common` (one rule per module, `rule : Rule`, `Test`-driven).

The four Material-discipline rules (§2.3–2.6) share one foundation: they need to know **which
module they're looking at** and **which `M3e.*` slot/attribute helpers exist**. Build a shared
`review/src/M3e/Slots.elm` helper (not a rule) that, given a vendor `M3e.*` module name, knows
its real slot names — generated from the vendor bindings or hand-maintained. The
spec-deltas doc is the source of truth for which slots are real.

---

### 2.1 `PreferBadgeCount`  · auto-fixable

**Catches:** `Ui.Badge.label (String.fromInt n)` (and `Ui.Badge.label (String.fromInt <| n)`,
and `String.fromInt n |> Ui.Badge.label`). Steers callers to `Ui.Badge.count n`, which applies
the Material `999+` truncation that `label` does not.

**Why the type system can't:** both `count : Int -> Badge msg` and `label : String -> Badge msg`
are total, well-typed functions. `label (String.fromInt n)` is a perfectly valid expression that
silently drops the `999+` Material truncation. It's a *semantic* preference, not a type error.

**Failing:**
```elm
view n = Ui.Badge.label (String.fromInt n)          -- ✗ → Ui.Badge.count n
viewB n = String.fromInt n |> Ui.Badge.label         -- ✗
viewC n = Ui.Badge.label (String.fromInt <| n)       -- ✗
```
**Passing:**
```elm
view n = Ui.Badge.count n                            -- ✓
status s = Ui.Badge.label s                          -- ✓ (genuine text, not a stringified Int)
label2 = Ui.Badge.label ("v" ++ String.fromInt n)    -- ✓ (composed string, not a bare conversion)
```

**Sketch:** `Rule.newModuleRuleSchemaUsingContextCreator` + `withExpressionEnterVisitor`.
Resolve `Ui.Badge.label` and `String.fromInt` to their canonical module via the
`ModuleNameLookupTable` (handles aliases/imports). Match an `Application [ label, arg ]` where
`label` resolves to `Ui.Badge.label` and `arg` is *exactly* an application of `String.fromInt`
to a single sub-expression (also match the `|>`/`<|` pipe shapes). Offer a `Fix.replaceRangeBy`
swapping `label (String.fromInt e)` → `count e`. The "composed string" passing case falls out
naturally: the argument isn't a bare `String.fromInt _` application.

---

### 2.2 `NoActionlessButton`  · report-only (no fix)

**Catches:** a `Ui.Button.new {…}` builder pipeline that reaches `Ui.Button.view` without ever
passing through `withOnClick`, `withHref`, or `withToggle`. Per the design decision
(`COMPONENT_BUILDER_REDESIGN.md` §3: *"a button with no action and no explicit disabled state
should be a lint/review smell, not a silent behaviour change"*), this approximates nri's
"action is required" without making it a type-level requirement (which the single-`new`-
constructor MISI carve-out deliberately avoids).

**Why the type system can't:** `new {label, variant} |> view` is fully typed and renders a real,
inert button. Requiring an action at the type level would force the three-constructor split the
design explicitly rejected. So the *degenerate-but-valid* state is caught by review instead.

**Failing:**
```elm
saveBtn = Ui.Button.new { label = "Save", variant = Ui.Button.Filled } |> Ui.Button.view   -- ✗
withIcon =                                                                                   -- ✗ still no action
    Ui.Button.new { label = "Add", variant = Ui.Button.Tonal }
        |> Ui.Button.withLeadingIcon icon
        |> Ui.Button.view
```
**Passing:**
```elm
ok = Ui.Button.new { label = "Save", variant = Ui.Button.Filled }
        |> Ui.Button.withOnClick Save |> Ui.Button.view                    -- ✓
link = Ui.Button.new {…} |> Ui.Button.withHref "/help" |> Ui.Button.view   -- ✓
tog  = Ui.Button.new {…} |> Ui.Button.withToggle {…} |> Ui.Button.view     -- ✓
disabled = Ui.Button.new {…} |> Ui.Button.withDisabled Ui.Button.Disabled  -- ✓ explicitly inert
            |> Ui.Button.view
```

**Sketch:** this needs *flow* analysis of a pipeline, which a pure expression visitor handles
well because Elm pipelines are `(|>)` application trees. `withExpressionEnterVisitor`: when you
encounter an expression that resolves to `Ui.Button.view`, walk its single argument's pipe/
application spine collecting every `Ui.Button.*` function applied. If the spine contains
`Ui.Button.new` but none of `{withOnClick, withHref, withToggle, withDisabled}`, report at the
`new` range. (`withDisabled` is the escape hatch — an explicitly-disabled button is intentional.)
Limitation: only catches the inline-pipeline form; a button stored in a `let` and viewed
elsewhere is out of scope (document this — it's the 90% case and report-only anyway). Use
`Rule.error` with no fix; the author must add the right wiring.

---

### 2.3 `NoRawAttributeInUi`  · report-only

**Catches:** inside `src/Ui/*`, a raw `Html.Attributes.attribute "<name>" …` (commonly aliased
`Attr.attribute`) **where a typed `M3e.*` binding for that attribute exists** on the element
being rendered. From the spec-deltas: Search's raw `Attr.attribute "open"`, Slider's raw
`Attr.attribute "value"`, Stepper's raw `Attr.attribute "selected" "true"` — each *duplicates*
(and can drift from) a real `M3e.*` binding.

**Why the type system can't:** `Attr.attribute : String -> String -> Attribute msg` accepts any
two strings. Nothing ties `"value"` to `M3e.Slider.value` or rejects a typo'd `"pageIndex"`
(the real Paginator bug: camelCase ignored, CEM wants `page-index`).

**Failing (in `src/Ui/Slider.elm`):**
```elm
Attr.attribute "value" (String.fromFloat v)   -- ✗ M3e.Slider.value exists
Attr.attribute "selected" "true"              -- ✗ (Stepper) M3e.Step.selected exists
```
**Passing:**
```elm
M3e.Slider.value v                            -- ✓ typed binding
Attr.attribute "aria-label" cfg.label         -- ✓ global a11y attr, no typed binding, allowed
Attr.attribute "data-testid" "x"              -- ✓ data-* allowed
```

**Sketch:** module rule scoped to `src/Ui/` (config via `Rule.ignoreErrorsForDirectories`
inverted — i.e. only register findings when the reviewed module path is under `src/Ui/`; do this
with a `withContextFromImports`/path check in the context creator). Visit `Application` nodes
resolving the function to `Html.Attributes.attribute`; read the first arg if it's a string
literal. Allow a hard-coded **global allowlist** matching the project's own validator:
`slot` (handled by §2.5), `id`, `role`, `title`, `hidden`, `tabindex`, and the prefixes
`aria-*`, `data-*`, `on*`. For any other literal name, look it up against the slot/attr table
(§2 intro). If a typed `M3e.*.<attr>` binding exists for it, report "use `M3e.<Module>.<attr>`
instead of a raw attribute". Pair with `withCommentsVisitor` only if you want to honour an opt-
out comment; otherwise report-only.

---

### 2.4 `NoProprietaryDsClasses`  · report-only (fix optional)

**Catches:** any `Html.Attributes.class "ds-…"` / `classList`-with-`ds-` / `Ui.*.withClass
"ds-…"` **anywhere** (`src`, `vendor`, `docs`). From spec-deltas: `ds-*` and `t-*` classes are
**not Material** and ship no CSS — `Ui.Card` (4×), `Ui.Dialog`, `Ui.SideSheet`, `Ui.BottomSheet`,
`Ui.Tooltip`, and `Ui.Shape`'s doc-comment steering callers to `ds-w-16`/`ds-h-16`. Extend to
`t-*` for `Ui.Theme` tokens.

**Why the type system can't:** `class : String -> Attribute msg`. Any string is valid; whether a
class exists in shipped CSS is unknowable to the compiler.

**Failing:**
```elm
Html.div [ Attr.class "ds-card-media" ] [ media ]                 -- ✗
Attr.class "t-primary"                                            -- ✗ (Theme token, no CSS)
Ui.Shape.withClass "ds-w-16"                                      -- ✗
```
**Passing:**
```elm
Html.div [ M3e.Card.mediaSlot ] [ media ]                         -- ✓ typed slot
Attr.class "flex items-center"                                    -- ✓ real utility class
```

**Sketch:** project (or module) rule, run repo-wide. Visit `Application` resolving to
`Html.Attributes.class`/`classList` and to any `…withClass`; inspect string-literal args; report
any literal matching `^(ds-|t-)` . A fix is *not* safe in general (the replacement is a
typed slot, which is structural, not a class), so report-only with a message pointing at the
typed-slot/role-token alternative. Optionally `Fix.removeRange` only when the class is the *sole*
attribute and a known slot replacement is registered — skip for v1.

---

### 2.5 `NoUntypedSlot`  · report-only

**Catches:** `Attr.attribute "slot" "<name>"` (raw slot string) in `src/Ui/*` where the
`M3e.*` binding for the enclosing element exposes an `xSlot` helper — *or* where the named slot
is not a real slot of that element at all. This is the rule that defends against the **6 CRITICAL
deltas** (AppBar title → nonexistent default slot; Tabs badge → nonexistent `badge` slot on
`m3e-tab`; SplitButton/SideSheet/NavigationBar/Rail content → wrong/nonexistent slot).

**Why the type system can't:** slot names are strings. `Attr.attribute "slot" "badge"` on an
`m3e-tab` (which has no `badge` slot) is well-typed and silently drops the content.

**Failing (in `src/Ui/Tabs.elm`, AppBar.elm):**
```elm
Html.span [ Attr.attribute "slot" "badge" ] [ Html.text b ]    -- ✗ m3e-tab has no badge slot
Html.span [ Attr.attribute "slot" "leading" ] [ html ]         -- ✗ → M3e.AppBar.leadingSlot
```
**Passing:**
```elm
Html.span [ M3e.NavMenuItem.iconSlot ] [ Ui.Icon.view it.icon ]   -- ✓ typed slot helper
Html.span [ M3e.Button.trailingIconSlot ] [ … ]                   -- ✓
```

**Sketch:** the trickiest rule because correctness depends on the *nearest m3e ancestor element*.
Two implementation tiers:

- **v1 (cheap, high-value):** flag *every* raw `Attr.attribute "slot" _` in `src/Ui/*`,
  message: "set slots via the typed `M3e.<Module>.<name>Slot` helper, not a raw string." This is
  defensible because the project rule (spec-deltas intro) is "slots must be set via typed
  helpers." All current legitimate uses (NavigationBar, Stepper, Button…) already use the typed
  helpers, so the only hits are the deltas. Pure `withExpressionEnterVisitor`.
- **v2 (semantic):** additionally resolve the nearest enclosing `M3e.*.component`/`Html.node
  "m3e-…"` call to know the element, look the slot name up in the slot table (§2 intro), and
  distinguish "slot exists, use the helper" (auto-fixable → `M3e.X.fooSlot`) from "slot does NOT
  exist on this element" (CRITICAL, no fix, hard error). Needs an ancestor-tracking visitor
  (carry a stack in module context across `withExpressionEnterVisitor`/`ExitVisitor`).

Ship v1 first (TDD), grow into v2.

---

### 2.6 Proposed additional rules (enforce MISI / D1–D5 discipline)

These are recommended, in priority order. They formalise principles from the design docs
(D1 one `Ui` module per documented m3e component; D2 typed structural slots; D4 no silent
no-ops; D5 builder pattern).

- **`NoUndocumentedM3eElement`** (D1, MEDIUM) — flag `Html.node "m3e-…"` / `M3e.*.component`
  for a tag **not in the CEM**. Catches the ScrollContainer/TextHighlight/`m3e-slide`
  undocumented-element deltas. Sketch: maintain the CEM tag set (from `data/components.json`);
  visit `Application` to `Html.node` with a string-literal first arg, or imports of vendor
  modules with no CEM record; report if the tag isn't in the set.

- **`NoSilentNoOpBuilder`** (D4, HIGH) — flag `with*` setters known to map to attributes the CEM
  doesn't have (`Ui.Dialog.withFullScreen` → nonexistent `full-screen`). Hard to generalise;
  better expressed as a curated denylist of `(module, setter)` pairs derived from the deltas.
  Lower priority — many of these should just be *fixed* in `src/` and the setter removed, after
  which `NoUnused.Exports` covers it.

- **`NoStringSlotInDocs`** — same as `NoUntypedSlot` but scoped to `docs/` example code, so the
  published catalog never teaches the wrong pattern. Reuse the §2.5 visitor with a different
  directory scope.

- **`PreferTypedSize`** (consistency) — steer raw `Attr.attribute "size" "medium"` (AppBar) to
  the `M3e.*.size` typed binding / `Ui.Size`. Subsumed by `NoRawAttributeInUi` (§2.3) once the
  slot table includes `size`; list here only as a documented expectation.

**Recommendation:** build §2.1–2.5 in the first TDD pass (they have the highest ratio of real
findings to effort and every one has a current violation to turn green against). Treat §2.6 as a
second wave once the slot/CEM tables exist.

---

## 3. The `review/` project

### 3.1 Directory layout (mirrors `elm-review-common` conventions)

```
review/
  elm.json                      -- "type": "application", deps below
  src/
    ReviewConfig.elm            -- the manifest (§3.4)
    PreferBadgeCount.elm
    NoActionlessButton.elm
    NoRawAttributeInUi.elm
    NoProprietaryDsClasses.elm
    NoUntypedSlot.elm
    M3e/Slots.elm               -- shared slot/attr/CEM-tag tables (not a Rule)
  tests/
    PreferBadgeCountTest.elm
    NoActionlessButtonTest.elm
    NoRawAttributeInUiTest.elm
    NoProprietaryDsClassesTest.elm
    NoUntypedSlotTest.elm
```

Create it with `cd review && elm-review init` (writes `elm.json` + skeleton `ReviewConfig.elm`),
then `elm install` each community package from inside `review/`.

### 3.2 `review/elm.json`

```json
{
    "type": "application",
    "source-directories": [ "src" ],
    "elm-version": "0.19.1",
    "dependencies": {
        "direct": {
            "elm/core": "1.0.5",
            "elm/json": "1.1.4",
            "elm/project-metadata-utils": "1.0.2",
            "jfmengels/elm-review": "2.13.0",
            "stil4m/elm-syntax": "7.3.0",
            "jfmengels/elm-review-unused": "1.2.4",
            "jfmengels/elm-review-simplify": "2.1.0",
            "jfmengels/elm-review-common": "1.3.3",
            "jfmengels/elm-review-documentation": "2.0.4",
            "jfmengels/elm-review-the-elm-architecture": "1.0.3",
            "jfmengels/elm-review-debug": "1.0.8"
        },
        "indirect": { }
    },
    "test-dependencies": {
        "direct": { "elm-explorations/test": "2.1.1" },
        "indirect": { }
    }
}
```
(Resolve exact versions with `elm install`; the above are the families, not pinned truth.)

### 3.3 Pointing elm-review at src AND vendor AND docs AND demos

elm-review reviews the files reachable from the `elm.json` it's pointed at via
`--elmjson`. The repo has two:

- root `elm.json` → `source-directories: ["src", "vendor/elm-m3e"]` (the library + bindings)
- `docs/elm.json` → the catalog/playground/demos app.

**Recommended invocation (two passes, one config):**

```bash
# library + bindings (run from repo root)
docs/node_modules/.bin/elm-review --config review --elmjson elm.json

# docs app + demos + generated catalog
docs/node_modules/.bin/elm-review --config review --elmjson docs/elm.json
```

Scope *within* the config using `Rule.ignoreErrorsForDirectories` /
`Rule.ignoreErrorsForFiles`:

- `vendor/elm-m3e/` is **generated** — `ignoreErrorsForDirectories [ "vendor/elm-m3e/" ]` for
  the *style* rules (`NoMissingTypeAnnotation`, `NoExposingEverything`, `NoUnused.Exports`,
  doc rules), but **keep** `NoDebug`, `Simplify`, and `NoProprietaryDsClasses` on it.
- `docs/.../generated/` (e.g. `generated/Play/UiCatalog.elm`) — ignore style/doc rules;
  generated code shouldn't gate CI on annotations.
- TEA rules (§1.5) → restrict to `docs/src` via `ignoreErrorsForDirectories` for everything
  else, or simply only-add them in the docs pass.
- The Material-discipline rules (§2.3–2.5) self-scope to `src/Ui/` internally; in the docs pass
  `NoStringSlotInDocs` (§2.6) takes over.

**To make the package-judged doc rules (`Docs.ReviewAtDocs`, `NoMissingTypeExpose`,
`Docs.ReviewLinksAndSections`, `Docs.UpToDateReadmeExample`) fully evaluate**, the library needs
a `package`-typed `elm.json`. Two paths:

1. **Pre-publish split (recommended end state):** give `src/` (+ a vendored or published
   `elm-m3e`) its own `"type": "package"` `elm.json` with `exposed-modules` listing all `Ui.*`.
   Point one elm-review pass at it. This is also what `package.elm-lang.org` will require.
2. **Interim:** keep the application `elm.json`; the doc rules that need package metadata will
   no-op or under-report, but `Docs.ReviewAtDocs` still validates `@docs` consistency within each
   module. Track "flip to package elm.json" as the gate before the first `elm publish`.

### 3.4 `ReviewConfig.elm` skeleton

```elm
module ReviewConfig exposing (config)

import Docs.ReviewAtDocs
import Docs.ReviewLinksAndSections
import Docs.UpToDateReadmeExample
import Documentation.Readme
import NoConfusingPrefixOperator
import NoDebug.Log
import NoDebug.TodoOrToString
import NoExposingEverything
import NoImportingEverything
import NoMissingTypeAnnotation
import NoMissingTypeAnnotationInLetIn
import NoMissingTypeExpose
import NoPrematureLetComputation
import NoUnused.CustomTypeConstructorArgs
import NoUnused.CustomTypeConstructors
import NoUnused.Dependencies
import NoUnused.Exports
import NoUnused.Modules
import NoUnused.Parameters
import NoUnused.Patterns
import NoUnused.Variables
import Simplify
import NoMissingSubscriptionsCall
import NoRecursiveUpdate
import NoUselessSubscriptions

-- Custom rules
import PreferBadgeCount
import NoActionlessButton
import NoRawAttributeInUi
import NoProprietaryDsClasses
import NoUntypedSlot

import Review.Rule as Rule exposing (Rule)


config : List Rule
config =
    List.concat
        [ unused
        , common
        , docs
        , debug
        , theElmArchitecture        -- effective only on docs/src
        , materialDiscipline        -- the custom rules
        ]
        |> List.map ignoreGenerated


ignoreGenerated : Rule -> Rule
ignoreGenerated =
    Rule.ignoreErrorsForDirectories
        [ "vendor/elm-m3e/"            -- generated bindings (style/doc rules only; see below)
        , "docs/src/Generated/"        -- generated catalog
        ]


unused : List Rule
unused =
    [ NoUnused.Variables.rule
    , NoUnused.CustomTypeConstructors.rule []
    , NoUnused.CustomTypeConstructorArgs.rule
    , NoUnused.Dependencies.rule
    , NoUnused.Exports.rule
    , NoUnused.Modules.rule
    , NoUnused.Parameters.rule
    , NoUnused.Patterns.rule
    ]


common : List Rule
common =
    [ NoExposingEverything.rule
    , NoImportingEverything.rule []
    , NoMissingTypeAnnotation.rule
    , NoMissingTypeAnnotationInLetIn.rule
    , NoMissingTypeExpose.rule
    , NoConfusingPrefixOperator.rule
    , NoPrematureLetComputation.rule
    ]


docs : List Rule
docs =
    [ Docs.ReviewAtDocs.rule
    , Docs.ReviewLinksAndSections.rule
    , Docs.UpToDateReadmeExample.rule
    , Documentation.Readme.rule
    ]


debug : List Rule
debug =
    [ NoDebug.Log.rule
    , NoDebug.TodoOrToString.rule
    ]


theElmArchitecture : List Rule
theElmArchitecture =
    -- restrict to the docs app; the Ui library is view-only
    [ NoMissingSubscriptionsCall.rule
    , NoRecursiveUpdate.rule
    , NoUselessSubscriptions.rule
    ]
        |> List.map (Rule.ignoreErrorsForDirectories [ "src/", "vendor/" ])


materialDiscipline : List Rule
materialDiscipline =
    [ PreferBadgeCount.rule          -- auto-fix
    , NoActionlessButton.rule        -- report-only
    , NoRawAttributeInUi.rule        -- self-scopes to src/Ui
    , NoProprietaryDsClasses.rule    -- repo-wide
    , NoUntypedSlot.rule             -- self-scopes to src/Ui (v1)
    ]
```

> Note: `Simplify`, `NoDebug.*`, and `NoProprietaryDsClasses` should **not** be passed through
> `ignoreGenerated` for `vendor/` — they should run on the bindings too. The skeleton above
> applies one blanket ignore for brevity; in the real config, split into two `List.map` groups
> (style/doc rules get the vendor ignore; correctness rules don't).

### 3.5 CI wiring

Add npm scripts (per the existing `npm run elm-review` convention in the design docs) and a CI
gate:

```jsonc
// docs/package.json (or root, wherever scripts live)
"scripts": {
  "review:lib":  "elm-review --config ../review --elmjson ../elm.json",
  "review:docs": "elm-review --config ../review --elmjson elm.json",
  "review":      "pnpm review:lib && pnpm review:docs",
  "review:fix":  "pnpm review:lib --fix-all-without-prompt && pnpm review:docs --fix-all-without-prompt"
}
```

CI job (the `OVERNIGHT_PLAN.md` Phase-5 gate — build, format, **elm-review**, test, docs build,
doc-example check):

```yaml
- run: pnpm install
- run: pnpm --dir docs review            # fails the build on any finding
- run: pnpm --dir review test            # the custom-rule TDD tests (elm-test in review/)
```

Run `elm-review` in **non-fix mode** in CI (no `--fix`) so it fails loudly; developers run
`pnpm review:fix` locally. The custom-rule tests in `review/tests/` run under `elm-test` with the
`review/elm.json` and are the TDD harness the next session writes first (red) before any
`review/src/*.elm` exists.

---

## 4. Build order for the TDD session

1. `elm-review init` in `review/`; install community packages; commit the §3.4 config with the
   five custom-rule imports **commented out** and verify the community rules run green/triaged.
2. TDD `PreferBadgeCount` (§2.1) — simplest, auto-fixable, isolated. Seed tests from §2.1
   examples.
3. TDD `NoProprietaryDsClasses` (§2.4) — string-literal match, repo-wide, many real hits.
4. TDD `NoUntypedSlot` v1 (§2.5) — blanket raw-slot flag in `src/Ui/`.
5. TDD `NoRawAttributeInUi` (§2.3) — needs the slot/attr allowlist + `M3e.*` binding table.
6. TDD `NoActionlessButton` (§2.2) — pipeline-spine analysis.
7. Build `M3e/Slots.elm` table; grow `NoUntypedSlot` to v2 (semantic, ancestor-aware) and add
   the §2.6 rules.
8. Wire CI; flip to a `package`-typed `elm.json` for `src/` before first publish.
