# Spec — D: Docs app shell (clone matraic's shell)

**Date:** 2026-07-07
**Branch:** `docs/d-app-shell`
**Product intent (DECIDED — do not relitigate):** Clone matraic's docs shell closely. All in
`docs/app/Shared.elm` (+ `docs/style.css`, a GitHub SVG asset). Shared wraps EVERY page — review with
extra care and playwright at mobile + desktop.

## Target (matraic) vs current (from investigation)

**Matraic shell** (`../matraic-m3e/docs/index.html`): `<m3e-theme>` › `<m3e-app-bar class="docs-header-bar">`
(sibling) + `<m3e-drawer-container start start-mode="auto" end-mode="auto">` with `slot="start"` =
`<m3e-nav-menu id="nav-drawer">`, default slot = main content, `slot="end"` = `<div id="settings-drawer">`.
App bar: leading hamburger icon-button (`<m3e-drawer-toggle for="nav-drawer">`), title+version, trailing =
npm + **GitHub (inline mark SVG, `fill="currentColor"`)** + settings icon-button
(`<m3e-drawer-toggle for="settings-drawer">`). **No app-bar theme quick-toggle.** Settings drawer holds
color / color-scheme / contrast / directionality segmented buttons.

**Our current** (`Shared.elm`): `<m3e-theme>` › CSS-grid `grid-rows-[auto_1fr]` with `appShellBar` +
`drawerShell`. `drawerShell` (~689) already uses `DrawerContainer.view` with `startMode Value.auto` and
Elm-controlled `start`. App bar (`appShellBar` ~391): brand + `menuButton` (md:hidden), title/subtitle,
trailing = `schemeQuickToggle` (~458, **to remove**) + `settingsTriggerElement` (Card popover trigger,
~487) + `githubLink` (`Icon.name "code"`, ~442). Settings is a **Card popover** gated on `model.settingsOpen`
with a manual backdrop (~502) + `settingsPanel` (~517) holding `schemeSegmented`/`contrastSegmented`/
`seedColorInput`/`densitySegmented`/`directionSegmented` (the `segmented` helper ~544). Model has
`settingsOpen`, `showMenu`, `viewportWidth`, `scheme`, `seed`, `contrast`, `density`, `dir`; `onChange`
on the drawer is NOT currently wired.

## Mechanism (design decision — controlled-from-Elm)

Keep drawers **controlled by Elm state** (extends the pattern our nav already uses), rather than adopting
matraic's declarative `<m3e-drawer-toggle>` (untested in our Elm vdom, and our client-routed SPA benefits
from Elm closing the mobile nav on navigation — matraic's iframe shell sidesteps this). Faithfully clone
matraic's **structure, appearance, and behavior**; the internal state mechanism is ours to choose.

## The 5 decided changes

1. **Clone shell structure/appearance.** Keep the drawer-container as the shell (nav in `start`, content in
   default slot, settings in `end`). Match matraic's app-bar layout (hamburger left on mobile, title, then
   trailing GitHub + settings) and its surface colors (see CSS fidelity below). The grid-row app-bar +
   drawer arrangement is acceptable (same visual result); do not regress it.
2. **Settings → `end` drawer.** Add `DrawerContainer.endMode Value.auto` + `DrawerContainer.end
   model.settingsOpen` + `DrawerContainer.endSlot (settingsDrawerContent model)` to `drawerShell`. Move the
   settings heading + controls out of the Card `settingsPanel` into the end-slot content. **Delete** the
   Card popover (`settingsPanel`), the manual full-viewport backdrop (~502-507), and
   `settingsTriggerElement`'s wrapper — the drawer-container provides the scrim/focus-trap. The app-bar
   settings button becomes a plain `IconButton` (icon `settings` or `tune`) firing `ToggleSettings`.
   **Keep all our controls** (scheme, contrast, seed color, density, direction) — the decided change is the
   settings *location* (end drawer), not removing our richer control set. Match matraic's settings styling
   (flex column, row-gap, per-control `m3e-heading` labels, `width: fit-content` on segmented buttons,
   round color swatch).
3. **Nav → `start-mode="auto"`.** Already set. Ensure it behaves as persistent-on-desktop / hamburger-
   overlay-on-mobile (matraic parity). Keep `start` controlled (`not (isMobile model) || model.showMenu`).
4. **GitHub link → real GitHub mark SVG.** Replace `Icon.name "code"` in `githubLink` with an inline
   GitHub mark `<svg viewBox="0 0 512 512" fill="currentColor">…path…</svg>` (from matraic's
   `index.html:46-53`) via a `Native`/raw node so it inherits on-surface color (adapts light/dark). Keep
   the `href`, `target="_blank"`, and `Aria.label "GitHub repository"`.
