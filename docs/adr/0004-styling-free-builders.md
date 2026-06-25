# 4. Builders are styling-free; expose escape hatches

Date: 2026-06-24

## Status

Accepted

## Context

Building the docs site against `Ui.Card` exposed two related questions:

1. Where does the M3 typescale come from for card title text?
2. How does a caller add `class "h-full"` to a card to make it stretch in a
   grid?

A first attempt baked `class "text-title-medium"` into `Ui.Card`'s headline
renderer. That is exactly the wrong move at Layer 4: builders that hardcode
styling defeat the bridge (`tailwind-m3e-web`), drift from the M3 tokens the
elements already produce on their own, and prevent callers from composing
layout decisions cleanly.

Separately, the audit found that 50 of 52 `Ui.*` builders had no way to
attach a caller-supplied `class`/`data-*`/`aria-*`/event handler to the
underlying host element. The only options were "fork the module" or "wrap
in a `<div>` (which breaks the typed-slot contract upstream)."

## Decision

A Layer-4 `Ui.*` builder is bound by three rules:

1. **No baked styling.** A builder must never hardcode a `class "…"` /
   Tailwind / token class by default. Structural attributes from `M3e.*`
   (slots, variant/size enums) are fine — those *are* the contract.
2. **The only dependencies are `M3e.*` modules and other `Ui.*` builders.**
   No styling/bridge/external deps; no `tailwind-m3e-web` imports.
3. **Every builder exposes a `withAttributes : List (Attribute msg)`
   escape hatch** that **appends** the caller's attributes to the **root
   host element's** attribute list, **before** the builder's own structural
   attributes (so `variant` / `slot` / `id` win on conflict).

Content slots prefer **typed builder inputs** (another `Ui.*` type) when the
slotted alternatives form an enumerable set we want to enforce, with a
parallel `with<Slot>EscapeHatchHtml : Html msg` for the rare arbitrary-Html
case. Inherently arbitrary slots (`Card.media`/`body`/`footer`,
`AppBar.leading`/`trailing` — see [ADR 5](0005-heterogeneous-chrome-slots.md))
stay `Html msg`.

Where text-bearing slots want a terse call site without dropping back to
arbitrary `Html`, the typed builder side provides preset constructors:
`Ui.Heading` ships `display`/`headline`/`title`/`label : String -> Heading`
so `Card.withHeadline (Heading.title "Featured")` reads as a one-liner while
the M3 typescale still comes from the `m3e-heading` element (zero baked
classes).

## Consequences

- **Style flows top-down at the call site, not bottom-up from the library.**
  The `tailwind-m3e-web` bridge stays the single source of styling truth.
- **The 52-builder rollout was nearly mechanical**: per
  [`docs/research/builder-audit.md`](../research/builder-audit.md), 0
  modules baked styling (only `Ui.Toc` had a dead `ui-toc-auto-width` class
  — removed), 34 builders accepted the hatch by mechanical retrofit, and 14
  were "tricky" only because the host element is chosen at render or
  construction time (dual-root form-field controls, dispatch dual-root,
  ctor-gated panels, wrapper-with-subscripts).
- **Tests pin the contract**: `Ui.Card`'s suite asserts a caller `class`
  reaches the host AND that the structural `variant` survives an attempt to
  clobber it via `withAttributes` (caller attrs are emitted first, structural
  attrs last).
- **`Ui.Shape.withClass` / `Ui.Skeleton.withClass` are kept** as caller-owned
  conveniences (they accept a list of strings the caller hands in — not baked
  styling). They overlap with `withAttributes` and may be deprecated later,
  but their ergonomics at the studies' call sites earn their keep for now.
- **`elm-review` enforces the rule**: `NoProprietaryDsClasses` (a custom rule
  in `review/src/`) flags any `class "ds-*"` / `class "t-*"` regression; CI
  runs the rule on every push.

## Notes

- The audit's first cut suggested converting `AppBar.leading`/`trailing` to
  typed `Ui.IconButton` lists. Real consumers (Reply, Rally) mix
  `Search`/`Avatar`/brand icons with action buttons, so those slots are
  inherently heterogeneous. See [ADR 5](0005-heterogeneous-chrome-slots.md)
  for the refined rule.
- The `IconButton` enhancement that *did* land — `withTarget`/`withRel`/`withDownload`
  to round out its anchor surface — lets an "external link" be a single typed
  `Ui.IconButton` (no `<a>` wrapper), which is the kind of typed-slot win we
  reach for first.
