# The complete effort — what we're building and why

> The single source of truth for the whole effort: the vision, the goals and their
> rationales, every locked decision and *why* it was chosen, and the journey of
> corrections that produced the design. Written 2026-06-30. If anything below
> conflicts with an older doc, this and the ADRs win.
>
> Read order: this → [THREE_LAYER_PATTERN.md](THREE_LAYER_PATTERN.md) (the technical
> core) → [ADRs 0006–0010](adr/). Glossary: [CONTEXT.md](../CONTEXT.md).

---

## 1. The vision (one paragraph)

A **CEM-driven code generator** (`elm-cem`, library-agnostic) emits a **stack of
progressively safer Elm APIs** over any web-component library's Custom Elements
Manifest. For Material 3 Expressive (`@m3e/web`) the output is a strongly-typed,
Make-Impossible-States-Impossible wrapper with **zero hand-written component
modules** — every component, across three layers, comes out of the generator from
the CEM plus a small declarative config. You learn 2–3 components and you know the
whole library, because they all came from the same machine.

## 2. The goals — and why each one

| Goal | Why |
|---|---|
| **Generate the whole surface, not just atoms** | The hand layer was the worked example of "what the generator should emit"; every deviation from naive codegen is a generator requirement. Generating it removes drift and manual upkeep. |
| **Three layered APIs (escape gradient)** | Safety + convenience at the top, raw control at the bottom, with explicit, louder steps to drop down. The correct way and the easy way coincide; escape hatches exist for inevitable shortcomings. |
| **`Hand = ∅` for components** | Hand-rolled components are *inconsistent*; that breaks the "learn a few, know them all" property. Uniformity from one generator beats per-component ergonomic tuning. (This is the user's overriding value: **uniformity > ergonomics**.) |
| **Composition over injection** | Added structure (slots, child elements, native controls) is always built by the consumer composing pieces, never by the generator injecting into caller nodes. Two mechanisms total: typed slots + container/item families. |
| **Phantom-typed, Make-Impossible-States-Impossible** | The invariant is the **Material 3 spec + accessibility**, not the DOM. The type system — extensible phantom rows — prevents invalid component/attribute/slot compositions at compile time. |
| **Regenerate-on-release** | This repo becomes config + 100%-generated output; a new `@m3e/web` release regenerates and "just works." |

## 3. The reduction layers — Mech / Decl / Hand

How much of the surface the generator can own, from the requirement audit:

- **Mech** — derivable from the CEM alone (DOM-property correctness, the `Value`
  vocabulary, the layer shapes). No external input.
- **Decl** — needs a small declarative config (slot typing, multi-tag grouping,
  required content, event decoders, renames). **Never** imperative function-body
  injection — if it can't be expressed declaratively, it's Hand.
- **Hand** — irreducible. **Target: ∅ component modules.** The residue is the
  generated IR core + app-level patterns (e.g. Snackbar's imperative `open` is a
  documented JS+port the app owns, not a binding module).

## 4. The output layers — the three-layer pattern

The full technical spec is [THREE_LAYER_PATTERN.md](THREE_LAYER_PATTERN.md). In
brief: **it's all partial application.** The bottom layer is partially-applied
`elm/html` (tag/name baked in). The middle collects those partial applications into
a lazy IR for *attributes* and eagerly builds `Html` when a component is applied.
The top does the same deferral for *component composition*, holding everything in
the IR until one `toHtml` at the root. Three extensible phantom rows
(`Value` / `Attr` capability / `Element` kind) make every composition compile-checked.
Names exist exactly once (baked into the bottom, passed up as functions). The IR
exists for **composition** (associating elements via `slot=`), not introspection.

```
M3e.* (top, lazy IR + kind rows) → M3e.Cem.* (middle, IR attrs + eager component)
  → M3e.Cem.Html.* (bottom, partial-applied elm/html) → raw elm/html
```

## 5. Repos and roles

- **`elm-cem`** — the library-agnostic generator. **Stays a separate repo; no m3e
  opinions; combining it in is a hard no.** It will target other CEM libraries
  (Fluent, Calcite, Web Awesome, Warp, Shoelace …). Currently cloned into `./elm-cem`
  (gitignored) to work on; push upstream, then delete the clone.
- **`elm-m3e`** (this repo) — runs `elm-cem` on the m3e CEM **with** a config, and
  ships the generated output. Becomes config + generated layers, regenerated on
  release.
- **Other binding repos** (`elm-fluent-ui`, `elm-calcite`, `elm-web-awesome`,
  `elm-warp`, `elm-shoelace`) — generated **config-free** (lower layers only). Proven
  generic: the same generator produced correct `Sl.*` for Shoelace with no config.
- **Archived `elm-custom-elements-manifest`** — the original monorepo; *behind*
  `elm-cem` (don't mine it for code). It "still gets mistakenly updated"; ignore it
  as a source.
- The IR core (`Node`/`Element`/`Internal`/`Attr`/`Value`/native-HTML) is
  **generated** (ADR 8, "c1"); the `Value` vocab is manifest-derived.

## 6. Locked decisions and rationales

- **Full three-layer retarget; generate the core** (ADR 8). The config is what makes
  it safe — without config the generator can't know slot typing, so it could only
  produce the lower layers; *with* config it produces the structural top. Reverses a
  narrow earlier "IR-emission rejected" note that applied only to enum *setter*
  outputs.
- **Composition over injection; injection primitive eliminated** (ADR 9). Verified
  against real `@m3e/web` source: slider thumbs / bottom-sheet actions / split-button
  buttons / form controls are all *composition*, not injection. Guardrail: declarative
  templates only; a case that needs runtime node-rewriting would be the true Hand
  boundary (none exists today).
- **`Hand = ∅` for components; native-HTML IR** (ADR 10). Native elements that sit in
  a slot are first-class IR constructors (flat phantom rows, `nativeHtmlInput`…);
  arbitrary native HTML stays the `html` escape. `Label` → a type alias for placeable
  content + `M3e.text`. a11y: wrapping components get implicit label association free
  (m3e controls are form-associated); sibling-slot form-field takes a required `id`.
- **The three-layer partial-application pattern** (THREE_LAYER_PATTERN.md). The IR
  holds un-applied functions; only `toHtml` is eager; strings single-sourced via
  function reuse; IR is for composition; the three phantom rows are mandatory on all
  public return types.
- **Naming**: `M3e.*` / `M3e.Cem.*` / `M3e.Cem.Html.*`, plus one `M3e.Node.toHtml`.
  Generic form `<Prefix>` / `<Prefix>.Cem` / `<Prefix>.Cem.Html`.
- **Config is JSON for the tool; documented with YAML examples.**
- **Prerelease; breaking changes embraced; perfection over compatibility.** No
  back-compat shims, no migration/equivalence testing, do NOT publish any package.
- **Uniformity > per-component ergonomics.** The reason `Hand = ∅` is worth it.
- **Introspection deferred, optional.** The IR is composition-oriented now; the
  introspection seam (`findProperty`) is an easy add later, not built now.
- **The foundational type assumption is proven.** A shared polymorphic attr/value
  used across two differently-shaped consumers does not monomorphize on first use
  (compiled 6-case probe). The design does not need rethinking on that axis.

## 7. The correction journey (the gold — why the design is what it is)

Each step is a wrong understanding of mine and the correction that fixed it. The
corrections *are* the rationale; preserve them.

1. **Hand cases → I proposed a declarative element-injection DSL.** Correction:
   *always composition over injection.* Reading the real components showed every
   "injection" was actually composition. → the injection primitive was deleted
   entirely (ADR 9).
2. **Native controls → I kept them as the last injection case.** Correction: expose
   *IR-friendly native HTML* constructors and compose them into typed slots. → native
   injection became native composition; flat phantom rows (`nativeHtmlInput`).
3. **Layers → I had all three independently calling raw constructors.** Correction:
   *each layer builds on the prior;* the middle was "bottom-quality" and the top
   "bypassed the middle to use atoms directly." → the nesting requirement.
4. **Nesting → I proposed lazy-top / eager-lower with the middle holding Value
   typing.** Correction: the **opaque** `variant` belongs in the *bottom*; the middle
   holds **lazy IR attributes**; the top must **use the middle's atoms**; a single
   `List (Trailing msg)` is wrong because Button has *many* slots.
5. **Reuse → I proposed wrapping the bottom's `Html.Attribute` as opaque `RawAttr`.**
   Correction: don't capture the **opaque result** — capture the **parts** (function
   + value), un-applied; *"if you define the same string on two layers you did it
   wrong"*; functions are first-class — store them.
6. **Parts → I proposed structured single-sourced `Node.Attr`.** Correction: it's
   **partial application** — `Html.node "tag"`, `attribute "name"` are partial
   applications; the middle captures the attr application as IR; the top does the same
   for **component composition**; only `toHtml` applies. Also: the IR is for
   **composition** (add a `slot=` to associate elements), **not introspection**;
   composition is **add-only**; `elm/html` last-wins handles double-set attrs;
   introspection is an easy, optional, later add.
7. **Partial-application model → I dropped the phantom rows from the return types.**
   Correction: *the phantom extensible typing in the return types is non-negotiable* —
   without it the composition guarantees fall apart. → the three phantom rows restored
   on every public signature.

## 8. Status (2026-06-30)

- **Design**: converged and documented (this doc + THREE_LAYER_PATTERN + ADRs).
- **Proof-of-pipeline (M1/M2)**: the generator was made to emit three namespaced
  layers + a top-layer IR component, compile-verified, with an executed IR test
  passing — **but on the OLD IR model.** M1/M2 are now **superseded** by the
  partial-application pattern above and will be revised, not extended.
- **Tooling frictions resolved** (elm-tooling); merged to `main` on both repos.
- **Next build**: write nothing new conceptually — implement the three-layer
  partial-application model in the generator, starting with **Button** end-to-end
  (compile-verified with negative phantom probes). The middle layer *is* enum→`Value`
  (the shared `Value` vocabulary, net-new). Tracking: elm-m3e#71 ↔ elm-cem#1.

## 9. Hard constraints (do not violate)
- Do **not** publish any npm/elm package.
- Do **not** merge `elm-cem` into this repo; keep it library-agnostic.
- The **three phantom rows are mandatory** on public return types.
- **Single-source every string** (no re-typing tags/attr names across layers).
- **Add-only** composition; rely on `elm/html` last-wins for conflicts.
- Leave the docs/examples refactor alone (reserved for a dedicated local-LLM agent).
