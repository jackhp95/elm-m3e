# matraic m3e — site map, controls, page anatomy, and our recommended IA

Reference site: <https://matraic.github.io/m3e> (hash-routed SPA; the bare
`/#/...` routes serve a thin pre-rendered shell, but the direct `.html` content
paths — e.g. `/getting-started/installation.html`, `/components/button.html` —
resolve to full content and are the authoritative source for this map).

The site is **the polished, M3-themed multi-page app we want to mirror**. Our
current docs are a single long scrolling page (`Route/Index.elm`) plus an
auto-generated `Route/Reference.elm`. This file inventories matraic's structure
and proposes a concrete IA for us.

---

## 1. Top app bar / global chrome

- **Title:** "M3E — Material 3 Expressive for Every Framework", with version
  badge **v2.5.12** (matches the `@m3e/web` package version we vendor).
- **Right side:** a **GitHub** link and a **Settings** affordance.
- **Persistent left sidebar** (the nav inventory below), scrollable, grouped.
- The whole app is rendered on M3 **surface** colors with the M3 **type scale**
  and a chosen **source color** driving the dynamic scheme — i.e. the shell
  *itself* looks like a Material 3 app, not a generic doc theme. This is the
  single most important thing to copy (see `visual-gap.md`).

## 2. Global controls (the Settings panel)

matraic exposes a settings cluster that retheme the entire app live:

| Control | Options | M3 token it drives |
| --- | --- | --- |
| **Color scheme** | Light / System / Dark | `color-scheme` + light-dark() resolution of `--md-sys-color-*` |
| **Contrast** | Default / Medium / High | high-contrast remapping of color roles (forced-colors-aware) |
| **Source color** | color picker (dynamic color) | regenerates the whole `--md-sys-color-*` scheme from one seed via material-color-utils (their `<m3e-theme>`/Theme component) |
| **Direction** | LTR / RTL | document `dir` |
| **Density** | documented as a Styles axis | `--md-sys-density-scale` (0 default, negative = compact) / `--md-sys-density-size` |

These are exactly the axes our vendored bridge already tokenizes
(`vendor/tailwind-m3e-web/src/sys/{color,density,...}.css`), so we can wire the
same controls without new token work.

## 3. Full sidebar navigation (verbatim groups)

**Getting Started**
- Overview
- Installation
- Browser Support

**Styles**
- Color
- Density
- Motion
- Typography

**Frameworks**
- React
- Vue
- Angular

**Components** (50+ entries):
App Bar · Autocomplete · Avatar · Badge · Bottom Sheet · Breadcrumb · Button ·
Button Group · Calendar · Card · Checkbox · Chips · Content Pane · Datepicker ·
Dialog · Divider · Drawer Container · Expansion Panel · FAB · FAB Menu · Form
Field · Heading · Icon · Icon Button · List · Loading Indicator · Menu · Nav Bar
· Nav Menu · Nav Rail · Paginator · Progress Indicator · Radio Group · Search ·
Segmented Button · Select · Shape · Skeleton · Slide Group · Slider · Snackbar ·
Split Button · Split Pane · Stepper · Switch · Tabs · Textarea Autosize · Theme ·
TOC · Toolbar · Tooltip · Tree.

## 4. Component page anatomy (canonical section order)

Every component page follows the same shape (from Button and Card):

1. **Title + tag** — e.g. `m3e-button`.
2. **Intro / description** — one or two sentences on purpose.
3. **Import statement** — `import "@m3e/web/button";`.
4. **Usage overview** — minimal example.
5. **Feature-by-feature subsections**, each with a *live interactive demo*:
   variants, shapes, sizes, icons/slots, toggle, disabling, types, links,
   orientation, density customization, etc. (Card adds an **Anatomy**
   subsection naming its slots.)
6. **Accessibility** notes.
7. **Native module support** (no-bundler import map usage).
8. **API documentation** — tables for **properties/attributes**, **slots**,
   **events**, and **CSS custom properties**.

Notable: there is no separate anatomy *diagram image*; "Anatomy" is a prose +
slot-name subsection. Live demos sit inside surface-container panels.

### Example API captured

- **Button** (`m3e-button`): variants `elevated/filled/tonal/outlined/text`;
  props `variant, shape, size, toggle, selected, disabled, disabled-interactive,
  type, href, target, rel, download, name, value`; slots `icon, trailing-icon,
  selected, selected-icon`; events `beforeinput, input, change`; CSS props
  `--md-sys-density-scale`, `--md-sys-density-size`.
- **Card** (`m3e-card`): variants `filled (default), outlined, elevated`; props
  `variant, inline, orientation, actionable, disabled, disabled-interactive,
  href, target, rel, download`; slots `header, content, actions, footer,
  (default)`.

## 5. Styles page anatomy

