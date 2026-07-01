# Component-agnostic API + per-layer barrels

> The design for collapsing per-component setters into shared, polymorphic,
> phantom-gated vocabulary, and exposing each generated layer through a single
> barrel/index module. Converged 2026-07-01. Supersedes the "per-component setter
> modules" shape for everything *except* the constructor. Builds on the double-list
> ([ADR 0011](adr/0011-ir-faithfulness-advisory-cardinality.md)) and the escape/kit
> model ([ADOPTION_AND_SLOTS.md](ADOPTION_AND_SLOTS.md)).

## 1. The principle

**Every attribute, event, and action is ONE component-agnostic polymorphic
function; the phantom capability record gates validity.** There are no
per-component setter functions. Composition safety comes from the phantom rows, not
from module namespacing. This is the payoff the phantom design was always pointing
at — it removes ~500 redundant generated functions (`disabled` alone was emitted
54×) and makes a single-import barrel trivial and collision-free.

## 2. Component modules = constructors only

`M3e.Button` exposes just its constructor:
```elm
button : { required } -> List (Attr caps msg) -> List (Content slots msg) -> Element { s | button : Supported } msg
```
**The double-list shape is unchanged** (required record + attrs list + content
list). What changes is that Button no longer exposes `disabled`/`variant`/`icon`/… —
those move to the shared vocabulary. A component module is now essentially one
function + its capability/slot row aliases.

## 3. Shared vocabulary modules (like `M3e.Value`, but for each kind)

Separate modules, so the three vocabularies never collide with each other:
- **`M3e.Attr`** — every attribute + event setter, polymorphic + phantom-gated:
  `disabled : Bool -> Attr { c | disabled : Supported } msg`,
  `onClick : Decoder msg -> Attr { c | onClick : Supported } msg`,
  `href`, `variant`, `size`, …
- **`M3e.Value`** — enum tokens (`filled`, `small`, …), each carrying its category in
  its supported-row so `variant Value.small` won't type-check but `variant Value.filled` will.
- **`M3e.Action`** — action setters (the `Action` href-XOR-onClick vocabulary).

## 4. Enum attributes — both forms

- **Token form:** `variant : Value { … variant values … } -> Attr { c | variant : Supported } msg`.
- **Baked convenience alias:** `variantFilled : Attr { c | variant : Supported } msg`  (= `variant Value.filled`).
- **No per-value capability flags.** The `Value` token's supported-row already keeps
  variant-tokens distinct from size-tokens. Whether a *specific* component accepts a
  *specific* value (Chip vs Button variants) is **not** type-gated — it's caught by
  **elm-review**. Loose types for composition ease; elm-review for correctness.

## 5. Same-name, different-type attributes → type suffix (browser-inspired)

Where one name maps to different types across components (`value` is a String on a
text control, a number on a slider; `type`), we do what the DOM does:
- **String keeps the bare name** (the default): `value : String -> Attr …`.
- **Other types are suffixed:** `valueFloat`, `valueInt`, …
- The **canonical (unsuffixed)** binding defaults to the **most common** type across
  components; **config-overridable** where the common default is wrong.

## 6. Slots — general + specific, elm-review bridges

For slot content setters, ship **both**:
- **General:** `trailingSlot : Element { … union of all valid "trailing" kinds … } msg -> Content { r | trailing : Supported } msg`
  — accepts everything any component's `trailing` slot accepts (loose).
- **Specific:** `appBarTrailingSlot : Element { iconButton } msg -> Content { r | trailing : Supported } msg`
  — strictly typed to AppBar's `trailing`.
- An **elm-review rule** auto-rewrites the general call to the correct
  `<component><Slot>Slot` prefix, and flags inputs that no component accepts.
- The **general canonical** defaults to the most common accepted kind (config-overridable).
- Rationale: the slots config is **hand-rolled and may be wrong**; loose types +
  elm-review let us compose freely now and tighten/fix the config iteratively.

## 7. Per-layer barrels

