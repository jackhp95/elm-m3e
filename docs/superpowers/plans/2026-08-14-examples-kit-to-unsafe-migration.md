# Plan — Migrate the examples generator from `Kit`/`Native`/`Seam` to `TypedHtml`/`M3e.Unsafe`

- **Date:** 2026-08-14
- **Repo:** `/Users/jack/Documents/code/elm-m3e` (docs = elm-pages app, pnpm)
- **Branch base:** `feat/prepush-commit-generated-docs` (or a fresh worktree off it)
- **Role:** execution (expected tier: opus @ medium — mechanical string-swap + harness src-dir fix + one type-equivalence risk to compile-check)
- **Scope (ONE axis only):** replace the deleted userland vocabulary that the generator still EMITS —
  `Kit.text` / `Kit.link` / `Native.attribute` / `Native.node` — with the current substrate
  (`TypedHtml.text` / `TypedHtml.a` / `M3e.Unsafe.Attributes.customAttribute` / `M3e.Unsafe.customElement`),
  and drop the deleted `docs/kit` source-directory from the three gen harnesses so
  `gen:examples-config` stops FATAL-ing. The **ctor rename axis** (`view`→`<name>`) is ALREADY DONE
  (commit `d230e979`, `to-elm.mjs:430`) — do NOT touch it.
- **Out of scope:** the barrel/surfaces content, the ctor rename, any library `src/M3e` change, docs app `.elm` files.

---

## Background & evidence (all verified in this investigation)

### The break
`docs/kit/` (modules `Kit`, `Native`, `Seam`) was deleted; commit `333eb9a0` (2026-08-04) removed the last
of it (`Seam.elm`) and unwired `docs/kit` from the docs app's own elm.json. The `Kit`/`Native` *modules*
were already gone before that (last seen at `4b5f5ec4`). The example generator was never migrated, so it
still emits the old vocabulary and its compile harnesses still list `docs/kit` as a source-dir.

**Reproduced FATAL** (`cd docs && node scripts/examples-gen/examples-to-elm.mjs`):
```
FATAL: top-layer verification did not build (harness/elm.json issue):
structural compile error in elm.json:
    /Users/jack/Documents/code/elm-m3e/docs/kit
I cannot find it though. Is it missing? Is there a typo?
```

**Committed staleness** (`docs/data/examples.json`): `Kit.text` ×3003, `Native.attribute` ×1141,
`Native.node` ×98, `Kit.link` ×0, `Seam.*` ×0. Last real regen (`5eede4fa`, 2026-07-30) predates the kit deletion.

### Confirmed replacement mapping (old sig ↦ new sig — ALL target symbols verified to exist)

| Old (emitted) | New (emit this) | Evidence |
|---|---|---|
| `Kit.text "s"` | `TypedHtml.text "s"` | `Kit.text : String -> Element { s \| sharedText : Shared } admittedBy msg` (`4b5f5ec4:docs/kit/Kit.elm:48`) is **byte-identical** to `TypedHtml.text : String -> Element { s \| sharedText : Shared } admittedBy msg` (`docs/vendor/elm-foundation/TypedHtml.elm:1168`). Perfect drop-in, same arity. |
| `Kit.link "URL" [ kids ]` | `TypedHtml.a [ TypedHtml.Attributes.href "URL" ] [ kids ]` | `TypedHtml.a : List (Attr A.Attrs msg) -> List (Element …) -> Element childAccepts admittedBy msg` (`TypedHtml.elm`, `a :`). `TypedHtml.Attributes.href : String -> Attr { c \| href : Supported } msg` (`TypedHtml/Attributes.elm:541`). Docs app already uses exactly `TypedHtml.a [ TypedHtml.Attributes.href path ] [ M3e.text lbl ]` in `Shared.elm:1487` and as a `NavMenuItem.label` in `Route/Guide/Seams.elm:160`. **Arity change** — see Risk. |
| `Native.attribute "n" "v"` | `M3e.Unsafe.Attributes.customAttribute "n" "v"` | `Native.attribute : String -> String -> Attr c msg` (`4b5f5ec4 Native.elm:78`) ↦ `customAttribute : String -> String -> Attr capability msg` (`src/M3e/Unsafe/Attributes.elm:48`). Same 2-arg shape. Docs app uses it live (`Route/Guide/Seams.elm:136`). |
| `Native.node "tag" attrs kids` | `M3e.Unsafe.customElement "tag" attrs kids` | `Native.node : String -> …` (`Native.elm:45`) ↦ `customElement : String -> List (Attr …) -> List (Element …) -> Element …` (`src/M3e/Unsafe.elm:59`). Same 3-arg shape (String tag). Docs app uses it live (`Route/Guide/Seams.elm:134`, `Route/Guide/Motion.elm:161`). |
| `Seam.*` | (n/a) | Generator emits **zero** `Seam.*` — only in comments. No code change; comment sweep only. |

