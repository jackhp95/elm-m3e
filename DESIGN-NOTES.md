# DESIGN-NOTES — Phase 0 decisions (3-package skeleton)

## 0b — Module layout decisions

Three open questions from §3.1 of the consolidation plan, now locked:

### Q1. Does `elm-m3e-components` expose a convenience barrel?

**Yes — `M3e.Components`.** A single import that lists every component constructor
(`foo = M3e.Foo.view`), matching the elm/html feel: `import M3e.Components` gives
you one-import access to all 122+ component constructors without forcing individual
per-component imports. Users choose among three import tiers:

```
import M3e                          -- generic combos only (Element, text, toHtml, Attributes, Kind, Values)
import M3e.Components               -- all component constructors, one import
import M3e.Button                   -- per-component strict surface (narrowed values, builder, required content)
```

The barrel lives in `elm-m3e-components` (it's component-shaped, not generic).
Each entry is a thin delegation `foo = M3e.Foo.view`, exactly like today's
`src/M3e.elm` constructors but without re-exporting any per-component types — the
caller who needs to *name* `ButtonIs` imports `M3e.Build` (the builder package's
annotation-skin), not the barrel.

### Q2. Does the thin `M3e` core re-export anything component-shaped?

**No.** The thin core stays strictly generic — the four modules listed in §3.1
(`M3e` with `Element`/`text`/`toHtml`/`mapMsg`/`mapNode`, `M3e.Attributes`,
`M3e.Kind`, `M3e.Values`). No per-component type alias, no per-component
constructor. This is the invariant that fixes the type leak: `import M3e` never
forces you to import a component module just to annotate a value.

`M3e.Attributes` is already component-agnostic (confimed in plan §1.2); it stays
as-is. `M3e.Kind` and `M3e.Values` stay as-is. The generic `M3e` module keeps
`text`, the substrate re-exports (`Element`, `Attr`, `Node`, `toHtml`, `toNode`,
`mapMsg`, `mapNode`), and — in Phase 1 — the Lazy/Keyed surface.

### Q3. Does the builder package want a flat `M3e.Build` alias-skin?

**Yes — `M3e.Build` as a thin annotation-skin.** A single module re-exporting
every per-component `Is` type alias (e.g. `type alias ButtonIs s = M3e.Button.Build.Is s`)
so that a caller who only needs to *name* a component's phantom type in an explicit
annotation can import just `M3e.Build`:

```elm
import M3e.Build exposing (ButtonIs)

-- annotate without importing M3e.Button or M3e.Button.Build
viewButton : List (Element (ButtonIs s) admittedBy msg) -> Element (ButtonIs s) admittedBy msg
```

This is the "cheap import" from §3.1 bullet 4 — pulls in only type aliases, not
the full component API. The true type definitions live in `M3e.Build.Internal`
(non-exposed, absent from `elm-m3e-builder`'s `exposed-modules`, hence invisible
to `docs.json`/cap); `M3e.Build` and each `M3e.<Component>.Build` expose only
thin `type alias` lines pointing at those internal defs.

---

## 0a — Per-package versioning/tagging + publish scheme

The one-repo cost from §3.1: three `elm.json` packages in one repo need
independent versioning and a CI path to publish each.

### Tag scheme

`<package-dir>/v<semver>`, e.g.:

- `elm-m3e/v1.0.0`      — thin core release
- `elm-m3e-components/v1.0.0`  — components release
- `elm-m3e-builder/v1.0.0`     — builder release

Each tag is a standard lightweight or annotated git tag. The directory prefix
disambiguates which `elm.json` the tag applies to. This is a well-established
monorepo convention (used by elm-json's own repo, Rust workspaces, changesets,
etc.).

### Version independence

Each package versions independently. A breaking change to the builder package
bumps only `elm-m3e-builder`'s version; a new component (non-breaking addition to
`elm-m3e-components`) bumps only that package's minor. The inter-package
dependency declarations in each `elm.json` express the range:

```
elm-m3e-builder ─depends on─> elm-m3e-components ─depends on─> elm-m3e (core)
```

A major bump in core means both downstream packages must widen their dep range
and bump accordingly if they consume the new APIs.

### CI publish mechanism

`elm publish` reads a package's own `elm.json` and requires a matching git tag
(`v<version>`). The tag-prefix scheme (above) means `elm publish` must be run
from each package directory individually, with its own tag. A CI workflow detects
which packages changed (via `git diff --name-only` against the merge-base or the
last release tag) and publishes each independently:

```yaml
# sketch — for DESIGN-NOTES only, not yet implemented
jobs:
  publish:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        pkg: [elm-m3e, elm-m3e-components, elm-m3e-builder]
    if: ${{ contains(steps.changed.outputs.all, matrix.pkg) }}
    steps:
      - run: cd ${{ matrix.pkg }} && elm publish
```

Because `elm publish` resolves the git tag by stripping the `v` prefix and
comparing against `elm.json`'s `version` field, the `<pkg>/v<semver>` tag must
match the package's own version. The tag `elm-m3e/v2.0.0` paired with
`elm-m3e/elm.json`'s `"version": "2.0.0"` satisfies this check.

### Deviation from one-package-per-repo convention

This is the deliberate deviation flagged in §3.1/§5/§6 of the plan. The family
convention is one package per GitHub repo (`elm-typed-html`, `elm-shoelace`,
`elm-web-awesome`). This repo adopts a monorepo workspace instead. The cost is
the tagging/publish scheme above; the benefit is keeping tight coupling between
core/component/builder types in lockstep during development without coordinating
releases across repos. The three `elm.json` directories simulate the per-package
isolation that `elm publish` requires while keeping the source co-located.

### Local development during transition

Until the generator emits the new layout (Phase 2), development still uses the
root `elm.json` with its single `exposed-modules` list. The three skeleton
`elm.json` files define the target package boundaries. When the generator is ready
to emit the split layout, the root `elm.json` will either become a development-only
config using `source-directories` to include all three packages' `src/` trees, or
be removed and replaced by per-package workflows.

---

## Friction log reference

- `M3e.Action`, `M3e.Coerce`, `M3e.Events`, `M3e.Unsafe`, and `M3e.Html` are in
  the current root `exposed-modules` but are NOT in any skeleton `elm.json` yet.
  They are support modules, not pure generic-core or per-component-view. Their
  placement will be resolved in Phase 2 (generator emission): `M3e.Events` likely
  stays in the thin core (it's component-agnostic), `M3e.Unsafe`/`M3e.Coerce`
  land where the generator puts them. Documented here so Phase 2 has a clear
  starting point.
- The builder package currently lists only 3 `exposed-modules` (sketch). When the
  generator emits, it will list all `M3e.<Component>.Build` modules (122+) plus
  `M3e.Build`.
