# 7. `attributes` host escape on host-box components

Date: 2026-06-27

## Status

Accepted. Realizes the "`withAttributes` host hatch" rule that
[ADR 4](0004-styling-free-builders.md) said **stands**, under ADR 6's bare
option-naming convention (`attributes`, not `withAttributes`).

## Context

The `M3e.*` builders are styling-free (ADR 4): a component sets only the
attributes/properties/slots its element actually observes, and bakes no layout
or color. But several `@m3e/web` elements hard-set their own host box, so a
caller **cannot** size or color them from the outside without touching the host:

- `m3e-shape` — `:host { width: var(--m3e-shape-size, 3rem); aspect-ratio: 1/1 }`
- `m3e-scroll-container` — `:host { display: block; height: auto }` (won't
  stretch to a bounded flex parent, so `overflow-y` never engages)
- `m3e-skeleton` — `:host { display: contents }` (generates no box)
- the progress indicators — fill color reads `--m3e-progress-indicator-color`,
  **not** the inherited `color` property

The M3e port dropped the host hatch ADR 4 had specified, so these were
un-sizable / un-colorable (issues #21, #23, #24).

## Decision

Host-box components expose an escape option:

```elm
attributes : List (Node.Attr msg) -> Option msg
```

It appends raw attributes to the **host** element (e.g.
`Shape.attributes [ Node.rawAttr (class "h-36 w-full") ]`,
`Progress.attributes [ Node.rawAttr (style "--m3e-progress-indicator-color" "var(--md-sys-color-error)") ]`).
Applied so far to `Shape`, `ScrollContainer`, `Skeleton`, `Progress`; add it to
any other component whose host needs caller-driven sizing/styling.

## Consequences

- Restores ADR 4's intended host hatch; styling stays *opt-in via the escape*,
  never baked into the default render.
- The escape is `List (Node.Attr msg)` (IR attrs), so callers reach for
  `Node.rawAttr` for classes/styles — consistent with the rest of the IR.
- Not every component needs it; leaf controls (Button, Checkbox…) intentionally
  omit it to keep their surface tight.
