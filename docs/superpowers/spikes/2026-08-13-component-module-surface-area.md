# Spike — elm-cem → elm-m3e component-module surface area

**Date:** 2026-08-13
**Question owner:** Jack
**Repos (read-only):** `elm-cem` (generator), `elm-m3e` (output + config)
**Prototyping:** none needed — see TL;DR (Q4 turned out moot).

---

## TL;DR — verdict

- **Is Jack "off base"?** Partly. The mental model of "130 modules out of ~205 components, so ~75 are module-less" is an **overcount artifact**, not a real gap. There are **130 real components and 130 modules — a perfect 1:1**. The 205 is the *barrel-function* count, which mixes 130 constructors + 57 `slot*` placers + 18 utilities. There is **no module-less set of user-facing components to close.**

- **Does the naming convention require "a module for every element"?** It already has one. Every constructible `@m3e/web` element has a `M3e.Component.X` module today. The `import M3e.Component.Button as Button exposing (Button, button)` goal needs a **rename inside existing modules** (`view` → per-component ctor name, `el` → `component`), **not** new module generation.

- **Is "expand to all-modules" safe or costly?** **N/A — there is nothing to expand.** The only elements without a module are 5 *abstract base classes* (`ActionElementBase`, etc.) that are not registered custom elements and cannot be constructed by anyone. Emitting modules for them would be actively wrong (they have no tagName). So the cost question dissolves: current surface == complete surface.

- **`component` name-safe?** **Yes.** No top-level `component` value, no `component` attribute/slot/member on any element, no `component` in the barrel. The only textual hits are (a) prose in an M3e.elm doc comment and (b) a `component =` *record field* in `src/M3e/Review/Facts.elm` — neither is a top-level name, neither collides.

- **Recommendation:** **Keep the 130-module status quo; do the `el` → `component` (and `view` → `<ctor>`) rename at the generator level.** Do NOT chase an "all-elements" expansion — it does not exist as a real gap.

---

## Q1 — Module-generation criterion (the real gate)

The premise ("it is NOT 'has required arguments'") is correct — view-only components get modules. The real gate is a four-stage pipeline; no single stage is "the" criterion, so here is the whole chain in order:

### Stage 1 (JS, runs first): `bin/elm-cem.js` `reconcileTagNames`
Repairs a **corrupt `tagName` in the shipped @m3e/web manifest** before Elm sees it. From the code comment (`bin/elm-cem.js:253-269`):

> `M3eStepperNextElement.tagName` is `"m3e-stepper-previous"` and `M3eFabMenuItemElement.tagName` is `"m3e-menu-item"` … the corrupt tags make StepperNext get merged into StepperPrevious … those two modules are never emitted.

It overwrites each class declaration's `tagName` with the authoritative `custom-element-definition` export name. **Without this pass, elm-m3e would have 128 modules, not 130.**

### Stage 2 (Elm): `codegen/Generate/Config.elm` `extractComponents`
```elm
extractComponents exclude manifest =
    manifest.modules
        |> List.concatMap .declarations
        |> List.filter (\decl -> decl.customElement == Just True)   -- the gate
        |> List.filter (\decl -> not (List.member decl.name exclude))  -- the denylist
        |> mergeComponentsByTagName
        |> List.map dropNamelessMembers
        |> normalizeAttrTypes
```
The gate is **`customElement == Just True`** (keyed on the class **name**, e.g. `M3eButtonElement`, not the tagName), **minus an explicit `_exclude` denylist.**

### Stage 3 (Elm): `codegen/Generate/Normalize.elm` `mergeComponentsByTagName`
Merges declarations sharing **both** tagName and name (true duplicate re-listings). Distinct declarations sharing a tag survive (the R2 `source`/`pictureSource` split mechanism). tagName-less declarations are **kept**, not dropped, at this stage.

### Stage 4 (Elm): `codegen/Generate/Phantom/Emit.elm` `homeOf` → `own`
```elm
homeOf comp =
    case comp.home of
        Just h -> Just h
        Nothing ->
            if comp.transparent || comp.roles /= Nothing then Just comp.name
            else Nothing
```
`own = brand.comps |> List.filter (\c -> homeOf c == Nothing)` — and **only `own` comps get `[internalTypesModule, compModule, compBuildModule]`** (`Emit.elm:112`). Comps with a `home`/`transparent`/`roles` go into a shared `homeModule` (native/aria families) with `view` only, no own module.

**Crucially, for the @m3e/web brand, NO config sets `home`, `transparent`, or `roles`** (verified: `grep -rln '"home"|"transparent"|"roles"'` across `elm-m3e/config/*.json` and `elm-cem/config,cem-configs` → zero hits except unrelated `icons-catalog.json`). So `homeOf` returns `Nothing` for **every** comp → **every surviving comp gets its own module.** The `home`/`transparent`/`roles` routing is a *native-family* feature that is entirely inert here.

