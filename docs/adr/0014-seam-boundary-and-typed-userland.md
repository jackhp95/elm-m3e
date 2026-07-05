# 14. Config-declared semantic seams, a single opaque-IR boundary, and typed native HTML

Date: 2026-07-05

## Status

Proposed (awaiting review). Builds on [ADR 6](0006-m3e-architecture.md) (typed
slots), [ADR 8](0008-three-layer-generator-retarget.md) (three-layer emitter),
[ADR 9](0009-composition-over-injection.md) (composition over injection),
[ADR 12](0012-codegen-aware-elm-review.md) (codegen-aware review), and
[ADR 13](0013-top-shape-matrix-and-translation.md) (surface translation).

**Supersedes** [ADR 10](0010-hand-zero-native-ir.md)'s treatment of text/label as
a *loose type alias* (`Element { s | element : Supported }` with `M3e.text` as a
default constructor and "no governance newtype/module") and its use of `element`
as a universal placeable kind. **Extends** ADR 10's native-HTML IR. Keeps ADR 10's
`for=id`/`id=id` wiring and `Hand = ∅` (userland seams are *userland*, not library
hand-code).

## Context

ADR 10 decided that text/label are just constructors of a loosely-typed
placeable `Element { s | element : Supported }`, deliberately *without*
governance. Real use broke that in two ways:

1. **The `element` kind fits nothing.** Every producer stamps a kind, and slots
   accept a closed set of kinds — a component stamps its own noun
   (`M3e.Button.view -> Element { s | button : Supported }`), and a text slot
   accepts `{ text, icon }`. But `M3e.Element.text` stamps `element`, and **no
   generated slot accepts `element`** (verified: zero components list it). So the
   canonical-looking text producer works in *no* kinded slot — you must reach for
   `Kit.text` in a separate copyable package. That is issue #97, and it is a
   symptom, not the disease.

2. **Text is not the library's to define.** A team whose "text" is an
   i18n-key web component resolving to the user's language — with span-wrapping so
   it can carry a `slot=` attribute — cannot be served by a hard-coded
   `Node.text`. `text`/`link`/`label` are **seams**: points where generated
   structure meets team-specific composition. Loosening them into a fixed alias
   *removes* the team's ability to give their own coupler a precise type, which is
   the opposite of the goal.

