# Visual gap — why our built docs look unstyled vs matraic, and how to fix it

Root-cause analysis of why the built site reads as a plain single-column
technical doc instead of a themed Material 3 app like
<https://matraic.github.io/m3e>. Conclusions are based on the actual files:
`app/Shared.elm`, `app/View.elm`, `app/Route/{Index,Reference}.elm`,
`style.css`, `m3e-entry.js`, `elm-pages.config.mjs`, and the vendored bridge
under `vendor/tailwind-m3e-web/`.

## TL;DR

The M3 **tokens are fully wired** (color roles, type scale, density, shape,
motion, elevation are all defined on `:root` in the bridge and exposed as
Tailwind v4 utilities). The problem is **application, not tokens**:

1. The **app shell** (`Shared.elm`) that wraps every page is the elm-pages
   starter stub — a bare unstyled `<nav>` with an "Open Menu" button and two
   dummy `<li>`s, plus a bare `<main>`. None of the M3 surface, type scale, app
   bar, or sidebar lives here. This is the chrome matraic styles, and it is
   unthemed.
2. There is **no global `<html>`/`<body>` M3 base**. Surface color and
   `on-surface` text are applied *per page* inside each route's `<m3e-theme>`
   wrapper, so the default white `<body>` and the Tailwind system font stack
   bleed in around/behind the shell.
3. There are **no theme / density / dark-mode / direction controls** anywhere.
4. The site is **two long pages**, not the multi-page sidebar app matraic is.

So the fix is to (a) make the shell itself an M3 app (app bar + sidebar +
surface base), (b) set the M3 base on the document, and (c) add the global
controls. Detailed, file-by-file plan below.

---

## What IS correctly wired (do not redo)

- **Token cascade** — `style.css` imports `vendor/tailwind-m3e-web/src/index.css`
  (seed → ref palette → sys → `@theme`) plus the generated component utilities.
  All `--md-sys-color-*`, `--md-sys-typescale-*`, `--md-sys-density-*`,
  shape/motion/elevation tokens are defined on `:root`.
- **Tailwind utilities** — `theme.css` maps those tokens to real utilities:
  `bg-surface`, `text-on-surface`, `text-on-surface-variant`,
  `bg-surface-container*`, `border-outline-variant`, `text-display-small`,
  `text-headline-medium`, `text-title-medium`, `text-body-large`,
  `text-label-large`, `rounded-md-corner-*`, etc. The page code already uses
  these correctly.
- **Dark mode infrastructure** — `sys/color.css` declares
  `color-scheme: light dark` and every role uses `light-dark(...)`, so a dark
  scheme resolves automatically once a toggle sets the scheme. No extra dark
  palette work is needed.
- **Web components register** — `m3e-entry.js` imports `@m3e/web/all` and the
  `avt-snackbar` wrapper; `elm-pages.config.mjs` links `/m3e.js`, `/style.css`,
  and the Material Symbols font.
- **Per-page theming exists** — both `Route/Index.elm` and `Route/Reference.elm`
  wrap their content in
  `Html.node "m3e-theme" [ attribute "color" "#6750A4", attribute "scheme"
  "auto", class "block min-h-screen bg-surface text-on-surface" ] [...]`.
  Inside that wrapper the content is genuinely M3-styled.

## Root causes (the gap)

### RC1 — The app shell is the unstyled starter stub (highest impact)

`app/Shared.elm` `view` (lines 94–120) returns:

```
[ Html.nav [] [ Html.button [onClick MenuClicked] [text "Open Menu"]
              , <ul> with "Menu item 1" / "Menu item 2" ]
, Html.main_ [] pageView.body
]
```

This is what frames every route. It has **no class attributes at all** — no
surface, no app bar, no real sidebar, no M3 type scale. matraic's equivalent is
a themed top app bar + persistent sidebar. Because Shared wraps the route, even
though the route's own `<m3e-theme>` panel is styled, it sits inside a generic
unstyled document frame with a leftover "Open Menu / Menu item 1" widget.

### RC2 — No document-level M3 base (`<html>`/`<body>`)