### What is SKIPPED, and why
Only the **`_exclude` denylist** in `config/slots.json` (`slots.json:30-36`):
```json
"_exclude": [
  "ActionElementBase",
  "MenuItemElementBase",
  "ProgressElementIndicatorBase",
  "TooltipElementBase",
  "TimepickerInputElementBase"
]
```
These 5 are `customElement:true` **abstract base classes with `tagName: null`** — real Lit base classes that other components extend but that are never `customElements.define()`d, so they cannot be constructed. Excluding them is correct.

**Net gate:** *concrete registered custom element* (`customElement:true` AND has/gets a tagName) AND *not in `_exclude`*.

---

## Q2 — The element universe (the counts reconciled)

**Authoritative manifest:** `docs/node_modules/@m3e/web/dist/custom-elements.json` (from `package.json` `gen:src`: `--flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json`). 2.78 MB.

Raw counts (all from commands run against the manifest):

| Measure | Count | Command / note |
|---|---|---|
| `customElement: true` declarations | **135** | `grep -c '"customElement": true'` |
| …of which have **no** tagName (abstract bases) | **5** | Python walk of declarations |
| …with a tagName | **130** | 135 − 5 |
| distinct tagNames (naive) | **129** | duplicate `m3e-stepper-previous` collapses one |
| **modules generated** | **130** | `ls src/M3e/Component/*.elm | wc -l` |

**The 5 no-tagName custom elements** (the ONLY module-less "elements", all in `_exclude`):
```
ActionElementBase
TooltipElementBase
MenuItemElementBase
ProgressElementIndicatorBase
TimepickerInputElementBase
```
All `customElement:true, tagName:null, kind:class` — abstract, un-constructible.

**The 129-vs-130 discrepancy:** the manifest is buggy — `M3eStepperNextElement` ships with `tagName: "m3e-stepper-previous"` (a duplicate of its sibling). Stage-1 `reconcileTagNames` repairs it to `m3e-stepper-next`, so StepperNext and StepperPrevious both get modules → 130. The naive `sort -u | wc -l` = 129 hides this real component. Confirmed: the only file-module absent from the naive tag set is `StepperNext`.

### Reconciling 205 barrel vs 130 modules
The barrel (`src/M3e.elm` `exposing`) has **205 lowercase functions**, broken down (parsed from the exposing block):

| Barrel section | Count |
|---|---|
| Component constructors | **130** |
| `slot*` placers (`slotIcon`, `slotLeading`, …) | 57 |
| Utilities (`text`, `toHtml`, `mapMsg`, `key`, `lazy`…`lazy8`, `addClass`, `attrIf`, `when`, `testId`, `mapNode`) | 18 |
| **Total lowercase** | **205** |

(+3 uppercase re-exports: `Element`, `Attr`, `Node`.)

**So 205 is an overcount of "components."** The true component count is **130**, matching the module count exactly. There is **no genuine ~75 module-less set** — that number was `57 slots + 18 utils`.

**True counts:**
- True component count: **130**
- Module count: **130**
- Module-less **components**: **0**
- Module-less **elements**: **5** (abstract base classes, non-constructible, correctly excluded)

---

## Q3 — Does Jack's naming goal require every element to have a module?

**Goal:** `import M3e.Component.Button as Button exposing (Button, button)` — `view` renamed to the lowercased component name (`button`), `el` renamed to `component` (keeps the `required` attr, avoids a slots.json rename).

**Answer: the goal is already fully satisfiable with the existing 130 modules.** Every element a user can construct standalone *already has* a module. The rename is purely cosmetic inside those modules:

- Today (`src/M3e/Component/Button.elm`): exposes `view` (standard ctor) + `el` (required-content ctor). Only 29 of 130 modules expose `el` (those with required content/action): `Accordion AssistChip Breadcrumb Button Chip ExpansionPanel Fab FilterChip Heading IconButton InputChip NavMenuItem Option RadioGroup RichTooltip RichTooltipAction SearchBar SearchView SegmentedButton Select Slider Snackbar SplitButton SplitPane Step SuggestionChip TocItem Tooltip TreeItem`.
- Jack's target: `view` → `button` (per-module ctor name), `el` → `component`.

The 5 module-less elements are **abstract base classes** — a user would **never** `import M3e.Component.ActionElementBase`. They are not slotted children either; they are Lit implementation base classes. So the "module-less gap" is entirely irrelevant to the convention.

Note on genuinely-slotted children: elements like `m3e-option`, `m3e-tab`, `m3e-menu-item`, `m3e-step` **do** get their own modules today (Option, Tab, MenuItem, Step all exist in `src/M3e/Component/`). elm-m3e does **not** withhold modules from slotted-only children — the slot-admittance constraint is enforced separately by `Cem.ValidSlotKind` (elm-review), not by omitting the module. So the convention is uniform across all 130.

**Conclusion: the convention needs zero new modules.** It needs the `view`/`el` rename only.

---

