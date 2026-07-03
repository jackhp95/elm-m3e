# 13. The top-layer shape matrix: three co-equal shapes + a translation lattice

Date: 2026-07-03

## Status

Accepted. Reconciles [ADR 11](0011-ir-faithfulness-advisory-cardinality.md)
(advisory cardinality/required-presence) with the Action unification
(`feat(m3e): unify clickable activation via M3e.Action`, which typed required
`content`/`action` into a record). Resolves the "Deferred" section of ADR 11
("how optional attributes and optional slots are passed is NOT decided") and
supplies the shape matrix that [ADR 12](0012-codegen-aware-elm-review.md)'s
translator is parameterized over. Governs epic #138 workstream A; B–E build on it.

The companion spec — `docs/superpowers/specs/2026-07-03-top-shape-gradient-design.md`
— carries the worked translation table and the Facts fields each surface needs.

## Context

`CONTEXT.md` names **five addressable API surfaces**: the bottom layer
(`M3e.Cem.Html.*`), the middle layer (`M3e.Cem.*`), and the top layer
(`M3e.*`) in **three shapes** over the same IR. The bottom and middle layers are
built and stable. The three top shapes were not:

- **Shape decision is implicit.** The generator emits exactly one `view` per
  component; the shape is decided by `hasRecord = not (isEmpty requiredSingular)
  || not (isEmpty extra)` in `elm-cem/codegen/Generate.elm` (~L1973) — not by any
  selector. Components with a required slot/action got a record; the rest got two
  lists.
- **The shipped "record" shape is a 3-arg hybrid.** The Action unification lifted
  required `content`/`action` into a typed record, producing
  `view { content, action } [ attrs ] [ content ]` (Button, IconButton, Fab,
  Chip). That is a record + **two** lists, matching neither shape CONTEXT.md
  described.
- **The phantom-builder shape was absent.**

Underneath sat a genuine design fork. ADR 11 made cardinality and
required-presence **advisory** (review rules, loose IR) to avoid forcing a record
— and `Maybe`-noise for optional-singular slots — onto every component. The Action
unification pulled the other way, making required-presence a **compiler**
guarantee via a record. The hybrid is the unreconciled artifact of that fork.

Two facts observed while mapping the code reframe the decision:

1. **The IR already composes to one eager point.** Every top constructor returns
   `Element supported msg` (lazy IR); the sole conversion to `Html` is
   `toHtml : Element any msg -> Html msg` at the app root
   (`docs/app/Shared.elm`; `THREE_LAYER_PATTERN.md` — "THE ONLY EAGER POINT").
   So a shape's guarantees can live entirely on its *input* side while its
   *output* stays identical and freely composable.
2. **A record field is present exactly once by construction.** Putting singular
   slots in a record makes duplicate-singular *unwritable* — no phantom trickery,
   no consuming rows. This is precisely the type-level design ADR 11 sketched and
   deferred ("put singular slots in a record; `Maybe` for optional-singular;
   required slots as plain fields").

## Decision

**Three top shapes, co-equal, one per namespace segment, over the identical IR.**
No shape is canonical. A team picks by taste/context; the codegen-aware
translator (ADR 12) rewrites a call between any two surfaces, so no choice is a
trap.

| # | Surface | Namespace | Shape | returns |
| --- | --- | --- | --- | --- |
| 1 | Bottom | `M3e.Cem.Html.*` | `el [ Html.Attribute ] [ Html ]` | `Html` |
| 2 | Middle | `M3e.Cem.*` | `el [ Attr ] [ Html ]` | `Html` |
| 3 | Top / double-list | `M3e.*` | `view [ Attr ] [ Content ]` | `Element` |
| 4 | Top / record + double-list | `M3e.Record.*` | `view { required } [ Attr ] [ Content ]` | `Element` |
| 5 | Top / phantom-record | `M3e.Build.*` | `<ctor> { complete record }` | `Element` |

The three top shapes are **one monotonic safety progression**; each step converts
exactly one advisory check into a compile-time guarantee:

| Mistake | ③ double-list | ④ record + lists | ⑤ phantom-record |
| --- | --- | --- | --- |
| Invalid enum token (per-component setter) | compiler | compiler | compiler |
| Wrong slot-kind child | compiler | compiler | compiler |
| Missing **required** (label/action) | review | **compiler** | **compiler** |
| **Duplicate singular** (`icon` twice) | review | review | **impossible** |

- **③ → ④** hoists *required* opts into a record → missing-required moves from
  review to the compiler. **Shape ④ is the shipped 3-arg hybrid, blessed** — not
  retired; the hybrid *is* the canonical record shape.
- **④ → ⑤** hoists *everything* into the record (optional-singular as `Maybe`,
  multi as `List`) → duplicate-singular becomes structurally unwritable and every
  remaining check is typed. **Shape ⑤ is ADR 11's own deferred sketch**, now
  shipped as one opt-in shape rather than forced on all components.

**Consequences of the shape being input-only:**

- All three top shapes return the identical `Element supported msg`. They nest and
  interchange freely (a ⑤ Button inside a ③ Card inside a ④ Dialog); the translator
  rewrites only the call site, never the surrounding composition.
- ⑤ has **no** per-component build-to-Html step. The single eager point remains
  the root `toHtml`. ("single build" = one conversion per view.)
- **Double lists, not a merged list.** `Attr` and `Content` stay separate lists in
  ③ and ④. No `Attr ∪ Content` union type is introduced, and no attribute-vs-content
  sort rule is needed (two lists cannot interleave). This supersedes ADR 11's
  walked-back single-unified-list sketch by *dropping* it, not by adopting it.

**Namespace depth on the top axis denotes shape variant, not safety.** The escape
gradient's "deeper = less safe / more raw" rule (`M3e` → `M3e.Cem` →
`M3e.Cem.Html`) governs the **layer** axis only. `M3e.Record`/`M3e.Build` are
deeper yet *safer*; the extra segment names a shape, orthogonal to the
safety-depth axis. `CONTEXT.md` must state this.

