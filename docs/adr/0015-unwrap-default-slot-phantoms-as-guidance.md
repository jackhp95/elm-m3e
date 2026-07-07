# 15. Unwrap the M3e default slot; phantom rows as guidance, not a boundary

Date: 2026-07-07

## Status

Accepted (decided direction; implementation planned). Amends [ADR 9](0009-composition-over-injection.md)
and the double-list composition model established in [ADR 8](0008-three-layer-generator-retarget.md) and
[ADR 13](0013-top-shape-matrix-and-translation.md). Narrows the `Content` opaque-IR boundary of
[ADR 14 §2](0014-seam-boundary-and-typed-userland.md) so it fences *named-slot* placement only. Extends
[ADR 12](0012-codegen-aware-elm-review.md) — the guarantees this removes from the type system are added
to the codegen-aware elm-review rule set (a new `slotKinds` fact + slot-safety rules).

## Context

The M3e top layer composes with a **double list**: `view [attrs] [contents]`, where each content is a
`Content` — an `Element` that has been lowered to a `Node` and tagged with a slot. The default (unnamed)
slot is reached through `child`/`children`, named slots through per-slot setters (`panel`, `nextIcon`, …):

```elm
M3e.Tabs.view [] [ M3e.Tabs.child tab1, M3e.Tabs.child tab2, M3e.Tabs.panel body ]
```

`Content` exists because a single *homogeneous* Elm list must carry children bound for *different* slots.
Each helper checks the child's kind, **erases** it, and stamps a slot row (`Content { default }`,
`Content { panel }`); `view`'s argument type then rejects a child tagged for a slot the container lacks.

Two facts undermine using this as a *guarantee* on the top layer:

1. **The wrapper is ceremony for the overwhelmingly common case.** Default children — the bulk of every
   example — must be wrapped in `child`/`children` purely to unify into the `List Content`, even though
   the default slot adds no `slot=` attribute at runtime. The API reads worse than `elm/html` for no
   payoff a reader can see.

2. **The safety it does provide is partial, and doesn't catch the mistakes that matter.** Most container
   slots are `Element any` (a card body, header, footer, a toolbar, a dialog body all hold arbitrary
   content — verified: 21 components have an `any`-kind default slot alongside named slots). For those,
   `Content` checks only slot-*name* validity, not child *kind*: it will happily accept a fab-menu-item,
   a nav rail, or another card as a Card child. So the phantom row never prevented the nonsensical
   compositions you would most want caught; it only prevents a foreign *slot label*, whose worst runtime
   outcome is a non-rendered child (an unmatched `slot=` is dropped from the shadow tree).

The system is layered by design: `M3e.Record.*` (required record) and `M3e.Build.*` (phantom Builder
pipeline) exist precisely to provide hard composition guarantees, and codegen-aware elm-review
([ADR 12](0012-codegen-aware-elm-review.md)) is the composition safety net. Asking the *ergonomic* top
layer to also be the soundness boundary — at the cost of the wrapper, and while only delivering a partial
guarantee — is the wrong place to spend the strictness.

## Decision

On the **M3e top layer only** (`M3e.*` — the ③ Standard shape; `M3e.Record.*`/`M3e.Build.*` are
unchanged):

1. **Default-slot children are passed as raw `Element`s.** `view : List Attr -> List Element -> Element`.
   No `child`/`children` wrapper. A component with a kind-restricted default slot constrains the list
   element type (`List (Element { menuItem | … })`); an `any` default slot takes `List (Element any)`.

2. **Named slots stay as per-slot setters, now `Element -> Element`.** A named-slot setter stamps
   `slot="name"` (the existing `M3e.Element.withSlot` primitive) and returns a placed `Element`, so it
   drops into the *same* single `List Element` as the default children. Its input type is the guidance:
   `Card.actions : Element { button } -> Element` still steers you, it just no longer produces a distinct
   type the container must re-check.

3. **`M3e.Content` / `M3e.Content.Internal` retire on this layer.** The slot-tagging primitive collapses
   into `M3e.Element.Internal` (which already carries `withSlot`). The for/id auto-wiring primitive
   (`slotWithAttr`, [ADR 10](0010-hand-zero-native-ir.md) R6) relocates to an attribute setter.

4. **The M3e-layer phantom rows are *guidance*, not a soundness boundary.** They steer authoring
   (which setter to call, what kind a slot wants) and drive the generator/converter; they are explicitly
   **not** relied on for absolute composition truth.

5. **The removed guarantees move to codegen-aware elm-review** (extends [ADR 12](0012-codegen-aware-elm-review.md)):
   - *Known slot names* — a child stamped with a `slot=` the container doesn't declare is a lint error
     (the negative of `PreferSpecificSlot`; data already in the `slotRewrites` facts).
   - *Required slots* — promoted from advisory to a hard rule (was partly leaning on the phantom
     required-record).
   - *Allowed child kinds per slot* — a **new** fact `slotKinds` (sourced from each `SlotSpec.kinds`,
     already in codegen scope) and a new rule (`Cem.ValidSlotKind` / `NoForeignSlotChild`). This is the
     one guarantee that becomes strictly weaker than a type check: it is advisory where a child's kind
     can't be resolved statically. That is an accepted trade for this layer.

## Consequences

- **Ergonomics:** the common case reads like `elm/html` — `M3e.Toolbar.view [] [ button1, button2 ]` —
  and mixed default+named lists simplify (both are just `Element`s: `[ NavMenuItem.icon i, label ]`).
- **Blast radius (large; see the plan):** `elm-cem/codegen/Generate.elm` (③/④ view + setter emission,
  Facts `slotKinds`), the runtime `Content` modules retire, ~all of `packages/m3e/src` regenerates
  (`child`/`children` drop from ~133 modules; `Content` leaves the surface), the HTML→Elm converter
  (`to-elm.mjs`) stops wrapping default children, `elm-review-cem`'s `Fact` gains `slotKinds` (breaking
  bump) + new rules, `GoldenTest.elm` and the converter tests rewrite, ~71 hand-written call sites across
  ~24 files migrate, and the userland `Seam` moves from `Content.Internal` to `Element.Internal`.
- **Guarantee timing:** composition safety shifts from compile-time/structural to lint-time on M3e. The
  new/promoted elm-review rules **must be green before the phantom guarantee is removed**, or there is a
  window with neither.
- **`Record`/`Build` unaffected:** they remain the layers to reach for when you want the strong,
  type-enforced guarantees; this ADR sharpens that division of labor rather than weakening it.

## Open questions (to settle in the plan/review)

- Confirm the single-`List Element` mechanism (this ADR's assumption) over a two-argument
  `view attrs defaultChildren namedSlots` split — the single list is preferred (preserves source order,
  one uniform shape) but the codegen change should validate it against the Record required-content shape.
- Exact home for the relocated for/id (`slotWithAttr`) auto-wiring — an attribute setter vs a thin
  `Element` combinator.
- `slotKinds` rule severity on statically-unresolved children (advisory vs off) and how it reports.
