# Plan — Record/Build translator: recognise `M3e.Component.<Name>` + emit `M3e.Build.<Name>`

**Date:** 2026-08-14
**Role:** PLAN (gauntlet)
**Repos:** `elm-review-cem` (the rules) + `elm-m3e` (consumes the rules to generate docs Usage examples)
**Status:** ready to execute

---

## Problem

The docs Usage examples carry per-surface tabs: **M3e** (Standard top layer), **Components (Record)**,
**Builder (Build)**, **HTML**. The **Record** and **Build** surface strings are produced by
elm-review-cem's opt-in translator rules `Cem.translateToRecord` / `Cem.translateToBuild`
(implemented in `src/Cem/Internal/Translate.elm`), run over each example's Standard `top` code by
`docs/scripts/examples-gen/gen-record-build.mjs`.

The library moved all 130 components from `M3e.<Name>` to `M3e.Component.<Name>`, renamed the
Standard constructor from `view` to the whole-word-lowercased module base (`AppBar` → `appbar`), the
required-record constructor from `el` to `component`, and split the Build surface into its OWN module
`M3e.Build.<Name>` (`build` / `toElement` / `withX`). The translator still:

1. matches only the constructor literally named **`view`** (`resolveViewCall`, Translate.elm:192);
2. emits the record constructor as **`.el`** (Translate.elm:245);
3. emits Build ctors/setters into **`fact.module_`** (`= M3e.Component.<Name>`) — but Build now lives
   in the separate `M3e.Build.<Name>` module.

So the rule no-ops cleanly on every real example → Record/Build surface count dropped **339 → 0** →
the docs UI renders the "identical by design" rationale-null tab instead of translated code.

### Evidence (verified this session)

- Translators live at `elm-review-cem/src/Cem/Internal/Translate.elm` (shared machinery) with public
  wrappers `src/Cem/TranslateToRecord.elm` + `src/Cem/TranslateToBuild.elm`. There is NO separate
  `TranslateToRecord.mjs`; the rules ARE the translators.
- Source-match, Translate.elm:189-197:
  ```elm
  resolveViewCall context fnNode =
      case Node.value fnNode of
          Expression.FunctionOrValue _ "view" ->      -- ← OLD ctor name, hardcoded
              Lookup.moduleNameFor context.lookup fnNode
                  |> Maybe.andThen (\parts -> Dict.get (String.join "." parts) context.byModule)
          _ -> Nothing
  ```
- Record emit, Translate.elm:241-252 uses `compModule ++ ".el "` where `compModule = fact.module_`.
- Build emit sites all use `fact.module_` / `compModule`:
  - `buildReplacement` (Translate.elm:511-524): `compModule ++ ".build"`, `compModule ++ ".toElement"`
  - `attrPipe` (466-472): `fact.module_ ++ "." ++ withSetterName …`
  - `childPipe` (475-485): `fact.module_ ++ ".withChild …"` / `fact.module_ ++ "." ++ withSetterName …`
- Library reality (elm-m3e):
  - `src/M3e/Component/AppBar.elm` exposes `appbar` (whole-word lowercase) — NOT `appBar`, NOT `view`.
  - `src/M3e/Component/Accordion.elm` exposes `accordion` **and** `component` (the ex-`el`).
  - Only **29** component modules expose `component` (`grep -rln "^component :" src/M3e/Component/*.elm | wc -l` = 29) — matches the 29 `Record`-facet components.
  - `src/M3e/Build/Accordion.elm` exposes `build`, `toElement`, `withMulti`, `withChild`, `withClass`, `withId`, `withSlot`, `withStyle`. All **130** Build modules are exactly `M3e.Build.<X>` (`grep -rh "^module M3e.Build" src/M3e/Build/*.elm | wc -l` = 130, none deeper-nested).
  - `M3e.Component.AppBar.appbar` is the real Standard shape (verified in `config/examples.rich.json`).
