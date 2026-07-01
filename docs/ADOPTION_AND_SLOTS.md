# Adoption + the slot/DECL model — live design notes (2026-06-30)

> Resume point for the conversation after the generator mechanisms were finished.
> The generator is done and verified; this doc captures **what we decided next**:
> how the repo adopts the generated output, and the **explicit slot/DECL model**
> we're converging on. Pick up from §3 (the open slot questions).

## 1. Where we actually are (honest)

The **generator mechanisms** are complete and verified (three layers, `Value`
vocab, typed slots/containers, core-gen via `runtime/`, derived events, required
content + a11y, `Action`, variant-split folding). But **the elm-m3e repo still
ships the OLD hand-written `src/M3e/`** — the generated model only exists in
`scratchpad/` + `gen-sample/`. "Done" = the generator can produce it; **not** that
the repo has adopted it. Outstanding, agreed order:

1. **Slot/DECL model** (this doc, §2–3) — must be locked first; everything keys off it.
2. **Adopt** — swap generated output into `src/M3e`; migrate consumers.
3. **Config-authoring coverage** (~96 components) — the per-component domain work.
4. **Smaller DECL items** (§4).
5. **Housekeeping** (§5) — last.

## 2. Decisions locked this session

### Adoption via `ornith` (point 1) — agreed, depends on the model
Two parts: (a) **swap** generated output into `src/M3e` (mechanical file move, we
do it); (b) **migrate consumers** (docs app routes, the ~896 old-IR tests) from the
old API → new API — *that's* the rote refactor we'll hand to **ornith**. The ornith
prompt is explicit old→new transformation rules and **can't be written until the new
API is final**, i.e. after the slot model + config. So: **model → adopt+ornith.**

### First-run generates a complete, prunable DECL; skip if one exists (agreed)
On first run against a new library, emit a **complete default DECL** derived from the
CEM ("everything the middle layer allows"). The dev **narrows by deletion**. If a
DECL file already exists, **don't regenerate it** (a `bin/elm-cem.js` file-exists
check + write — not elm-codegen). This makes the DECL discoverable/prunable rather
than authored from scratch.

### Shape: required → record; optionals → list; elm-review sorts (agreed in principle)
- **Required** content/slots → the **first record** argument (required-only).
- **Optional** attrs **and** optional slots → combined; the generator routes each to
  attrs vs the right slot. **elm-review** sorts attrs-first, slots-last (honoring
  author order within each; opinionated attr-ordering is an allowed future option).
- *Caveat that reopened the design — see §3.*

### Smaller DECL items (point 3) — explained + agreed (see §4)
### Housekeeping (point 4) — agreed, do last (see §5)
### Snackbar (point 5) — agreed: **don't** build the JS/port hack
It undercuts the fully-derivative property. Leave Snackbar as its declarative node;
**PR `matraic/m3e`** to give `<m3e-snackbar>` a declarative `open` attribute so it
derives for free. Separate upstream contribution, not work in this package.

## 3. The slot model — OPEN, this is where we are

### The correction: I was wrong about "last-wins" for slots
I wrote *"a singular named slot gets one (Html last-wins if doubled)."* **That's
wrong.** `elm/html` last-wins applies to **attributes** (set `disabled` twice → last
wins). It does **not** apply to **slotted children**: every element with
`slot="trailing"` **renders, in order**. That's exactly the **AppBar trailing** case —
multiple trailing actions, all shown. So:

- **Slotted children accumulate; they do not collapse.** Multi-element named slots
  are a real, desirable pattern (AppBar trailing icons/actions).
- A genuinely **singular** slot (one icon) is **not** enforced by Html — if you put
  two, both render (broken). So cardinality must be **explicit**, not inferred from
  Html semantics.

### What "explicit" requires — per-slot axes
Each slot now carries, explicitly:
1. **name** — `""`/`default` for the unnamed slot; named otherwise.
2. **cardinality** — singular vs **multi** (the AppBar-trailing pattern). Proposed
   field: `multi: true` (default false). Default slot may be **`false`** = accepts no
   children (component has no default content).
