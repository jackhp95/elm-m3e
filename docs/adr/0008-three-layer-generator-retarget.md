# 8. Three-layer generator retarget — `elm-cem` emits the whole `M3e.*` surface

Date: 2026-06-30

## Status

Accepted. Builds on [ADR 6](0006-m3e-architecture.md). **Reverses the narrow
"IR-emission rejected" note** in `vendor/elm-m3e/VENDORED_FROM.txt` (2026-06-28):
that rejection applied only to enum/`Value` *setter* outputs (which stay
`Html.Attribute`); this ADR governs the component *view* output and the layering,
where the IR is now emitted.

## Context

Today `elm-cem` emits a single layer — `Cem.M3e.*` `Html`-returning atoms — and
the typed `M3e.*` library is hand-written on top. The
[generator-requirements audit](../elm-cem-generator-requirements.md) showed that
essentially every way the hand layer deviates from naive codegen is either
derivable from the CEM alone ([[Mech]]) or from a declarative config ([[Decl]]).

The config is what makes a full retarget *safe*. Without config the generator
cannot know a slot's accepted child kinds, so it can only honestly produce the
`Html`-children layer; **with** config it can produce the structural
`Element`/`Node` layer. That unlock is why the earlier IR rejection no longer
applies to the view path.

## Decision

`elm-cem` retargets to emit a **three-layer escape gradient** under one library
namespace (`M3e` for this library; a generic `<Prefix>` for any CEM):

| layer | module | shape |
|---|---|---|
| top | `M3e.*` | phantom-typed IR for **both** attributes and children (typed slots); returns `Element`. One separate `M3e.Node.toHtml` at the app root. |
| middle | `M3e.Cem.*` | phantom-typed **attributes** (shared `Value` vocab); `Html` children; returns `Html`. (today's output, renamed from `Cem.M3e.*`) |
| bottom | `M3e.Cem.Html.*` | plain `elm/html` constructors, one per tag; correct DOM property emission; no phantom typing. |

Each outer layer is built from the one beneath; **deeper = less safe, less
convenient, more powerful** — the escape gradient, mirroring the library's own
html → element → child shape.

`elm-cem` also **generates the IR core** (`Node`, `Element`, `Internal`, `Attr`,
`Action`, the manifest-derived `Value` vocabulary, and the native-HTML IR
constructors — see [ADR 10](0010-hand-zero-native-ir.md)) generically,
parameterized by the CEM + config. This repo therefore becomes **config +
100%-generated output**, regenerated on each `@m3e/web` release.

## Consequences

- `elm-cem` stays m3e-agnostic: all m3e specifics live in this repo's config; the
  generator emits a generic core + per-manifest layers. (Combining the generator
  into this repo is explicitly **not** done.)
- The generic core is byte-identical across libraries and namespaced per-library
  (`M3e.Node` vs a future `Foo.Node`), so two `elm-cem` libraries in one app would
  not share an `Element` type. Acceptable for m3e-only today; extracting the core
  to a shared package is the deferred trigger if cross-library interop matters.
- Naming changes: `Cem.M3e.*` → `M3e.Cem.*`, plus the new `M3e.Cem.Html.*`. ADR 6's
  "reserve `Cem.` so a hand layer can own `M3e.*`" rationale dissolves — there is
  no hand layer to protect (see [ADR 10](0010-hand-zero-native-ir.md)); the
  generator owns all of `M3e.*`.