Nothing sets surface background, `on-surface` text color, or an M3 font on the
document root. The compiled `style.css` shows `--font-sans: ui-sans-serif,
system-ui, sans-serif, ...` (Tailwind's default), and no `@layer base` rule puts
`bg-surface`/`text-on-surface` on `body`. Consequences:

- The viewport background outside each route's `min-h-screen` wrapper is default
  white/transparent, not M3 surface — visible as a mismatched frame and on
  overscroll.
- Body text defaults to the system font + Tailwind's base size, not the M3 type
  scale, anywhere the page doesn't explicitly opt in.
- Dark mode never visibly engages for the shell because the shell has no
  surface color to flip.

### RC3 — `color`/`scheme`/`contrast` are hard-coded per page, not global

The source color `#6750A4`, `scheme "auto"`, and `contrast "standard"` are
duplicated as literals inside each route's `<m3e-theme>`. There is no single
place that owns the theme, and no UI to change it — so the "themed M3 app with
live theme/density/dark/direction controls" experience matraic has is absent.

### RC4 — Density / direction not surfaced

`sys/density.css` defines `--md-sys-density-scale: 0` on `:root` but nothing lets
a user change it, and `theme.css` intentionally does not expose density/state as
utilities (by design — override the source vars). Direction (`dir`) is never set.

### RC5 — IA mismatch reinforces the "plain doc" feel

Two long pages (`Index` scroll-spy + `Reference`) instead of matraic's
app-bar + sidebar multi-page structure. Even fully themed, a single endless
column reads as a technical doc, not an app. (Addressed in `matraic-site-map.md`;
listed here because it is part of the visual impression.)

---

## Prioritized, file-by-file fix plan

### P0 — Make the shell an M3 app (`app/Shared.elm`)

Replace the stub `view` with a real M3 layout that owns the global
`<m3e-theme>` wrapper (so routes stop each declaring their own):

- Wrap the whole body in
  `Html.node "m3e-theme" [ attribute "color" sourceColor, attribute "scheme"
  scheme, attribute "contrast" contrast, class "grid min-h-screen
  grid-rows-[auto_1fr] bg-surface text-on-surface" ]`.
- Add a **top app bar**: a `<header>` styled
  `bg-surface-container text-on-surface` with the title ("elm-m3e — Material 3
  Expressive for Elm"), a version badge, a GitHub link, and the settings
  controls (P1).
- Add a **persistent sidebar** `<nav>` (`bg-surface-container-low`,
  `text-on-surface-variant`, sticky, scrollable) holding the IA groups from
  `matraic-site-map.md` (Getting Started / Styles / Elm Integration /
  Components / Reference). Replace the "Open Menu / Menu item 1" placeholder.
- Put `pageView.body` in a `<main class="min-w-0 ...">` cell.
- Use the existing `Model.showMenu` for a responsive drawer toggle on small
  screens instead of the dummy menu.

Then **delete the per-page `<m3e-theme>` wrappers** from `Route/Index.elm`
(lines 86–101) and `Route/Reference.elm` (lines 105–108) — they become plain
content; the shell themes them. This also fixes RC3 (one owner for the theme).

### P0 — Set the document M3 base (`style.css`)

Add a small base layer (the only hand-written CSS we need) after the imports:

```css
@layer base {
  html { color-scheme: light dark; }
  body {
    background-color: var(--md-sys-color-surface);
    color: var(--md-sys-color-on-surface);
    font-size: var(--md-sys-typescale-body-large-font-size);
    line-height: var(--md-sys-typescale-body-large-line-height);
  }
}
```

Optionally set an M3 font: matraic uses the M3 sans (Roboto / system). Either
add a Roboto `<link>` in `elm-pages.config.mjs` `headTagsTemplate` alongside the
Material Symbols link and set `--default-font-family` / `--font-sans` to it, or
explicitly accept the system stack. This kills the white-frame bleed (RC2) and
makes dark mode flip the whole document.

### P1 — Global theme / density / dark / direction controls (`app/Shared.elm`)

Add state to `Shared.Model` (`sourceColor`, `scheme : Light | System | Dark`,
`contrast`, `density : Int`, `dir : Ltr | Rtl`) and `SharedMsg` variants to set
them. Render the controls in the app bar. They map to:

- `scheme` → the `scheme` attribute on the shell `<m3e-theme>` (+ `color-scheme`).
- `sourceColor` → the `color` attribute (dynamic color regenerates roles).
- `contrast` → the `contrast` attribute.
- `density` → set `--md-sys-density-scale` via an inline `style` on the wrapper
  (e.g. `style "--md-sys-density-scale" (String.fromInt n)`).
- `dir` → `attribute "dir" "rtl"|"ltr"` on the wrapper (or `<html>` via a port).

This is the matraic Settings panel. All five axes are already tokenized in the
bridge, so no token work is required — only plumbing.

### P2 — Adopt the multi-page IA (routes)

Per `matraic-site-map.md`: split into Getting Started / Styles / Elm Integration
pages, generate one Components page per `Ui.*` module (API tables from
`data/reference.json`), and demote the current `Index` demo sections into a
"Studies" area. Keep `Reference.elm` as the flat exhaustive index. This is the
larger effort; P0+P1 alone already make the shell read as an M3 app.

### P3 — Polish

- Material Symbols are already loaded but verify icon fill/weight axes render.
- Add M3 elevation (`shadow-md-level*`) to the app bar / cards for depth.
- Use `bg-surface-container*` tiers to differentiate app bar vs sidebar vs
  content, as matraic does, rather than flat surface everywhere.

---

## Summary of the one-sentence cause

The tokens and per-page theming are correct, but the **shell that frames every
page was never themed** (it is the starter `<nav>`+`<main>` stub) and **the
document body has no M3 surface/type base**, so the site renders as generic
content inside an unthemed frame — and it lacks the app-bar + sidebar structure
and the theme/density/dark/direction controls that make matraic read as a
Material 3 app.