3. **optionality** — `required` (→ record) vs optional (→ list).
4. **kinds** — the accepted-kind union. **`element` is implicitly allowed in every
   slot** (the escape). **`text` is an explicit kind** = a **user-provided** text
   element alias: slotted text needs a wrapper element, and the generator must **not**
   bake that wrapper opinion (it'd be wrong or break), so the **user supplies** the
   text element. (Connects to the earlier "Label = placeable-content alias" idea.)

### Proposed explicit DECL (for review — §3 is the open part)
```jsonc
"AppBar": {
  "slots": {
    "leading":  { "kinds": ["icon"] },                       // optional, singular; element implicit
    "trailing": { "kinds": ["icon","button"], "multi": true },// MULTIPLE — accumulates
    "default":  false                                          // no default children
  }
},
"TreeItem": {
  "slots": {
    "label": { "kinds": ["text"], "required": true },        // required singular; text = user wrapper
    "icon":  { "kinds": ["icon"] },                           // optional singular
    "default": { "kinds": ["treeItem"], "multi": true }      // default slot = list of treeItems
  }
}
```
Derived API shape (proposed):
- **required singular** → record field `label : Element { text, element } msg`.
- **required multi** → record field `List (Element kinds msg)` (rare).
- **optional (singular or multi)** + **default children** + **attrs** → the one
  optional list; the generator stamps `slot=` per item. **multi** accumulates; for an
  **optional-singular** slot the generator takes a **deterministic** one (documented),
  rather than relying on Html.

### The kind taxonomy (a slot's `kinds`) — four distinct things
Review 2026-06-30 surfaced that "empty kinds" was overloaded. The correct taxonomy:
- **specific kinds** (`["icon","text"]`) — the slot accepts those component kinds; the
  slot's phantom row is closed to them.
- **`any`** — the slot accepts **arbitrary** children by design (Card content, Dialog
  body, panel/prefix/suffix regions): its phantom row is **open to every kind**. Set
  when the element imposes NO restriction (no specific `::slotted` selector, no
  `querySelector` for a tag, no `instanceof` filter). **This was the big miss** — ~31
  open slots were wrongly authored as closed because `any` wasn't in the vocabulary.
- **`element` (implicit, never listed)** — the raw element/html **escape hatch** is
  available on *every* slot regardless; it's the type-escape, not the slot's intent.
- **`[]` empty (rare)** — genuinely no typed children; only when the element rejects
  element children. If a slot exists and is unrestricted, it's **`any`, not `[]`.**

`text`/`link` remain userland producers referenced as kinds. Corrected pass re-derives
with `any`; the pre-`any` state is checkpointed at `d20250b`.

### RESOLVED (see ADR 0011) — PLUS one part deferred
- **Q-card → advisory enforcement (decided); API shape (DEFERRED).** Cardinality is
  NOT type-enforced as `Maybe`/record fields (too noisy — TreeItem alone has 4 icon
  slots). Type level keeps **kind + capability** MISI (phantom rows); **cardinality +
  required-presence** are **generated elm-review rules + doc notes**; the IR is fully
  faithful. **BUT** the single-unified-list surface was **walked back** — not sold yet.
  For now: **required slots go in a required record**; the optional-slot arrangement
  (unified list vs separate list vs setters) is an **open follow-up** (see §7). The
  config authoring is shape-independent, so it proceeds regardless.
  **ADR [0011](adr/0011-ir-faithfulness-advisory-cardinality.md).**
- **Q-text/link → userland producers, NOT in the package.** `text` and `link` are
  userland functions returning `Element { text }` / `Element { link }` (the phantom is
  just a tag; any function with the right non-phantom shape slots in). Shipped as
  **copyable examples for repo-forkers**, not package modules — zero opinion baked into
  the binding. The package exposes the `element` escape + `Element` primitive so
  userland can stamp its own kinds. `link` (a slotted `<a>`) is distinct from the
  `Action` module (a component's own href/onClick).
- **Q-schema → confirmed** `kinds` / `multi` / `required`; a `default` entry is present
  only when an unnamed slot exists (its absence = no default children).

## 4. Smaller DECL items (agreed; all config-driven, no new core)
- **R12 typed-arg overrides** — Icon `weight` (`W100…W700`), Heading `level` (1–6),
  Icon glyph `name`, Theme `scheme`: `"typedArgs": { "weight": "weight" }` → typed setter.
- **R13 surface curation** — skip non-public attrs (form read-back,
  `disabledInteractive`): `"skip": [...]`.
- **R-EXTRA** — semantic renames (`min`/`max`, `forId`); static-attr injection
  (`role=group` on ChipSet); auto-`id` (slugify label for form-field/Select).
- **`detail.x` events** — payload in `event.detail.X` (Paginator `pageIndex`):
  `"events": { "page": { "detail": "pageIndex", "type": "Int" } }`.
- **More variant-split groups** — Fab/ExtendedFab etc. via existing `group` config.

## 5. Housekeeping (last)
Regen-on-release pipeline; delete the `./elm-cem` clone (push upstream first); the
config-free other libraries (Shoelace/Fluent/Calcite/Web-Awesome/Warp).

## 7. Follow-up: the optional-slot / options API shape (OPEN)

Deferred by decision — we are **not** committing to how optional attributes and
optional slots are passed. Candidates to weigh later:
- **One unified list** `name [ attrs ∪ slots ]` (the walked-back sketch) — uniform,
  terse, but mixes concerns and can't type-pin optional-singular arity.
- **Required record + separate optional slot list** (attrs list distinct from slots).
- **Required record + per-slot setters** returning options.
- Something else. Decide against real call-sites (Button, TreeItem, AppBar, Tabs) with
  the icon-heavy cases (TreeItem's 4 icon slots) as the ergonomics stress test.
Constant across all candidates: required slots → a required record; kind/capability
MISI at the type level; cardinality/required-presence via elm-review + docs;
per-slot `kinds`/`multi`/`required` config. Tracked: **elm-m3e#77** (to be filed).

## 8. Escapes & extensibility gradient (2026-06-30 decisions)

Four decisions on how open the system is, and how you escape it:

### `any` = the universal/open row; permissive default you trim
- **Representation:** a slot with `any` accepts an `Element` of **any kind** — in Elm, a
  **polymorphic/open row** (setter takes `Element k msg`, `k` free). Expose a nameable
  **alias** for it so `any` slots read clearly (e.g. `M3e.Kind.Any` / an `anyChild`
  producer), rather than an anonymous open var.
- **Generation model (confirmed):** the process should emit the **FULL permissive
  schema — every composition enabled — and the author removes what they don't want to
  support.** Clearer than authoring restrictions from nothing; the investigated config
  is that trim already applied from code-evidence. (Same principle as the first-run
  prunable DECL.) Config sugar: `"any"` = "all kinds".
- **Consulting m3e-docs confirmed** the permissive lean (Card "custom layouts", Avatar
  img/icon/text). The config process to date read only **CSS/JS** (code inference);
  **m3e-docs (Material spec/guidelines) is a richer INTENT source** and a good input for
  a future cross-check pass. Codegen means being wrong is cheap — fix and regen.

### Native-HTML IR (extends [ADR 10](adr/0010-hand-zero-native-ir.md))
Ship **native-HTML IR producers beyond form controls** — prose/inline elements
(`p`, `strong`, `span`, `em`, `a`, `img`, `ul`/`li`, …) as first-class IR `Element`s so
teams get normal HTML functionality **inside** our composition. Rationale: if we don't,
teams roll their own; better to provide it. Teams wanting design-system purity opt into
an **elm-review** rule that discourages/corrects native usage — so the guardrail is
opt-in, not baked in. Native elements carry the implicit escape kind, so they slot in
anywhere (and specifically anywhere `any`).

### `stripPhantom` — the auditable escape valve
Provide `stripPhantom : Element a msg -> Element b msg` (coerces the phantom kind row)
for when a consumer believes the design system is wrong and needs to compose something
it forbids. It's **loud and greppable** — the design-system team **audits `stripPhantom`
usages** and either fixes the app's misuse or fixes the codegen'd package (a feedback
signal, not just a hole). This is the pressure-release that keeps the phantom rows strict
without trapping users.

### Proven (scratch compile, 2026-06-30 — Elm 0.19.1, over the real runtime core)
```elm
-- producers (OPEN rows), canonized via Seam, no suppression:
text : String -> Element { k | text : Supported } msg
link : String -> List (Element s msg) -> Element { k | link : Supported } msg
Seam.asElement  : Node msg -> Element supported msg          -- DS files: build+stamp a kind
Seam.asAttribute : Html.Attribute msg -> Attr capability msg

-- native-HTML IR (carry the `html` kind → fit `any`, or a specific slot via EscapeHatch):
M3e.Html.p : List (Attr c msg) -> List (Element s msg) -> Element { k | html : Supported } msg

-- slot consumers:
iconSlot : Element { icon : Supported } msg -> …   -- CLOSED: rejects text/html/link
anySlot  : Element any msg -> …                    -- `any` = a lowercase TYPE VARIABLE; accepts everything

-- break-glass (any file, audited):
EscapeHatch.asElement : Element a msg -> Element b msg     -- coerce phantom (stripPhantom)
EscapeHatch.fromHtml  : Html msg -> Element supported msg
```
Verified: `anySlot` accepts text/icon/link/native-`p`; `iconSlot (text …)` and
`iconSlot (H.p …)` **fail** to compile; `iconSlot (EscapeHatch.asElement (text …))`
compiles. So `any` needs **no alias** — it's just a type var — and the producer-open /
consumer-closed rule holds. Scratch: `scratchpad/proto/`.

### Kind universe (updated)
> **{ CEM component kinds } ∪ { `any` = open row } ∪ { native-HTML IR } ∪ { userland
> producers: `text`, `link`, … }**, with `element`/html escape implicit everywhere and
> `stripPhantom` as the explicit, audited override.

## 6. Hard constraints (unchanged)
elm-cem stays separate + m3e-agnostic (no merge); prerelease, breaking changes fine;
**do not publish**; three phantom rows mandatory on public return types; single-source
every string; add-only composition; docs/examples refactor reserved for ornith.
