# The Layers

elm-m3e is split into **facets** — addressable packages at different points in the
layer/form space. This guide describes the facet stack, the markup foundation it
sits on, and the atom layer that bridges the two.

For the full theory of the layer axis and form axis, see [`DESIGN.md §1–§3`](../DESIGN.md).
For the brand model and kind tiers, see [`Glossary`](Glossary.md) and
[`decisions.md CX2–CX3`](../decisions.md#cx2--brand-kind-rows-per-library).

## The foundation: markup-core

Every elm-m3e facet depends on `jackhp95/markup-core`. This package, produced by
the elm-cem repo, owns:

- The IR runtime types (`Markup.Element`, `Markup.Node`, `Markup.Html.Attr`).
- The token foundation (`Markup.Token`, `Markup.Aria`, `Markup.Attributes`).
- The kind vocabulary (`Markup.Kind` with `Shared` and `Brand`).
- The accessible atom constructors (`Markup.Atoms`).

`markup-core` is the floor. Its `Markup.Element.Element` type is the one nominal
type every generated library shares. Because all libraries import the same
published package, the nominal type system works across library boundaries — a
`Markup.Kind.Shared`-typed atom produced by `markup-core` unifies with any m3e
slot that opts in to that atom role.

## The m3e facet stack

The seven m3e packages, from narrowest to broadest surface:

```
markup-core               Markup.* runtime, atoms, kinds (foundation)
  elm-m3e-core            M3e.Kind.Brand + M3e.Token.* + M3e.Element.* + M3e.Node.* + M3e.Html.Attr.*
    elm-m3e-raw           M3e.Raw.*  (partial Html applications; strings live here)
      elm-m3e-html        M3e.Html.* (lazy Attr + eager component; phantom capability rows)
        elm-m3e           M3e.* standard (lazy IR for components; barrel; Action; Seam; Coerce)
          elm-m3e-record  M3e.Record.*  (required-record form; missing-required is a compile error)
          elm-m3e-build   M3e.Build.*   (builder pipeline; duplicate-singular is unwritable)

elm-m3e-review-facts      M3e.Review.Facts  (install in review/ apps only)
```

Each level adds expressiveness and safety over the one below it. Dropping to a
lower facet is rawer and less safe but gives more control.

### elm-m3e-core

The core package contains everything that is not yet a component view: the phantom
phantom-row runtime types (`M3e.Element.*`, `M3e.Node.*`, `M3e.Html.Attr.*`), the
token and value types (`M3e.Token`, `M3e.Aria`, `M3e.Attributes`), and crucially
`M3e.Kind` with the `Brand` type.

`M3e.Kind.Brand` is opaque and nullary. It is the per-library phantom marker. Elm's
nominal type system gives it a distinct identity from `Markup.Kind.Brand` and every
other library's brand. This is the mechanism that makes kind segregation compile-time
safe with zero runtime cost.

### elm-m3e-raw

The raw facet contains `M3e.Raw.*` — one module per component, with functions that
are plain partial applications of `Html.node` and `Html.Attributes.attribute`. No
phantom types. Strings live here and nowhere else in the generated code.

Use the raw facet when you need maximal control and are willing to lose compile-time
slot-kind guarantees.

### elm-m3e-html

The html (middle) facet contains `M3e.Html.*` — lazy attribute and event setters,
plus an eager `view` function that applies attributes to produce `Html` (not `Element`).
Phantom capability rows appear here (`Attr { c | variant : Supported }`).

Use the html facet when you want typed attributes but are integrating into an
existing `Html`-returning codebase where lazy `Element` IR is not convenient.

### elm-m3e (standard)

The standard package is the normal-use entry point. It contains:

- All top-layer component modules (`M3e.Button`, `M3e.Card`, …).
- The barrel (`M3e`) re-exporting everything in the standard form.
- `M3e.Action` — the typed action constructors (onClick, etc.).
- `M3e.Seam` — the seam stamper (see [`Seams`](Seams.md)).
- `M3e.Coerce` — the config-blessed named coercions.
- `M3e.Native` — typed IR constructors for raw HTML elements.

A `view` function in the standard form takes a list of attributes and a list of
children and returns a lazy `Element`:

```elm
M3e.Button.view
    [ M3e.Button.variant M3e.Token.filled ]
    [ Markup.Atoms.text "Submit" ]
```

Slot kind checking works at compile time. The kind rows of the children must
unify with the closed slot row of the component. An atom produced by
`Markup.Atoms.text` carries `{ s | text : Markup.Kind.Shared }`; if the button's
slot config declares `shared:text`, the slot row is `{ text : Markup.Kind.Shared }`
and the unification succeeds. A foreign-library element carrying a different brand
fails to unify and is rejected by the compiler.

### elm-m3e-record and elm-m3e-build

The record and build packages add stricter forms (see [`DESIGN.md §3`](../DESIGN.md)
for the full matrix). Both depend on the standard package because `M3e.Action` is
component-coupled (it imports standard-facet modules), so the dependency chain
runs from core through standard to record/build.

### elm-m3e-review-facts

This satellite package contains only `M3e.Review.Facts` (the generated component
facts table). Install it exclusively in `review/elm.json` apps. It depends on
`jackhp95/elm-review-cem`, which must not enter application trees. The review-facts
separation resolves the blocker that made `M3e.Review.Facts` unpublishable as part
of the main package (it imports `Cem.Facts`, a review-only module).

## The atom layer

Atoms sit between the Markup foundation and the m3e component surface. They are
produced by `Markup.Atoms` (part of `markup-core`) and carry `Markup.Kind.Shared`
in role-specific fields:

| Atom | Kind field | Type produced |
|------|-----------|----------------|
| `Markup.Atoms.text "…"` | `text : Markup.Kind.Shared` | `Element { s \| text : Markup.Kind.Shared } msg` |
| `Markup.Atoms.link {href} first rest` | `link : Markup.Kind.Shared` | `Element { s \| link : Markup.Kind.Shared } msg` |
| `Markup.Atoms.label {for} children` | `label : Markup.Kind.Shared` | `Element { s \| label : Markup.Kind.Shared } msg` |
| `Markup.Atoms.iconDecorative svg` | `icon : Markup.Kind.Shared` | `Element { s \| icon : Markup.Kind.Shared } msg` |
| `Markup.Atoms.iconLabeled {label} svg` | `icon : Markup.Kind.Shared` | `Element { s \| icon : Markup.Kind.Shared } msg` |

An m3e component slot accepts an atom when its slot config declares
`"shared:<atom>"` and the generated slot row contains that field. The Elm type
checker resolves the unification. No cast, no coercion, no seam crossing required.

Atoms are the only thing that flows freely across library boundaries. Private-brand
components are rejected by default.

## The generated markup surface

In parallel with the m3e facet stack, the elm-cem repo produces the **markup
family**: `markup-core`, `markup-raw`, `markup-html`, `markup` (standard), and
`markup-build`. The markup library is generated by the same elm-cem pipeline as
elm-m3e, from its own HTML manifest — this is what proves the generator is
library-agnostic (CX8). The markup standard package's docs.json measured at
132,168 bytes (18% of the 700 KB gate).

The markup v1 surface contains 16 HTML elements (structural, form, and list
categories). Missing: `ol`, headings (`h1`–`h6`), and `img` — these are flagged
to Jack for pre-release decision (additions are non-breaking).
