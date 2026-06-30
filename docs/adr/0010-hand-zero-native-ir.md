# 10. `Hand = ∅` for components; native-HTML IR constructors

Date: 2026-06-30

## Status

Accepted. Builds on [ADR 8](0008-three-layer-generator-retarget.md) and
[ADR 9](0009-composition-over-injection.md). **Supersedes the ~13-module
`R-HAND` list** in the generator-requirements.

## Context

The generator-requirements audit projected an irreducible ~13-module hand layer
("capture ceiling ≈ 80%"). Re-examination — with composition over injection
([ADR 9](0009-composition-over-injection.md)) and native-HTML IR — found **zero
runtime-imperative component cases**: every claimed-`Hand` module is a pure
IR-producing function expressible as composition. The two stragglers resolve
without hand code:

- **Label** is not a component — it is a `Html`-newtype governance seam. The
  text-resolver model (R11) already subsumes it.
- **SplitButton**'s only hand aspect was calling `Button.view`; it becomes a
  typed-slot container the consumer fills.

## Decision

**The library has zero hand-written component modules.** Enablers:

- **Native-HTML IR constructors.** The native elements that get placed into a
  typed/named slot (`input`, `textarea`, `label`, `img`, `video`, `a`, `span`)
  are first-class `Element` constructors with **flat** phantom rows
  (`nativeHtmlInput`, `nativeHtmlTextarea`, …), so composing one into a typed slot
  is provably valid. Scope is deliberately narrow: IR **only** the natives that go
  into a slot (they must be introspectable to receive a stamped `slot=`); arbitrary
  native HTML in a default-slot region stays the `html`/`fromRawHtml` escape.
- **Label → a type alias** for placeable content
  (`Element { s | element : Supported } msg`) with `M3e.text` as default
  constructor; a team's translation element is just another constructor of the
  same type. No governance newtype/module.
- **Accessibility by structure.** Wrapping components (e.g. RadioButton's
  `<label><m3e-radio>…`) get implicit label association for free — m3e controls are
  form-associated/labelable (`core.js` `_Labelled` mixin). Sibling-slot components
  (`m3e-form-field`, which performs no association) take a **required `id`** field;
  the generator wires `for=id` + `id=id` from it.
- The IR core (including these native constructors) is generator-emitted
  ([ADR 8](0008-three-layer-generator-retarget.md)) — foundational, not component
  code. "`Hand = ∅`" is about **component modules**.

## Consequences

- "Eliminate the hand layer" is literal for components. The residue is generated
  core + app-level patterns: e.g. Snackbar's imperative `open` is a documented
  JS-wrapper + port the *app* owns, not a binding module — its declarative node
  generates normally.
- **Uniformity dividend** (the motivating value): every component comes from the
  same generator, so learning 2–3 components generalizes to the whole library.
  This is why per-component hand ergonomics were dropped — they would be
  inconsistent and break that inference.
- The native scope may later widen to a fuller HTML mirror if the `html` escape
  proves too coarse for in-slot composition. Deferred (YAGNI).