**Translation is a lattice.** The translator normalizes any call to
`(component, attrs, slots, action, required-content)` and re-emits at the target.
Because all five surfaces already share one runtime IR, **downhill (safe → raw) is
total and mechanical**; **uphill (raw → safe) is partial and must validate**
(`variant "purple"` has no valid target token → a diagnostic, not a rewrite). See
the companion spec for the per-component fact maps this requires.

### Considered and rejected

- **A single canonical top shape.** Rejected: the shapes serve different call
  sites, and the translator makes "pick one" unnecessary. Co-equal + translate is
  strictly more flexible.
- **A merged `Opt = Attr ∪ Content` list** for ③/④ (a genuine option we explored).
  Rejected in favour of double lists: it needs a new IR union type, produces wider
  phantom rows and worse error messages, and its only benefit — one list instead
  of two — is cosmetic since attrs and content route to different IR sinks anyway.
- **A `new |> …setters |> build` consuming-row builder** for ⑤. Rejected: a plain
  record already makes duplicate-singular unwritable, so the pipeline and its
  capability-consuming rows are unnecessary ceremony.
- **Keeping the implicit `hasRecord` fork.** Rejected: it ties shape to the
  accident of "has a required slot," offers no phantom shape, and cannot present
  shapes side by side.

## Consequences

- **ADR 11 stands as the floor.** Shape ③ keeps its advisory required-presence and
  cardinality. Shapes ④ and ⑤ are *additive* compile-time guarantees, not a
  reversal. Only ADR 11's unified-list deferral is closed (by dropping it).
- **The generator's shape selector becomes global** ("emit these three top
  namespaces"), replacing the per-component `hasRecord` fork (#138 B1).
- **⑤ reintroduces `Maybe`-noise** — the exact ergonomic cost ADR 11 cited (e.g.
  TreeItem's four icon slots become four `Maybe` fields, and every optional attr
  becomes a `Maybe`). Accepted **because ⑤ is opt-in and co-equal**, never forced.
  ⑤'s call-site ergonomics (all-`Maybe` literal vs. a `default`-record-override
  convention) are deferred to the B/generator spec.
- **The review net (ADR 12) is scoped to ③ and ④'s loose parts.** ⑤ needs no
  review; ④ needs only duplicate-singular + enum validity; ③ needs missing-required
  as well. The Facts module gains `requiredAttrs`, shorthand↔specific pairs, and
  per-surface shape/arity metadata to drive both the rules and the translator
  (#138 C, D).
- **Reversible-ish.** Shapes are independent generated namespaces; dropping or
  adding one is a generator change, not an IR change.

## Related

- `CONTEXT.md` → "API shape", "The generated layers", "Codegen-aware rule" (needs
  the shape-variant-vs-safety-depth clarification — #138 E1).
- ADR 8 (three layers), ADR 9 (composition over injection), ADR 11 (advisory
  cardinality), ADR 12 (codegen-aware review + the translator this feeds).
- Companion spec: `docs/superpowers/specs/2026-07-03-top-shape-gradient-design.md`.
- Generator fork: `elm-cem/codegen/Generate.elm` (`hasRecord` ~L1973,
  `requiredType` ~L1785).
- Symptom issues the matrix resolves: #115 (AssistChip forced action), #121
  (IconButton content is a required record field).
