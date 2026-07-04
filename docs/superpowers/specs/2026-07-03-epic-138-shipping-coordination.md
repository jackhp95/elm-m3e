# Epic #138 shipping coordination

Date: 2026-07-03
Companion to: [ADR 0013 (amended)](../../adr/0013-top-shape-matrix-and-translation.md),
[top-shape gradient spec](2026-07-03-top-shape-gradient-design.md),
[spike design](2026-07-03-build-shape-codegen-spike-design.md) +
[result](2026-07-03-build-shape-codegen-spike-result.md).

## Purpose

Workstreams B (generator), C (facts), and D (rules) each get their own
brainstorm → spec → plan cycle. This document keeps them coherent by pinning
which pieces ship together, the cross-spec invariants each design must
respect, and the order specs get written.

## What ships together, what ships apart

**First ship — the ③/④ safety net.** Ships as a coordinated release across
three specs, none of which is useful without the other two: ③ is meaningless
without missing-required rules; the rules can't fire without the facts; the
facts have nothing to describe without the generator emissions.

- *Generator.* Shape selector replacing the `hasRecord` fork; uniform ③
  emission (all components, with action-attr re-exposure for required-bearing
  ones); ④ emitted only when the required record has ≥1 field.
- *Facts.* Adds `requiredAttrs`, shorthand↔specific attribute pairs, and
  per-component shape/arity metadata to `M3e.Review.Facts`.
- *Rules.* Missing required attribute, missing required singular slot, wrong
  arity, `PreferSpecificSlot` shorthand→specific auto-fix, and hardening
  `RequireSlot` against non-literal content.

**Second ship — ⑤ `M3e.Build.*`.** A single generator spec plus a hand-written
`M3e.Build.Internal` for the `Available`/`Used` markers. Purely additive
namespace; no consumer-facing coupling to the first ship. The spike result
captured the operational learnings this emitter needs.

**Third ship — codegen-aware translator.** The elm-review rule that translates
a call between any two of the five surfaces (spec §5's lattice). Ships last
because it needs all shapes to exist to be worth writing.

## Cross-spec invariants (first ship)

The three first-ship specs must agree on the points below; each spec's
Definition of Done verifies it against the others as written. These
invariants are *binding on all three brainstorms* — a design decision in one
spec that violates them is a coordination bug and blocks the ship.

Every `requiredAttrs` fact the generator emits is a real per-component
required attribute drawn from CEM + config. The missing-required-attribute
rule consumes this field verbatim; a fact the rule can't consume, or a
required attribute with no fact, is a coordination bug.

Every shorthand↔specific pair the generator emits (`variant` ↔
`variantButton`) comes from the same setter-name resolution the top-layer
setters already use. The `PreferSpecificSlot` auto-fix drives its rewrites
off this field; the shorthand a user writes must map to a specific setter
that actually exists in the generated top module.

Per-component shape/arity metadata reflects exactly what shapes ③ and ④
actually take at that component — which shapes exist, arity per shape,
attr-vs-slot classification of every parameter. The wrong-arity rule consumes
this to know how many arguments a call at a given surface should have; a
mismatch between metadata and the emitted `view` type is a coordination bug.

The facts module cannot expose ⑤-specific fields in the first ship; ⑤ has no
rule dependency and its metadata is deferred to the second ship's spec.

## Order specs are written

Generator first — it pins what gets emitted, and the other two need that
answer before they can describe or consume it. Then facts, which describes
the evidence extracted from CEM + config for the rules. Then rules, which
consume facts to enforce guarantees. Then the ⑤ generator spec. Then the
translator spec.

Each spec follows the standard brainstorm → design doc → plan → implement
cycle. The generator, facts, and rules specs cross-reference this document
so the invariants are load-bearing on every subsequent design decision.

## Where each spec lives

- *Generator (first ship):* to be drafted, `2026-07-XX-generator-shape-selector-design.md`.
- *Facts (first ship):* to be drafted, `2026-07-XX-review-facts-expansion-design.md`.
- *Rules (first ship):* to be drafted, `2026-07-XX-review-rules-safety-net-design.md`.
- *⑤ generator (second ship):* to be drafted, `2026-07-XX-build-shape-emitter-design.md`.
- *Translator (third ship):* to be drafted, `2026-07-XX-codegen-aware-translator-design.md`.

Dates fill in as each spec is drafted.