- **Facts already migrated** (elm-m3e `src/M3e/Review/Facts.elm`): all 130 `module_ = "M3e.Component.<X>"` (`grep -c` = 130; zero bare `M3e.<X>`). `component = "appBar"` (camelCase) for AppBar — **does NOT match the real `appbar` ctor**, so the source-match slug must come from the module's last segment lowercased, NOT from `fact.component`.
- `Cem.Facts` internals available to the rule (Translate imports `Cem.Internal.Facts as Facts`, line 48):
  - `Facts.factComponentSegment fact` → last module segment (`"AppBar"`), Facts.elm:260-266.
  - `Facts.factNamespaceParts fact` → all-but-last (`["M3e","Component"]`), Facts.elm:163-170.
  - `Facts.factNamespace fact` → joined (`"M3e.Component"`).
- Generator invocation, `elm-m3e/docs/scripts/examples-gen/gen-record-build.mjs`:
  - `SURFACES` (line 74-77): `Cem.translateToRecord M3e.Review.Facts.facts` and `Cem.translateToBuild M3e.Review.Facts.facts`.
  - `runRule` (79-101) writes a scratch elm-review config, copying `${REPO}/review/src` and adding `extraSourceDirs: [${REPO}/src, ${REPO}/../elm-review-cem/src]` (line 86) — **it consumes elm-review-cem from the working tree, no publish/build step**. Runs `elm-review --report=json`, applies conversion edits via `applyEditsPartial`, recompiles, and keeps an output only if it CHANGED and still compiles (main(), 103-146). Output → `config/examples.surfaces.json`.
  - The full docs chain is `gen:examples-config` → `gen:examples-surfaces` (= this script) → `gen:examples-barrel` → `gen:examples` (merge into `docs/data/examples.json`). See friction `20260813T000000Z-examples-gen-rename-true-blast-radius`.
- Gate: `elm-review-cem` `npm run test:elm` (elm-test-rs). **Baseline this session: 318 passed, 0 failed.**

### Fix classification

**Localized pattern-update, not a rework** — but a THREE-axis change, each surgical:

1. **Source slug** (`resolveViewCall`): match the module first, then require `name == <last-segment lowercased>` OR `name == "component"` (so it matches both the Standard ctor and, harmlessly, the record ctor — see LEAF 1 note). ~1 small function rewrite.
2. **Record output ctor**: `.el` → `.component` (one string, Translate.elm:245).
3. **Build output module**: derive `M3e.Build.<Comp>` from `fact.module_` (swap the `Component` namespace segment for `Build`) and use it for `.build`/`.toElement`/`withX`/`withChild` instead of `fact.module_`. Add one helper `buildModule : Fact -> String`; thread it through `buildPlan` → `buildReplacement`/`buildPipes`/`attrPipe`/`childPipe`.

Tests (`tests/TranslateToRecordTest.elm`, `tests/TranslateToBuildTest.elm`) currently use `module_ = "M3e.Button"` + `.view`/`.el`/same-module `.build`. They must be updated to the new shape to lock the behaviour (LEAF 2).

---

## Sequencing

```
LEAF 1  fix Translate.elm (3 axes)               ─┐
LEAF 2  update the two translator test files      ├─ elm-review-cem;  gate: npm run test:elm green
LEAF 3  (investigation gate, if LEAF 1 uncertain) ─┘
LEAF 4  regen elm-m3e surfaces + verify count 0→~N   ─┐
LEAF 5  regen full examples.json chain + compile-check ├─ elm-m3e
LEAF 6  E2E spot-check Record & Build tabs are real   ─┘
```

Every leaf has a cheap acceptance test. Do NOT commit/push (WORK role decides; gauntlet review-gate first).

---

## LEAF 1 — Fix `Translate.elm` to the `M3e.Component.<Name>` / `M3e.Build.<Name>` shape

**File:** `/Users/jack/Documents/code/elm-review-cem/src/Cem/Internal/Translate.elm`
**Model tier (informational):** opus / medium.

### 1a — Source match: recognise the new Standard ctor name

Replace `resolveViewCall` (Translate.elm:186-197). The new match resolves the MODULE first, then
checks the name equals the whole-word-lowercased last module segment. Also accept the literal
`"component"` is **not** wanted here (that's the record ctor, a DIFFERENT surface we must not treat as
Standard) — so match ONLY the Standard slug.

