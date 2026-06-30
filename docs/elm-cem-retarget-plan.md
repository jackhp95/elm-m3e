# elm-cem retarget — implementation plan

> Phased plan to deliver the converged design: a config-driven generator that
> emits the whole `M3e.*` surface with **zero hand-written component modules**.
> Decisions are recorded in [ADR 8](adr/0008-three-layer-generator-retarget.md),
> [ADR 9](adr/0009-composition-over-injection.md),
> [ADR 10](adr/0010-hand-zero-native-ir.md); the requirement derivation is in
> [elm-cem-generator-requirements.md](elm-cem-generator-requirements.md).

## Shape of the work (two repos, one direction)

```
elm-cem (generic, separate repo)            elm-m3e (this repo)
  ├─ generate IR core (generic)               ├─ config/  slots.json + overrides.* (JSON; yaml in docs)
  ├─ R1 correctness (Mech)                     ├─ <@m3e/web>/custom-elements.json (input)
  ├─ three-layer emitter (Mech)        ──►     ├─ generated/  M3e.* / M3e.Cem.* / M3e.Cem.Html.* + core
  └─ Decl engine (R4–R13)                      ├─ docs + examples (refactored to new API)
                                               └─ tests (IR-introspection + browser contract)
```

`elm-cem` holds **no m3e opinions** — every m3e specific is in this repo's
`config/`. `elm-cem` is cloned in temporarily, changed, pushed, and the clone
deleted. Everything is **prerelease**: breaking changes are embraced; there is no
back-compat to the current hand API to preserve.

## Phases

### Phase 0 — Lock the spec *(this effort — done when the ADRs + spec land)*
ADRs 0008–0010, the converged section of the requirements doc, and this plan.

**Foundational probe — PASSED (2026-06-30).** The load-bearing type assumption —
that a shared polymorphic attr/value used across two differently-shaped consumers
does **not** monomorphize on first use and block the second — was verified by a
compiled probe (6 cases: `disabled`+`onClick` over Button/IconButton, and the
`small` Value token over Button's 5-size vs Fab's 3-size closed rows; each tested
inline, let-bound-unannotated, top-level-unannotated, and annotated). All compiled.
Elm generalizes the row variable; each consumer specializes independently. *(The
ledger's "annotations on intermediate let-bound lists are load-bearing" caveat is
narrower than feared — it concerns error **localization** on *invalid* code, not
blocking *valid* sharing.)* The design does not need rethinking.

## Methodology — TDD by capability-area (not by component)

The natural unit of generator change is a **capability** (a transformation: R1
prop emission, R4 typed slots, R5 groups, native-IR, …), not a component. So the
loop is, per area:

1. Write/update the **expected-shape tests** for that one area.
2. Change the codegen until those tests pass.
3. Move to the next area; fix any other tests the change disturbed.

No speculative code; each area is independently revertible. Two test levels:

- **elm-cem** — golden/source + **`elm make` compile** of the generated output
  (the cheapest, highest-value external gate — golden-string matching alone won't
  catch a non-compiling emit).
- **elm-m3e** — IR-introspection behaviour tests + type-matrix tests (per the
  Phase 0 probe).

**One integration checkpoint** (Phase 3): green-per-capability ≠ green-combined,
because capabilities interact (a slot typed with native-IR + a `Value` attr +
required-`id` on one component). After a few areas land, smoke-test a handful of
components that combine them.

