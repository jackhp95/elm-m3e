# Deterministic HTML→M3e Example Converter — Implementation Plan (Plan 2 of 3)

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development to implement task-by-task. Steps use checkbox (`- [ ]`) syntax.

**Goal:** A deterministic Node script that reads the mined `<m3e-*>` HTML compositions in `m3e-docs/data/examples.json` and emits equivalent **typed top-layer `M3e.*` Elm** code, grouped into feature sections, plus per-component `category` metadata — written to a clean generated config file that feeds `elm-cem` (Plan 1's `examples`/`docMeta`) via a new multi-`--config-from` capability. The generated examples land in `packages/m3e` doc comments and are gated by `elm make` + the existing elm-review rules.

**Architecture:** `m3e-docs/scripts/examples-to-elm.mjs` parses each HTML snippet (linkedom) and walks the DOM, using the **CEM (`custom-elements.json`) + `config/slots.json` as the mapping oracle**: tag→`M3e.<Module>.view`, enum attr→`M3e.Value.<camel(value)>`, bool attr→`setter True`, string attr→`setter "v"`, required-record fields (e.g. `aria-label`→`{ ariaLabel = "..." }`) → the 3-arg `view` form, slot children→content helpers (with the `+Slot` collision bump), default children→`child`/`children`, text→`Kit.text`, plain HTML→`Native.*`/`Kit.link`/`Native.node Html.label`. Anything unmappable is **skipped and logged** (never emitted wrong). Output: `config/examples.generated.json` keyed by PascalCase module → `{ examples: [{title, code, section}], docMeta: { category } }`.

**Tech Stack:** Node ≥18 (ESM, `node --test`), `linkedom` (new devDep in `m3e-docs`), the `@m3e/web` CEM at `docs/node_modules/@m3e/web/dist/custom-elements.json`, `config/slots.json`, `elm-cem/bin/elm-cem.js`, elm compiler at `docs/node_modules/.bin/elm`, `elm-review` via `cd docs && node_modules/.bin/elm-review --config ../review --compiler node_modules/.bin/elm`.

**Plan 2 of 3** (epic: `docs/superpowers/specs/2026-07-02-docs-matraic-alignment-design.md`). Plan 1 (generic elm-cem `examples`/`docMeta`) is LANDED. Plan 3 = docs-site renderer-extractor + inline previews + categorized nav + matraic Usage pages (incl. the API-layer toggle).

**Decisions carried in (confirmed with user):**
- Target the **typed top-layer M3e.\*** API (idiomatic; verified against the real API).
- **Deterministic JS mapper** (not the elm-review codemod or ornith). `gpu.internal` Ollama/ornith is the recorded fallback for skipped examples — NOT built here.
- Config: **separate generated file** `config/examples.generated.json` + **extend elm-cem for multiple `--config-from`** (deep-merged), keeping hand-owned `config/slots.json` clean.
- Parser: **linkedom** (not jsdom).
- **Verification gate is tier-agnostic and reuses existing elm-review rules** (`ValidEnumValue`, `RequireSlot`, `SingularSlot`, `NoSeamOutsideAllowedModules`) — enforces top-layer idiom, not just compilation.

**Representative sample (drives golden tests):** `button` (enum-varies + icon slot + text), `checkbox` (booleans + plain wrappers), `icon-button` (required `aria-label` record + default icon slot), `card` (named `header`/`content` slots + plain `<div>` + nested chip-set), and the actionable card wrapped in `<a href>`.

---

## File Structure

| File | Responsibility | Change |
| --- | --- | --- |
| `elm-cem/bin/elm-cem.js` | CLI: accept multiple `--config-from`, deep-merge into `_config` | Modify (`injectConfig`) |
| `m3e-docs/package.json` | add `linkedom` devDep + `build:elm-examples` script | Modify |
| `m3e-docs/scripts/lib/naming.mjs` | JS port of `Naming.elm` (camel/pascal/constructor/avoidConflicts) | Create |
| `m3e-docs/scripts/lib/naming.test.mjs` | unit tests for naming | Create |
| `m3e-docs/scripts/lib/oracle.mjs` | build the per-tag mapping oracle from CEM + slots.json | Create |
| `m3e-docs/scripts/lib/oracle.test.mjs` | unit tests for the oracle | Create |
| `m3e-docs/scripts/lib/to-elm.mjs` | the recursive DOM→Elm mapper (+ skip-and-log) | Create |
| `m3e-docs/scripts/lib/to-elm.test.mjs` | golden tests (HTML → expected Elm) | Create |
| `m3e-docs/scripts/lib/sections.mjs` | section derivation from varying enum attr | Create |
| `m3e-docs/scripts/lib/sections.test.mjs` | unit tests | Create |
| `config/categories.json` | hand-authored module→category map | Create |
| `m3e-docs/scripts/examples-to-elm.mjs` | orchestrator: corpus → `config/examples.generated.json` + skip log | Create |
| `config/examples.generated.json` | generated converter output (committed) | Create (generated) |

**Test commands:**
- Converter unit/golden: `cd m3e-docs && node --test scripts/lib/*.test.mjs`
- elm-cem regen (both configs): `node elm-cem/bin/elm-cem.js --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json --config-from=config/slots.json --config-from=config/examples.generated.json --output=packages/m3e/src`
- docs reference: `cd docs && node scripts/extract-reference.mjs`
- elm-review: `cd docs && node_modules/.bin/elm-review --config ../review --compiler node_modules/.bin/elm`

---

## Task 1: elm-cem — accept multiple `--config-from` (deep-merged)

**Files:** Modify `elm-cem/bin/elm-cem.js` (`injectConfig`).

- [ ] **Step 1: Write a failing functional check.** Create two tiny config files and assert the merged `_config` carries fields from BOTH for the same component. Create `/tmp/cfg-a.json` = `{"Button":{"slots":{"icon":{"kinds":["icon"]}}}}` and `/tmp/cfg-b.json` = `{"Button":{"docMeta":{"category":"Actions"}}}`. Run the generator with both `--config-from` flags into `/tmp/multi-cfg-out` and assert the generated `M3e/Button.elm` contains the docmeta marker `category=Actions` AND that generation still succeeds (proving Button's slot config from file A wasn't lost). Command:
```bash
cd /Users/jack/Documents/code/elm-m3e && \
  node elm-cem/bin/elm-cem.js --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json \
    --config-from=/tmp/cfg-a.json --config-from=/tmp/cfg-b.json --output=/tmp/multi-cfg-out && \
  grep -c "category=Actions" /tmp/multi-cfg-out/M3e/Button.elm
```
Expected BEFORE the change: only the LAST `--config-from` wins (current `injectConfig` overwrites `configPath` in its loop), so file A's slot config is dropped — and depending on order the docmeta may appear but the merge is not happening. Confirm the current single-file behavior first, then implement.

- [ ] **Step 2: Implement deep merge.** In `injectConfig` (`elm-cem/bin/elm-cem.js:86-123`), change the arg scan to COLLECT all `--config-from` values into an array (instead of last-wins). Parse each JSON, then deep-merge (two levels: top-level component keys, then each component's field object — later files add/override fields, they do NOT replace the whole component entry). Assign the merged object to `cem._config`. Keep the temp-file + `--flags-from` rewrite unchanged. Reference merge helper:
```js
function deepMergeConfigs(objs) {
  const out = {};
  for (const o of objs) {
    for (const [comp, fields] of Object.entries(o || {})) {
      out[comp] = { ...(out[comp] || {}), ...fields };
    }
  }
  return out;
}
```
Wire it: collect `configPaths = []`, push each `--config-from` value; if non-empty, `cem._config = deepMergeConfigs(configPaths.map(p => JSON.parse(fs.readFileSync(p, "utf8"))))`. Preserve the existing "no config ⇒ pass through" and "unreadable ⇒ strip flag + log" behaviors (apply per-file: a single unreadable file logs and is skipped, others still merge).

- [ ] **Step 3: Run the check — expect PASS** (both files' contributions present; generation succeeds).
- [ ] **Step 4: Regression — single `--config-from` still works.** Run the canonical single-config regen into `/tmp/single-out` and confirm it still generates (unchanged behavior for the common case).
- [ ] **Step 5: Clean up + commit (from elm-cem repo).**
```bash
rm -rf /tmp/multi-cfg-out /tmp/single-out /tmp/cfg-a.json /tmp/cfg-b.json
cd /Users/jack/Documents/code/elm-m3e/elm-cem && git add bin/elm-cem.js && \
  git commit -m "feat(elm-cem): accept multiple --config-from (deep-merged per component)"
```

---

## Task 2: Converter scaffold + Naming port

**Files:** Modify `m3e-docs/package.json`; Create `m3e-docs/scripts/lib/naming.mjs` + `naming.test.mjs`.

- [ ] **Step 1: Add linkedom + script.** In `m3e-docs/package.json`, add `"linkedom": "^0.18.0"` to `devDependencies` and `"build:elm-examples": "node scripts/examples-to-elm.mjs"` to `scripts`. Run `cd m3e-docs && npm install` to install linkedom.

- [ ] **Step 2: Write failing naming tests.** Create `m3e-docs/scripts/lib/naming.test.mjs`:
```js
import { test } from "node:test";
import assert from "node:assert/strict";
import { camel, pascal, constructor, avoidConflicts } from "./naming.mjs";

test("camel", () => {
  assert.equal(camel("variant"), "variant");
  assert.equal(camel("disabled-interactive"), "disabledInteractive");
  assert.equal(camel("extra-small"), "extraSmall");
  assert.equal(camel("trailing-icon"), "trailingIcon");
  assert.equal(camel("12-sided-cookie"), "value12SidedCookie");
  assert.equal(camel("_blank"), "blank");
});
test("pascal", () => {
  assert.equal(pascal("button"), "Button");
  assert.equal(pascal("icon-button"), "IconButton");
  assert.equal(pascal("chip-set"), "ChipSet");
  assert.equal(pascal("top-start"), "TopStart");
  assert.equal(pascal("2x"), "V2x");
});
test("constructor == pascal", () => assert.equal(constructor("tonal-spot"), pascal("tonal-spot")));
test("avoidConflicts", () => {
  assert.equal(avoidConflicts("round", new Set()), "roundAttr");
  assert.equal(avoidConflicts("children", new Set()), "childrenAttr");
  assert.equal(avoidConflicts("variant", new Set()), "variant");
  assert.equal(avoidConflicts("foo", new Set(["foo"])), "fooAttr");
});
```

- [ ] **Step 3: Run — expect FAIL** (`naming.mjs` missing). `cd m3e-docs && node --test scripts/lib/naming.test.mjs`.

- [ ] **Step 4: Implement `naming.mjs`** — a faithful port of `elm-cem/codegen/Naming.elm` (read it to confirm each rule). Key rules: `replaceSymbols` (`+`→` plus `, `%`→` percent `, `&`→` and `, `=`→` equals `, `?`→` question `, `#`→` hash `, `@`→` at `); `splitWords` (replaceSymbols, then non-alphanumeric→space, split, drop empties — does NOT split on case); `camel` = word[0] lowercased + rest capitalized, then `ensureLeadingAlpha("value")` (empty→"value"; leading digit→prepend "value"); `pascal` = all words capitalized, `ensureLeadingAlpha("V")`; `constructor = pascal`; `avoidConflicts(name, taken)` = `name+"Attr"` if name ∈ reserved-list OR taken, else name. Reserved list (exact): `number, numbered, abs, acos, asin, atan, atan2, ceiling, cos, degrees, e, floor, logBase, pi, radians, round, sin, sqrt, tan, truncate, compare, max, min, children, attributes, component`.
```js
const RESERVED = new Set(["number","numbered","abs","acos","asin","atan","atan2","ceiling","cos","degrees","e","floor","logBase","pi","radians","round","sin","sqrt","tan","truncate","compare","max","min","children","attributes","component"]);
const SYMS = [["+"," plus "],["%"," percent "],["&"," and "],["="," equals "],["?"," question "],["#"," hash "],["@"," at "]];
function splitWords(raw) {
  let s = String(raw);
  for (const [from, to] of SYMS) s = s.split(from).join(to);
  s = [...s].map((c) => (/[a-zA-Z0-9]/.test(c) ? c : " ")).join("");
  return s.split(" ").filter(Boolean);
}
const cap = (w) => (w ? w[0].toUpperCase() + w.slice(1) : w);
function ensureLeadingAlpha(s, fallback) {
  if (s === "") return fallback;
  if (/[0-9]/.test(s[0])) return fallback + s;
  return s;
}
export function camel(raw) {
  const ws = splitWords(raw);
  const body = ws.map((w, i) => (i === 0 ? w.toLowerCase() : cap(w))).join("");
  return ensureLeadingAlpha(body, "value");
}
export function pascal(raw) {
  return ensureLeadingAlpha(splitWords(raw).map(cap).join(""), "V");
}
export const constructor = pascal;
export function avoidConflicts(name, taken) {
  return RESERVED.has(name) || taken.has(name) ? name + "Attr" : name;
}
```
Note: `pascal("2x")` → splitWords `["2x"]` → cap `"2x"` → leading digit → `"V2x"`. `camel("12-sided-cookie")` → `["12","sided","cookie"]` → `"12SidedCookie"` → leading digit → `"value12SidedCookie"`. Confirm these match the Elm via the tests.

- [ ] **Step 5: Run — expect PASS.** Adjust `naming.mjs` until green against the Elm's real behavior (if any case disagrees, the Elm source is the source of truth — re-read `Naming.elm` and fix the port).

- [ ] **Step 6: Commit (from repo root — m3e-docs is part of the outer repo).**
```bash
cd /Users/jack/Documents/code/elm-m3e && git add m3e-docs/package.json m3e-docs/package-lock.json m3e-docs/scripts/lib/naming.mjs m3e-docs/scripts/lib/naming.test.mjs && \
  git commit -m "feat(examples): converter scaffold + Naming.elm JS port"
```

---

## Task 3: The CEM mapping oracle

**Files:** Create `m3e-docs/scripts/lib/oracle.mjs` + `oracle.test.mjs`.

The oracle turns the CEM + slots.json into a per-tag lookup the mapper needs. For each custom-element declaration (has `tagName`):
- `module` = `pascal(tagName without the "m3e-" prefix)`.
- `attributes`: map each `{ name, type/parsedType, fieldName }` to `{ htmlName, setter: camel(name) (with avoidConflicts against other setters), kind: "bool"|"enum"|"string", enumValues: [raw...] }`. Classify kind: boolean if `type.text` is `boolean`; enum if `parsedType.text`/`type.text` is a `'a' | 'b'` union (extract quoted values); else string. (Mirror `elm-cem/codegen/Attr.elm` classify; numbers→string setter is fine for examples.)
- `requiredFields`: from `config/slots.json`'s `<Module>.required` map (field→kind), e.g. IconButton `{ ariaLabel: ... }` — these become the 3-arg `view { ... }` record. The record field name is `camel(field)`; the source HTML attribute is its kebab form (`aria-label`).
- `slots`: for each CEM slot `{ name }`, compute the TOP content-helper name: default (`name===""`) → `child`/`children`; else `camel(name)`, bumped to `camel(name)+"Slot"` if it collides with an attribute setter name on this component. Record `{ rawName, helper, kind }` (kind from slots.json `<Module>.slots.<name>.kinds`: `icon`/`text`/`any`).

- [ ] **Step 1: Failing tests** (`oracle.test.mjs`) — load the real CEM + slots.json and assert Button/IconButton/Checkbox facts:
```js
import { test } from "node:test";
import assert from "node:assert/strict";
import { buildOracle } from "./oracle.mjs";
const oracle = buildOracle();
test("button module + variant enum", () => {
  const b = oracle["m3e-button"];
  assert.equal(b.module, "Button");
  const variant = b.attributes.find((a) => a.htmlName === "variant");
  assert.equal(variant.kind, "enum");
  assert.deepEqual(variant.enumValues.sort(), ["elevated","filled","outlined","text","tonal"]);
  assert.equal(b.attributes.find((a) => a.htmlName === "disabled").kind, "bool");
});
test("button slot helpers incl. selected->selectedSlot bump", () => {
  const b = oracle["m3e-button"];
  assert.equal(b.slots.find((s) => s.rawName === "icon").helper, "icon");
  assert.equal(b.slots.find((s) => s.rawName === "selected").helper, "selectedSlot");
  assert.equal(b.slots.find((s) => s.rawName === "").helper, "child");
});
test("icon-button has a required ariaLabel field", () => {
  const ib = oracle["m3e-icon-button"];
  assert.ok(ib.requiredFields.some((f) => f.field === "ariaLabel" && f.htmlName === "aria-label"));
});
```

- [ ] **Step 2: Run — expect FAIL** (`oracle.mjs` missing).

- [ ] **Step 3: Implement `oracle.mjs`.** Read `docs/node_modules/@m3e/web/dist/custom-elements.json` and `config/slots.json`. Walk `modules[].declarations[]` where `d.tagName`. Use `pascal`/`camel`/`avoidConflicts` from `naming.mjs`. Classify attr kinds (bool via `type.text==="boolean"`; enum via a `/'([^']*)'/g` scan of `parsedType?.text || type?.text` yielding ≥2 values; else string). Compute slot helpers with the collision bump (bump when `camel(slotName)` is in the set of attribute setter names). Pull `requiredFields` from `slots.json[Module].required` (field name→`camel`, htmlName→kebab of the field, i.e. `ariaLabel`→`aria-label`; derive kebab by inserting `-` before capitals and lowercasing). Return an object keyed by `tagName`.

- [ ] **Step 4: Run — expect PASS.** Reconcile against the real CEM/slots.json (if IconButton's required field isn't in slots.json under `required`, inspect `packages/m3e/src/M3e/IconButton.elm`'s `view` record and `config/slots.json` to find where the required `ariaLabel` originates, and source it correctly — the generator reads it from `_config` `required`, so slots.json is the authority).

- [ ] **Step 5: Commit.**
```bash
cd /Users/jack/Documents/code/elm-m3e && git add m3e-docs/scripts/lib/oracle.mjs m3e-docs/scripts/lib/oracle.test.mjs && \
  git commit -m "feat(examples): CEM+slots.json mapping oracle"
```

---

## Task 4: Core element mapper (Button / Checkbox / Icon)

**Files:** Create `m3e-docs/scripts/lib/to-elm.mjs` + `to-elm.test.mjs`.

`toElm(htmlString, oracle)` parses with linkedom (`import { parseHTML } from "linkedom"`) and maps the top-level element(s). Returns `{ code: string } | { skip: reason }`. The recursive `elementToElm(node)`:
- m3e element → `M3e.<Module>.view <reqRecord?> [<attrs>] [<content>]`. Attrs: enum→`M3e.<Module>.<setter> M3e.Value.<camel(value)>`; bool present→`M3e.<Module>.<setter> True`; string→`M3e.<Module>.<setter> "<value>"`. Required-record fields consumed from matching attributes into `{ field = "value" }` (emit the 2-arg form when the component has no required fields).
- children: group by `slot` attribute. `slot="X"` → `M3e.<Module>.<helper> (<child>)`; unslotted element/text children → `child`/`children` (use `children [..]` when >1 default child, else `child`).
- text node (non-whitespace) → `Kit.text "<trimmed>"`.
- unknown attribute (no setter, not a required field, not `slot`) → **skip the whole example**, return `{ skip: "unmapped attr <name> on <tag>" }`. (aria-* handled only if a required field; otherwise skip-and-log.)

- [ ] **Step 1: Golden tests** (`to-elm.test.mjs`) — the PRECISE spec. Author expected Elm by reading the real modules (`M3e/Button.elm`, `M3e/Checkbox.elm`, `M3e/Icon.elm`) so helper/setter names are exact:
```js
import { test } from "node:test";
import assert from "node:assert/strict";
import { buildOracle } from "./oracle.mjs";
import { toElm } from "./to-elm.mjs";
const oracle = buildOracle();
const conv = (h) => toElm(h, oracle);
test("button with icon slot + text", () => {
  const r = conv(`<m3e-button variant="filled"><m3e-icon slot="icon" name="add"></m3e-icon>New</m3e-button>`);
  assert.deepEqual(r, { code:
`M3e.Button.view [ M3e.Button.variant M3e.Value.filled ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "add" ] []), M3e.Button.child (Kit.text "New") ]` });
});
test("checkbox boolean attr", () => {
  assert.deepEqual(conv(`<m3e-checkbox checked></m3e-checkbox>`),
    { code: `M3e.Checkbox.view [ M3e.Checkbox.checked True ] []` });
});
test("skip on unmapped attr", () => {
  const r = conv(`<m3e-button data-foo="x">Hi</m3e-button>`);
  assert.ok(r.skip && /data-foo/.test(r.skip));
});
```
> The exact whitespace/format of the expected `code` is up to the implementer, but MUST be valid Elm and MUST elm-format cleanly (Task 8 runs elm-format on the generated modules). Keep a single canonical rendering (the tests pin it).

- [ ] **Step 2: Run — expect FAIL** (`to-elm.mjs` missing).
- [ ] **Step 3: Implement `to-elm.mjs`** per the algorithm above (linkedom `parseHTML`; walk `.children`/`.childNodes`; `.tagName.toLowerCase()`, `.attributes`, text via `node.nodeType===3`). Emit strings; collect the first skip reason and short-circuit the whole example to `{ skip }`.
- [ ] **Step 4: Run — expect PASS.**
- [ ] **Step 5: Commit.** `git add m3e-docs/scripts/lib/to-elm.mjs m3e-docs/scripts/lib/to-elm.test.mjs && git commit -m "feat(examples): core DOM→M3e mapper (attrs, slots, text, skip-and-log)"`

---

## Task 5: Required-record form, plain HTML, and links (IconButton / Card)

**Files:** Modify `m3e-docs/scripts/lib/to-elm.mjs`; extend `to-elm.test.mjs`.

Extend the mapper for: (a) the required-record `view { ariaLabel = "..." } [attrs] [content]` form when `oracle[tag].requiredFields` is non-empty (consume those attributes into the record; if a required field's source attribute is ABSENT, skip-and-log `missing required <field>`); (b) plain HTML — `<div>/<span>/<section>/<nav>/<p>/<header>/<footer>/<strong>/<em>/<small>/<ul>/<ol>/<li>/<img>/<br>/<hr>` → `Native.<tag> [] [ <children> ]`; `<a href="...">` → `Kit.link "<href>" [ <children> ]`; `<label>` (+ any tag not in Native's list) → `Native.node Html.label [] [ <children> ]` (emit the needed `Html`/`Html.Attributes` usage note); (c) plain-HTML attributes other than `slot`/`href` on plain elements → skip-and-log (keep v1 conservative).

- [ ] **Step 1: Golden tests** for IconButton (required record + default icon slot) and Card (named `header`/`content` slots + nested `<div slot="content">` + `<m3e-chip-set>`), and the `<a href>`-wrapped actionable card. Author expected Elm by reading `M3e/IconButton.elm` (confirm the default-slot helper name — verify whether it exposes `child` or the icon goes in the required record) and `M3e/Card.elm`. Include a skip test for a `<label for="...">` if `for` has no mapping (or map `<label>` via `Native.node Html.label` with the `for` attribute dropped + logged).
- [ ] **Step 2: Run — expect FAIL** on the new cases.
- [ ] **Step 3: Implement** the three extensions.
- [ ] **Step 4: Run — expect PASS** (all Task 4 + Task 5 goldens).
- [ ] **Step 5: Commit.** `git commit -m "feat(examples): required-record form + plain HTML + links in mapper"`

---

## Task 6: Section derivation

**Files:** Create `m3e-docs/scripts/lib/sections.mjs` + `sections.test.mjs`.

`deriveSection(exampleDom, oracle)`: if the example's top level is multiple sibling elements of the SAME m3e tag and exactly one **enum** attribute takes ≥2 distinct values across them, return the section from a `SECTION_HINTS` map (`variant`→"Variants", `size`→"Sizes", `shape`→"Shapes", `orientation`→"Orientation", else `pascalWords(attr)`); otherwise return `null` (unsectioned → elm-cem's default "Examples" group). Explicitly EXCLUDE boolean/identity attrs (`name`, `value`, `aria-label`, `href`, `id`) from the "varies" signal.

- [ ] **Step 1: Failing tests** — the button "five variants" HTML → `"Variants"`; a single-element example → `null`; icon-buttons varying only by `aria-label` → `null`.
- [ ] **Step 2: Run — FAIL.** **Step 3: Implement** `sections.mjs` (+ `SECTION_HINTS`). **Step 4: PASS.**
- [ ] **Step 5: Commit.** `git commit -m "feat(examples): section derivation from varying enum attribute"`

---

## Task 7: Category map

**Files:** Create `config/categories.json`.

A hand-authored map of PascalCase module → category, using Material-style buckets: **Actions** (Button, IconButton, Fab, SplitButton, ButtonGroup, SegmentedButton…), **Communication** (Badge, Snackbar, Tooltip, ProgressIndicator, LoadingIndicator, Skeleton…), **Containment** (Card, Dialog, BottomSheet, Divider, ExpansionPanel, ContentPane, SplitPane, Toolbar…), **Navigation** (AppBar, NavBar, NavRail, NavMenu, Breadcrumb, Tabs, Toc, Paginator, Stepper…), **Selection** (Checkbox, Radio, Switch, Slider, Chip, ChipSet…), **Text inputs** (Autocomplete, Select, Textarea, FormField, Datepicker, Calendar…), plus **Layout/Style** for the rest (Theme, Heading, Icon, Avatar, Shape, List…).

- [ ] **Step 1: Author `config/categories.json`** covering ALL 53 example-corpus components (cross-check keys against `Object.keys(examples.json).map(pascal)`; any component with no category defaults to "Other" and is logged). This is editorial — the exact taxonomy can be refined later; completeness (every component categorized) is what matters here.
- [ ] **Step 2: Commit.** `git add config/categories.json && git commit -m "feat(examples): component category map (docMeta.category source)"`

---

## Task 8: Orchestrator + full corpus run

**Files:** Create `m3e-docs/scripts/examples-to-elm.mjs`; generates `config/examples.generated.json` + a skip log.

Orchestrator: build the oracle; load `m3e-docs/data/examples.json` + `config/categories.json`; for each component slug → `pascal(slug)` module; for each example: convert every top-level sibling via `toElm` (an example that skips ANY element is skipped whole, with its title + reason appended to the skip log); wrap multi-sibling results as the example `code` (join siblings — for the generated example string, emit a `Layout`/list form consistent with what Plan 3 renders; v1: join sibling `code`s with `\n\n` and let the extractor treat each example as one snippet); derive `section`; assemble `{ examples: [{title, code, section}], docMeta: { category } }`. Write `config/examples.generated.json` (pretty-printed, stable key order) and print a coverage summary (`N examples converted, M skipped`) + write `config/examples.skipped.txt`.

- [ ] **Step 1: Implement `examples-to-elm.mjs`** using the lib modules.
- [ ] **Step 2: Run it.** `cd m3e-docs && node scripts/examples-to-elm.mjs`. Inspect `config/examples.generated.json` and the coverage summary; skim `config/examples.skipped.txt`. **No silent caps** — the skip log must list every dropped example with a reason.
- [ ] **Step 3: elm-format sanity on a sample.** Extract one generated `code` string into a scratch `.elm` `view` and run `docs/node_modules/.bin/elm-format --yes` on it to confirm the emitted Elm formats cleanly; if not, fix the mapper's rendering (spacing) and re-run.
- [ ] **Step 4: Commit** the generated artifacts + script. `git add m3e-docs/scripts/examples-to-elm.mjs config/examples.generated.json config/examples.skipped.txt && git commit -m "feat(examples): orchestrator + generated example config (full corpus)"`

---

## Task 9: Integration + the verification gate

**Files:** none new — regenerate `packages/m3e/src` and gate it.

- [ ] **Step 1: Regenerate the library with BOTH configs.**
```bash
cd /Users/jack/Documents/code/elm-m3e && \
  node elm-cem/bin/elm-cem.js --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json \
    --config-from=config/slots.json --config-from=config/examples.generated.json --output=packages/m3e/src
cd packages/m3e && npx --no-install elm make src/M3e.elm --output=/dev/null   # expect ~379 modules
```
- [ ] **Step 2: Confirm examples landed** — `grep -rl "elm-cem:example" packages/m3e/src/M3e/ | head` shows multiple component modules; spot-check `M3e/Button.elm` has a `### Variants` section with real `M3e.Button.view …` code.
- [ ] **Step 3: The gate — compilation is verification.** Run the docs reference extractor (which runs `elm make --docs`, the strict doc build): `cd docs && node scripts/extract-reference.mjs && echo REFERENCE_OK`. Expect `REFERENCE_OK`. THEN run the idiom gate: `cd docs && node_modules/.bin/elm-review --config ../review --compiler node_modules/.bin/elm`. Expect elm-review green (the generated example code must satisfy `ValidEnumValue`/`RequireSlot`/`SingularSlot`/`NoSeamOutsideAllowedModules`). **If elm-review flags a generated example**, that example used an invalid enum token / missing required slot / escape hatch → treat as a mapper bug: fix `to-elm.mjs`, re-run Tasks 8-9. This is the "examples can't lie AND are idiomatic" guarantee.
- [ ] **Step 4: Update the documented regen command.** Edit `HANDOFF.md` (the regen command, ~L57-60) to include `--config-from=config/examples.generated.json` alongside `config/slots.json`, and note that `config/examples.generated.json` is regenerated by `cd m3e-docs && node scripts/examples-to-elm.mjs`.
- [ ] **Step 5: Commit** the regenerated library + docs. `git add packages/m3e/src HANDOFF.md docs/data/reference.json && git commit -m "feat(examples): regenerate M3e with verified usage examples in doc comments"`

---

## Self-Review

**Spec coverage (design §Layer 2):** HTML→Elm converter (Tasks 2-5), CEM-driven oracle (Task 3), section deriver (Task 6), category/docMeta (Task 7), config population + multi-config plumbing (Tasks 1, 8), skip-and-log honesty valve (Tasks 4, 8), verified-against-real-API gate reusing elm-review (Task 9). Targets typed top-layer M3e (all mapper tasks). ✅

**Deferred to Plan 3 (not gaps):** rendering examples on the docs site (extractor → view modules, inline previews), categorized nav, the API-layer toggle.

**Known verify-against-reality points (compiler/tests catch these):** exact per-component content-helper names (Tasks 4/5 author goldens by reading the real modules); IconButton's default-slot vs required-record shape (Task 5 Step 1); where `ariaLabel` required field is sourced in slots.json (Task 3 Step 4); multi-sibling example rendering shape (Task 8 — coordinate with Plan 3). None silent: golden tests + elm-review gate fail loudly.

**Highest risk (per design):** converter special-cases. Mitigation: skip-and-log every unmapped construct (never emit wrong Elm), the elm-review gate rejects non-idiomatic output, and the skip log is committed so coverage is visible. The `gpu.internal` ornith fallback can later convert the skipped set (out of scope here).
