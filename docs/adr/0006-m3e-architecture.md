# 6. The `M3e.*` architecture — introspectable IR + phantom-typed slots + view-style components

Date: 2026-06-26

## Status

Accepted. **Supersedes the retired ADR 5 (heterogeneous-chrome-slots) in full** and
**the slot-typing guidance of [ADR 4](0004-styling-free-builders.md)** (ADR 4's
"styling-free" rule stands). This is the canonical description of the library's
shape.

## Context

The pre-1.0 `Ui.*` layer wrapped `@m3e/web` web components as functions
returning **opaque `Html msg`**. A whole-repo audit found that this shape made
the library's own thesis — Make Impossible States Impossible, measured against
the **Material 3 spec and accessibility**, not against the DOM — impossible to
deliver:

- Slots are filled with `Html msg`, so the library can neither **constrain**
  what a slot accepts (M3 says an icon slot holds an icon; the DOM accepts
  anything) nor **compose** a child (inject `slot=`/`for`/`id`, normalize
  attributes) — `Html msg` is opaque.
- Accessible names and DOM properties live where `Test.Html` can't see them, so
  bugs (a dropped radio label, an inert select label, a dead change channel)
  shipped green through 252 unit tests.
- The slot question was answered case-by-case ("look at 3–5 call sites,"
  ADR 5) rather than by the spec, and the result was two escape-hatch
  conventions, one of 54 modules following them, and a reference module that
  contradicted its own ADR.

The fix is structural: stop producing opaque `Html msg` and start producing an
**introspectable data structure**, and type slots **by the Material content
kind** rather than by observed call sites.

## Decision

### 1. An introspectable IR — `M3e.Node`, not `Html msg`

A component renders to a data structure the library controls, converted to real
`Html` exactly **once, at the application root** (`M3e.Node.toHtml`):

```elm
type Node msg
    = Element { tag : String, attrs : List (Attr msg), children : List (Node msg) }
    | Text String
    | Raw (Html msg)                 -- escape: an opaque leaf

type Attr msg
    = Attribute String String        -- introspectable: relational attrs (id/for/slot/aria-*)
    | Property String Json.Encode.Value  -- introspectable: web-component props (testable)
    | RawAttr (Html.Attribute msg)   -- opaque passthrough: codegen attrs AND all events
```

Introspection is **opt-in per attribute**: relational attributes and properties
(the things a parent injects or a test asserts) are modeled explicitly;
everything else — generated `Cem.M3e.*` attributes, every event including custom
ones — rides opaquely in `RawAttr`. The only non-`elm/html` dependency is
`VirtualDom.mapAttribute`, used by `Node.map`.

This buys three things `Html msg` cannot: a parent composes a child by rewriting
data (`Node.withSlot`, `Node.setAttribute` for `for`/`id`); a unit test asserts
DOM **properties** and structure directly (closing the verification gap); and
the whole app stays builder-data until the single root conversion.

### 2. Phantom-typed slots — type by Material content kind

Slot content is one type, `M3e.Element`, carrying a phantom **row** that
records which kinds a value is:

```elm
type Element supported msg = Element (Node msg)   -- `supported` is phantom
type Supported = Supported
```

A **child** tags itself with an **open** row (`Element { s | iconButton : Supported } msg`
— "I am an icon button; I fit any slot that lists `iconButton`"). A **parent
slot** lists the **accepted child kinds** in a **closed** row:

```elm
type alias Trailing msg =
    Element { iconButton : Supported, search : Supported, avatar : Supported, element : Supported } msg
```

A child whose tag is not in the closed set is a compile error. The accepted set
is decided by the **Material content taxonomy** (see `docs/CONVENTIONS.md`):
single child → one kind; homogeneous list → that kind; spec-heterogeneous region
→ the union of valid kinds; arbitrary region → a free row.

### 3. View-style components — `view {required} [options] -> Element {tag}`