Each generated layer gets a top-level barrel re-exposing its **full** API (all
constructors + the shared vocab) so the common case is one import:
- **`M3e`** (top) · **`M3e.Cem`** (middle) · **`M3e.Cem.Html`** (bottom).
- `import M3e exposing (..)` → every constructor + `disabled`/`variantFilled`/`trailingSlot`/…
- As layers are added later, each gets the same barrel.
- Core types + `toNode` are re-exposed; the hundreds of `Value` tokens stay in
  `M3e.Value` (re-exposing them all would bloat the barrel).

## 8. elm-review is first-class output

The generator emits rules (shipped alongside, opt-in):
1. **PreferSpecificSlot** — rewrite `trailingSlot` → `appBarTrailingSlot` in context (auto-fix).
2. **ValidEnumValue** — flag a `variantX` used on a component that doesn't accept it.
3. (existing) **RequireSlot** / **SingularSlot** — advisory required-presence + cardinality.

## 9. Why

- **Huge code reduction** — ~500 per-component setters collapse to a few dozen shared ones.
- **Trivial, collision-free barrels** — the whole point.
- **Composition ease** — loose, agnostic setters; the type system guarantees *kind +
  capability*, elm-review guarantees the finer per-component/per-value correctness.
- **Config resilience** — hand-rolled config can be wrong; loose+review absorbs that.

## 9b. The Vocab architecture (converged refinement — supersedes §2/§3/§7 mechanics)

Everything is defined **once** in an internal **`Vocab`** per layer, and every public
module is a thin **alias** of it. This avoids duplication and, because aliases only
ever point *down*, avoids circular imports.

- **`Vocab` is internal and holds only the concepts NEW to its layer, reusing below.**
  The middle and top share the exact `Attr { c | cap } msg` phantom, so the **attr
  vocab is defined once at the middle level** (`M3e.Cem.Vocab`) and the **top reuses
  it**; the top vocab (`M3e.Vocab`) adds only what's new up there — constructors
  returning `Element`, and the `Content`/slot setters. Bottom vocab = raw `htmlAttr`;
  middle wraps it in `M3e.Cem.Attr.attribute` → phantom `Attr`.
- **Names are disambiguated in Vocab, attribute-first + component-suffixed:**
  `variantButton`, `variantChip` (so autocomplete on `variant` surfaces the typed
  ones), shared `disabled` (no suffix — only *type-divergent* attrs get a suffix),
  constructors `button`/`card`.
- **The barrel `M3e` aliases the full vocab** (loose general `variant` + all the
  disambiguated names + constructors). `import M3e exposing (..)` = everything. The
  barrel is also the **compile-time collision guard** — if two aliases share a name it
  won't compile, so Vocab may be split into as many internal modules as is clean.
- **Component modules alias the barrel/vocab and strip the component suffix**, renaming
  the constructor to `view`: `M3e.Button` → `view` (= `button`), `variant`
  (= `variantButton`, the *strict* one), `disabled` (shared, unchanged). **Exception:**
  combined-group modules (variant-split, e.g. `Progress` = `linear`/`circular`) can't
  have two `view`s — their sub-components keep their natural vocab names.
- **No `M3e.Attr` module** — the vocab is it. (This also fixes the opaque-`Html` bug:
  the vocab is defined at the phantom level.)

Build order: phantom middle-vocab emit → `M3e.Cem.Vocab` → `M3e.Vocab` (constructors +
slots) → barrel aliases both → component alias modules (suffix-strip + `view`) →
elm-review auto-prefix rule.

## 10. Open micro-decisions (proceeding with these defaults)
- Slot naming: `<slot>Slot` (general) / `<component><Slot>Slot` (specific).
- elm-review rules: authored **after** the core generation lands (loose types work without them).
- **First step:** generate `M3e.Attr` (shared attrs) + shrink component modules to
  constructors; then the barrels; then the value/slot suffix+general/specific split;
  then the elm-review rules.

Old barrel reference (for shape/naming inspiration): `git show 2b6e836^:src/M3e.elm`.
