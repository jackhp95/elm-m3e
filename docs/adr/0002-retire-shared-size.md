# 2. Retire the shared `Ui.Size`; let `Ui.Heading` own its size

Date: 2026-06-23

## Status

Accepted

## Context

`src/Ui/Size.elm` exposed a single global three-step scale:

```elm
type Size = Small | Medium | Large
```

It was imported by exactly one module — `Ui.Heading` (`grep -rn "import
Ui.Size" src/` returns only `src/Ui/Heading.elm`). Every other sized builder
(`Ui.Button`, `Ui.IconButton`, …) already defines its *own* size type, because
Material 3 defines sizes **per component**, not as one shared global scale. The
`m3e-*` elements bear this out: a button's size enum, an icon-button's size
enum, and `m3e-heading`'s `small | medium | large` are independent contracts
that happen to overlap for headings.

A shared `Ui.Size` therefore implied a cross-component scale that Material does
not have, and coupled `Ui.Heading` to a module no one else used.

## Decision

- Define a three-step `Size = Small | Medium | Large` **inside**
  `src/Ui/Heading.elm`, matching the CEM `m3e-heading` `size` enum
  (`small | medium | large`, element default `medium`).
- Expose it as `Size(..)` from `Ui.Heading` and update `withSize` /
  `toM3eHeadingSize` to use the local type.
- **Delete `src/Ui/Size.elm`.**

Verified that nothing else in `src/` imports `Ui.Size` before deleting.

## Consequences

- Each component owns its own size vocabulary, matching Material 3's
  per-component sizing and the existing pattern set by `Ui.Button` et al.
- One fewer module; no shared type pretending to be a universal scale.
- `Ui.Heading.Size` is now part of Heading's public surface (`@docs Size,
  withSize`). Consumers that imported `Ui.Size.Size` for headings switch to
  `Ui.Heading.Size`.
- No behavioural change to the rendered element — the same `small | medium |
  large` values map to the same `m3e-heading` `size` attribute.