### How the compile-verify works (this IS the acceptance test)
`examples-to-elm.mjs:228` calls `verifyExamples()` (`verify-examples.mjs:295`). That builds a scratch
`Verify.elm` via `writeCorpusApp` (`lib/scratch-harness.mjs:80`), whose **imports are auto-derived**:
```js
// scratch-harness.mjs:91-97
const imports = new Set();
for (const it of bindings)
  for (const mod of referencedModules(it.code))   // any dotted PascalCase module
    if (moduleResolves(mod, srcDirs)) imports.add(mod);
```
So once the emitter produces `TypedHtml.*` / `M3e.Unsafe.*` / `M3e.Unsafe.Attributes.*`, the harness
auto-`import`s them **iff** they resolve under `srcDirs`. `M3e.Unsafe` + `M3e.Unsafe.Attributes` live under
`src/` (`LIB_SRC`); `TypedHtml` + `TypedHtml.Attributes` live under `docs/vendor/elm-foundation`
(`FOUNDATION_SRC`). The **only** harness change is fixing `srcDirs` (drop dead `docs/kit`; ensure both real
dirs are present). The generator then runs `elm make` — a **green build IS the acceptance test**.

### elm-review fence — NOT a concern for this task
`NoUnsafeImportOutsideAllowed` (`review/src/CodegenReviewConfig.elm:19`) fences `import *.Unsafe` in the
**docs app** (`review/` runs against `docs/app` + `docs/src` via `check:review`). The generator's ephemeral
`writeCorpusApp` scratch dir has **no** ReviewConfig — it only runs `elm make`. The strings in
`examples.json` are **display-only code snippets** rendered in the Usage UI; they are never fed to
elm-review. So emitting `M3e.Unsafe.*` in generated examples is safe and un-flagged. (No allow-list edit.)

---

## Pipeline map (for the executor)

```
gen (run-s) → … → gen:examples-config → gen:examples-surfaces → gen:examples-barrel → gen:examples
                    │ examples-to-elm.mjs  │ gen-record-build.mjs │ gen-barrel.mjs      │ build-examples-data.mjs
                    │ reads config/         │ writeCorpusApp        │ writeCorpusApp      │ merges the 3 sidecars
                    │ examples.matraic.json │ SRC_DIRS:68           │ SRC_DIRS:52         │ into docs/data/examples.json
                    │ + converter+verify    │ (has docs/kit)        │ (has docs/kit)      │ (NO elm; pure merge)
                    │ writes examples.rich  │                       │                     │
                    │ .json (+generated,    │                       │                     │
                    │ surfaces, skipped)    │                       │                     │
                    ▼ verifyExamples()       ▼                       ▼                     ▼
              SRC_DIRS: verify-examples.mjs:48  ← the FATAL lives here (KIT_SRC:39)
```
Config sidecars (`config/examples.rich.json`, `.surfaces.json`, `.barrel.json`, `.generated.json`) are
**generated, not committed** — none exist on disk now. Committed inputs: `config/examples.matraic.json`,
`config/categories.json`. Final output `docs/data/examples.json` (committed) is what the plan regenerates.

---

## Tasks (atomic leaves, sequenced)

> All paths absolute-from-repo-root. Run generator steps from `docs/` (`cd /Users/jack/Documents/code/elm-m3e/docs`).
> `elm-format` binary: `docs/node_modules/.bin/elm-format`. `node --test` for the gen unit tests.

---

### LEAF 1 — Fix the three harness SRC_DIRS (removes the FATAL)

Three files list the deleted `docs/kit`. Drop it; ensure the foundation vendor dir is present
(needed so `TypedHtml`/`TypedHtml.Attributes` resolve → get auto-imported by `writeCorpusApp`).