```elm
{-| The fact for a per-component Standard `<root>.<Comp>.<slug>` reference (where
`<slug>` is the whole-word-lowercased component module segment, e.g.
`M3e.Component.AppBar.appbar`), or `Nothing` for anything else (the flat barrel,
the record `.component` ctor, another module).
-}
resolveViewCall : Context -> Node Expression -> Maybe Fact
resolveViewCall context fnNode =
    case Node.value fnNode of
        Expression.FunctionOrValue _ name ->
            Lookup.moduleNameFor context.lookup fnNode
                |> Maybe.andThen (\parts -> Dict.get (String.join "." parts) context.byModule)
                |> Maybe.andThen
                    (\fact ->
                        if name == standardSlug fact then
                            Just fact

                        else
                            Nothing
                    )

        _ ->
            Nothing


{-| The Standard top-layer constructor name for a component: its module's last
segment, whole-word-lowercased (`AppBar` → `appbar`, `Accordion` → `accordion`).
This is the elm-cem/generator convention (`extract-reference.mjs` whole-word
lowercase), and is NOT the same as `fact.component` (which is camelCase, e.g.
`appBar`), so it must be derived from the module segment, not the noun field.
-}
standardSlug : Fact -> String
standardSlug fact =
    String.toLower (Facts.factComponentSegment fact)
```

> **Note on collision safety:** `String.toLower "AppBar"` = `"appbar"` — matches the real ctor.
> `fact.component` for AppBar is `"appBar"` — deliberately NOT used. This is the single most
> error-prone spot: using `fact.component` would fail to match multi-word components. See LEAF 3.

### 1b — Record output ctor `.el` → `.component`

Translate.elm:243-252, in the `ToRecord ->` branch:

```elm
                    ToRecord ->
                        Just
                            { replacement =
                                compModule
                                    ++ ".component "        -- was ".el "
                                    ++ recordLiteral fields
                                    ++ " "
                                    ++ listLiteral attrResult.residual
                                    ++ " "
                                    ++ listLiteral residualChildren
                            , actionImport = actionImport
                            }
```

### 1c — Build output module `M3e.Component.<X>` → `M3e.Build.<X>`

Add the helper (near `standardSlug`):

```elm
{-| The Build-surface module for a component: its Standard module with the
component-namespace segment swapped for `Build`. `M3e.Component.AppBar` →
`M3e.Build.AppBar`. Assumes the `…Component.<Comp>` layout; for a flat
`<root>.<Comp>` library this degrades to `<root>.Build.<Comp>` (acceptable —
today every namespace with the Build facet is the nested `Component` layout).
-}
buildModule : Fact -> String
buildModule fact =
    let
        namespaceParts =
            Facts.factNamespaceParts fact

        buildNamespace =
            case List.reverse namespaceParts of
                _ :: restReversed ->
                    List.reverse (List.reverse ("Build" :: restReversed))

                [] ->
                    [ "Build" ]
    in
    String.join "." (buildNamespace ++ [ Facts.factComponentSegment fact ])
```

> `factNamespaceParts` for `M3e.Component.AppBar` = `["M3e","Component"]`; drop last (`Component`),
> append `Build` → `["M3e","Build"]`; re-append segment `AppBar` → `M3e.Build.AppBar`. Verified all 130
> Build modules are exactly `M3e.Build.<X>`.

Thread `buildModule fact` into the Build branch. In `buildPlan` (Translate.elm:200-262), the `ToBuild`
branch currently calls `buildPipes context fact …` and `buildReplacement compModule fields pipes`.
Change so Build uses the Build module for BOTH the seed/toElement AND the pipes:

```elm
                    ToBuild ->
                        buildPipes context fact (buildModule fact) attrResult.residualNodes residualNodes
                            |> Maybe.map
                                (\pipes ->
                                    { replacement = buildReplacement (buildModule fact) fields pipes
                                    , actionImport = actionImport
                                    }
                                )
```

Update `buildPipes` to take an explicit `buildMod : String` and use it in place of `fact.module_`:

```elm
buildPipes : Context -> Fact -> String -> List (Node Expression) -> List (Node Expression) -> Maybe (List String)
buildPipes context fact buildMod attrNodes childNodes =
    let
        roots = [ Facts.factNamespaceParts fact ]
        namedSetters = Facts.namedSlotSetters fact
        attrPipes = attrNodes |> List.map (attrPipe context fact buildMod) |> combineMaybes
        childPipes = childNodes |> List.map (childPipe context fact buildMod roots namedSetters) |> combineMaybes
    in
    Maybe.map2 (++) attrPipes childPipes
```

