# Plan — D: Docs app shell (clone matraic)

Spec: `docs/superpowers/specs/2026-07-07-d-app-shell.md`
Branch: `docs/d-app-shell` (off `main` @ `fe6b723`).
Everything is in `docs/app/Shared.elm` unless noted. Line numbers drift — grep the symbol names.

## Step 0 — Baseline + API recon
- `cd docs && npm run build:ci` → exit 0 at HEAD.
- Build+serve, screenshot the current shell (app bar with theme toggle + settings popover) at desktop and
  mobile, so the before/after is captured.
- **Recon `DrawerContainer.onChange`**: read `packages/m3e/src/M3e/DrawerContainer.elm` (it exposes
  `end, endMode, endDivider, endSlot, startDivider, onChange`). Determine `onChange`'s exact type/payload
  (what the change event reports — a record of start/end open bools? a custom type?). Also check
  `config/slots.json` `DrawerContainer` `events` and the m3e CEM for the change event detail shape. Write
  down the mapping you'll use. This governs the sync wiring (spec "Correctness").

## Step 1 — Remove the app-bar theme quick-toggle (change 5)
- Delete `schemeQuickToggle` (def ~458-477) and its `AppBar.trailing (schemeQuickToggle model)` in
  `appShellBar` (~407). Keep `SetScheme`/`schemeToString`/`storeScheme` (used by settings).
- `elm make` — confirm no now-unused warnings besides what you'll clean.

## Step 2 — GitHub mark SVG (change 4)
- In `githubLink` (~442), replace the `Icon.view [Icon.name "code"]` child with an inline GitHub mark SVG.
  Build it via the project's `Native` node seam (mirror how `Doc.rawPreview`/other Native SVG/nodes are
  built; the docs app uses `Native.node`/`Seam.fromHtml (Html.node …)`). Markup:
  `<svg viewBox="0 0 512 512" fill="currentColor" width="24" height="24" aria-hidden="true"><path d="…"/></svg>`
  — copy the exact path from `../matraic-m3e/docs/index.html:47-52`. Keep the `IconButton` wrapper, its
  `Action.linkWith { href="https://github.com/jackhp95/elm-m3e", target=Just "_blank", … }`, and
  `Aria.label "GitHub repository"`. `fill="currentColor"` makes it adapt to light/dark.
- If a raw SVG string is easier/safer, you may route it through the existing `raw-html` custom element
  (`node "raw-html" [attribute "content" svgString]`) — but a typed `Native.node "svg"` with a `Native.node
  "path"` child is preferred if the seam supports arbitrary SVG nodes + a `d` attribute. Pick what compiles
  cleanly and renders; verify the SVG actually appears (playwright) and is sized like sibling icons.

## Step 3 — Settings → end-slot drawer (change 2, the big one)
- **Move the controls:** create `settingsDrawerContent model` = the heading + the existing controls
  (`schemeSegmented`, `contrastSegmented`, `seedColorInput`, `densitySegmented`, `directionSegmented` — the
  `segmented` helper and these are already defined ~544-630; reuse verbatim). Wrap in a container styled
  like matraic's `#settings-drawer` (flex column, row-gap, padding) — apply via Tailwind classes on the
  wrapper (`flex flex-col gap-4 px-4 py-2` etc.) or an id + style.css rule.
- **Wire into the drawer:** in `drawerShell` (~689) add
  `DrawerContainer.endMode Value.auto`, `DrawerContainer.end model.settingsOpen`,
  `DrawerContainer.endSlot (settingsDrawerContent model)` alongside the existing `startMode`/`start`/
  `startSlot`. (Confirm `DrawerContainer.endSlot`/`endMode`/`end` names/types against DrawerContainer.elm.)