**1a. `docs/scripts/examples-gen/verify-examples.mjs`**
- Line 39: delete `const KIT_SRC = \`${M3E_ROOT}/docs/kit\`;`
- Line 48: `const SRC_DIRS = [LIB_SRC, KIT_SRC, FOUNDATION_SRC];` → `const SRC_DIRS = [LIB_SRC, FOUNDATION_SRC];`
- Line 2 comment `// against the REAL M3e.* / Kit / Native API.` → `// against the REAL M3e.* / M3e.Unsafe / TypedHtml API.`

**1b. `docs/scripts/examples-gen/gen-record-build.mjs`**
- Line 68: `const SRC_DIRS = [\`${REPO}/src\`, \`${REPO}/docs/kit\`];`
  → `const SRC_DIRS = [\`${REPO}/src\`, \`${REPO}/docs/vendor/elm-foundation\`];`
  (adds the foundation dir; some record/build bindings reference `TypedHtml`.)

**1c. `docs/scripts/examples-gen/gen-barrel.mjs`**
- Line 52: same edit as 1b:
  `const SRC_DIRS = [\`${REPO}/src\`, \`${REPO}/docs/kit\`];`
  → `const SRC_DIRS = [\`${REPO}/src\`, \`${REPO}/docs/vendor/elm-foundation\`];`

**Acceptance:**
```sh
cd /Users/jack/Documents/code/elm-m3e/docs
grep -rn 'docs/kit\|KIT_SRC' scripts/examples-gen/*.mjs; echo "exit=$?"
# EXPECT: no matches, exit=1
```

---

### LEAF 2 — Swap the emit strings in `docs/scripts/examples-gen/lib/to-elm.mjs`

Ten emit-string sites (verified). Comments swept in Leaf 6. Each edit below is exact.