`attrPipe` (Translate.elm:466-472) — the setter NAME still resolves against `fact.module_` (the
Standard call the user wrote qualifies setters under `M3e.Component.<X>`), but the EMITTED `withX`
must target the Build module:

```elm
attrPipe : Context -> Fact -> String -> Node Expression -> Maybe String
attrPipe context fact buildMod elem =
    attrHeadName context fact elem
        |> Maybe.map
            (\name ->
                buildMod ++ "." ++ withSetterName fact name False ++ " " ++ setterArgSource context elem
            )
```

`childPipe` (Translate.elm:475-485) — same swap, and `withChild` uses `buildMod`:

```elm
childPipe : Context -> Fact -> String -> List (List String) -> List String -> Node Expression -> Maybe String
childPipe context fact buildMod roots namedSetters elem =
    if Facts.fillsDefaultSlot roots context.lookup namedSetters fact.component elem then
        Just (buildMod ++ ".withChild " ++ parenValue (defaultChildValue context fact elem))

    else
        attrHeadName context fact elem
            |> Maybe.map
                (\name ->
                    buildMod ++ "." ++ withSetterName fact name True ++ " " ++ setterArgSource context elem
                )
```

> `attrHeadName`/`headName` (Translate.elm:535-556) resolve the setter's SOURCE module against
> `fact.module_` — leave those unchanged (the input example DOES qualify setters under
> `M3e.Component.<X>`). Only the OUTPUT string uses `buildMod`.

### 1d — Doc-comment sync (mechanical)

Update the module-doc examples (Translate.elm:10-11, 40-41) and the public-rule docs
(`TranslateToRecord.elm:3-6,31` `el`→`component`; `TranslateToBuild.elm` module doc) so they describe
`.component` and `M3e.Build.<Comp>.build`. Non-load-bearing but keeps the docs honest and the
neutrality/index checks happy.

### Acceptance test (LEAF 1, before touching tests)

The existing tests still assert the OLD shape, so they WILL fail after 1a — that's expected and is
fixed in LEAF 2. To confirm 1a-1c compile in isolation first:

