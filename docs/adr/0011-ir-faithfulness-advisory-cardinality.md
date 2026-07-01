# 11. IR faithfulness; cardinality & required-presence are advisory, not typed

Date: 2026-06-30

## Status

Accepted. Refines the slot model of [ADR 8](0008-three-layer-generator-retarget.md)
and [ADR 9](0009-composition-over-injection.md). Governs how the top layer's
`view`/builder is shaped and what the DECL's `multi`/`required` fields drive.

## Context

Slotted content raises two questions the type system *could* answer but at a cost:

1. **Cardinality** — some named slots are singular (one `icon`), others hold many
   (AppBar `trailing` renders "one or more" action buttons; slotted children
   **accumulate**, they do not collapse — `elm/html` last-wins applies to
   *attributes*, never to slotted children).
2. **Required presence** — a Button with no label, a TreeItem with no label, is a
   broken component.

A type-level guarantee is achievable: put singular slots in a record (a field is
present exactly once; `Maybe` for optional-singular), required slots as plain
fields. But every option costs ergonomics — optional-singular becomes `Maybe`
fields the caller must spell `Nothing` for (TreeItem alone has four icon slots),
and it forces a required record onto every component. Weighed against the project's
values (**uniformity > per-component ergonomics**, and *"the code you write should
match the code that appears in the browser"*), the record tax was judged worse than
the guarantee is worth.

## Decision

Two principles are decided here. **The exact top-layer API *shape* is explicitly
deferred** — see "Deferred" below.

**Principle 1 — IR faithfulness.** The generated IR emits exactly what the caller
composed, never silently adding, dropping, deduplicating, or reordering. Multi-slots
accumulate in author order; duplicate attributes pass through (the browser resolves
last-wins); nothing is deduplicated on the caller's behalf.

**Principle 2 — enforcement splits by what each invariant is worth at the type level:**

- **Type level (kept — this is the MISI that matters):** *kind* and *capability*
  validity, via the extensible phantom rows. A wrong attribute or a wrong-kind slot
  child is a compile error. This is never relaxed.
- **Advisory (generated lint + docs):** *cardinality* and *required-presence*. The
  DECL's `multi: false` emits an elm-review rule ("this slot is singular") + a doc
  note; `required: true` emits a rule ("this component needs this slot") + a doc
  note. Neither changes the shape of any type, and neither mutates output.

A compile error from the phantom rows is **not** a violation of faithfulness — it
rejects invalid input before anything is built; it never rewrites valid input.

## Deferred (open follow-up)

**How optional attributes and optional slots are passed is NOT decided.** The
single-unified-list sketch (`name [ attrs ∪ slots ]`) was walked back — we are not
sold on it yet. For now:

- **Required slots go in a required record** (a field is present exactly once, which
  also pins their arity naturally).
- **Optional slots are NOT put in the record as `Maybe` fields** (the `Nothing`-noise
  that motivated Principle 2's advisory stance still applies).
- **The optional-slot arrangement** (one unified list vs. a separate slot list vs.
  per-slot setters vs. something else) is an **open question to investigate later.**

Principles 1 and 2 are shape-independent and hold regardless of how that resolves.
The DECL/config authoring is likewise shape-independent: per-slot `kinds`/`multi`/
`required` is the same data whatever the eventual surface.

## Consequences

- **`multi` / `required` are lint+docs inputs, not type-shape inputs.** The DECL
  schema (`kinds` / `multi` / `required`) is unchanged; only the generator's
  interpretation is.
- **Cardinality/required mistakes compile.** They surface as elm-review diagnostics
  and documented warnings, and — faithfully — as the same broken render the raw
  component would produce. Accepted deliberately.
- **New generator output:** codegen'd elm-review rules (one family for singular
  slots, one for required slots) shipped alongside the library for consumers to opt
  into.
- **Reversible-ish:** if a type-level guarantee is later wanted for a specific slot,
  moving it into a record is a localized change; the faithfulness principle for
  everything else stands.

## Related

- Userland kind-producers (`text`, `link`) are the extensibility seam the options
  list plugs into — provided as copyable examples, **not** shipped in the package.
  See [ADOPTION_AND_SLOTS.md](../ADOPTION_AND_SLOTS.md) §3.