**2a. `Kit.text` → `TypedHtml.text`** — 5 template-literal sites. Do a scoped replace-all of the
**emit** occurrences (the ` \`Kit.text "…"\` ` templates), lines 172, 211, 229, 267, 283:
```
`Kit.text "${escapeElmString(   →   `TypedHtml.text "${escapeElmString(
```
(All five have the identical prefix `\`Kit.text "${escapeElmString(`. A `replace_all` on that exact
substring hits exactly the emit sites and NOT the prose comments, which read `Kit.text` without the
backtick+`${` template shape.)

**2b. `Kit.link` → `TypedHtml.a [ href ]`** — 1 site, line 358:
```
return `Kit.link "${escapeElmString(href)}" ${list}`;
```
→
```
return `TypedHtml.a [ TypedHtml.Attributes.href "${escapeElmString(href)}" ] ${list}`;
```

**2c. `Native.attribute` → `M3e.Unsafe.Attributes.customAttribute`** — 2 sites (lines 340, 541).
Both are ` \`Native.attribute "…" "…"\` `. Replace-all the exact substring:
```
`Native.attribute "   →   `M3e.Unsafe.Attributes.customAttribute "
```

**2d. `Native.node` → `M3e.Unsafe.customElement`** — 3 sites (lines 316, 396, 410).
All three are ` \`Native.node "${escapeElmString(tag)}" …\` `. Replace-all the exact substring:
```
`Native.node "${escapeElmString(tag)}"   →   `M3e.Unsafe.customElement "${escapeElmString(tag)}"
```
(NB line 316 uses `${kidList}`, 396/410 use `${list}` — the leading token is identical, so the
substring replace is safe for all three.)

**Acceptance (emit strings only, comments excluded):**
```sh
cd /Users/jack/Documents/code/elm-m3e/docs
grep -nE '`(Kit\.text|Kit\.link|Native\.attribute|Native\.node) ' scripts/examples-gen/lib/to-elm.mjs
echo "exit=$?"
# EXPECT: no matches (exit=1). Only comment-mentions of Kit/Native remain (fixed in Leaf 6).
grep -cE 'TypedHtml\.text|TypedHtml\.a \[ TypedHtml\.Attributes\.href|M3e\.Unsafe\.Attributes\.customAttribute|M3e\.Unsafe\.customElement' scripts/examples-gen/lib/to-elm.mjs
# EXPECT: >= 10
```

---

### LEAF 3 — Update the generator's unit-test fixtures `to-elm.test.mjs`

`docs/scripts/examples-gen/lib/to-elm.test.mjs` has 30 `Kit.`/`Native.` occurrences in **assertions and
input fixtures**. These must move to the new vocabulary so `test:examples-gen` still green-lights the
emitter. Mechanical swaps (mirror Leaf 2 mapping) across the file:

- `Kit.text ` → `TypedHtml.text ` (in both input `code:` fixtures and `assert.match` regexes — e.g. lines
  14, 20, 65, 73, 122, 157, 165, 185, 209, 220, 253, 263, 306, 307, 351, 366)
- `Kit\.text` (regex-escaped forms in asserts, e.g. `/… \(Kit\.text "Mail"\)/`) → `TypedHtml\.text`
- `Kit.link "URL" […]` input fixtures / asserts → `TypedHtml.a [ TypedHtml.Attributes.href "URL" ] […]`
  and the `Kit\.link` regex asserts → the `TypedHtml\.a \[ TypedHtml\.Attributes\.href …` shape
  (lines 209, 358–366). For the loose `/Kit\.link "\/x"/` assert at line 366, change to
  `/TypedHtml\.a \[ TypedHtml\.Attributes\.href "\/x"/`.
- `Native.attribute "n" "v"` fixtures/asserts → `M3e.Unsafe.Attributes.customAttribute "n" "v"`
  (and `Native\.attribute` regexes → `M3e\.Unsafe\.Attributes\.customAttribute`) — lines 176–177, 326,
  331–335, 340–342.
- `Native.node "tag" …` fixtures/asserts → `M3e.Unsafe.customElement "tag" …` (and `Native\.node`
  regexes accordingly) — lines 357–360.

> Note the two test *names/comments* (`"… folds to Kit.text"`, `"… via the Native.attribute Seam"`) —
> rename them to the new vocabulary for honesty (part of this leaf; not load-bearing).

**Acceptance:**
```sh
cd /Users/jack/Documents/code/elm-m3e/docs
grep -nE 'Kit\.|Native\.|Seam\.' scripts/examples-gen/lib/to-elm.test.mjs; echo "exit=$?"
# EXPECT: no matches, exit=1
node --test scripts/examples-gen/lib/to-elm.test.mjs 2>&1 | tail -5
# EXPECT: "# pass <N>" with "# fail 0"
```

---

### LEAF 4 — Full generator unit-test suite green

**Acceptance:**
```sh
cd /Users/jack/Documents/code/elm-m3e/docs
pnpm run test:examples-gen 2>&1 | tail -6
# EXPECT: "# fail 0" (all lib/*.test.mjs pass — oracle/sections/naming unaffected)
```

---

### LEAF 5 — Regenerate the config step; the built-in compile-verify must be GREEN

This is the crux — `elm make` over the auto-imported corpus proves every emitted example compiles against
the CURRENT `src/M3e` + vendor `TypedHtml`/`M3e.Unsafe`.

```sh
cd /Users/jack/Documents/code/elm-m3e/docs
node scripts/examples-gen/examples-to-elm.mjs 2>&1 | tee /tmp/gen-config.log | tail -25
echo "exit=${PIPESTATUS[0]}"
```
**Acceptance:**
- exit=0 (NO `FATAL:` line in `/tmp/gen-config.log`).
- `config/examples.rich.json` now exists and is Kit/Native/Seam-clean:
```sh
cd /Users/jack/Documents/code/elm-m3e
test -f config/examples.rich.json && echo "rich exists"
grep -oE 'Kit\.text|Kit\.link|Native\.attribute|Native\.node|Seam\.' config/examples.rich.json | wc -l
# EXPECT: rich exists ; count = 0
grep -cE 'TypedHtml\.text|M3e\.Unsafe\.' config/examples.rich.json
# EXPECT: > 0
```
> **If a small number of bindings now FAIL to compile** (not a structural FATAL — a per-binding failure the
> harness attributes and skips), that is the **`Kit.link`→`TypedHtml.a` type-equivalence risk** biting: a
> link-kinded slot (`NavMenuItem.label`, `TreeItem.label`) that accepted `Kit.link`'s `{ sharedLink }` row
> may not accept `TypedHtml.a`'s inherited-child row. **Do not guess** — see Risk R1 for the diagnostic and
> the sanctioned fallback (drop those examples via the existing skip path, or reshape the `a` emit). Record
> which bindings dropped in `config/examples.skipped.txt` and note them; a handful of skips is acceptable
> and keeps the pipeline green.

---

### LEAF 6 — Sweep the now-lying comments in `to-elm.mjs` (+ `examples-to-elm.mjs`, `verify-examples.mjs`)

Comments still describe `Kit`/`Native`/`Seam` as live. Non-functional but honesty-required. Update the
prose at `to-elm.mjs` lines 10–11, 39, 44, 77, 106–107, 124, 126–127, 204–205, 218, 239–252, 276, 291–293,
322–323, 332, 349, 373, 385, 390, 402, 409, 481, 506, 535, 631; `examples-to-elm.mjs:21,204`;
`verify-examples.mjs` header. Replace each `Kit.text`→`TypedHtml.text`, `Kit.link`→`TypedHtml.a`,
`Native.attribute`→`M3e.Unsafe.Attributes.customAttribute`, `Native.node`→`M3e.Unsafe.customElement`,
`Seam`/`kit Native.elm`/`docs/kit/Native.elm`→`M3e.Unsafe` references. (Bulk sed is fine here since these
files no longer contain emit-strings after Leaf 2 — verify with the Leaf 2 grep first.)

**Acceptance:**
```sh
cd /Users/jack/Documents/code/elm-m3e/docs
grep -rnE 'Kit\.|Native\.|Seam' scripts/examples-gen/lib/to-elm.mjs scripts/examples-gen/examples-to-elm.mjs scripts/examples-gen/verify-examples.mjs; echo "exit=$?"
# EXPECT: no matches, exit=1
node --test scripts/examples-gen/lib/to-elm.test.mjs 2>&1 | tail -3   # still green after comment sweep
```

---

### LEAF 7 — Run the remaining gen sidecar steps (surfaces, barrel) green

Now that Leaf 1 fixed their SRC_DIRS, these two `writeCorpusApp` consumers must also build.

```sh
cd /Users/jack/Documents/code/elm-m3e/docs
node scripts/examples-gen/gen-record-build.mjs 2>&1 | tail -8; echo "exit=${PIPESTATUS[0]}"   # writes config/examples.surfaces.json
node scripts/examples-gen/gen-barrel.mjs       2>&1 | tail -8; echo "exit=${PIPESTATUS[0]}"   # writes config/examples.barrel.json
```
**Acceptance:** both exit=0; no FATAL/`docs/kit` in output.
```sh
cd /Users/jack/Documents/code/elm-m3e
for f in config/examples.surfaces.json config/examples.barrel.json; do
  grep -oE 'Kit\.|Native\.|Seam\.' "$f" 2>/dev/null | wc -l; done
# EXPECT: 0 and 0
```

---

### LEAF 8 — Merge into `docs/data/examples.json` (the committed artifact)

```sh
cd /Users/jack/Documents/code/elm-m3e/docs
node scripts/build-examples-data.mjs 2>&1 | tail -8; echo "exit=${PIPESTATUS[0]}"
```
**Acceptance — the headline metric (Kit/Native/Seam → 0):**
```sh
cd /Users/jack/Documents/code/elm-m3e/docs
for t in 'Kit\.text' 'Kit\.link' 'Native\.attribute' 'Native\.node' 'Seam\.'; do
  printf '%-18s ' "$t"; grep -oE "$t" data/examples.json | wc -l; done
# EXPECT: every count = 0  (was 3003 / 0 / 1141 / 98 / 0)
grep -cE 'TypedHtml\.text|M3e\.Unsafe\.' data/examples.json
# EXPECT: > 0 (the new vocabulary is present)
```

---

### LEAF 9 — END-TO-END acceptance: full `gen` chain + `build:site` green + spot-check a rendered Usage example

**9a. Whole generator chain in order (proves nothing else regressed):**
```sh
cd /Users/jack/Documents/code/elm-m3e/docs
pnpm run gen:examples-config && pnpm run gen:examples-surfaces && pnpm run gen:examples-barrel && pnpm run gen:examples
echo "chain-exit=$?"
# EXPECT: chain-exit=0
```

**9b. Site build green (elm-pages build + search index):**
```sh
cd /Users/jack/Documents/code/elm-m3e/docs
pnpm run build:site 2>&1 | tail -15; echo "build-exit=${PIPESTATUS[0]}"
# EXPECT: build-exit=0
```

**9c. Spot-check a Usage snippet shows CURRENT vocabulary (pick a component known to carry text, e.g. Button):**
```sh
cd /Users/jack/Documents/code/elm-m3e/docs
node -e '
  const d = require("./data/examples.json");
  const s = JSON.stringify(d);
  const hasNew = s.includes("TypedHtml.text");
  const hasOld = /Kit\.text|Native\.attribute|Native\.node|Kit\.link|Seam\./.test(s);
  console.log("hasNew=",hasNew,"hasOld=",hasOld);
  if(!hasNew || hasOld) process.exit(1);
'
# EXPECT: hasNew= true hasOld= false ; exit 0
```

**9d. (Optional visual, if a browser gate is convenient) — render a Usage page and eyeball a code block:**
```sh
# from a prod build already produced by 9b; serve + open a component page, confirm the Usage
# "Elm" code panel reads `TypedHtml.text "…"` (not `Kit.text`). Load-flaky per MEMORY; not a gate.
cd /Users/jack/Documents/code/elm-m3e/docs && pnpm run serve  # then visit /components/button
```

---

## Sequencing

```
LEAF 1 (harness src-dirs) ─┐
LEAF 2 (emit strings)  ─────┼─→ LEAF 4 (unit suite) ─→ LEAF 5 (config regen + compile-verify) ─┐
LEAF 3 (test fixtures) ─────┘                                                                   │
LEAF 6 (comment sweep, after 2's grep) ─────────────────────────────────────────────────────┤
                                                                    LEAF 7 (surfaces+barrel) ─┤
                                                                    LEAF 8 (merge) ───────────┤
                                                                    LEAF 9 (E2E: chain+build+spot) ┘
```
Leaves 1/2/3 are independent and can be done in any order. 4 needs 2+3. 5 needs 1+2. 7 needs 1. 8 needs 5+7.
9 needs everything. Do 6 any time after 2's acceptance grep (so the grep can distinguish emit vs comment).

---

## Risks

- **R1 (the single riskiest leaf — LEAF 5, `Kit.link`→`TypedHtml.a` type equivalence).** `Kit.link`
  produced a **link-kinded** `Element { k | sharedLink : Shared } linkAdm msg` — purpose-built to satisfy
  link-admitting named slots (`NavMenuItem.label`, `TreeItem.label`). `TypedHtml.a` produces
  `Element childAccepts admittedBy msg` — it **inherits the child's accepts row**, it does NOT stamp a
  `sharedLink` row. The docs app DOES use `TypedHtml.a […] [ M3e.text … ]` as a `NavMenuItem.label`
  (`Shared.elm:1487`, `Seams.elm:160`), which is strong evidence it unifies — but the generator emits `a`
  into more slots than those two, so a subset MIGHT not type-check.
  **Diagnostic (run inside Leaf 5 if failures appear):** the compile harness attributes each failure to its
  binding name; read `/tmp/gen-config.log` for `M3e.<Comp>.<field>` mismatch lines. **Sanctioned fallbacks,
  in order:** (a) the emit already routes text/link slot children through `textLinkSlotChild`, whose `a`
  branch delegates to `plainElementToElm` — if a specific link slot rejects `a`, let that example fall to
  the existing **skip path** (it lands in `config/examples.skipped.txt`; a handful of skips is acceptable and
  the pipeline stays green); (b) if MANY link-slot examples drop, that's a genuine API-shape question —
  **stop and report** rather than inventing a `sharedLink` wrapper (no such userland helper exists post-kit).
  This is the only leaf whose green outcome is not mechanically guaranteed.

- **R2 (surfaces/barrel foundation dir).** Leaf 1b/1c ADD `docs/vendor/elm-foundation` to those harnesses'
  SRC_DIRS. If a record/build binding references a `TypedHtml.*` symbol and the dir were omitted, the module
  would fail to auto-import and the whole step would go structural-red. Mitigated by adding it; the Leaf 7
  acceptance (exit 0) catches any residue.

- **R3 (builtAt churn).** `docs/.elm-pages/Pages.elm` `builtAt` timestamp changes on every `build:site` and
  is nondeterministic (per MEMORY). When committing, either ignore that hunk or accept it — it is not a
  regression. Not part of acceptance.

## Non-goals / guardrails
- Do NOT touch `to-elm.mjs:430` (ctor default) — that axis is DONE (`d230e979`).
- Do NOT edit `src/M3e/**` or any docs `.elm` app file — this is a generator-only change.
- Do NOT add an elm-review allow-list entry — the generated snippets are display-only, never linted.
- Config sidecars (`config/examples.*.json`) are generated, not committed — do not `git add` them.
  Commit ONLY `docs/data/examples.json` (+ `docs/data/example-usage.json` if it changed) and the
  three `.mjs` source edits.
