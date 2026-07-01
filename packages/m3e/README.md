# @m3e (packages/m3e) — the generated M3e.* library

**Generated output. Do not hand-edit.** `elm-cem` regenerates this whole tree from
the `@m3e/web` Custom Elements Manifest + `../../config/slots.json`.

A standalone Elm package: `M3e.*` components (double-list API — `component {required}
[attrs] [content]`) over a generated IR core (`M3e.Node`, `M3e.Element`,
`M3e.Content`, `M3e.Cem.Attr`, `M3e.Value`, `M3e.Action`) and the middle/bottom
layers (`M3e.Cem.*`, `M3e.Cem.Html.*`). `exposed-modules` is synced on every
generation.

Type-level MISI (kind + capability phantom rows); `any` slots are a plain type var;
required-presence and singular cardinality are advisory (elm-review + docs). See the
[repo README](../../README.md) and `docs/ADOPTION_AND_SLOTS.md`.

Rebuild check: `elm make` from this directory (compiles all exposed modules).
