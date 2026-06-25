# 3. Remove `Ui.Carousel` — out of scope for `@m3e/web`

Date: 2026-06-24

## Status

Accepted

## Context

`Ui.Carousel` wrapped `m3e-slide-group` + `m3e-slide` (matraic's `<m3e-slide-group>`,
a horizontal slide track). It rendered blank in practice: slides collapsed to
`0×0` because the wrapper didn't supply the sizing config the slide-group needs.
While debugging, the deeper question surfaced: does Material 3 Expressive
(`@m3e/web`) **actually provide a carousel**?

It does not. matraic's component set explicitly omits a carousel — Slide Group
is a low-level scroll-track utility, not a full Material carousel surface. The
public component catalog lists 52 components; "Carousel" was an abstraction we
were authoring on top of a slide track that wasn't designed for it.

## Decision

Remove `Ui.Carousel` entirely (module + test + reference entry + component
demo). Keep `Ui.Slide` (the real `m3e-slide-group` utility — a documented
matraic component) for direct horizontal-scroll uses. Where carousels appeared
in studies (Crane and Shrine "featured" rows), replace with the simplest plain
layout that satisfies the intent: a Tailwind `flex gap-N overflow-x-auto` row
of card builders. Documented `Ui.*` set is now 52 components.

## Consequences

- One fewer module to maintain and document; the catalogue matches what
  matraic actually ships.
- The "identify the right layer" lesson: the fix wasn't in the builder or the
  atom — it was a scope decision. Anything matraic doesn't model is
  out-of-scope at Layer 4 too.
- If/when matraic adds a real carousel element, `Ui.Carousel` is the first
  thing to add back; until then, `Slide` + plain layout covers every use we
  found.
