# Testing the `M3e.*` library

Two layers, because m3e components are custom elements whose truth lives in
places a virtual-DOM test can't reach.

| Layer | Tool | Sees | Run |
|---|---|---|---|
| **Unit** | `elm-test` (`tests/*Test.elm`) | the *emitted virtual DOM* — tags, **string attributes**, slots, text | `npx elm-test@0.19.1 --compiler node_modules/.bin/elm` |
| **Runtime contract** | Playwright (`docs/tests-browser/`) | the *real browser* — shadow DOM, **DOM properties**, the a11y tree, interaction | `cd docs && pnpm run test:browser` |

The **unit suite is deliberately thin**. The IR-introspection unit layer that
once lived under `tests/Ui/` was removed when the library moved from `Ui.*` to
the generated `M3e.*` layers; a green `elm make packages/m3e` is now the primary
correctness proof (the phantom-typed slots make most mis-uses a compile error).
What remains under `tests/` are targeted `Test.Html.Query` regression tests for
the hand-written IR core — e.g. `NodeSlotTest.elm` guards issue #79 (named-slot
assignment must survive on `Raw` / escape-hatched / `Element.map`'d content).

`tests/elm.json` is a small test-only application whose `source-directories`
point at the two package sources (`../packages/m3e/src`, `../packages/m3e-kit/src`).

The contract harness covers the behaviors `Test.Html` **structurally cannot** —
and that gap is exactly how the icon-invisible bug (friction F1) shipped past
the compiler.

## Footguns that keep biting

These have each bitten more than once. Know them before writing a test.

### F6 — `Query.find` / `findAll` search **descendants only**, never the root
If the element you're asserting is the **root** of the rendered fragment (e.g. a
bare `m3e-switch`, the `m3e-toolbar` itself, `m3e-skeleton`), `Query.find
[ tag "m3e-switch" ]` returns **0** and errors. Assert the root directly:

```elm
-- WRONG: m3e-toolbar is the root → find can't match it
view |> Query.fromHtml |> Query.find [ Selector.tag "m3e-toolbar" ] |> ...

-- RIGHT: query the root with `has`, or query its (descendant) children directly
view |> Query.fromHtml |> Query.has [ Selector.tag "m3e-toolbar", ... ]
view |> Query.fromHtml |> Query.findAll [ Selector.tag "m3e-icon-button" ] |> Query.count ...
```
Reach for `findAll` + `count`/`index` for non-unique selectors, and `has` (not
`find`) when the thing you're checking is the root element.

### F4 — DOM **properties** are invisible to `Test.Html`
Bindings that emit `Html.Attributes.property` (`checked`, `selected`, `open`,
`loaded`, number props like `hide-friction` / `overshoot-limit`, …) are **not**
real attributes. `Test.Html` only sees attributes, so:

```elm
-- This reports `invalid` and fails — `hideFriction` is a property:
Query.has [ Selector.attribute (M3e.BottomSheet.hideFriction 0.8) ]
```
Don't assert property values in `elm-test`. Assert observable structure
(tags / string attributes / slots / text) only, and verify the
property-driven behavior in the **contract harness**:

```ts
const v = await el.evaluate((e) => (e as any).hideFriction); // reads the property
```
Rule of thumb: if the `M3e.*` function is `Html.Attributes.property`, it's
browser-only. Bare/string attributes (`Attr.attribute "position-x" "before"`)
are fine in `elm-test`.

### F1 — slotless elements read content from an **attribute**, not children
`<m3e-icon>` has no slot — its glyph comes from the `name` attribute; a
`Html.text` child is silently dropped. The generated `M3e.*` layer routes this
correctly via the typed slot rows, and `review/`'s elm-review rules guard the
source side. (Run the repo's lint from `docs/`:
`cd docs && node_modules/.bin/elm-review --config ../review --compiler node_modules/.bin/elm`.)

## When to add a **contract** test (not a unit test)
Add to `docs/tests-browser/` (Playwright) when the behavior is:
- a **DOM property** (`checked`, `open`, `loaded`, gesture numbers, …),
- **shadow-DOM** rendering (does the glyph actually paint? is the form-field
  chrome present/absent?),
- the **accessibility tree** (computed role / accessible name from `aria-label`),
- or **interaction** (clicking a `triggerFor` opens the element-managed menu).

The harness mounts the real components via the docs component pages
(`/components/<slug>`), so a small demo on that page often doubles as the
fixture. It reuses a dev server on `:1239` if one is up, else starts one;
override with `BASE_URL=…`.