**External testing**: the Playwright browser contract harness (#36) for
runtime / shadow-DOM / events / the imperative paths.

### Phase 1 — Generator foundations (`elm-cem`, mostly Mech)
- **Emit the IR core** generically (ADR 8 c1): `Node`, `Element`, `Internal`
  (option endomorphism), `Attr`, `Action` (capability-row wrapper + `toAttrs`),
  the native-HTML IR constructors (ADR 10), and the manifest-derived `Value` vocab
  (R3, partly shipped).
- **R1 correctness**: camelCase property keys (not kebab), real boolean & numeric
  DOM properties, unconditional-emit reset semantics. *(Confirmed still-broken in
  the vendored regen — the hand layer is currently the only correct source.)*
- **Three-layer emitter scaffolding**: `M3e.Cem.Html.*` (plain html), `M3e.Cem.*`
  (Value attrs + html children), `M3e.*` (Element/Node, default = degenerate
  shapes when CEM declares no attrs/slots).

### Phase 2 — Decl engine (`elm-cem`, config-driven)
- **`slots.json`**: per slot — accepted child kinds (incl. native kinds),
  `arbitraryAllowed`, and `wrap` mode (`container-div` / `direct` / `text-span` /
  `none`). Drives R4 closed-row typed slots + R8 placement helpers.
- **`overrides.<component>`**: R5 `groups` (container + item families; the sparse
  descriptor with worked fills for Fab/Progress/Menu/Chip/List), R6 required-content
  & a11y-name + the required-`id` wiring (ADR 10), R7 optionality-from-`default`,
  R9 event→typed-payload decoders, R11 text destinations (Element vs String), R12
  typed-argument overrides, R13 surface curation, R-EXTRA (renames, static attrs,
  auto-id, `role=group`).

### Phase 3 — Integration checkpoint (gate before fan-out)
After the Phase 1–2 capability-areas land, smoke-test **one component of each
structural shape** end-to-end (config → generate → `elm make` → IR unit tests →
browser contract) to catch capability *interactions*:

| slice | component | proves |
|---|---|---|
| simple + Value + content | **Button** | three-layer emission, Value vocab, content, `M3e.text` |
| container + typed slots | **Card** / **AppBar** | closed-row slots, wrap modes |
| R5 container + items | **Slider** (thumbs) | multi-tag groups, item constructors, range = 2 thumbs |
| native composition | **TextField** | native-HTML IR constructors, required-`id` wiring |

Green here = generator + config schema + IR core de-risked on the hard cases.
Finalize the two schema details deferred to the slice: R9 decoder-descriptor depth
and the exact native-kind list.

### Phase 4 — Fan-out (all ~74 components)
Author `config/` for every component; regenerate. The **only** hand-authored
artifact is config — no per-component Elm. Per-component gate: `elm make`,
`elm-format`, `elm-review`, IR unit tests, browser contract.

### Phase 5 — Docs, examples, pipeline
- Refactor docs/examples to the new API (evaluate **ornith 1.0** for the
  mechanical refactor — separate decision when reached).
- Regenerate-on-release pipeline wired; `vendor/`/`generated/` is tracked,
  generated.
- Push `elm-cem` changes; **delete the `elm-cem` clone** from this repo.

## Testing strategy
- **IR-introspection unit tests** (regenerated): assert DOM properties, slots,
  structure, accessible names against the `Node` IR — the verification gap ADR 6
  closed.
- **Browser contract harness** (Playwright): event dispatch, shadow-DOM rendering,
  the imperative paths (Snackbar `open`, BottomSheet close-sync).
- No equivalence-to-old-hand-API testing — prerelease, the API is changing on
  purpose.

## Tracking

Umbrella: **elm-m3e#71** (consumer) ↔ **elm-cem#1** (generator).

| area | issue |
|---|---|
| Phase 1 — IR core / R1 / three-layer / R3 | elm-cem#2 / #3 / #4 / #5 |
| Phase 2 — R4+R8 / R5 / R6 / R7+extra / R9 / R11-13 | elm-cem#6 / #7 / #11 / #8 / #9 / #10 |
| Phase 2 — config schema | #72 |
| Phase 3 — integration checkpoint | #73 |
| Phase 4 — fan-out | #74 |
| Phase 5 — docs/examples / harness+pipeline | #75 / #76 |

## Open (resolve during the slice, not blocking)
- R9 decoder-descriptor language depth (how much `target.x`/`detail.x`/multi-event
  is declarative vs `plain`).
- Exact native-kind list (start: `input`, `textarea`, `label`, `img`, `video`,
  `a`, `span`).
- IR-core extraction to a shared package — only if cross-library interop becomes
  real (ADR 8).
