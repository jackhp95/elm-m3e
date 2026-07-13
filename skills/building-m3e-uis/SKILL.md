---
name: building-m3e-uis
description: >-
  Builds Material 3 Expressive UIs in Elm with the elm-m3e (M3e.*) component library —
  the generated typed binding over @m3e/web. Use in projects using elm-m3e when the user
  wants to add or wire an m3e component (button, dialog, list, nav bar, chips, fab, text
  field, card), asks "how do I use elm-m3e", "material elm ui", "which M3e layer/form should
  I use", hits a blank screen where m3e components render nothing, or fights the phantom
  types. Covers the layer/form decision tree (M3e barrel / per-component / M3e.Record /
  M3e.Build / M3e.Html / M3e.Raw), the mandatory @m3e/web JS custom-element registration
  (the #1 newcomer trap), and the userland seam (Kit text/link producers you copy, not
  import from the package). For layout composition see composing-m3e-layouts; for a11y see
  making-m3e-accessible; for tokens/theming see theming-m3e-apps; for judging a finished
  view see reviewing-m3e-designs.
---

# Building M3e UIs

elm-m3e is a **generated** typed Elm binding over matraic's `@m3e/web` Material 3
Expressive web components. Everything under `src/M3e/` is emitted by `elm-cem` from the
`@m3e/web` Custom Elements Manifest plus `config/slots.json`; you consume it, you never
hand-edit it. The library ships **no JS runtime** — an `M3e.button` is a lazy IR node
that becomes a `<m3e-button>` only at `Markup.Element.toNode`. The Elm IR core (`Element`,
`Node`, `Html.Attr`, `Aria`, `Attributes`) lives in the shared `markup-core` package
(`Markup.*` modules); elm-m3e imports them as a dependency rather than copying them.

## The #1 trap: register the custom elements

elm-m3e ships as a **facet family** — install only the facets you need:

```bash
elm install jackhp95/elm-m3e-standard  # the everyday API (most apps)
elm install jackhp95/elm-m3e-build     # Build form + Record form
elm install jackhp95/elm-m3e-core      # M3e.Kind + M3e.Token only (deep deps)
```

For the Elm IR core shared across facets, `markup-core` is installed as a transitive
dependency; you typically never install it directly.

The `<m3e-*>` custom elements are inert HTML until the matching JS is registered at app
startup. **If you skip this, every component renders as an empty/unstyled box and nothing
is wrong with your Elm.** Wire it once:

```bash
npm install @m3e/web
```

```js
// index.js — register every <m3e-*> element BEFORE the Elm app mounts
import "@m3e/web";
import { Elm } from "./Main.elm";
Elm.Main.init({ node: document.getElementById("root") });
```

When "components render but look broken / do nothing", check this import first.

## Layers and forms — decision tree

Two orthogonal axes shape the API (see `docs/DESIGN.md` §1, §3). The **layer** axis is
how raw you go — a safety gradient; the **form** axis is how strict one call site is —
how required vs optional parts are passed. All layers and forms return the same
`Markup.Element.Element … msg`, so they nest and interchange freely. Default to the standard
form; move only when a concrete guarantee earns it.

| Want | Use | Why |
|------|-----|-----|
| The everyday default | **`M3e` barrel** (top layer, standard form) — `M3e.button [attrs] [content]` | one import (`import M3e exposing (..)`), lowercase names, generalized setters. Start here. |
| A component with **required** content (label, action) checked by the compiler | **`M3e.Record.*`** (Record form) — `view { required } [attrs] [content]` | missing-required becomes a *compile* error, not a lint. Only components that have required parts get a Record module. |
| A pipeline where **duplicate-singular is unwritable** | **`M3e.Build.*`** (Build form) — `seed {req} \|> setter \|> build`, imported qualified | setting a singular attr twice fails to type-check. Opt-in, per-component, no barrel. |
| A raw attribute the top layer doesn't expose | **`M3e.Html.*`** (Html layer) — lazy IR attrs, eager component | documented escape, less convenience. |
| Partial applications of `elm/html`, no phantom types | **`M3e.Raw.*`** (raw layer) — fully applied → `Html` | the documented floor; the last escape hatch. |

