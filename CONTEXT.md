# elm-m3e

A strongly-typed, Make-Impossible-States-Impossible Elm layer over matraic's
`@m3e/web` Material 3 Expressive web components. Increasingly, the layer is
*generated*: a CEM-driven generator emits a stack of progressively safer APIs,
and only an irreducible remainder is hand-written.

## Language

### The generator capabilities

**Mech**:
Output the generator can derive from the CEM manifest alone — no external input.
_Avoid_: mechanical-only, codegen-default

**Decl**:
Output the generator produces from a declarative config file (slot typing,
overrides). Never imperative function-body injection — if it can't be expressed
declaratively, it is [[Hand]], not Decl.
_Avoid_: config-layer, declarative-injection

**Hand**:
Irreducibly hand-written output; no declarative input captures it (imperative
opens, native-element compositions, node-tree mutation). The residual the
generator deliberately leaves a hole for.
_Avoid_: manual, custom, escape-hatch

**CEM**:
The Custom Elements Manifest (`custom-elements.json`) describing the `@m3e/web`
components. The generator's sole automatic input.
_Avoid_: manifest, custom-elements.json

### The generated layers (the escape gradient)

A stack of three generated APIs over the same components. Each deeper layer is
**less safe and less convenient but more powerful**; each outer layer is *built
from* the one beneath it. The correct way and the easiest way are the same way
(the top layer); working outside the system is possible but requires explicit,
louder declarations. Going deeper = getting access to more internals. Mirrors
the library's own html → element → child gradient.

All three nest under one library namespace (`M3e` for this library; a generic
`<Prefix>` for any CEM the generator targets). Going deeper is one namespace
segment more.

**Top layer** — `M3e.*`:
Structural, [[Decl]]-powered. Phantom-typed IR for **both** attributes and
children; returns the `Element`/`M3e.Node` IR. A single separate function turns
that IR into `Html`. The safe, blessed path.

**Middle layer** — `M3e.Cem.*`:
[[Mech]]-powered phantom-typed **attributes** (the shared `Value` token
vocabulary); children are ordinary `Html msg`; returns `Html`. The library's
output before config existed.

**Bottom layer** — `M3e.Cem.Html.*`:
The plain `elm/html` API, one constructor per tag. No opinion beyond correct DOM
property emission. What the generator originally produced.

**Escape gradient**:
The ordered path from safe-and-opinionated to raw-and-permissive across the
layers: top → middle → bottom → raw `elm/html`. The review surface lives on the
explicit steps outward.
_Avoid_: fallback chain, escape hatches (plural)

### API shape

**API shape**: the *calling convention* of a constructor. The bottom and middle
[[Layer]]s each expose a single fixed shape; only the **top** layer varies, across
three **co-equal** shapes, one per namespace segment. So there are **five
addressable API surfaces** in all (bottom + middle + three top shapes) — not a 3×3
grid — and a [[Codegen-aware rule]] should be able to translate a call between any
two of the five. The three top shapes form one monotonic safety progression: each
step converts an advisory check into a compile-time guarantee. See
[ADR 0013](docs/adr/0013-top-shape-matrix-and-translation.md).
_Avoid_: signature, form, style

**Double-list shape** (top, `M3e.*`):
`view [ attrs ] [ content ]` — one attribute list, one content list. No
required-presence or duplicate-singular protection; a [[Codegen-aware rule]] flags
missing required attrs/slots and repeated singular slots. The base top namespace;
also what `Card`/`ListItem` ship today.

**Record + double-list shape** (top, `M3e.Record.*`):
`view { required } [ attrs ] [ content ]` — required attrs/slots hoisted into a
record (present exactly once, so mandatory arguments are compiler-enforced); the
rest stays in the same two lists. Attributes and content are **not** jumbled
(still two lists), so no sort rule is needed; only duplicate-singular stays
advisory. The blessed home of the shipped `{ content, action }` hybrid.

**Phantom-record shape** (top, `M3e.Build.*`):
A single fully-typed constructor over a complete record — required fields plain,
optional-singular as `Maybe`, multi as `List`. A record field is present exactly
once, so duplicate-singular is *unwritable*, and every other check is typed too:
the compiler alone catches presence, cardinality, and validity, so it needs no
elm-review support. Returns the same `Element` IR (no per-component build step —
the one eager point stays the root `toHtml`).

**Shape variant vs. safety depth**:
Namespace depth means two different things on two axes. On the **layer** axis it
tracks the [[Escape gradient]] (`M3e` → `M3e.Cem` → `M3e.Cem.Html`; deeper = less
safe, more raw). On the **top-shape** axis the extra segment (`M3e.Record`,
`M3e.Build`) names a *shape variant only* — deeper is not less safe; the three top
shapes are co-equal peers a [[Codegen-aware rule]] translates between.
_Avoid_: conflating the two axes

### Mechanisms

**Codegen-aware rule**:
An elm-review rule that knows the CEM/config the library was generated from —
per-component required/multi/valid-enum facts and the shorthand-vs-specific
naming (`variant` vs `variantButton`). It reports or auto-fixes layer-/shape-
specific issues and can translate a call between [[Layer]]s and [[API shape]]s.
_Avoid_: lint rule, static check

**Seam**:
A blessed insertion of non-generated code (a class on a native element, a layout
primitive, a markdown/table wrapper) *within* the generated structures — the
sanctioned counterpart to the louder [[Hand]] escape.
_Avoid_: escape hatch, injection

**Seam module**:
A repo-designated module — one of possibly several, configured in the
[[Codegen-aware rule]] — that is the *only* sanctioned home for [[Seam]] usage,
where a team keeps its layout primitives and non-generated wrappers so those
patterns are easy to find and later unify. (The docs app's is `Layout.elm`.)
_Avoid_: Utils, Helpers, Custom

**Composition over injection**:
The governing rule. Added structure is always built by the consumer composing
pieces (typed slots, item-family members) — never by the generator injecting
elements into or around caller-supplied nodes. The library is exactly typed
slots + container/item families.
_Avoid_: element injection, wrapper templates

**Native-HTML IR constructor**:
An `Element` constructor for a plain HTML tag (`nativeHtmlInput`,
`nativeHtmlTextarea`, `nativeHtmlLabel`, …) carrying a flat phantom row, emitted
only for the native elements that get placed into a typed/named slot. Lets native
controls compose into slots provably-validly. Arbitrary native HTML elsewhere
stays the `html` escape.
_Avoid_: native wrapper, injected input

**IR core**:
The foundational generated modules every layer imports — `Node`, `Element`,
`Internal`, `Attr`, `Action`, the `Value` vocabulary, and the native-HTML
constructors. Generated, not hand-written; "[[Hand]] = ∅" refers to *component*
modules, not the core.
