# elm-cem generator requirements — extracted from the elm-m3e hand layer

> Derived 2026-06-29 by auditing all ~74 hand-written `src/M3e/*.elm` wrappers
> against their naive codegen counterparts in `vendor/elm-m3e/Cem/M3e/*.elm`.
> The hand layer is the worked example of "what the generator should emit"; every
> way it deviates from naive codegen is a generator requirement. This is the input
> spec for the elm-cem retarget (`jackhp95/elm-cem#1`).

## Method

For each component: diff the hand wrapper (the API we want) against the naive
CEM-generated module (what the generator produces today), classify every deviation
by which generator capability would absorb it, and tag reducibility:

- **MECH** — generator can produce it from CEM alone.
- **DECL** — needs a declarative external-input file (slots map + per-component overrides). Never imperative function-body injection.
- **HAND** — irreducibly hand-owned; no reasonable declarative input captures it.

## Headline conclusion (the "capture it entirely" number)

**Capture ceiling ≈ 80%.** Of ~74 components, roughly **55–60 are fully reducible**
(MECH + DECL) and **~14 carry an irreducibly hand-owned aspect**. So the honest goal
is *"the generator owns the mechanical+declarative majority; a small hand-owned set
remains for genuinely imperative / multi-native-element / cross-component cases."*
"Eliminate the hand layer" → realistically "shrink it from ~74 modules to ~14, and
make those 14 the only thing anyone hand-writes."

The irreducible ~14 (see R-HAND below): Calendar, DatePicker (JS-Date decode),
Snackbar (imperative open), SplitButton (cross-component composition), Field,
TextField, Select, TimePicker (form-field + native-element compositions),
BottomSheet (action injection), RadioButton (slotless-radio label wrap), Search
(inner input), Slider (auto-thumb), plus the no-element modules Text / Theme-helpers
/ Label / StepperNext.

---

## Universal requirement

### R0 — Emit the Node/Attr IR + the `{required} → [optional] → Element` shape
- **MECH. Every component.** Naive returns `Html.Html msg` from `component`; the hand layer returns `Element { s | tag : Supported } msg` built from the `M3e.Node` IR, with a `view : { required } -> List (Option msg) -> Element …` signature and an `Internal.Option` config endomorphism.
- This is the reversed IR-emission decision and the shape generalization. The Button/Heading anomaly (R2) falls out of it for free.
- **Shape exceptions to support:** thin content-only elements (`StepperNext/Previous/Reset`: `List content -> Element`) and attribute-less elements (`ContentPane`, `TextOverflow`, `DatePickerToggle`: no `List (Option msg)` param at all because CEM declares no attrs). The generator must emit the degenerate shapes, not force `[opt]` when there are no options.

---

## Mechanical requirements (generator owns outright)

### R1 — Correct DOM property emission (camelCase keys, typed encoding, reset semantics)
- **MECH. Pervasive.** This is elm-cem#1 item (a), and the audit shows it is **still not fully fixed in the vendored layer** — the hand layer is currently the only thing making these correct. Sub-rules:
  - **camelCase property keys** from CEM `fieldName`, not kebab `name`. Naive codegen still emits kebab in: `no-animate` (Collapsible), `hide-toggle` (ExpansionPanel), `inset-start`/`inset-end` (Divider), `fit-anchor-width`/`anchor-offset` (FloatingPanel, OptionPanel), `page-index`/`show-first-last-buttons`/`hide-page-size` (Paginator), `selected-index` (Slide), `hide-selection-indicator` (SelectionList), `min-rows`/`max-rows` (TextareaAutosize), `case-sensitive` (TextHighlight), `strong-focus` (Theme), `hide-delay`/`show-delay` (Tooltip), `max-depth` (Toc), `disable-restore-focus` (RichTooltipAction), `disable-close` (Dialog). **→ Action: confirm #69's actual coverage; it appears incomplete.**
  - **`selected`/`checked` as real DOM properties** (`Node.property … (Encode.bool …)`), not naive's `Html.Attributes.selected`/`checked` (HTML attributes / string-properties that web components ignore). Affected: Button, IconButton, NavItem, Radio, ListOption, Step, Tab, ButtonSegment, MenuItemCheckbox.
  - **Numeric properties as numbers**, not strings: Paginator `length` (Int, not Float-as-string), Progress `value` (Float), Slider/SliderThumb `value` (Float), Slide `selectedIndex` (Int). Naive uses `Html.Attributes.value` (string).
  - **Boolean reset**: emit boolean properties unconditionally (so re-render resets to `false`), per elm-m3e#59.
  - **Known codegen bug**: `Cem.M3e.StepPanel.actionsSlot` emits `slot="actions-"` (trailing dash). Generator slot-attr emission is buggy.
  - **Encoding divergence to resolve**: Icon `opticalSize` — hand uses `attribute` + Int; CEM uses `property` + Float. Pick the DOM-correct one.