Separately, the opaque IR's boundary leaks. `M3e.Element` currently exposes
`fromNode`/`toNode` publicly, so **any** module can mint an `Element` from a raw
node and freely assert any phantom row. Two near-duplicate userland escape
modules (`Seam`, `EscapeHatch`, issue #81) and the scattered `any`-row /
native-IR / `stripPhantom` surface (issue #78) are the visible symptoms of an
unbounded escape.

The governing goal is: **extend the phantom-typed guarantees the generated code
enjoys to userland code**, and keep the escape *centralized and reviewable* —
without opinionating what teams build. And a posture goal (from the config
philosophy): a freshly-generated CEM should default **maximally permissive** (top
layer ≈ middle layer, everything composes) so teams **subtract** invalid
compositions rather than opt into valid ones.

## Decision

### 1. Semantic seams are config-declared, generator-typed, userland-crafted

Config (`config/slots.json`, a `_seams` block — library-agnostic) declares the
seams and the kind each produces:

```jsonc
"_seams": {
  "text":  { "kind": "text",  "wrap": "span" },   // slottable text; span-wraps to carry slot=
  "link":  { "kind": "link",  "tag": "a" },
  "label": { "kind": "label", "tag": "label" }
}
```

The generator emits, per seam, three rungs of one ladder — a **contract type**, a
**stamper**, and leaves the **team's coupler** as the userland body:

```elm
type alias Text s msg = Element { s | text : Supported } msg   -- (1) named contract (public)
text : Node msg -> Text s msg                                  -- (2) stamper (Internal — see §2)
```
```elm
-- (3) userland (the team's designated Seam module) — gets the SAME phantom typing
t : TranslationKey -> M3e.Seam.Text s msg
t = renderInUserLang >> M3e.Seam.text
```

The library never defines *what* text is; it defines the *typed hole* and the
team fills it. `Kit.text` stops being a privileged separate producer.

### 2. The opaque IR crosses raw↔phantom only through `Internal` modules — reachable in userland solely from Seam

This is the root-cause fix for the leak, made **structural** (not lint-only) via
Elm's own module exposure. The opaque type + every phantom-asserting op live in
an `Internal` module; the public module re-exposes only the safe subset:

```elm
module M3e.Element.Internal exposing (Element(..), fromNode, toNode, stripPhantom, map)
type Element supported msg = El (Node msg)
fromNode = El                                    -- the free phantom assertion

module M3e.Element exposing (Element, map)       -- safe public surface
import M3e.Element.Internal as I
type alias Element supported msg = I.Element supported msg   -- opaque (no (..))
map = I.map
```

`M3e.Element.Internal` is imported **only** by generated `M3e.*` code and the
team's `Seam` module. A userland module doing `import M3e.Element` has no
`fromNode` in scope — it *cannot* construct an `Element` from raw. The escape's
raw rung lives *inside the fence*, reachable only in Seam. Crossings split by
direction and danger:

| crossing | can it lie? | public form | Internal / Seam-only |
|---|---|---|---|
| `fromNode`, `fromHtml`/`raw`, `asAttribute`, raw `Content.slot`, `stripPhantom`, the seam **stampers** | **yes** — free assertion | **no** | **yes** — the residue target, review-caught |
| `toHtml`, `toNode`, `toAttribute` (extract) | no | **yes** — clean conversions + app render | reachable in Seam |
| typed construction (components, native ctors), `map`/`fold`, contract types | no | **yes** | n/a |

"Mapping and folding is fine per module" — they never cross; they stay public.

### 3. Typed native/HTML IR — config opt-in, HTML-natural attribute typing

Native constructors are a **public typed facade** (they can't lie: the kind
follows the tag, attrs follow HTML) *implemented with* the Internal crossings:

```jsonc
"_native": { "emit": ["a","label","input","textarea","select","span","div"],
             "semantics": { "a": "link", "label": "label" } }   // these stamp a semantic kind
```
```elm
a   : List (Attr { c | href : Supported, target : Supported } msg) -> List (Element s msg) -> Element { k | link : Supported } msg
div : List (Attr c msg) -> List (Element s msg) -> Element any msg
```

Attributes are constrained by **HTML's natural typing** — a built-in table the
generator ships (`href`→anchors, `for`→label/output, …), config-adjustable — so
`M3e.Native.div [ href "x" ] []` is a compile error. Userland native composition
gets the same MISI safety as generated components.

### 4. The public↔Seam axis *is* the translator's clean↔residue axis

The `TranslateToX` rules ([ADR 13](0013-top-shape-matrix-and-translation.md))
produce exactly two outcomes, mapped one-to-one onto the two exposures:

- **allowed conversion** → emit the **public** crossing (`M3e.Element.toHtml`,
  typed constructors). Compiles, no flag.
- **failed/lossy conversion** → emit the **Seam** crossing
  (`Seam.asAttribute (…)`). Compiles, and `NoSeamOutsideAllowedModules` catches
  it → the developer sees exactly which residue didn't convert.

Both exposures are therefore load-bearing, not redundant. The dangerous in-bound
assertions have **no public form** and that costs the translator nothing — a
clean conversion never asserts freely (it uses typed construction); it only
reaches for a Seam assertion when giving up on expressing something, which is
exactly when it should be flagged. The safe out-bound extractions and render are
public because clean conversions and the app root need them, with no lie to
govern. (This is why the public render exit `M3e.Element.toHtml` must be a
first-class import target — the D6 emitter already emits it for clean Element→Html
conversions.)

### 5. Governance is structural; elm-review is a coarse backstop

- **Primary fence (structural):** the Internal split — userland can't import
  `*.Internal`, so it can't cross the boundary outside Seam.
- **Backstop rule:** *no `import *.Internal` outside generated `M3e.*` + the
  allowed Seam module(s)* — a one-line import ban, airtight, no type inference.
- **Coupler locality (optional):** *a top-level function whose return type is a
  seam contract, defined outside the allowed module → flag.* Keys on the produced
  **type**, so it catches a coupler however it was built. This is the tight,
  rung-agnostic rule; the older "no `M3e.Seam.*` calls outside Seam" is a weaker
  subset kept only as a cheap nudge.
- **Un-caged floor by design:** a one-off, inline, un-annotated crossing at a
  call site is a *local escape*, not reusable system growth — deliberately not
  policed, with the by-return-type rule available if a team wants even that caged.
  *Even the governance is subtractive.*

### 6. Subtractive, zero-opinionation config posture

Design-system constraints (slot-kinds, which seams/natives exist) default
**permissive** (top ≈ middle; teams narrow by editing config). HTML-natural attr
typing is the one *restrictive* default — universal truth, not opinion — shipped
correct and adjustable. *(Generating the permissive starter config from a fresh
CEM — config scaffolding/init — is a **sibling epic**, not this ADR.)*

## Consequences

- **Absorbs** #97 (text is a governed seam, not a broken alias), #2 (typed native
  IR as the public facade over Internal crossings), #78 (`any`-row / native-IR /
  `stripPhantom` = the Internal boundary surface), #81 (one Seam boundary; a
  second crossing module is the anti-pattern this forbids).
- **Reframes** #114 (TextField = native `input` + `for=id` wiring + a Seam
  coupler — composition, not a new generated component) and #121 (IconButton
  content becomes a slot/seam, consistent with the model).
- **Supersedes** ADR 10's loose text/label alias and `element`-as-placeable-kind.
  `element` is retired as a slot kind; `text`/`link`/`label` become reserved seam
  kinds declared in config.
- **`Hand = ∅` holds and sharpens:** the library still ships zero hand-written
  *component* modules; seam *couplers* are userland (a team's system), which is
  precisely where hand-craft belongs — now with generated typed contracts so that
  craft is as safe as the generated code.
- **Cost:** an `Internal`-module split across the IR core runtime templates, and
  a native attr→element table in the generator. Both one-time; prerelease.

## Open questions (to settle in review)

1. **Seam stamper signature** — `Node msg -> Text s msg` as above, or should the
   stamper accept `Element any msg` (so a team can feed already-composed IR, not
   just a `Node`)? The latter is more composable; the former is the minimal hole.
2. **`Content.slot` confinement** — the raw slot-assertion is Internal; generated
   per-slot setters are the public form. Confirm no public path mints an arbitrary
   slot row.
3. **Module naming** — generated contract types + native facade under
   `M3e.Native` / `M3e.Seam` (generated) vs the *userland* `Seam` module. Resolve
   the `Seam` name collision (e.g. generated `M3e.Seam.Contract` vs userland
   `Seam`).
4. **Native attr→element table** — ship as a data file the generator reads
   (config-overridable) vs. hard-coded with a config override hook.
5. **Render exit** — public `M3e.Element.toHtml` **and** a `Seam.render` alias
   (per §4, both); confirm the public one is the app-root default.