- **Color**: explains M3 design tokens (`--md-sys-color-*`), the three color
  approaches (static / dynamic / forced-colors), and color roles
  (primary, surface, outline, …). References the Theme component for dynamic
  color generation.
- **Typography**: documents the 30-style scale (15 standard + 15 emphasized) via
  `--md-sys-typescale-*` and `--md-sys-typescale-emphasized-*`; each role
  encodes font-size, line-height, weight, tracking; contextual mappings
  (buttons → label-large, list items → body-large, hints → body-small).
- **Density / Motion**: each documents its own `--md-sys-*` axis.

## 6. Installation page (what theirs documents — we adapt to Elm)

`npm i @m3e/web`; per-component `import "@m3e/web/button"` or full
`import "@m3e/web/all"`; browser `<script type="module">`; no-bundler import-map
usage; ships a Custom Elements Manifest + VS Code language server.

---

## 7. Recommended IA for OUR site

We are an **Elm** binding layer (`Ui.*`) over `@m3e/web`. Mirror matraic's
structure but adapt "Frameworks" to Elm and add a "Studies" area for the
existing rich demos. Proposed top-level groups:

**Getting Started**
- Overview — what `m3e-builder`/`elm-m3e` is, MISI philosophy, relationship to
  `@m3e/web` (this is today's `Index.elm` hero + status content).
- Installation — Elm install, `m3e-entry.js` registration, `style.css` bridge
  import, the `<m3e-theme>` wrapper requirement.
- Browser Support — same matrix as matraic (Web Components / ESM baseline).

**Styles**
- Color — render our `--md-sys-color-*` roles as live swatches (we already have
  every role tokenized in `vendor/tailwind-m3e-web/src/sys/color.css`).
- Typography — render the type scale from `vendor/.../sys/typescale.css`.
- Density — show `--md-sys-density-scale` effects (tie to the global control).
- Motion / Shape / Elevation — our bridge tokenizes all of these too.

**Elm Integration** (matraic's "Frameworks", adapted)
- The `Ui.*` builder pattern (MISI: typed slots, required collaborators).
- elm-pages wiring + the `<m3e-theme>` scope + freeze/SSR notes.
- (Optionally a note that React/Vue/Angular are upstream `@m3e/web` concerns.)

**Components** — one page per `Ui.*` module, each laid out like matraic's
component page (intro → import → usage → feature demos → accessibility → API
table). Drive the API tables from `data/reference.json` (already extracted) so
they stay in sync with the bindings.

**Studies** — the current long-form demo sections (Shape/Icon/Avatar/Skeleton/
ScrollContainer/Snackbar/Theme/Size) become richer composed demos rather than
the whole site.

**Reference** — keep the existing auto-generated `Route/Reference.elm` as the
exhaustive flat index, linked from the app bar like matraic's GitHub link.

## 8. Mapping our 53 `Ui.*` modules → matraic component pages

Our `src/Ui/*.elm` modules (53, after `Ui.Table` was removed) and
`data/reference.json` keys map almost 1:1 to matraic's component pages. Notable
correspondences and gaps:

| matraic page | our `Ui.*` module |
| --- | --- |
| App Bar | `AppBar` |
| Avatar / Badge / Breadcrumb / Calendar / Card / Checkbox / Divider / Heading / Icon / Icon Button / List / Menu / Paginator / Search / Select / Shape / Skeleton / Slider / Snackbar / Split Button / Split Pane / Stepper / Switch / Tabs / Tooltip / Toolbar / TOC | same-named module |
| Button + Button Group | `Button`, `ButtonGroup` |
| Chips | `Chip` |
| Datepicker | `DatePicker` (+ we also have `TimePicker`, no matraic page) |
| Dialog | `Dialog` |
| Bottom Sheet | `BottomSheet` |
| Drawer Container / Nav Bar / Nav Rail / Nav Menu | `NavigationDrawer`, `NavigationBar`, `NavigationRail` (+ our `SideSheet`) |
| FAB / FAB Menu | `Fab`, `FabMenu` (+ our `ExtendedFab`) |
| Form Field | `TextField` |
| Loading Indicator / Progress Indicator | `LoadingIndicator`, `Progress` |
| Radio Group | `RadioButton` |
| Segmented Button | `SegmentedButton` |
| Slide Group | `Slide` |
| Theme | `Theme` |
| Tree | (no `Ui.*` module — matraic-only) |
| Autocomplete / Content Pane / Expansion Panel / Textarea Autosize | (no direct `Ui.*` module — matraic-only or folded into others) |

Ours-only (no matraic page): `Carousel`, `ExtendedFab`, `SideSheet`,
`TextHighlight`, `TimePicker`, `Size` (a shared primitive, not a component).
matraic-only (no `Ui.*`): Autocomplete, Content Pane, Expansion Panel,
Textarea Autosize, Tree. These gaps are worth a note on each side's Components
index but do not block mirroring the IA.
