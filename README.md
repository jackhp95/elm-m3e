# elm-m3e · `M3e.*` — type-safe Material 3 Expressive for Elm

A **Make-Impossible-States-Impossible** Elm layer over matraic's
[`@m3e/web`](https://github.com/matraic/m3e) Material 3 Expressive web
components. Its invariant is the **Material 3 spec + accessibility**, not the
DOM: slots are typed to the kinds M3 allows, accessible names are required by
construction, and components render to an **introspectable IR** that a parent can
compose and a unit test can inspect.

> **Status: pre-1.0, architecture finalized.** The `M3e.*` layer (introspectable
> IR + phantom-typed slots + view-style components) is described in
> [ADR 0006](docs/adr/0006-m3e-architecture.md) and being ported from the prior
> `Ui.*` builders. See [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) for the
> guide and [`docs/CONVENTIONS.md`](docs/CONVENTIONS.md) for the per-component
> rules.

## Architecture

```
@m3e/web         vendored Material 3 Expressive custom elements (the runtime)
  └─ Cem.M3e.*   generated CEM bindings — one module per element, no opinions, the escape hatch
       ↘
        M3e.*    THIS library — introspectable IR + phantom-typed composition + MISI + a11y
```

Four ideas (full detail in [ADR 0006](docs/adr/0006-m3e-architecture.md)):

- **Introspectable IR (`M3e.Node`)** — components render to data, not opaque
  `Html msg`, converted to `Html` once at the app root. So a parent injects
  `slot=`/`for`/`id` by rewriting data, and a unit test asserts DOM **properties**
  and structure that `Test.Html` can't see.
- **Phantom-typed slots (`M3e.Renderable`)** — a slot accepts exactly the
  Material content kinds it should; a wrong child is a compile error.
- **View-style components** — `view {required} [options] -> Renderable {tag}`:
  one concept, no lift, accessible name required by construction.
- **Matched escapes** — `Renderable.html` for default-slot regions,
  `Renderable.element` for named slots (so an injected `slot=` can never be
  dropped). The `element` escape + the public IR are the **extensibility seam**:
  the library ships no layout primitives; you build your own on top.

```elm
M3e.AppBar.new
    |> M3e.AppBar.withTrailing
        [ M3e.Search.view { placeholder = "Search mail" } []
        , M3e.IconButton.view { icon = "more_vert", name = "More" } [ M3e.IconButton.onClick Menu ]
        ]
```

## Naming

- **`M3e.*`** — the library (package `m3e`). What you import.
- **`Cem.M3e.*`** — the generated CEM bindings (the `Cem.` prefix marks origin
  and that they are generated). Used as the escape hatch; the two coexist.

## Repository layout

| Path | What |
|------|------|
| `src/M3e/` | The library — IR (`Node`, `Renderable`), components, `Field`/`Label`. |
| `vendor/elm-m3e/` | Generated `Cem.M3e.*` bindings. See `VENDORED_FROM.txt`. |
| `docs/` | The documentation site — an elm-pages app rendering the real modules. |
| `docs/adr/` | Architecture decision records ([0006](docs/adr/0006-m3e-architecture.md) is canonical). |
| `docs/ARCHITECTURE.md`, `docs/CONVENTIONS.md` | The guide and the per-component rules. |
| `docs/research/` | Historical dogfooding logs (superseded by ADR 0006). |

## Documentation site

The docs are an [elm-pages](https://elm-pages.com) app that renders **the real
library modules**, styled with Tailwind v4 + the
[`tailwind-m3e-web`](https://github.com/jackhp95/tailwind-m3e-web) bridge (zero
hand-written CSS).

```bash
cd docs
npm install
npm run build      # -> docs/dist  (also rebuilds public/style.css + public/m3e.js)
npm start          # local dev server
```

Deploy (Netlify): **Add new site → Import from Git**, **Base directory** =
`docs`; build command and publish dir come from `docs/netlify.toml`.

## Testing

- `elm-test` — unit assertions against the IR (tags, accessible names,
  properties, slot/relational wiring), plus negative compile checks for slot
  constraints.
- `docs/tests-browser/` — a Playwright contract harness for the things only a
  real browser shows (event dispatch, shadow-DOM rendering).

## Further reading

- [ADR 0006](docs/adr/0006-m3e-architecture.md) — the canonical architecture.
- [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) — narrative guide + cost ledger.
- [`docs/CONVENTIONS.md`](docs/CONVENTIONS.md) — per-component rules / spec template.
- [`docs/research/`](docs/research/) — historical logs from dogfooding `Ui.*`.

See the repo's GitHub issues for tracked work.
