# Old → new API migration spec (the ornith task)

> **Target = the built Vocab API** (`COMPONENT_AGNOSTIC_API.md` §9b, shipped in
> `packages/m3e/`). This spec is current as of 2026-07-01. The structural guidance
> (§1b Node-vs-Element, §2 IR-helper→kit, §3 renames, §4 conceptual replacements) is
> unchanged; the only shape change from earlier drafts is the constructor name — it
> is **`view`** (in each `M3e.<Comp>` module), not the lowercase component noun.


> The hand `M3e.*` library (deleted) is replaced by the generated double-list
> library in `packages/m3e/` plus the userland kit in `packages/m3e-kit/`. This
> spec is the exact transformation for migrating consumers (the docs app: 21 files,
> ~1073 call sites; then other elm+m3e repos). Verify with `elm make` per file.

## 0. What changed (the shape)
- **`X.view { record } opts`  →  `X.view { required } [attrs] [content]`.** Every
  component's constructor is now **`view`**, in its own module `M3e.<Comp>`, taking
  up to three args: an optional **required record**, an **attrs list**, and a
  **content list**. The old single `opts` list splits into the two typed lists.
- **Recommended target — the per-module strict API** (self-contained: constructor +
  its setters + its slots all in `M3e.<Comp>`, enum inputs value-checked):
  ```elm
  import M3e.Button as Button
  import M3e.Value as Value
  Button.view [ Button.variant Value.filled, Button.disabled True ] [ Button.child label ]
  ```
  This is a near-mechanical rename of the old per-component-setter code: `Button.button`
  → `Button.view`; the setters (`Button.variant`, `Button.icon`, `Button.child`, …) are
  UNCHANGED. `Button.variant` rejects a non-button token at compile time.
- **One-import alternative — the barrel.** `import M3e exposing (..)` re-exposes every
  constructor under its **noun** (`button`, `icon`, `divider` = `M3e.Button.view` …)
  plus the whole shared attribute/event vocabulary (`disabled`, `variant`, `onClick`,
  …) as ONE *loose* polymorphic function per name: `button [ variant filled ] [ … ]`.
  Loose = the value isn't per-component-checked (that's a future elm-review rule).
  **Slot content setters are NOT in the barrel** — for slots (`Button.child`,
  `Fab.icon`) you still import the component module. Where a component name collides
  with an attribute the attribute is suffixed (`shapeAttr`, `stepAttr`).
- **The IR no longer introspects.** `Node.findProperty/findAttribute/childrenOf/
  tagOf` are gone (they only appeared in tests, already deleted).
- **Raw HTML / text / native elements move to the userland kit** (`packages/m3e-kit`):
  `Kit`, `Native`, `EscapeHatch`, `Seam`.

