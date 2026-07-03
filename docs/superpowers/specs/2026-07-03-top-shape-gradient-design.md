# Top-layer shape gradient — design (epic #138, workstream A)

Date: 2026-07-03
Status: Accepted (companion to [ADR 0013](../../adr/0013-top-shape-matrix-and-translation.md))
Scope: **workstream A only** — decide & specify. Workstreams B (generator), C
(facts), D (rules/translator), E (docs) each get their own spec→plan cycle and
consume this document.

## 1. Purpose

Epic #138 asks for the "five addressable API surfaces" of `CONTEXT.md` to be
finished: bottom, middle, and the top layer in three shapes, plus a codegen-aware
review net that gives the loose shapes the guarantees the phantom shape gets from
types. Before any generator or rule work, the shape matrix and the shape↔shape
translation contract must be pinned. This spec pins them. The decision itself
lives in ADR 0013; this document is the worked detail.

## 2. The five surfaces (running example: `<m3e-button>`)

Scenario: a `filled` button, label "New", leading `add` icon, `onClick DoThing`.

### ① Bottom — `M3e.Cem.Html.Button` → `Html msg`
```elm
M3e.Cem.Html.Button.button
    [ M3e.Cem.Html.Button.variant "filled", M3e.Cem.Html.Button.onClick DoThing ]
    [ Html.text "New"
    , M3e.Cem.Html.Icon.icon
        [ M3e.Cem.Html.Icon.name "add", Html.Attributes.attribute "slot" "icon" ] []
    ]
```
Nothing typed. `variant "purple"` compiles; no label compiles; `slot` is a raw
string.

### ② Middle — `M3e.Cem.Button` → `Html msg`
```elm
M3e.Cem.Button.button
    [ M3e.Cem.Button.variant M3e.Value.filled, M3e.Cem.Button.onClick DoThing ]
    [ Html.text "New", {- icon child as raw Html with a slot attr -} ]
```
Attrs typed to the token vocabulary; **children are raw `Html`** — slot
correctness not typed; no label still compiles.

### ③ Top / double-list — `M3e.Button` → `Element`
```elm
M3e.Button.view
    [ M3e.Button.variant M3e.Value.filled
    , M3e.Button.onClick DoThing            -- action expressed as an attr-opt
    ]
    [ M3e.Button.label (Kit.text "New")     -- required content, unenforced here
    , M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "add" ] [])
    ]
```
Matches `Card`/`ListItem` today. Enum + slot-kind typed. Missing label and
duplicate `icon` both compile → review backstop.

### ④ Top / record + double-list — `M3e.Record.Button` → `Element`
```elm
M3e.Record.Button.view
    { content = Kit.text "New", action = M3e.Action.onClick DoThing }
    [ M3e.Record.Button.variant M3e.Value.filled ]
    [ M3e.Record.Button.icon (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
```
This is the shipped 3-arg hybrid, blessed. Missing `content`/`action` is a
**compile error**. Duplicate `icon` in the content list still compiles → review.

### ⑤ Top / phantom-record — `M3e.Build.Button` → `Element`
```elm
M3e.Build.Button.button
    { content = Kit.text "New"
    , action = M3e.Action.onClick DoThing
    , variant = Just M3e.Value.filled
    , icon = Just (M3e.Icon.view [ M3e.Icon.name "add" ] [])
    , trailingIcon = Nothing
    , selected = Nothing
    -- … every optional attr/slot present as a field …
    }
```
Required fields plain; optional-singular as `Maybe`; multi as `List`. **Duplicate
singular is unwritable** (one field). Everything else typed. No review needed.
(The exact constructor name and whether a `default`-record-override convention
softens the `Maybe`-noise are B/generator concerns; the shape decision is only
"one fully-typed constructor over a complete record, returning `Element`.")

### The progression (what each converts)

| Mistake | ③ | ④ | ⑤ |
| --- | --- | --- | --- |
| Invalid enum token (per-component setter) | compiler | compiler | compiler |
| Wrong slot-kind child | compiler | compiler | compiler |
| Arity / over-application | compiler | compiler | compiler |
| Missing **required** | review | **compiler** | **compiler** |
| **Duplicate singular** | review | review | **impossible** |

③→④ hoists *required* into a record; ④→⑤ hoists *everything* in. Shapes ④ and ⑤
share the identical `{ required }` core; ⑤ additionally absorbs the optionals.

## 3. Composition & the single eager point

All three top shapes return the identical `Element supported msg`. They nest and
interchange freely; the sole conversion to `Html` is
`toHtml : Element any msg -> Html msg` (= `Element.toNode >> Node.toHtml`) at the
app root. A shape's guarantees are entirely input-side; the output IR is uniform.
Consequence: the translator (§5) rewrites only the *call site*, never the
surrounding tree, and one `toHtml` renders a view mixing all shapes.