```bash
cd /Users/jack/Documents/code/elm-review-cem && npx elm make src/Cem/TranslateToRecord.elm src/Cem/TranslateToBuild.elm --output=/dev/null
```
**Expected:** `Success!` (compiles clean; the semantic check is LEAF 2's test run).

---

## LEAF 2 — Update the two translator test files to the new shape

**Files:** `/Users/jack/Documents/code/elm-review-cem/tests/TranslateToRecordTest.elm`,
`/Users/jack/Documents/code/elm-review-cem/tests/TranslateToBuildTest.elm`
**Model tier:** opus / medium.

The fixtures currently use `module_ = "M3e.Button"` and inputs like `M3e.Button.view [...] [...]`,
Record output `M3e.Button.el { … } …`, Build output `M3e.Button.build … |> M3e.Button.withVariant …
|> M3e.Button.toElement`. Migrate each fixture + expectation to the new library shape:

- **Fixtures:** `module_ = "M3e.Button"` → `module_ = "M3e.Component.Button"` (and likewise
  `AssistChip`, `ExpansionPanel`, `Fab`, `Avatar`, etc.). Keep `component = "button"` (still a valid
  camelCase noun; the source-match now derives the slug from the module segment, so `Button`→`button`
  matches `fact.component` here — but for a multi-word fixture like `ExpansionPanel` the SOURCE call
  must be `M3e.Component.ExpansionPanel.expansionpanel` — whole-word lowercase — NOT `.expansionPanel`).
- **Inputs (`src =`):** `M3e.Button.view [...] [...]` → `M3e.Component.Button.button [...] [...]`;
  qualify every setter under `M3e.Component.Button.*`. The `.child`/`.icon`/`.header` slot setters
  likewise move under `M3e.Component.<X>`.
- **`under =`** strings must match the new input verbatim.
- **Record `whenFixed`:** `M3e.Button.el { … } [ … ] [ … ]` → `M3e.Component.Button.component { … } [ … ] [ … ]`.
  The `action` field's `M3e.Action.*` and the added `import M3e.Action` are unchanged
  (`factNamespaceParts` = `["M3e","Component"]`, and `actionImport` appends `"Action"` →
  `import M3e.Component.Action` — **CHECK**: is the Action module `M3e.Action` or `M3e.Component.Action`?
  See LEAF 3 sub-check A; the expectation string must match whichever the library exposes).
- **Build `whenFixed`:** `M3e.Button.build { … } |> M3e.Button.withVariant v |> … |> M3e.Button.toElement`
  → `M3e.Build.Button.build { … } |> M3e.Build.Button.withVariant v |> … |> M3e.Build.Button.toElement`.
  NOTE the module switches to `M3e.Build.Button` for `build`/`withX`/`toElement`, while the `content`
  field VALUE and the `action` record stay as authored.
- The error-message assertions (`"This Standard \`view\` call can be rewritten…"`,
  TranslateToBuildTest.elm:56) reference the word "view" — the message string in Translate.elm:693 is
  static and does not include the ctor name, so it stays `view`. **Leave the message assertions as-is**
  unless LEAF 1d changed the message text (it should not).

> This is the bulk of the human-judgement work. Do it fixture-by-fixture; a Review.Test expectation
> mismatch prints the exact diff, so iterate against the test runner.

### Acceptance test (LEAF 2 — the elm-review-cem gate)

```bash
cd /Users/jack/Documents/code/elm-review-cem && npm run test:elm
```
**Expected:** `TEST RUN PASSED`, `Passed: 318` (or the new total if fixture count changed), `Failed: 0`.
Baseline was 318/0 green; the two translator suites must be green under the NEW shape. If any Standard
fixture other than the translators broke, LEAF 1 over-reached — revert and narrow.

Also re-run the fuller gate to catch facts-sync / index / neutrality regressions from the doc edits:
```bash
cd /Users/jack/Documents/code/elm-review-cem && npm run gate
```
**Expected:** all `check:*` and `test:*` pass. (`check:facts-sync` reads `RealFactsFixture.elm` — if it
asserts the OLD `M3e.<X>`/`view` shape it may need the same migration; treat a failure there as an
in-scope sub-fix, not a blocker.)

---

## LEAF 3 — (Conditional) Investigation sub-leaf: two genuinely-unknown internals

Do this ONLY if LEAF 1/2 hit a wall. These are the two spots the evidence does not fully pin down:

**Sub-check A — the Action module path.** `actionImport` (Translate.elm:233-238) appends `"Action"` to
`Facts.factNamespaceParts fact` → for `M3e.Component.Button` that's `import M3e.Component.Action`, and
`actionExpression` (416-433) emits `Facts.factNamespace fact ++ ".Action." ++ ctor` →
`M3e.Component.Action.onClick`. **Verify the library actually exposes `M3e.Component.Action`** (vs a
top-level `M3e.Action`):
```bash
ls /Users/jack/Documents/code/elm-m3e/src/M3e/Component/Action.elm /Users/jack/Documents/code/elm-m3e/src/M3e/Action.elm 2>/dev/null
```
The friction `20260814T000000Z-…-module-qualifier-vs-ctor-slug` lists `Action` among the ~8 modules
that stayed **top-level** (`M3e.Action`). If so, `factNamespaceParts` (which yields
`["M3e","Component"]`) produces the WRONG Action path, and the fix must special-case Action to the
ROOT namespace (`Facts.rootParts fact ++ ["Action"]`, or `["M3e","Action"]`). This would be a small
4th sub-axis in LEAF 1; surface it, don't guess. (Only affects the ~components with `usesAction`.)

**Sub-check B — the `component`-ctor false-match.** `resolveViewCall` now matches by module + slug.
Confirm the record ctor `component` never equals `standardSlug fact` (it can't unless a component's
module segment lowercases to the literal `"component"` — none do). Confirm too that a Standard example
never legitimately calls `M3e.Component.<X>.component` (the record ctor) expecting Standard treatment —
it doesn't; Standard examples use the noun ctor. No action expected; documented so the reviewer needn't
re-derive it.

**Escalation:** if either sub-check reveals a deeper structural gap (e.g. Build setters take a
DIFFERENT arg type than the Standard setter, breaking the verbatim `setterArgSource` hoist), STOP and
report per the gauntlet stop-gate rather than expanding scope. (Verified this session that
`Component.Accordion.multi : Bool -> …` and `Build.Accordion.withMulti : Bool -> …` share the `Bool`
arg, so the common case is sound — but spot-check one slot-heavy component like `List`/`NavBar`.)

**Acceptance:** each sub-check answered with a command + its output pasted into the WORK log; no code
guessed past an unanswered question.

---

## LEAF 4 — Regenerate elm-m3e Record/Build surfaces; assert count 0 → ~N

**Repo:** `/Users/jack/Documents/code/elm-m3e`. The generator reads elm-review-cem from
`../elm-review-cem/src` (gen-record-build.mjs:86) — no publish needed; LEAF 1's edits are picked up
directly.
**Model tier:** opus / medium.

### Preconditions
- `config/examples.rich.json` must have populated `top` fields (the Standard corpus). Per friction
  `20260814T…-namespace-blocker`, the Kit→Unsafe + `M3e.Component.` qualifier migration
  (`docs/superpowers/plans/2026-08-14-examples-kit-to-unsafe-migration.md`) must have landed so `top`
  compiles. **Guard:** if `top` is still null/stale, this leaf is BLOCKED on that upstream plan —
  surface it; do not fabricate surfaces.
  ```bash
  cd /Users/jack/Documents/code/elm-m3e && node -e 'const r=require("./config/examples.rich.json"); const n=Object.values(r).flat().filter(e=>e.top).length; console.log("top non-null:",n)'
  ```
  **Expected:** a few hundred (matching the ~339 corpus). If `0`, STOP — upstream `top` regen first.

### Run
```bash
cd /Users/jack/Documents/code/elm-m3e/docs && node scripts/examples-gen/gen-record-build.mjs
```
**Expected stdout (shape):**
```
gen-record-build: over <~330+> examples — record <~29..N>, build <~N> → …/config/examples.surfaces.json (non-transformed show the rationale tab).
```
The headline: `record` and `build` counts must be **> 0** (were 0). `record` will be smaller (only the
29 Record-facet components can yield a record surface); `build` should be the larger set.

### Acceptance test (LEAF 4)
```bash
cd /Users/jack/Documents/code/elm-m3e && node -e '
  const s=require("./config/examples.surfaces.json");
  const all=Object.values(s).flat();
  const rec=all.filter(x=>x.record).length, bld=all.filter(x=>x.build).length;
  console.log("record surfaces:",rec,"build surfaces:",bld);
  if(rec===0||bld===0){console.error("FAIL: still 0");process.exit(1)}
'
```
**Expected:** `record surfaces: <N>0>  build surfaces: <M>0>`, exit 0. This is the headline metric
flip (0 → populated). The generator ALREADY compile-verifies each kept surface internally (main() only
keeps a rewrite that changed AND recompiles, gen-record-build.mjs:130-137), so a non-zero count is
also a compile guarantee for those entries.

---

## LEAF 5 — Regenerate the full `examples.json` chain; whole-set compile check

**Model tier:** opus / medium.

`gen-record-build.mjs` writes only the sidecar `config/examples.surfaces.json`. Merge it into the
UI-consumed `docs/data/examples.json` via the pipeline (friction
`20260813T…-rename-true-blast-radius` documents the chain):
```bash
cd /Users/jack/Documents/code/elm-m3e/docs && cat package.json | grep -E "gen:examples"   # confirm exact script names
```
Then run the surfaces-merge tail (`gen:examples-barrel` if it consumes surfaces, then `gen:examples`).
Prefer the repo's own script names over hand-rolling:
```bash
cd /Users/jack/Documents/code/elm-m3e/docs && pnpm run gen:examples
```
(Adjust to run the barrel step first if the merge order requires it — read `build-examples-data.mjs`
to confirm it reads `examples.surfaces.json`.)

### Acceptance test (LEAF 5)
1. `examples.json` now carries non-null Record/Build:
   ```bash
   cd /Users/jack/Documents/code/elm-m3e && node -e '
     const d=require("./docs/data/examples.json");
     const flat=Object.values(d).flat();
     const rec=flat.filter(e=>e.record).length, bld=flat.filter(e=>e.build).length;
     console.log("examples.json record:",rec,"build:",bld);
     if(rec===0||bld===0)process.exit(1)'
   ```
   **Expected:** both > 0.
2. Docs app still builds (the site consumes `examples.json`):
   ```bash
   cd /Users/jack/Documents/code/elm-m3e/docs && pnpm run build:site
   ```
   **Expected:** exit 0. (Ignore the nondeterministic `Pages.elm` `builtAt` timestamp per MEMORY.)

---

## LEAF 6 — E2E: a spot-checked component's Record & Build tabs show real code

**Model tier:** opus / medium.

Pick a known-good component with both facets — **Button** (has `component` record + Build) or
**Accordion**. Verify the emitted strings are real per-component surface code, not rationale-null:

```bash
cd /Users/jack/Documents/code/elm-m3e && node -e '
  const d=require("./docs/data/examples.json");
  const pick=(mod)=>{
    const ex=(d[mod]||[]).find(e=>e.record||e.build);
    if(!ex){console.error("no record/build for",mod);process.exit(1)}
    console.log("=== "+mod+" ===");
    console.log("RECORD:", ex.record||"(null)");
    console.log("BUILD :", ex.build||"(null)");
    const okR = !ex.record || /M3e\.Component\.\w+\.component /.test(ex.record);
    const okB = !ex.build  || /M3e\.Build\.\w+\.build/.test(ex.build) && /M3e\.Build\.\w+\.toElement/.test(ex.build);
    if(!okR||!okB){console.error("FAIL shape",mod);process.exit(1)}
  };
  pick("Button"); pick("Accordion");
'
```
**Expected:** RECORD contains `M3e.Component.<X>.component { … }`; BUILD contains
`M3e.Build.<X>.build … |> … |> M3e.Build.<X>.toElement`. Neither is null-by-rationale for these
picks. Non-zero exit ⇒ the surfaces are still wrong.

**Optional visual confirm (paseo/prod build only — dev server does NOT hydrate `<m3e-*>`, per MEMORY
`elm-pages-dev-server-hydration-gotcha`):** open the Button Usage page on the PROD build, click the
**Components (Record)** and **Builder (Build)** tabs, confirm they render `M3e.Component.Button.component`
/ `M3e.Build.Button.build` code, not the "identical by design" rationale panel.

---

## Riskiest leaf

**LEAF 2** (test migration) is the highest-effort/most-error-prone: 23 `.view`/`.el`/`.build`
expectation strings across two files, each needing the module-namespace swap, the whole-word-lowercase
Standard slug in inputs (`expansionpanel`, not `expansionPanel`), the `.el`→`.component` record ctor,
AND the `M3e.Build.<X>` module for Build outputs — with the `import M3e.[Component.]Action` path
depending on LEAF 3 sub-check A. A single wrong expectation is a loud, self-diagnosing Review.Test
diff, so it's low-RISK but high-toil.

The highest genuine-UNKNOWN risk is **LEAF 3 sub-check A** (Action module path): if `Action` stayed
top-level `M3e.Action` while everything else nested under `M3e.Component`, `factNamespaceParts` yields
the wrong Action qualifier and every `usesAction` component's Record surface emits an unresolvable
`M3e.Component.Action.onClick` → those surfaces silently drop (compile-fail → nulled). It won't crash;
it'll just quietly under-populate — exactly the failure mode this whole task exists to fix — so it MUST
be verified, not assumed.

## Out of scope / dependencies

- The Standard `top` corpus (`examples.rich.json`) being populated + compiling is a **precondition**
  owned by `2026-08-14-examples-kit-to-unsafe-migration.md`. If it hasn't landed, LEAF 4 is blocked
  upstream (surface, don't fabricate).
- The `Facts.callSiteUnder` `"view"` hardcode (Facts.elm:355,361) drives OTHER rules (PreferBarrel,
  PreferComponentModules) — **NOT touched here**; those rules are not on the docs Record/Build path.
  Flag as a separate follow-up if those rules also need the new ctor slug.
- No commit/push (gauntlet WORK + review-gate own that).