The `Html` and `raw` layers are **documented escapes**, not the everyday path. Drop to
them only when the top layer genuinely can't express something; prefer filing the gap.

**Rule of thumb:** build a settings screen or a form → **standard form** (`M3e` barrel).
A button/dialog/snackbar that *must* carry a label or action → **Record form**. A guided,
cardinality-guaranteed builder (wizard step, generated form) → **Build**.

## Don't fight the phantom types

Three phantom rows make invalid compositions a compile error (`docs/DESIGN.md` §1). When
the compiler rejects your view, it is telling you the composition is invalid — **fix the
composition, don't reach for `M3e.Raw` or `Seam.recast` to silence it:**

- `M3e.Button.variant M3e.Token.square` — compile error: `square` isn't in the variant
  value row. Pick a real variant (`M3e.Token.filled`, `.outlined`, …).
- `M3e.Card.view …` inside a Button's content list — compile error: `card` isn't an
  accepted child kind of Button. Use the slot the parent actually accepts.
- Slot placers stamp `slot=` and return the right kind, so `M3e.appBarSlotTitle`,
  `M3e.listItemSlotLeading`, `M3e.navItemSlotIcon` fit exactly one place by construction.

Composition is **add-only**: helpers like `M3e.Button.icon` add a `slot=` and never
mutate existing attrs. Set an attr twice and `elm/html` last-wins applies — predictable,
no dedup machinery.

## The seam: atoms and native elements are userland

The library intentionally does **not** define `text`/`link`/`label`/`icon` in the
published package. These **atoms** are accessible-by-construction primitives whose exact
shape (String? i18n key? icon font vs SVG?) is a team decision. They live in the **Kit**,
a copyable module set under `docs/kit/` that is **NOT part of the published package** —
consumers copy `Kit`, `Native`, and `Seam` and adapt them (see `docs/kit/README.md`,
`docs/DESIGN.md` §4):

- **`Kit`** — `text`, `link`, `label`, `icon` producers. These return the **shared atom
  kind** (`Markup.Kind.Shared`), so they fit any slot typed `"shared:text"` /
  `"shared:icon"` / etc. — and `link : {href} -> Element {text:Shared} msg -> …`
  requires at least one content child, enforcing link accessibility at the type level.
- **`Native`** — native-HTML IR (`div`, `span`, `p`, `a`, `img`, `ul`, `li`, …) carrying
  the `html : M3e.Kind.Brand` kind, so it fits any `"arbitrary"` slot.
- **`Seam`** — the single sanctioned, loud, auditable break-glass (`fromHtml`, `recast`)
  built on the `*.Internal` modules. You cannot mint an `Element` from raw HTML anywhere
  else; that fence is Elm's own module exposure, not a lint rule. For stable semantic
  crossings, prefer `M3e.Coerce.*` (config-blessed coercions) over `recast`.

So a real call reads `M3e.button [ M3e.variant M3e.Token.filled ] [ Kit.text "Save" ]` —
library component, shared-atom text.

## Rendering exit

Everything stays IR until the app root. Convert once, at the top of your `view`:

```elm
Markup.Element.toNode myScreen   -- IR → Node → Html, the only eager point
```

## Reference

- **[reference/layers-and-forms.md](reference/layers-and-forms.md)** — the
  full layer/form comparison table, the mistake→enforcement matrix, and a compilable
  starter (`Browser.sandbox` app with the JS registration note).
- For neutral Material *theory* (why elevation, color roles, expressive rationale) see
  the **m3e knowledge base** (foundations / styles / expressive / components).
- Per-component API facts (which attributes/slots exist) live in the generated
  implementation cards and the component's own `src/M3e/<Name>.elm` doc comments —
  reference them by name; this skill does not restate them.

---
_Validated against elm-m3e 1.0.0, 2026-07._