## 4. The action asymmetry

`<m3e-button>`'s click/link is not an attribute *or* a content slot — it is the
`M3e.Action` wrapper (see the action-unification spec). Its surface form differs
by shape:

- **①/②/③** express it as **attr-style setters** (`onClick`, `href`, `toggle`, …)
  in the attribute list. (③ therefore re-exposes these top-level, which the
  current `M3e.Button` does *not* — it only offers them via the record. Shape ③
  must re-expose them.)
- **④/⑤** carry it in the **`action` record field** (`M3e.Action.onClick …`).

The translator's action-capability map (§5) bridges the two forms.

## 5. The translation lattice (feeds #138 C + D6)

Normalize any call to a canonical tuple, then re-emit at the target surface:

```
(component, attrs, slots, action, required-content)
```

- **Downhill (safe → raw)** — always total and mechanical: drop guarantees,
  re-emit. `⑤ → ④ → ③ → ② → ①`.
- **Uphill (raw → safe)** — partial; must validate against the facts. A string
  token with no valid target (`"purple"`), or a `slot="foo"` naming no known slot,
  becomes a diagnostic, not a rewrite.

Per-component fact maps the translator/rules require (drives workstream C):

| Map | Example | Facts status |
| --- | --- | --- |
| token ↔ string | `M3e.Value.filled` ↔ `"filled"` | have (`enums`) |
| name → is-attr-or-slot | `variant`=attr, `icon`=slot | **need** (C3) |
| slot-name ↔ helper | `"icon"` ↔ `M3e.Button.icon` | partial |
| action-capability set | `onClick`/`href` ↔ `M3e.Action.*` | **need** |
| required / unnamed slot | `content` field ↔ default-slot child | **need** (C1) |
| multi vs singular | arity per slot | have (`multiSlots`) |
| shorthand ↔ specific | `variant` ↔ `variantButton` | **need** (C2) |

## 6. Review-net scope by shape (feeds #138 D)

- **⑤** — no rules; types cover everything.
- **④** — duplicate-singular (`SingularSlot`, have) + enum validity for the
  loose barrel (`ValidEnumValue`, have). Missing-required is compiler-enforced.
- **③** — the above **plus** missing-required: required-multi slot
  (`RequireSlot`, have), required-singular slot (**need**, D2), and required
  attribute (**need**, D1, driven by C1's `requiredAttrs`).
- **All top shapes** — `PreferSpecificSlot` shorthand→specific auto-fix (**need**,
  D5, driven by C2) and the surface translator (**need**, D6).

The attribute-vs-content **sort** rule (previously D4) is **dropped**: with double
lists there is no interleaving to sort.

## 7. What changes downstream (pointers, not scope here)

- **B (generator).** Replace the implicit `hasRecord` fork
  (`Generate.elm` ~L1973) with a global selector emitting three top namespaces.
  ④/⑤ reuse the existing `requiredType` construction (~L1785) for their record.
  ⑤ adds the optional fields (`Maybe`/`List`). ③ re-exposes action attr-setters.
- **C (facts).** Add `requiredAttrs`, shorthand↔specific pairs, and per-surface
  shape/arity + attr-vs-slot metadata to `M3e.Review.Facts`.
- **D (rules/translator).** D1/D2 (missing-required for ③), D5 (`PreferSpecificSlot`),
  D6 (the §5 translator). D4 dropped.
- **E (docs).** `CONTEXT.md`: shape-variant-vs-safety-depth clarification (E1);
  docs app gains a 2-D toggle — layer × top-shape (E2).

## 8. Open questions deferred to later workstreams

- ⑤'s call-site ergonomics: bare all-`Maybe` record literal vs. a `default`-record
  the caller overrides. (B)
- Naming of ⑤'s constructor so it does not read as a second "build" beside the
  root `toHtml`. (B)
- Whether every component emits all three top namespaces, or degenerate cases
  (no required opts → ④'s record is empty; ⑤ ≈ ③ with `Maybe`s) are skipped for
  symmetry vs. economy. (B)

## 9. Definition of done for workstream A

- [x] Shape matrix decided and recorded (ADR 0013).
- [x] The five surfaces pinned with worked examples (§2).
- [x] The shape↔shape / layer↔layer translation contract specified as a lattice
  over one canonical tuple (§5).
- [x] The Facts fields the translator and rules need are enumerated (§5–6),
  handing workstream C a concrete target.
- [x] ADR 11 / 12 reconciliation stated (ADR 0013).