## Q4 — Cost of "a module for EVERY element"

**Moot.** Q2 establishes there is no real module-less set of user-facing components. The only elements without a module are the 5 abstract base classes, and emitting modules for them is impossible/wrong (no tagName → nothing to construct, no `customElements.define`). There is no "double the surface area" scenario — 130 already IS 100% of the constructible universe.

No prototype worktree was created because there was nothing to expand-to. (Had a real gap existed, the plan would have been: flip `_exclude` to empty in a throwaway worktree, `gen:src`, then measure module count / LOC delta / `elm make src/M3e.elm` / `build:site` bundle. Not run, because the input premise — a module-less user-facing set — does not hold.)

**Verdict: non-issue. There is no cost because there is no expansion to perform.**

(For completeness on the theoretical @m3e/web ~1800-element upgrade gate the docs defer: that is a *runtime custom-element registration* concern in the browser bundle, entirely orthogonal to how many Elm modules the library exposes. Elm module count does not touch it.)

---

## Q5 — `component` name safety

`component` (the proposed `el` rename) collides with **nothing**. Verified:

- **Barrel:** no top-level `component` in `src/M3e.elm` exposing list. The only textual hit is prose inside a `{-| … -}` doc comment ("every component constructor…"). Not a name.
- **Component modules:** `grep -rn "^component " src/M3e/Component/*.elm` → 0 top-level `component` definitions.
- **Manifest attrs/slots/members:** Python walk of every declaration's `attributes`, `slots`, `members` for `name == "component"` → **NONE**.
- **Facts registry:** `src/M3e/Review/Facts.elm` contains `component =` — but this is a **record field label** inside the per-component facts record (`{ component = "button", module_ = ..., enums = ... }`), emitted at `Emit.elm:6090`. A record field is not a top-level value and does not collide with a module-level `component` function.

**`component`-name-safe: YES.**

---

## Recommendation

**Keep the 130-module status quo. Perform the `el` → `component` rename (and `view` → per-component ctor name) at the generator level.**

### Where the rename lands (generator-side, regenerable)
The names `"view"` and `"el"` are **hardcoded string literals** in `codegen/Generate/Phantom/Emit.elm` (lines ~685-687, ~753-755, ~2787-2789). Changing them there and running `npm run gen:src` re-emits all 130 modules uniformly. This is exactly the kind of change the pipeline is built for — no per-component edits, no slots.json churn (the `required` attr stays as-is under the `el`→`component` plan, which is why Jack picked it).

### Tradeoffs

| Option | Pros | Cons |
|---|---|---|
| **Keep 130 + `el`→`component` (recommended)** | Convention goal met; uniform; regenerable; no slots.json rename; `component` collision-free | `view`→`<ctor>` means the general-barrel ctor name and the per-module ctor name become the same word (`button` in both `M3e` and `M3e.Component.Button`) — intended by Jack, reads naturally with `as Button` |
| Expand to all-elements | — | Not possible/meaningful: the only non-modules are un-constructible abstract bases |
| Do nothing (`view`/`el`) | Zero work | Misses the natural-reading `Button.button` / `Button.component` goal |

### One caveat to sanity-check during the rename
`view` → per-component ctor collapses two names to one *within a module* only if the module also exposed the ctor separately — it does not (modules expose `view`/`el`, the ctor name lives in the barrel). So `M3e.Component.Button` would expose `button` (was `view`) + `component` (was `el`). Confirm the generator's fail-loud exposing-collision guard (`Emit.elm` `runGuard`) stays green after the rename — it checks for duplicate exposed identifiers per module, and `button`/`component` are distinct, so it should pass. Regenerate and let the guard + `elm make` confirm.

---

## Evidence appendix — commands run

```
# ground truth (elm-m3e main)
ls src/M3e/Component/*.elm | wc -l                 → 130
ls src/M3e/Build/*.elm | wc -l                     → 130
grep -l "^view " src/M3e/Component/*.elm | wc -l   → 130
grep -l "^el "   src/M3e/Component/*.elm | wc -l   → 29

# manifest universe
grep -c '"customElement": true' <manifest>         → 135
# python walk: 5 have tagName:null (abstract bases), 130 have a tagName
# duplicate tagName m3e-stepper-previous (StepperNext mislabeled) → naive distinct = 129
# reconcileTagNames (bin/elm-cem.js) repairs it → 130 modules

# barrel reconciliation (parse src/M3e.elm exposing)
lowercase exposed = 205 = 130 ctors + 57 slot* + 18 utils

# gate (elm-cem)
Config.elm extractComponents: customElement==Just True, minus _exclude
slots.json _exclude = [5 *ElementBase abstract classes]
NO home/transparent/roles set for @m3e/web → every comp gets own module

# component name safety
grep "^component " src/M3e/**/*.elm                → 0 top-level defs
manifest attrs/slots/members named "component"     → NONE
src/M3e/Review/Facts.elm "component =" is a record FIELD, not a value
```