Components are **one concept**: a `view` that returns slot-ready content
directly (like `Html.div`), so heterogeneous slot lists fold with **no per-item
lift**:

```elm
M3e.AppBar.withTrailing
    [ M3e.Search.view { placeholder = "Search" } []
    , M3e.IconButton.view { icon = "more_vert", name = "More" } [ M3e.IconButton.onClick Menu ]
    ]
```

Required fields (including the accessible `name` — see §5) live in the record;
optionals fold like Html attributes; the full config is present at `view` time,
so conditional rendering is order-independent. This supersedes the pipe-builder
(`new |> with* |> view`): no lift, no separate builder type.

### 4. Two escapes, matched to the slot — `html` for regions, `element` for named slots

- `M3e.Element.html : Html msg -> Element { s | html : Supported } msg` —
  for **default-slot regions** (card body), where no slot is injected, so raw
  `Html` is fine.
- `M3e.Element.element : { tag : String } -> List (Node.Attr msg) -> List (Node msg) -> Element { s | element : Supported } msg` —
  for **named slots**, where the parent must stamp `slot=` onto the child; you
  build a slot-capable element, so the slot can never be silently dropped.

A named slot's accepted set lists `element` (not `html`), so raw `Html` in a
named slot is a **compile error** — the "dropped slot attribute" failure mode is
structurally impossible.

### 5. Accessibility by construction

Where a control has **no visible-text fallback** (icon-only button, compact FAB),
the accessible `name` is a **required constructor field** — an unlabeled control
is unconstructable. Where there is visible text, that text is the name. (The
`aria-labelledby`-to-a-hidden-`Label` path that lets a translation web component
supply the name is available but not required.)

### 6. Layered escape gradient + extensibility

```
elm/virtual-dom → elm/html → Cem.M3e.*  (generated CEM atoms, Html msg)
                                  ↘
                                   M3e.*  (this library — Node IR, typed composition)
```

`M3e.*` is a **strongly-typed M3 wrapper, not a layout framework.** It ships no
`Row`/`Column`/`Grid`. The `element` escape (and the public `M3e.Node` IR) is the
**extensibility seam**: consumers build their own layout primitives on top, and
may lock the escape to a layout module via elm-review. The escape gradient is
`M3e` (safe) → `Cem.M3e` (typed atoms) → raw `Html`.

## Consequences

- **Closes the verification gap.** DOM properties, slots, and structure are
  asserted in fast unit tests against the IR; the bug class that shipped green
  (dropped/inert labels, dead change channels) becomes catch-at-unit-test.
- **One slot rule, spec-derived.** ADR 5's call-site heuristic is retired; the
  accepted set comes from the Material content taxonomy, and the escape is the
  review surface.
- **Accepted costs** (see `docs/ARCHITECTURE.md` for the full ledger): a small
  constant-factor render overhead (build IR, then `Html`); phantom-row type
  errors name the slot but not the offending line (no fix — Elm 0.19 has no
  custom type errors); annotations on the child side use the open-row form;
  `M3e.Node`/`Cem.M3e.*` are a parallel vDOM-lite the library maintains
  (capabilities not yet modeled — keyed, lazy-inside, namespaced — fall back to
  the `Raw`/`RawAttr` escape, which is opaque). Lazy works at section
  boundaries (`Raw (Html.Lazy.lazy …)`).
- **Deferred:** retargeting the `Cem.M3e.*` codegen to emit `Node` (so the atoms
  are usable under the hood *with* introspection, not just as a raw escape).
  Until then `M3e.*` is self-contained (string tags), which is fine.

## Naming

The library is `M3e.*` (package `m3e`). The generated CEM bindings are
`Cem.M3e.*` (renamed from the former `M3e.*` — the `Cem.` prefix marks origin
and that they are generated). The two coexist; `M3e.*` does not depend on
`Cem.M3e.*` today, and `Cem.M3e.*` remains the escape hatch.
