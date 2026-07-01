# Old → new API migration spec (the ornith task)

> The hand `M3e.*` library (deleted) is replaced by the generated double-list
> library in `packages/m3e/` plus the userland kit in `packages/m3e-kit/`. This
> spec is the exact transformation for migrating consumers (the docs app: 21 files,
> ~1073 call sites; then other elm+m3e repos). Verify with `elm make` per file.
> Written 2026-07-01.

## 0. What changed (the shape)
- **`X.view { record } opts`  →  `X.x { required } [attrs] [content]`.** Every
  component's fn is now the **lowercase component name** (`Button.button`,
  `Icon.icon`, …), and takes up to three args: an optional **required record**, an
  **attrs list**, and a **content list**. The old single `opts` list splits into the
  two typed lists.
- **The IR no longer introspects.** `Node.findProperty/findAttribute/childrenOf/
  tagOf` are gone (they only appeared in tests, already deleted).
- **Raw HTML / text / native elements move to the userland kit** (`packages/m3e-kit`):
  `Kit`, `Native`, `EscapeHatch`, `Seam`.

## 1. The per-call mechanical rewrite
`X.view ARG1 OPTS`  →  `X.x [REQ] ATTRS CONTENT` where each old field routes by kind:

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
  content → the **content** list. If a component has no required record, drop that arg:
  `Divider.view []` → `Divider.divider [] []`.
- **The required record only appears when the component has a required-singular slot
  or an aria/action field** (Button label, Icon has none, Switch `{ariaLabel}`, …).

### Worked examples
```elm
Icon.view    { name = glyph } []                    →  Icon.icon [ Icon.name glyph ] []
Heading.view { label = "x", variant = Value.title } []
                                                     →  Heading.heading [ Heading.variant Value.title ] [ Kit.text "x" ]
Divider.view []                                      →  Divider.divider [] []
Switch.view  { ariaLabel = "2FA" }                   →  Switch.switch { ariaLabel = "2FA" } [] []
Fab.view     { icon = "edit", ariaLabel = "Compose" }→  Fab.fab { ariaLabel = "Compose" } [] [ Fab.icon (Icon.icon [ Icon.name "edit" ] []) ]
IconButton.view { icon = g, ariaLabel = l } []       →  IconButton.iconButton { ariaLabel = l } [] [ IconButton.content (Icon.icon [ Icon.name g ] []) ]
```
(For per-component slot/attr names, read the module's `exposing (…)` line in
`packages/m3e/src/M3e/<Comp>.elm` — the setters are named there.)

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
