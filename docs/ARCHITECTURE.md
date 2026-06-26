# `M3e.*` architecture

`M3e.*` is a strongly-typed, Make-Impossible-States-Impossible Elm layer over
matraic's [`@m3e/web`](https://github.com/matraic/m3e) Material 3 Expressive web
components. Its invariant is the **Material 3 spec + accessibility**, not the
DOM. The canonical decision record is [ADR 0006](adr/0006-m3e-architecture.md);
this is the narrative guide.

## The layers

```
elm/virtual-dom    sealed primitive (any node/attr/event)
  └─ elm/html      sealed typed HTML
       └─ Cem.M3e.*   generated CEM bindings — 1:1 with every element, no opinion, the escape hatch
            ↘
             M3e.*    THIS library — introspectable IR + typed composition + MISI + a11y
```

`elm/html` *seals* its data (you can't look inside `Html msg`). `M3e.Node`
**re-opens** introspectability for the sake of composition and testing — it is
not a duplicate of the platform vDOM, it is the part the platform hides.

## The IR (`M3e.Node`)

UI is **data** until one `M3e.Node.toHtml` at the application root:

```elm
type Node msg = Element { tag, attrs, children } | Text String | Raw (Html msg)
type Attr msg = Attribute String String | Property String Value | RawAttr (Html.Attribute msg)
```

Introspection is opt-in per attribute: relational attrs (`id`/`for`/`slot`/`aria-*`)
and web-component `Property`s are explicit (so parents inject and tests read);
generated attrs and **all events** ride opaque in `RawAttr`. This is why a
parent can wire a `<label for>` to a `<control id>` by rewriting data, and why a
unit test can assert a DOM *property* that `Test.Html` is blind to.

## Content & slots (`M3e.Renderable`)

One content type with a phantom **row**. Children tag themselves (open row);
slots list accepted kinds (closed row). The accepted set is decided by the
Material content taxonomy — see [CONVENTIONS.md](CONVENTIONS.md).

## Components are view-style

```elm
M3e.IconButton.view { icon = "delete", name = "Delete" } [ M3e.IconButton.onClick Del ]
--                 └ required (incl a11y name) ┘  └ optionals fold like Html attrs ┘  -> Renderable {iconButton}
```

`view {required} [options] -> Renderable {tag}`: one concept, returns slot-ready
content directly, so slot lists fold with **no lift**. Required fields are
mandatory; options are order-independent.

## Escapes (matched to the slot)

| Context | Escape | Why |
|---|---|---|
| default-slot region (card body) | `M3e.Renderable.html : Html msg -> …` | no slot injected; raw Html is fine |
| named slot (app-bar trailing) | `M3e.Renderable.element {tag} attrs children -> …` | parent must inject `slot=`; you build a slot-capable element |

A named slot's accepted set lists `element`, **not** `html` — so raw Html in a
named slot is a compile error, and a slot can never be silently dropped.

## Extensibility

The library ships **no layout primitives**. The `element` escape + the public
`M3e.Node` IR are the seam: build your own `Row`/`Column`/`Grid`/`Masonry`, and
lock the escape to a layout module via elm-review if you want. The escape
gradient is `M3e` (safe) → `Cem.M3e` (typed atoms) → raw `Html`.

## The cost ledger (eyes open)

Real costs we accept (mostly *authoring* costs, not consumer/runtime):

- **Phantom-row type errors** name the slot alias but not the offending line,
  and can't be customized (Elm 0.19). The consumer-facing friction; mitigated by
  short, well-named slot aliases. Worst with large accepted sets — but large
  sets are the *free-row* (arbitrary) case, which has no constraint to violate.
- **Annotations on the child side** use the open-row form
  `Renderable { s | tag : Supported } msg` (the `s` leaks). Slot-side aliases are
  clean and are what name the error.
- **A parallel vDOM-lite** (`M3e.Node`, `Cem.M3e.*`) that the library maintains.
  Capabilities not yet modeled (keyed, lazy-inside-a-section, SVG namespace) fall
  back to the `Raw`/`RawAttr` escape — never stuck, but introspection stops at an
  escape. Lazy works at section boundaries via `Raw (Html.Lazy.lazy …)`.
- **Constant-factor render overhead** (build IR, then `Html`) — proven
  acceptable by elm-ui / elm-css, which make the same trade.
- **A small onboarding cost** — the view-style + escapes + phantom rows are a
  bespoke shape vs. the Elm pipe-builder idiom.

Why it's worth it: typed composition + a11y-by-construction + a testable IR are
exactly what a Material-spec wrapper needs, and `Html msg` structurally cannot
provide them.

## Testing

Assert against the IR, not the rendered Html:

```elm
M3e.IconButton.view { icon = "delete", name = "Delete" } [ M3e.IconButton.selected True ]
    |> M3e.Renderable.toNode
    |> M3e.Node.findProperty "selected"      -- Test.Html cannot see this
    |> Maybe.map (Json.Encode.encode 0)
    |> Expect.equal (Just "true")
```

Property/structure/accessible-name assertions are fast unit tests. Behavior that
genuinely needs a browser (event dispatch, shadow-DOM rendering) stays in the
Playwright contract harness.
