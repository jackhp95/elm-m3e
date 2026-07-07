# 9. Composition over injection — eliminate the element-injection primitive

Date: 2026-06-30

## Status

Accepted. Builds on [ADR 6](0006-m3e-architecture.md) (typed slots) and
[ADR 8](0008-three-layer-generator-retarget.md). **Supersedes the "element
injection stays HAND" position** in the generator-requirements R8.

**Superseded in part by [ADR 15](0015-unwrap-default-slot-phantoms-as-guidance.md):**
on the M3e top layer the double-list `Content` wrapper (`child`/`children`) is
retired — default children are raw `Element`s and named slots are
`Element`-returning setters — with the composition guarantees this ADR encoded in
types moved to codegen-aware elm-review. The two-mechanism model (typed slots +
container/item families) is unchanged.

## Context

The generator-requirements audit found a class of components whose hand wrappers
**inject** extra structure: Slider auto-adds a `<m3e-slider-thumb>` child;
BottomSheet appends an `<m3e-bottom-sheet-action>` sentinel to each action;
SplitButton nests a `Button`; form controls inject native `<input>`/`<textarea>`/
`<label>`. The first design absorbed these with a declarative element-injection
config primitive (`wrap`/`children`/`siblings`/`native`/`selectBy`/`stampId`/
`slotChildDecorations`).

Reading the **real `@m3e/web` source** dissolved that primitive. Every case is
already a *composition*, not an injection:

- `m3e-slider` renders **consumer-supplied** `<m3e-slider-thumb>` children, capped
  at two — `isRange = thumbs.length > 1`. One thumb = single value; two = range.
- `<m3e-bottom-sheet-action>` is a **close-on-click trigger** member (it listens
  on its `parentElement` and calls `closest("m3e-bottom-sheet").hide()`).
- SplitButton's leading is **just a `Button` in a slot**.
- Form controls are **native elements** that belong in typed slots.

## Decision

**Always model added structure as composition, never injection.**

- m3e child elements → [[Decl]] R5 container + typed item-family members
  (`Slider.thumb`, `BottomSheet.action`, …) or R4 typed slots (SplitButton leading).
- native HTML that must sit in a typed/named slot → first-class native-HTML IR
  constructors the consumer composes in (see
  [ADR 10](0010-hand-zero-native-ir.md)).

The element-injection primitive is **eliminated**. The whole library reduces to
**two mechanisms** — R4 (typed slots, closed rows) and R5 (container + item
families) — over an element set of m3e tags **plus slot-placed native HTML**.

## Consequences

- The config schema shrinks: no injection section. `slots.json` (accepted kinds
  incl. native, `arbitraryAllowed`, `wrap` mode) + `overrides.<component>` (R5
  groups, R6, R7, R9, R11, R12, R13, R-EXTRA).
- Range sliders (two thumbs) and similar fall out for free; the old
  single-injected-thumb binding was simply an incomplete binding.
- **Guardrail.** Composition templates only. If a future component genuinely needs
  runtime/imperative node-rewriting (none in the current set — verified against
  source), *that* is the true [[Hand]] boundary — not a reason to reintroduce
  imperative config.
- BottomSheet's close stays imperative in m3e (the action calls `hide()`); the
  wrapper keeps Elm's `open` state in sync via the close event / `onClose`.