### R3 — Shared `M3e.Value` token vocabulary
- **MECH.** Already designed (#54, shipped in the hand layer). Collect enum literals manifest-wide, mint bare axis-neutral tokens, give each component a closed supported-row. Generator emits this.

---

## Declarative requirements (need external-input files)

### R4 — Slot → children typing + the closed-row composition model  *(elm-cem#1 external input #1; the big one)*
- **DECL. Pervasive.** Naive emits bare `iconSlot : Html.Attribute`; the hand layer types slots so children are documented and (optionally) enforced. **Needs `slots.json`** — per slot: the allowed child kinds + an `arbitraryAllowed` flag (does the Material spec permit arbitrary children here?).

#### Verified row mechanics (compiled probes against the real API, 2026-06-29)

These were settled empirically with `elm make`, not asserted — the behavior is non-obvious and easy to get wrong.

- **Open slot rows are affordance, NOT enforcement.** The current hand layer types slots with *open* rows, e.g. `Card.actions : List (Element { s | button : Supported } msg)`. Elm merges any two open records, so the row keeps **nothing** out:
  - `Card.actions [ Icon.view … ]` — wrong kind (`{ s | icon }`) → **compiles**.
  - `Card.actions [ M3e.html … ]` — raw html (`{ s | html }`) → **compiles**.
  The row only drives autocomplete and documents intent. **Contrast R3:** `Value` setters use *closed* rows, so `Button.view { variant = Value.small … }` is a **TYPE MISMATCH** (small ∉ the closed `{ elevated, filled, tonal, outlined, text }`). So **R3 enforces at compile time; open-row R4 does not** — exactly the "protection lives on the setter argument" note.

- **Closed slot rows DO enforce — without killing escapes.** Switching the typed-shorthand setter to a *closed* row (no `s |`) recovers real compile-time safety:
  - `actions : List (Element { button : Supported } msg)` ← `Button.view` ✅; ← `Icon.view` ❌ *TYPE MISMATCH* (compiler even hints "Maybe icon should be button?"); ← `M3e.html` ❌ *TYPE MISMATCH*.
  - Escapes survive, because they live elsewhere: (a) the universal `Element.fromNode : Node msg -> Element any msg` — `any` is a bare type variable, so it punches through *any* row by design (the loudest, elm-review-greppable hatch); and (b) separate named escape setters (below).

- **Open producers + closed consumers ⇒ heterogeneous coexistence WITH enforcement.** Because component `view`s return *open* rows, a mixed child list widens to the *union* row, which is then checked against the closed slot:
  - multi-kind slot `{ button, iconButton }` ← `[ Button.view, IconButton.view ]` → ✅ (both coexist);
  - single-kind slot `{ button }` ← `[ Button.view, IconButton.view ]` → ❌ (iconButton rejected);
  - multi-kind slot `{ button, iconButton }` ← `[ …, Icon.view ]` → ❌ (icon rejected).
  - **Generator rule:** generated `view`s MUST return open rows (`Element { s | tag : Supported } msg`); generated typed slots SHOULD use closed rows enumerating every allowed kind (`{ button : Supported, iconButton : Supported }`).

#### The named per-slot gradient (the emitted API shape)

For each slot, `slots.json` gives the allowed kinds + `arbitraryAllowed`; the generator emits a gradient whose **name loudness encodes distance from the happy path**:

| name | accepts | emitted when |
|---|---|---|
| `trailingIcon` (typed shorthand, often a constructor `{ name : String } -> Option`) | the blessed kind | one per allowed child kind |
| `trailing` / `trailingSlot` | arbitrary spec-allowed content — a closed row of *all* allowed kinds (or `Element any` if the slot is genuinely open) | **only if** `arbitraryAllowed` |
| `trailing_Element` | `Element any msg` — an off-spec IR element | always (escape) |
| `trailing_ESCAPE_HATCH_HTML` | raw `Html msg` — out-of-our-hands / third-party markup | always (escape) |

The *presence* of a friendly `trailingSlot` is itself the signal that arbitrary content is blessed; its *absence* marks an opinionated slot. The `element` escape is the extensibility seam — e.g. a company logo where only Material icons are "blessed" — letting consumers define their own helpers cleanly. `html` / `fromRawHtml` is the last resort for markup we can't express in the IR (third-party widgets, etc.).

- **Proposed `fromRawHtml : Html msg -> Element any msg`** — a *universal-row* raw-html lift (fits everywhere, like `fromNode`), replacing today's row-restricted `M3e.html : Html msg -> Element { s | html : Supported }` (which a closed slot correctly rejects). "html allowed anywhere," gated by elm-review rather than by types.

#### Enforcement split (the resolved model)

The **type system** (closed slot rows) polices the easy/common path — wrong kind or stray html is a compile error with a helpful hint. **elm-review** polices *only* the explicit escapes (`*_Element`, `*_ESCAPE_HATCH_HTML`, `fromNode`/`fromRawHtml`), proposing an alternative or requiring a suppression. The two split the work; together they make **easy path = correct path**. This is a stronger position than "open rows everywhere + elm-review as sole enforcer" — that was only forced by the hand layer's *choice* of open slot rows, not by the type system.

### R5 — Multi-tag grouping  *(elm-cem#1 external input #3 — but FAR bigger than "Progress")*
- **DECL. ~20 components.** The dominant structural pattern: one logical module spans several CEM tags. Two flavors the schema must express:
  - **Container + typed item family**: Menu (7 tags), List (8), Tabs (3), Tree (2), Stepper (3), Disclosure (2), Breadcrumb (2), SegmentedButton (2), RadioButton (2), Nav* (2–3), Slide (2), Tooltip (2). A parent `view` plus typed item/sub constructors (`item`, `option`, `section`, `treeItem`, …).
  - **Variant-split by required arg**: Chip (5 tags by kind), Progress (linear/circular by `shape`), Fab vs ExtendedFab (same `m3e-fab` tag, split by always-on `extended`). One module, tag chosen by a required field.
- This is the single largest schema surface. elm-cem#1 #3 named it but scoped it as rare; it is the norm.

### R6 — Required-content / accessible-name designation  *(elm-cem#1 external input #2)*
- **DECL. Pervasive.** Two sub-types:
  - **Accessible-name on no-text controls**: required `ariaLabel`/`name` → `aria-label` on Checkbox, Switch, Fab, IconButton, Avatar, Slider, ChipSet(filter/input). CEM has no such attribute; it's pure a11y convention.
  - **Required content slot/text**: `label`/`headline`/`message`/`content` as required fields rendered into a slot or as a text child — Button, Heading, Chip, Tabs.tab, Tree.treeItem, Menu items, Dialog, BottomSheet, Collapsible, Snackbar, etc.

### R7 — Optionality rule (drive required-vs-optional from CEM `default`)
- **DECL/MECH.** elm-cem#1's optionality rule. **Confirmed live divergences**: `Button.variant`, `Heading.variant`, `ExtendedFab.variant` are hand-coded as *required* despite non-sentinel CEM defaults (`text`/`display`/`primary-container`). Under the rule they become optional. (Card already does it right.) Sentinel defaults (`null`/`""`/`0`) may stay required by editorial choice (Paginator.length, Toc.for).

### R8 — Structural slot-grouping / wrapper markup  *(NEW — only partly implied by elm-cem#1 #1)*
- **DECL (templatable) + HAND (bespoke).** This is the biggest gap not fully on the elm-cem#1 list. CEM names slots but never describes the *wrapper markup* the hand layer injects:
  - **`div[slot=x]` region wrappers**: Card (header/content/footer/actions), Dialog (actions), Disclosure, SideSheet (start/end), SplitPane (content-pane), Tooltip (rich actions). Card also groups headline+subhead into one `content` div.
  - **`span[slot=x]` text wrappers**: Button.selectedLabel, Fab/ExtendedFab label, List overline/supporting-text, Tree label, Toc title/overline, Menu group, Dialog headline, Disclosure header.
  - **Injected child elements absent from CEM**: BottomSheet (`injectSheetAction` mutates the node tree), Search (inner `<input type=search slot=input>`), Slider (auto `<m3e-slider-thumb>`), RadioButton (`<label>` sibling wrap of slotless `<m3e-radio>`), SplitPane (`<m3e-content-pane>` wrap), Nav* (badge as `<m3e-badge>` child), Fab (icon child).
  - The schema needs a per-slot **wrapper template** (`none` | `div[slot]` | `span[slot]` | named-element) and a way to declare default-slot placement. The node-tree *mutations* (BottomSheet, Field) are HAND.

### R9 — Event → typed-payload decoders  *(elm-cem#1 external input #6 — also bigger than "a few")*
- **DECL (mostly) + HAND (two cases).** Almost every interactive component bakes a specific decoder instead of passing a raw `Decoder msg`:
  - `target.value` / `target.checked` / `target.selected` extraction (all form controls).
  - `detail.X` extraction (Paginator `detail.pageIndex`; Menu/Select `newState`).
  - multi-event → one msg (`onClose` ← `closed`+`cancel`; `onToggle` ← `opened`/`closed` → Bool).
  - `Decode.succeed msg` for plain clicks.
  - **HAND**: Calendar/DatePicker decode a JS `Date` object by abusing `elm/json`'s `JSON.stringify` path to coerce it to an ISO string with no JS interop. Tree uses plain-msg because the event carries non-serialisable live DOM refs.
- Schema: per-event a small decoder descriptor (source path + target type + multi-event fan-in); an `opaque`/`hand` escape for the irreducible ones.

### R10 — Universal escape hatches  *(elm-cem#1 comment 2)*
- **MECH + DECL.** Confirmed prototypes: `attributes : List (Node.Attr msg)` on Shape, ScrollContainer, Skeleton, Progress (ADR 0007 CSS-var passthrough). Plus `href/target/rel/download` via `Node.rawAttr` (Button, Fab, ExtendedFab), IconButton.extraContent, NavigationDrawer.content. Generalize: every component gets `extraAttrs` + a shared `M3e.Attr.attributes`. Content escape (`M3e.html`/`fromNode`) already universal.

### R11 — Configurable text handling
- **DECL.** The `String -> Html.text` default is fine but must be overridable. Non-trivial cases: Badge count truncation (`999+`), SegmentedButton value-defaults-to-label, Breadcrumb label used as *both* text child and `item-label` attr, Toc title/overline span-wrap. (User-raised requirement.)

### R12 — Typed-argument overrides  *(this is the Icon example — keep it DECL, never imperative)*
- **DECL.** Where m3e passes a value through untyped but we want Elm type-safety without vendoring or a review rule: Icon `weight` (ADT `W100..W700` → string), Icon glyph `name`, Heading `level` (Int clamped 1..6 → string), ThemeIcon/Theme `scheme`. Express as a declarative **argument-type override** (a named typed wrapper around the passthrough) in the overrides file — **not** function-body injection. *If a customization can't be expressed declaratively, it stays hand-owned.*

### R13 — Surface curation (omission / include list)
- **DECL.** The hand layer deliberately omits chunks of the CEM surface: FormAssociated read-back internals (`dirty/pristine/touched/untouched/willvalidate/validationmessage`), `disabledInteractive`, `onBeforeinput`/`onInput`, navigation labels, etc. Generator design decision: **emit the full surface and let an override file curate**, or emit a curated default. Recommend full-surface + optional skip-list, so nothing is silently unavailable.

### R-EXTRA — Misc declarative bits
- `role="group"` injection (ChipSet) — a static-attribute override.
- Auto-id via `slugify` when `id` omitted (Select, TextField, TimePicker) — a fallback-id strategy flag.
- Name-collision renames (elm-cem#1 #5): `textVariant`, `formType` (Elm `type` keyword), `min`/`max` (drop CEM's `Attr` suffix), `forId`. A small rename map.

---

## Irreducibly hand-owned  (R-HAND — the ~20% / ~14 modules)

These cannot be captured by any declarative input; they stay hand-written (the residual "hand layer"), and the generator should leave designated holes for them:

- **No custom element / Tailwind**: `Text`, `Label`, Theme typescale helpers (elm-cem#1 #4 skip list).
- **Native-element compositions** (`m3e-form-field` + native `<input>`/`<label>`/`<textarea>`): `Field`, `TextField`, `Select`, `TimePicker`. Includes `Node.setAttribute` IR-rewrite (Field stamps `id` onto the control node).
- **Imperative-only**: `Snackbar` (opened via JS `M3eSnackbar.open`, no declarative `open`); needs the JS wrapper / port.
- **JS-Date decode**: `Calendar`, `DatePicker` (`JSON.stringify` Date coercion).
- **Cross-component composition**: `SplitButton` calls `Button.view` for its leading slot — this is also the **#70 phantom-row leak** (SplitButton's variant row widened to match Button's, admits `Value.text` upstream rejects).
- **Node-tree mutation**: `BottomSheet` (`injectSheetAction`).
- **Slotless-element workarounds**: `RadioButton` (`<label>` sibling wrap), `Search` (inner `<input>`), `Slider` (hidden auto-thumb).
- **Upstream CEM bug**: `StepperNext` has no vendored module (CEM tagging bug); blocks generation until fixed upstream.

---

## Implied external-input schema (expanded from elm-cem#1)

1. **`slots.json`** — per component, per slot: allowed child element kinds + `arbitraryAllowed` (R4, drives the closed-row typed shorthands and whether a friendly `…Slot` rung is emitted) **and** the wrapper template `none|div[slot]|span[slot]|<element>` (R8).
2. **`overrides.<component>`** — required-content/a11y-name designation (R6), multi-tag grouping definition (R5), event-decoder descriptors (R9), typed-argument overrides (R12), surface skip-list (R13), static-attr injections + auto-id + renames (R-EXTRA), and a `hand-owned` flag (R-HAND) that tells the generator to skip / leave a hole.

Everything else flows mechanically from CEM (R0, R1, R3, R7, R10).

## Resolved design decisions

- **R4 slot enforcement (settled 2026-06-29, verified by compiled probes):** generated `view`s return *open* rows (enable heterogeneous child coexistence); generated typed slots use *closed* rows enumerating allowed kinds (real compile-time enforcement). Escapes relocate to named siblings (`*_Element`, `*_ESCAPE_HATCH_HTML`) + universal `fromNode`/`fromRawHtml`, policed by elm-review. Easy path = correct path.

## Open design decisions

- **Surface curation default** (R13): full-surface-then-skip vs curated-default. *Recommend full + skip-list.*
- **Wrapper-template expressiveness** (R8): how rich the declarative template language is before a case is declared HAND. Draw the line tightly — node-tree mutation is always HAND.
- **Decoder descriptor language** (R9): how much of the `target.x`/`detail.x`/multi-event space is declarative vs `opaque`.
- **Multi-tag grouping schema** (R5): one schema covering both container+items and variant-split, since they're the majority structural shape.

## Internal-inconsistency cleanups (not generator concerns, but noted)
- `SegmentedButton` and `Tooltip` use bespoke `Option` ADTs + manual `foldl` instead of `Internal.Option`/`applyOptions`. Normalize before/while generating.
- `ThemeIcon.Scheme` is a local ADT while `Theme.Scheme` is a `Value` row — pick one.
