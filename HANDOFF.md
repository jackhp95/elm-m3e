# HANDOFF — start here

The single "read this first" doc for resuming work. Written 2026-07-01. If a doc
below contradicts this file, this file is newer — but verify against the code.

## Current on-disk state (honest — it's mid-refactor)

- `packages/m3e/` **ships the generated library** and compiles green
  (`cd packages/m3e && elm make`). The old hand `src/M3e` + `vendor/` are gone.
- The generator (`elm-cem/`, a separate repo cloned in, gitignored) emits it from the
  `@m3e/web` CEM + `config/slots.json`.
- **We are mid-way through the "component-agnostic / Vocab" redesign.** The generated
  output is an **intermediate hybrid**, NOT the final shape:
  - ✅ shared attrs collapsed to one module; component top-modules are constructor +
    slot setters (no per-component attr setters).
  - ⚠️ **BUG (known):** that shared module is `M3e.Attr` and its setters return
    `Html.Attribute msg`, **not** the phantom `M3e.Cem.Attr.Attr { c | cap } msg` the
    constructors require — so there is currently **no working way to pass an attribute
    to a top-layer component.** It compiles only because nothing consumes it yet.
  - ❌ the final **`Vocab`** architecture is DOCUMENTED (`docs/COMPONENT_AGNOSTIC_API.md`
    §9b) but NOT built. `M3e.Attr` is a superseded intermediate — the end state has
    **no `M3e.Attr`**; the vocab is it.

## The immediate next build (do this first)

Implement the Vocab architecture (`docs/COMPONENT_AGNOSTIC_API.md` §9b, build order).
Step 1 both *fixes the bug* and is the foundation:

1. **Phantom attr emit.** In `elm-cem/codegen/Emit.elm`, the four setter emitters
   (enum ~L185, property ~L211, string ~L226, builtin ~L267) all end
   `|> Elm.withType (Type.function [..] htmlAttr)` where `htmlAttr` (L28-29) is
   `Html.Attribute msg`. The vocab needs its OWN emit that instead wraps each in
   `M3e.Cem.Attr.attribute` and returns `M3e.Cem.Attr.Attr { c | <cap> : Supported }
   msg` — exactly how the *middle* already does it (`M3e.Cem.Button.disabled =
   M3e.Cem.Attr.attribute M3e.Cem.Html.Button.disabled`). Do NOT flip `Emit` globally —
   the BOTTOM modules use it and must stay raw `htmlAttr`. **Subtlety:** the middle
   wraps a *per-component* bottom (`M3e.Cem.Html.Button.disabled`); a SHARED vocab has
   no single component, so either construct the html inline in the wrapper or emit a
   shared bottom vocab and wrap that.
2. `M3e.Cem.Vocab` (internal) = the phantom attr/event vocab, defined once.
3. `M3e.Vocab` (internal) = top-only new concepts (constructors → `Element`,
   `Content`/slot setters). Reuses the middle attr vocab (same `Attr` phantom).
4. Barrel `M3e` = pure aliases of the full vocab; it is the compile-time collision
   guard. **Also fix:** barrel re-bindings currently have NO type annotations
   (`accordion = M3e.Accordion.accordion`) — materialize them.
5. Component modules `M3e.<Comp>` = aliases, suffix-stripped, constructor → `view`
   (grouped/variant-split modules keep natural names — can't have two `view`s).
6. elm-review rules (generated) — `PreferSpecificSlot`, `ValidEnumValue`, and the
   ADR-0011 advisory `RequireSlot`/`SingularSlot`. AFTER core lands. The hand rules in
   `review/` are OLD-era artifacts, unrelated — decide delete vs keep later.

Verify each increment: regenerate via `elm-cem/bin/elm-cem.js` (NOT bare `elm-codegen
run` — see FRICTIONS F10) into `packages/m3e/src`, then `cd packages/m3e && elm make`
(all ~383 modules) + a negative-probe scratch file that must FAIL to compile.

## Then: migrate consumers (blocked on the above)

The docs app (`docs/`, elm-pages, ~18 files) still uses the OLD `.view` API and does
NOT compile against the new library. Migrate it (and later sibling repos) — see
`docs/MIGRATION_OLD_TO_NEW.md` **but note it's written against the SUPERSEDED
per-component-setter API and must be rewritten to the Vocab API first.** Tooling +
environment (the GPU box, ornith, elmq, the agent harness): **`docs/MIGRATION_TOOLING.md`.**

## Read order for the design
1. `docs/THE_COMPLETE_EFFORT.md` — vision + every decision.
2. `docs/COMPONENT_AGNOSTIC_API.md` — the CURRENT target API (Vocab). §9b is authoritative.
3. `docs/ADOPTION_AND_SLOTS.md` — slot model, `any`, escapes (§8).
4. `docs/adr/0008`–`0011` — architecture decisions (0011 = faithfulness + advisory cardinality).
5. `docs/THREE_LAYER_PATTERN.md`, `docs/MIGRATION_OLD_TO_NEW.md` (stale re: API shape),
   `README.md`, `FRICTIONS.md` (the F-numbered gotchas), `docs/MIGRATION_TOOLING.md`.

## Non-obvious learnings (don't re-derive)
- **`bin/elm-cem.js`, never bare `elm-codegen run`** (F10 — it does TS-alias inlining;
  bare run degrades enums to `String`).
- **Escapes are userland, NOT in the package**: `Kit`/`Native`/`EscapeHatch`/`Seam` live
  in `packages/m3e-kit/` (copyable examples). `any` = a lowercase type var (no alias).
- **Node-level vs Element-level migration differ** (MIGRATION §1b): `Node msg`-returning
  layout code → `Node.raw (Html.*)` (correct there); `Element`-returning component code →
  the kit (`EscapeHatch`/`Native`). `Node.raw(Html…)` is an ANTI-PATTERN at the Element level.
- **Loose types + elm-review**, not maximal strictness: same-name-different-type attrs →
  type-suffix (`value`/`valueFloat`); per-component enum-value validity → the generated
  `ValidEnumValue` rule; slot general+specific → `PreferSpecificSlot` autofix.
- **`config/slots.json` is hand-rolled and may be wrong** — the loose+review approach is
  deliberately forgiving so config can be fixed iteratively.
- The CEM the config was built against: `docs/node_modules/@m3e/web/dist/custom-elements.json`.