- **App-bar settings button:** replace `settingsTriggerElement` (~487, the popover trigger + backdrop +
  panel) with a plain `IconButton` (icon `settings`, `Aria.label "Settings"`, `Action.onClick
  ToggleSettings`) placed in `AppBar.trailing`. DELETE `settingsTriggerElement`, `settingsPanel` (~517),
  `settingsBody` if now redundant (or reuse its body list as `settingsDrawerContent`'s body), and the
  manual backdrop (~502-507).
- **Sync on element-driven close (spec Correctness):** wire `DrawerContainer.onChange` (per Step 0 recon)
  to a new/existing Msg that sets `settingsOpen`/`showMenu` from the reported open state. Add the Msg +
  update branch. Keep `onPageChange → CloseMenu`.
- Keep `ToggleSettings` Msg + update branch (now flips `settingsOpen`, which drives `end`).

## Step 4 — App-bar structure + nav parity (changes 1, 3)
- Ensure `appShellBar` trailing order matches matraic (GitHub, then settings) and the hamburger
  (`menuButton`, md:hidden) is the leading toggle. Nav already uses `startMode Value.auto` + controlled
  `start`; leave that logic but confirm desktop=persistent / mobile=overlay parity in playwright.
- Keep the brand/title/subtitle; matraic shows a title + version chip — a version chip is optional (only if
  cheap and there's a version to show; otherwise keep our title/subtitle).

## Step 5 — CSS fidelity (`docs/style.css`)
- Add the surface-color custom properties (spec) as Tailwind arbitrary-property classes on the app-bar and
  drawer-container elements (mirror `densityClass`), OR add scoped static rules in `style.css`:
  - app-bar: `--m3e-app-bar-container-color: var(--md-sys-color-surface-container-low)`
  - drawer: `--m3e-drawer-container-color: …-surface-container-low`,
    `--m3e-modal-drawer-container-color: …-surface-container`
  - settings drawer content: flex column, `row-gap:1rem`, padding; segmented `width:fit-content`; round
    color swatch (`input[type=color]` → `appearance:none;border:0;border-radius:50%;width:3rem;height:3rem`).
- Reuse the existing B2/C `prefers-reduced-motion` block if you add any transition (the m3e drawer handles
  its own motion; avoid adding motion that ignores reduced-motion).

## Step 6 — Verify
- `elm-format --yes` edited files; `elm-format --validate app src` → `[]`.
- `cd docs && npm run build:ci` → exit 0 (`check-nav: OK`, `Success - Adapter script complete`).
- **Playwright (build dist, serve :1239, ~1600ms), desktop 1280×900 + mobile 390×844, on ≥3 routes**
  (a component page e.g. `/components/appbar`, the index `/`, an examples route e.g. `/examples/travel`):
  - App bar: assert NO theme quick-toggle; GitHub button renders an inline `<svg><path>` (not a Material
    Symbol `code`); settings button present. Compare GitHub svg `fill`/computed color to app-bar text color
    in light AND dark (switch scheme via the settings drawer, re-measure).
  - Nav: desktop → nav visible beside content (persistent), hamburger hidden; mobile → nav offscreen,
    hamburger visible; click hamburger → nav overlays with a scrim; click scrim → closes; click hamburger
    again → reopens (assert it opens — proves no desync). Navigate a link on mobile → nav closes.
  - Settings: click settings button → a right-side drawer opens with the theme controls (assert the controls
    are in a `slot=end`/end-drawer, not a floating Card); scrim/again-toggle closes and reopens (no desync).
  - Theme control: change scheme in the drawer → page theme changes; assert `storeScheme` effect (scheme
    persists across reload, or spy the port/localStorage `m3e-scheme`).
  - Page content still renders inside the shell on all 3 routes; a component page's B2 folds + C slider
    still work under the new shell.
  - Screenshots (desktop+mobile, light+dark, nav open, settings open) to scratchpad. Kill server after.

## Step 7 — Do NOT commit; leave dirty for review.

## Deliverable for review
1. Diffs: `Shared.elm`, `style.css`, any GitHub-SVG asset/module.
2. The `onChange` payload shape you found + how you wired the sync (or the declarative-fallback note if used).
3. What Model/Msg fields were removed or kept and why (e.g. did `settingsOpen` stay? any dead state cleaned?).
4. Playwright transcript + screenshot paths proving criteria 1–8 at desktop + mobile, light + dark, nav
   open + settings open, and the no-desync reopen cycle for both drawers.
5. `build:ci` exit 0 + `elm-format --validate` `[]`.
6. Note on R2 (`end-mode=auto` desktop side-push) — how settings opens on desktop, and whether it matches
   matraic or you flagged a deviation.