## 1. The per-call mechanical rewrite
`X.view ARG1 OPTS`  →  `X.view [REQ] ATTRS CONTENT` where each old field routes by kind
(setters shown qualified per-module, e.g. `Icon.name`; the barrel's bare `name` works too):

| old field / call | new destination |
|---|---|
| `ariaLabel = s` | required record `{ ariaLabel = s }` (String) |
| a glyph `name = "add"` (Icon) | attr `Icon.name "add"` |
| `label = s` (Heading, Button text) | content `Kit.text s` |
| `variant = v` / `size` / `level` / `grade` / … | attr `X.variant v` (same token via `M3e.Value`) |
| an icon **glyph string** `icon = "edit"` | a composed element: `Icon.icon [ Icon.name "edit" ] []` placed in the right slot |
| `leadingIcon el` / `trailingIcon el` / `selectedIcon el` (old slot setters) | content setters `X.icon el` (leading), `X.trailingIcon el`, `X.selectedIcon el` |
| an action (`onClick`/`href`) on AssistChip | required record `{ action = Action.onClick msg }` / `Action.link href` (see `M3e.Action`) |
| default children (a container's items) | content `X.child el` (one) or `X.children [ … ]` (bulk) |

- **`opts` (old, one list)** splits: attribute setters → the **attrs** list; slot
  content → the **content** list. If a component has no required record, it takes just
  the two lists: `Divider.view [] []`.
- **The required record only appears when the component has a required-singular slot
  or an aria/action field** (Button label, Icon has none, Switch `{ariaLabel}`, …).

### Worked examples
```elm
Icon.view    { name = glyph } []                    →  Icon.view [ Icon.name glyph ] []
Heading.view { label = "x", variant = Value.title } []
                                                     →  Heading.view [ Heading.variant Value.title ] [ Kit.text "x" ]
Divider.view []                                      →  Divider.view [] []
Switch.view  { ariaLabel = "2FA" }                   →  Switch.view { ariaLabel = "2FA" } [] []
Fab.view     { icon = "edit", ariaLabel = "Compose" }→  Fab.view { ariaLabel = "Compose" } [] [ Fab.icon (Icon.view [ Icon.name "edit" ] []) ]
IconButton.view { icon = g, ariaLabel = l } []       →  IconButton.view { ariaLabel = l } [] [ IconButton.content (Icon.view [ Icon.name g ] []) ]
```
(The constructor is always `view`; for per-component slot/attr names read the module's
`exposing (…)` line in `packages/m3e/src/M3e/<Comp>.elm` — the setters are named there.)

## 1b. Node-level vs Element-level code (important)
Some consumer code works at the **`Node` level** (returns `Node msg`, builds with the
old `Node.element`/`Node.rawAttr`) rather than the component/`Element` level. Those do
**NOT** map to the kit (`Native`/`EscapeHatch` produce `Element`, not `Node`). Rebuild
them with `Node.raw` + plain `Html.*`:
```elm
-- old (Node-level layout helper):
div cls children = Node.element "div" [ Node.rawAttr (Attr.class cls) ] children
-- new:
div cls children = Node.raw (Html.div [ Attr.class cls ] (List.map Node.toHtml children))
```
The kit mappings in §2 are for **Element-level** (component-composition) code. Check
the function's return type first: `Node msg` → §1b; `Element … msg` → §2.

## 2. IR-helper / escape mappings — for ELEMENT-level code (add the imports)
| old | new | import |
|---|---|---|
| `Node.raw html` | `EscapeHatch.fromHtml html` | `import EscapeHatch` |
| `Element.html html` | `EscapeHatch.fromHtml html` | `import EscapeHatch` |
| `Node.rawAttr attr` | `EscapeHatch.asAttribute attr` | `import EscapeHatch` |
| `Node.element tag attrs kids` | `Native.node tag attrs kids` (or `Native.div`/`span`/`p`/…) | `import Native` |
| `Node.text s` / `Element.text s` (as slot content) | `Kit.text s` | `import Kit` |
| a navigation `<a>` | `Kit.link href kids` | `import Kit` |
| `Element.toNode el` at the **render root** | keep — then `M3e.Node.toHtml` | (still in `M3e.Node`/`M3e.Element`) |
| `Node.findProperty` / `findAttribute` / `childrenOf` / `tagOf` | **remove** — these were introspection; the double-list guarantees the same facts at compile time | — |

`EscapeHatch.asElement : Element a -> Element b` is the phantom-coercion break-glass
when the design system forbids a composition you need — loud + auditable.

## 3. Component renames (direct)
| old module | new module |
|---|---|
| `M3e.DatePicker` | `M3e.Datepicker` |
| `M3e.DatePickerToggle` | `M3e.DatepickerToggle` |
| `M3e.NavigationBar` | `M3e.NavBar` |
| `M3e.NavigationDrawer` | `M3e.DrawerContainer` |
| `M3e.NavigationRail` | `M3e.NavRail` |
| `M3e.RadioButton` | `M3e.Radio` |
| `M3e.ExtendedFab` | `M3e.Fab` + the `Fab.extended` attr |

## 4. Conceptual replacements (not 1:1 — needs judgment)
| old | new approach |
|---|---|
| `M3e.Text` / `M3e.Label` | `Kit.text` (userland producer) |
| `M3e.Field` / `M3e.TextField` | `M3e.FormField` wrapping a native control (`Native`-composed `input`/`textarea`, or `M3e.Select` / `M3e.InputChipSet`) |
| `M3e.Search` | `M3e.SearchBar` and/or `M3e.SearchView` |
| `M3e.Disclosure` | `M3e.Collapsible` / `M3e.ExpansionPanel` |
| `M3e.SideSheet` | `M3e.DrawerContainer` (with side slot) or `M3e.BottomSheet` |
| `M3e.StepperNext` | `M3e.StepperPrevious` family — confirm against `packages/m3e/src/M3e/Stepper*.elm` |
| `M3e.TimePicker` | **investigate** — no direct new module; may be `Datepicker`/calendar composition or genuinely absent in this `@m3e/web` version |

## 5. Procedure (per file)
1. Rewrite imports: rename per §3; add `Kit`/`Native`/`EscapeHatch` as used.
2. Rewrite each `X.view` call per §1; split `opts` into `[attrs] [content]`.
3. Replace IR helpers per §2; delete introspection.
4. `elm make` that file (source-dirs already point at `packages/m3e/src` +
   `packages/m3e-kit/src`); fix type errors — the phantom rows will pinpoint a
   wrong-kind slot or a missing required field. A genuinely-forbidden composition
   the design system is wrong about → `EscapeHatch.asElement` (and flag it).
5. Move to the next file. Keep changes faithful — don't "improve" behavior.

## 6. Notes for the ornith run
- The compiler is the oracle: a file is done when `elm make <file>` is green.
- Prefer the **most specific** new setter (read the module's `exposing`); fall back
  to `EscapeHatch` only when truly stuck, and leave a `-- TODO(escape)` marker.
- The fuzzy items in §4 (TimePicker, StepperNext, SideSheet, Disclosure) should be
  surfaced, not guessed — collect them for human review rather than forcing a match.