5. **Remove the app-bar theme quick-toggle.** Delete `schemeQuickToggle` (~458) and its `AppBar.trailing`
   usage (~407). Keep `SetScheme`/`schemeToString`/`storeScheme` (still used by the settings
   `schemeSegmented`). Theme control now lives only in the settings drawer.

## Correctness — drawer state sync (do not skip)

With controlled `start`/`end`, the drawer-container also manages its own open state (scrim click, Esc,
viewport change in `auto`). To avoid desync (a drawer visually closed by the user while Elm still thinks
it's open — requiring a double-toggle to reopen):
- **Wire `DrawerContainer.onChange`** to update `showMenu`/`settingsOpen` from the element's reported
  open state. First determine `onChange`'s payload shape from `packages/m3e/src/M3e/DrawerContainer.elm`
  and the m3e web component's change event (`config/slots.json` `DrawerContainer` events, or the CEM). Map
  it to the appropriate Msg(s) (e.g. `DrawerChanged { start : Bool, end : Bool }` → set both). If `onChange`
  cannot distinguish start vs end, use the most correct available signal and document the limitation.
- Keep `onPageChange = Just (\_ -> CloseMenu)` (close mobile nav on client navigation); also close settings
  on navigation if that matches matraic's feel (optional).
- If — and only if — the controlled+onChange approach proves unworkable in review/playwright (persistent
  desync), fall back to matraic's declarative `<m3e-drawer-toggle for="…">` (Native nodes) and drop the
  drawer booleans; document the switch. Default is controlled.

## CSS fidelity (`docs/style.css`, via Tailwind `[--var:val]` — Elm can't set CSS custom props)
- App bar surface: `--m3e-app-bar-container-color: var(--md-sys-color-surface-container-low)` (matraic
  `.docs-header-bar`).
- Drawer colors: `--m3e-drawer-container-color: surface-container-low`, `--m3e-modal-drawer-container-color:
  surface-container` (matraic `.docs-drawer-container`).
- Settings drawer content: flex column, `row-gap: 1rem`, `padding-inline: 1rem; padding-block: .5rem`;
  segmented buttons `width: fit-content`; round color swatch (`appearance:none; border-radius:50%; 3rem`).
- Apply the custom-property values as Tailwind arbitrary-property classes on the relevant Elm elements
  (mirror the existing `densityClass` pattern) OR add static rules in `style.css` scoped by a class.

## Acceptance criteria (playwright at mobile 390×844 AND desktop 1280×900)
1. **App bar:** no theme quick-toggle present; trailing shows the GitHub button (rendering the GitHub mark
   SVG, not a `code` icon) and a settings button; title/brand present.
2. **GitHub SVG** renders (an inline `<svg>` with a `path`, `fill=currentColor`) and its color matches the
   app-bar foreground in both light and dark scheme (toggle scheme via settings and re-check).
3. **Nav drawer:** desktop = persistent nav visible beside content (no hamburger needed / hamburger hidden);
   mobile = nav hidden, hamburger visible; tapping hamburger opens the nav as an overlay with a scrim;
   tapping the scrim (or navigating) closes it; reopening works (no double-toggle → no desync).
4. **Settings drawer:** clicking the app-bar settings button opens a right-side (`end`) drawer containing
   the theme controls (scheme, contrast, seed color, density, direction); it is NOT the old Card popover;
   closing (scrim/esc/button) works and reopening works (no desync). On mobile it overlays with a scrim.
5. **Theme controls still work** from the drawer: changing scheme updates the page theme AND persists
   (`storeScheme` still fires — verify scheme survives reload or the port is called); contrast/density/
   direction still apply.
6. **No regression to page content**: every route still renders inside the shell; the drawer content area
   shows the page. Component pages (with B2 folds + C sliders) still work within the shell.
7. `cd docs && npm run build:ci` → exit 0 (`check-nav: OK`, `Success - Adapter script complete`);
   `elm-format --validate app src` → `[]`.
8. `prefers-reduced-motion` respected for any drawer transition (the m3e element handles its own; just
   don't add motion that ignores it).

## Risks
- **R1 — controlled/DOM state desync** (the main risk). Mitigation: wire `onChange`; playwright the
  open→scrim-close→reopen cycle for BOTH drawers at mobile; if desync persists, switch to declarative
  toggles (documented fallback).
- **R2 — `end-mode="auto"` makes settings a desktop side-push** (matraic's behavior). If this feels
  disruptive (shoves all docs content when tweaking a setting), it's still matraic-faithful; note it. Do
  NOT silently change to `over` without flagging — that's a deviation from "clone closely" (surface it).
- **R3 — Shared.elm wraps every page**: a mistake breaks the whole site. Mitigation: build:ci + playwright
  several routes (a component page, the index, an examples route) at both viewports.
- **R4 — GitHub SVG via Native/raw node**: ensure it doesn't break the icon-button's sizing/color; size it
  to match the other app-bar icons (~24px), `fill=currentColor`.
