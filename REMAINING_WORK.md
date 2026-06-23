# m3e-builder — Remaining Work (exhaustive handoff)

> Written 2026-06-23 as a handoff for a future session. This captures **everything**
> known to be incomplete, deferred, unverified, or worth doing — across the library,
> the docs, the generator (`elm-cem`), publishing, and the `compass-social` consumer.
> Nothing here is blocking a build; it's all forward work.

## 0. Current state (so you know the baseline)

- **Library:** all **53** `Ui.*` modules in `src/Ui/` compile against the vendored
  `M3e.*` bindings. `parked/Ui/` holds **1** scoped-out module (`Disclosure`).
  `Ui.Table` was deleted (m3e ships no table element).
- **Bindings:** `vendor/elm-m3e/M3e/*.elm` are **regenerated with the fixed `elm-cem`**
  (typed per-component enums + per-component shared attributes). Provenance in
  `vendor/elm-m3e/VENDORED_FROM.txt`.
- **Docs:** elm-pages v3 app in `docs/`. Home (`/`) has **8** rich live-demo sections;
  `/reference` auto-extracts the full API of all 53 modules from source. Tailwind v4 +
  vendored `tailwind-m3e-web` bridge (`docs/vendor/tailwind-m3e-web/`), zero hand-CSS.
  `<avt-snackbar>` JS wrapper shipped at `js/avt-snackbar.js`.
- **Branch/merge:** `main` has everything (PR #10 merged). Library `elm.json` is an
  **`application`** (not yet a publishable package).
- **Generator fix:** lives in repo `jackhp95/elm-custom-elements-manifest`, branch
  `feat/resolve-ts-aliases-to-enums`, **PR #11 — still OPEN (not merged).**
- **Consumer:** `compass-social/ui/` is a compiling Elm spike (local-only repo, branch
  `feat/ui-spike-m3e`, **unpushed — no remote**).
- **Open issues** (this repo): #3 (Table removed, info), #6 (publish + prepare hook),
  #7 (docs static assets), #9 (assumptions). #1/#2/#4/#5/#8 are closed.

---

## 1. Verification & rendering — HIGHEST PRIORITY, nothing has been browser-verified

Everything to date is **type-checked, not visually verified**. The Elm compiler cannot
catch slot-distribution, layout, or styling mistakes in web components. This is the
single most important bucket.

1.1 **Browser render pass over all 53 components.** Stand up the docs (or a scratch
    app) in a real browser and look at every component. The `/play`-style discipline
    from the design docs applies. Capture screenshots. Tools available: `cloudflared`
    tunnel + the static `dist/` (see Appendix), or `elm-pages dev`.

1.2 **F3 follow-up — nav family slots (was a real bug).** NavigationBar/Rail/Drawer now
    wrap icon/label/badge in `M3e.NavMenuItem.iconSlot/labelSlot/badgeSlot`, and Tabs
    uses `M3e.Tab.iconSlot`. **Verify these actually render in the right place** — this
    is exactly the class of defect the type system can't see. Files:
    `src/Ui/{NavigationBar,NavigationRail,NavigationDrawer,Tabs}.elm`.

1.3 **Form label rendering.** The form family (TextField/Select/Checkbox/RadioButton/
    Switch/SegmentedButton/Slider) puts its label in `M3e.FormField`'s **default slot**
    (the CEM exposes no `labelSlot`). Confirm the label actually renders + associates
    for a11y. If `<m3e-form-field>` needs a specific child position/markup, fix it.

1.4 **Hand-written `Attr.attribute` audit (34 sites).** Several modules still set raw
    attributes/slots by string (e.g. Tooltip `position "after"`, badge slots). Some are
    legitimate binding gaps; some may now be covered by the regenerated typed bindings.
    Audit each: `grep -rn 'Attr.attribute' src/Ui`. Replace with the typed helper where
    one now exists; keep + comment the genuine gaps.

1.5 **Snackbar end-to-end.** The `<avt-snackbar>` wrapper + `M3eSnackbar.open` path is
    only smoke-checked via the docs "Show snackbar" button. Verify: auto-dismiss timing,
    the `action` button, the `avt-snackbar-action` event round-trip, and the singleton
    behavior when two render at once.

---

## 2. Code-review leftovers (thermonuclear review, 2026-06-23)

The review produced F1–F17. F1/F2/F3/F5/F6/F7/F9/F10/F11/F12/F13/F17 were fixed; F4 was
scoped out (Disclosure). The following were **intentionally deferred** — revisit:

2.1 **F8 — `Ui.List` flips its element from a modifier's presence.** Adding
    `withItemOnClick` silently switches `<m3e-list-item>` → `<m3e-list-item-button>`
    (`src/Ui/List.elm:~208`). Documented and milder than F4, but it's still
    render-path-from-modifier (D4). Decide: keep (documented) or split into
    `Ui.List.item` vs `Ui.List.actionItem` constructors.

2.2 **F12 caveat — `Ui.Select` DOM value uses the option *label*.** The fix emits
    `M3e.Option.value opt.label` because the option `value` is a generic type with no
    `String` rendering. If two options share a label, their DOM values collide. Selection
    doesn't depend on DOM-value uniqueness today, so it's correct — but if `<m3e-select>`
    ever relies on option values, add a `value -> String` key to the API.
    File: `src/Ui/Select.elm`.

2.3 **F14 — redundant parens / formatting.** `elm-format` was run, which normalized
    most. A few `(M3e.X.foo M3e.X.Bar)` parens in case branches remain (cosmetic). Low
    value; skip unless doing a broader cleanup.

2.4 **F15 — `Avatar.extractInitials` yields `""` for non-letter input** (e.g.
    `initials "123"`), producing the empty circle the module says it prevents.
    `src/Ui/Avatar.elm:~87`. Add a fallback (first chars regardless of class).

2.5 **`ds-*` proprietary Tailwind classes still in 6 modules (real rendered classes).**
    These won't style without the old `ds-` CSS:
    - `Card.elm` — `ds-card-media/headline/subhead/actions`
    - `Dialog.elm` — `ds-dialog-headline/body/actions`
    - `BottomSheet.elm` — `ds-bottom-sheet-body/actions`
    - `SideSheet.elm` — `ds-side-sheet-body/actions`
    - `Tooltip.elm` — `ds-tooltip-actions`
    - `Shape.elm` — `ds-w-16/ds-h-16` (these two are in a **doc-comment example**, not code)
    They're structural layout hooks (actions rows, body wrappers). Decide per-site:
    (a) drop them (the m3e element's slots already lay things out), (b) replace with plain
    Tailwind utilities, or (c) keep as styling hooks and document. `grep -rn 'ds-' src/Ui`.

---

## 3. Documentation breadth & interactivity

3.1 **45 of 53 components have only the auto-reference, not a rich live demo.** The home
    page documents 8: shape, icon, avatar, skeleton, scroll-container, snackbar, theme,
    size. Add curated live-demo sections for the high-value rest — especially **Button,
    IconButton, Card, Dialog, Chip, the nav family, TextField, Checkbox, Switch,
    SegmentedButton, Fab/ExtendedFab, Tabs, List, Menu, Tooltip, Progress, Badge**.
    - Each section reads each module's real API and shows a compiling example + "when to
      use" prose. See the existing `Doc`/`docSection` pattern in `docs/app/Route/Index.elm`.
    - **Restructure first:** one giant `Index.elm` won't scale and blocks parallel work.
      Split sections into per-component files (e.g. `docs/app/Components/Button.elm`
      exposing `section : Html msg`) so they can be authored independently (and by
      parallel agents). Mirror matraic's docs nav structure.

3.2 **Interactivity needs a stateful route.** The home route is `RouteBuilder.buildNoState`
    (static), so genuinely interactive demos (button clicks dispatching msgs, dialog
    open/close, a real Elm-state-driven snackbar, the Theme picker that was made static)
    aren't possible. Convert to `RouteBuilder.buildWithLocalState` (init/update/
    subscriptions) to demo real interaction. This unblocks 3.1's interactive components.

3.3 **Snackbar declarative demo via Elm state.** With 3.2 done, replace the inline-JS
    "Show snackbar" trigger with the real `Maybe (Ui.Snackbar.Snackbar Msg)` pattern from
    the module header, proving `Ui.Snackbar.view` works end-to-end from Elm.

3.4 **Doc-comment examples are prose, not compiled (root cause of F1 rot).** The Button
    doc-rot in Card/Dialog/Tooltip happened because `{-| … -}` examples aren't type-checked.
    Add a mechanism: either a doctest extractor that compiles each fenced example, or at
    minimum a CI grep for known-removed identifiers. See 6.2.

---

## 4. The generator (`elm-cem`) & bindings

4.1 **Merge PR #11** (`jackhp95/elm-custom-elements-manifest`, branch
    `feat/resolve-ts-aliases-to-enums`). Two commits: (a) inline TS string-literal aliases
    into the CEM so enum attrs become typed per-component enums; (b) emit shared attributes
    per-component (not only in `Common`). Base is `codegen-quality-overhaul`. **Not merged.**

4.2 **Regenerate the actual `elm-m3e` repo.** The fix is proven and vendored into THIS
    repo, but the standalone `jackhp95/elm-m3e` package still ships the OLD stringly-typed
    bindings until someone runs `npm run gen` there (it depends on elm-cem). Do that, then
    this repo can drop the vendored copy in favor of the published package (see §5).

4.3 **Regenerate the other binding libraries.** The alias-resolution + per-component-attrs
    fix benefits **every** `elm-*` library (shoelace, calcite, fluent-ui, warp, web-awesome,
    material, ionic, spectrum, carbon). Regenerate + spot-check each; they'll gain typed
    enums for free.

4.4 **`elm-cem`'s own test suite is RED (pre-existing).** A clean baseline shows
    **1271 fail / 36 pass / 1307 tests** — unrelated to the alias fix (verified by
    stashing the change). The generator's tests are broken in that checkout (likely a
    missing build/setup step or stale golden files). Investigate + green them before
    publishing the tool. This is a real debt independent of m3e-builder.

4.5 **Optional generator polish.** Consider whether `Common` should still hold the
    duplicated shared attrs now that every component emits its own (the per-component copy
    made the `Common` attr copies redundant for callers; events/decoders in `Common` are
    still useful). Slimming `Common` is a follow-up design call.

---

## 5. Publishing (the "publish later" half of "symlink now, publish later")

5.1 **`elm-m3e` → Elm registry.** It's an `application`-shaped repo today? Confirm; it
    needs to be a `package` with proper `exposed-modules` (the `bin/elm-cem.js` already
    syncs those). Publish via `elm publish`. Blocker: see #6 — its `prepare` hook runs
    `elm-tooling install` and **breaks any consumer's `npm install`** (and Netlify
    `npm ci`). Fix that hook first.

5.2 **`m3e-builder` → Elm registry package.** Currently `elm.json` is `application`
    (source-dirs = `src` + vendored bindings). To publish: convert to `package`, depend on
    the published `jackhp95/elm-m3e` (5.1) instead of vendoring, fill `exposed-modules`
    (53), write package summary, tag + `elm publish`. Until 5.1 lands it can't be a package
    (packages can't depend on unpublished packages or use multi-dir source).

5.3 **Once published**, update consumers (docs app + `compass-social/ui`) to
    `elm install jackhp95/elm-m3e` + the published `m3e-builder` package, and drop the
    `vendor/` copies + cross-repo `source-directories`. Tracked partly by #6.

---

## 6. CI & tooling (none exists for this repo yet)

6.1 **CI: compile + format gate.** Add a workflow that, on push/PR: `elm make` a barrel of
    all `src/Ui` (or `elm-pages build`), `elm-format --validate src`, and builds the docs.
    Catches regressions like the migration broke.

6.2 **CI: doc-example type-check (prevents F1-style rot).** Extract fenced/indented Elm
    examples from module doc-comments and compile them, OR grep for removed identifiers
    (`Ui.Button.button`, `Ui.Chip.set`, `Ui.Size.toString`, …). The published `/reference`
    renders these verbatim, so rot is user-visible.

6.3 **`elm-review` rules from the design docs.** The specs call for `PreferBadgeCount`
    (steer `Ui.Badge.label (String.fromInt n)` → `Ui.Badge.count n`) and a no-action-Button
    smell rule. Neither is ported. `review/src/` per the design docs.

6.4 **Render-verify (à la `m3e-docs`).** A headless check that every example's emitted
    markup is a registered `<m3e-*>` element / valid composition. The `m3e-docs` repo has a
    working pattern (`scripts/render-verify.mjs`, jsdom + the built bundle) to adapt.

6.5 **`extract-reference.mjs` hardening.** It's regex-based. It already strips `@docs`/
    `@figma-code-connect`; consider failing the build if a module has no overview or a
    member has no signature, and guard against doc-comment text that contains a top-level
    `name :` pattern. File: `docs/scripts/extract-reference.mjs`.

---

## 7. Scoped-out / parked

7.1 **`Ui.Disclosure` redesign (parked, F4).** Currently in `parked/Ui/Disclosure.elm`.
    It inferred its element from panel count (1 → `M3e.ExpansionPanel`, 2+ →
    `M3e.Accordion`) — render-path inference (D4 violation) + a mega-module that absorbed
    Accordion/Collapsible. To bring it back MISI-correctly: split into explicit
    `Disclosure.single` / `Disclosure.accordion` constructors so the element is chosen at
    the call site. Also fix the magic default id `"ui-next-disclosure"` (F16) while you're
    there. Then promote back into `src/Ui/` and document.

---

## 8. Snackbar completion

8.1 **Imperative `encode` → port path is undemonstrated.** `Ui.Snackbar.encode` produces
    JSON for an outbound port to `M3eSnackbar.open`, but no app wires it. Provide a
    reference `Ports` snippet + the inbound action-callback subscription pattern (the
    module header describes it). Possibly a tiny example app.

8.2 **Action round-trip.** The `avt-snackbar-action` event (declarative path) and the
    `actionCallback` (imperative path) both need a documented Elm subscription to turn the
    action press back into a `Msg`. Write + verify that wiring.

8.3 **Singleton reconciliation.** `<m3e-snackbar>` is a hard singleton (`static current`).
    Two declaratively-rendered snackbars can't both show. The wrapper should reconcile;
    today it just calls `.open` (last wins). Document or enforce.

---

## 9. `compass-social` consumer

9.1 **No remote repo.** `compass-social` is local-only (no git remote, no GitHub repo).
    The UI spike is committed on branch `feat/ui-spike-m3e` but **unpushed**. If it should
    live remotely, create `jackhp95/compass-social` (private) and push.

9.2 **Frontend language is officially TBD** (per `compass-social/wiki/articles/
    stack-and-architecture.md` — Elm vs Gleam/Grain/Roc). The spike commits to nothing; a
    real decision is needed before building the M1 UI.

9.3 **Spike has no run setup.** `compass-social/ui/` only type-checks. To run it needs the
    same build wiring as `m3e-builder/docs` (Vite + `vite-plugin-elm` + `@m3e/web` +
    vendored `tailwind-m3e-web` bridge). The `ui/README.md` documents the approach.

9.4 **Build the actual MVP UI.** The spike (`ui/src/Main.elm`) is a faceted "what's nearby"
    feed mock. The real UI wires it to the TS data layer (`compass-social/src/data/*` —
    items, taxonomy, location, Ticketmaster source) per `wiki/articles/mvp-ux.md` and
    `core-flows.md`. Big, separate effort (their M1).

---

## 10. Open GitHub issues (cross-reference)

- **#3** — `Ui.Table` removed; informational. Close or keep as a "revisit if m3e adds a
  table element" tracker.
- **#6** — publish `elm-m3e` + **fix its consumer-breaking `prepare` hook**. See §4.2, §5.1.
- **#7** — docs ship pre-built static CSS/JS (`public/style.css`, `public/m3e.js`) instead
  of the idiomatic elm-pages Vite pipeline, because elm-pages loads its own client and
  `index.ts` imports weren't bundled. Revisit proper integration. See `docs/` build scripts.
- **#9** — assumptions: theme seed `#6750A4`/`#8B6F47`, Material Symbols via Google Fonts
  CDN (could self-host), and the Theme demo is illustrative (the `t-*` role classes are
  app-provided). See §11.

---

## 11. Assumptions to revisit (decisions, not bugs)

11.1 **`Ui.Theme` `t-*` contract.** `toAttribute role` emits `t-primary`…`t-warning`
     classes that the consuming app must define (the library ships no CSS). Decide whether
     to (a) keep this contract + ship a reference CSS, (b) remap to the m3e/Tailwind bridge
     tokens, or (c) drop `Ui.Theme`. The docs demo currently *illustrates* role colors via
     bridge tokens but doesn't prove `Ui.Theme` itself. File: `src/Ui/Theme.elm`.

11.2 **`Ui.Size` vs per-component sizes.** A shared 3-step `Ui.Size` (Small/Medium/Large)
     exists but is used only by `Ui.Heading`; Button/IconButton/AppBar/Fab/ExtendedFab/
     ButtonGroup each define their own 5-step `Size`. Decide: make `Ui.Size` the canonical
     scale and adopt it everywhere, or remove it and let each component own its scale.

11.3 **Material Symbols delivery.** Loaded from `fonts.googleapis.com` in
     `docs/elm-pages.config.mjs headTagsTemplate`. Self-host for offline/no-CDN.

11.4 **Theme seed colors.** Hard-coded `#6750A4` (docs) / `#8B6F47` (compass spike). Pick
     real brand seeds.

11.5 **External demo image.** Avatar's image demo uses `https://i.pravatar.cc`. Swap for a
     local asset.

---

## Appendix — repo map, commands, pointers

**Repo layout**
```
src/Ui/*.elm              the library (53 modules)
parked/Ui/Disclosure.elm  scoped-out (§7.1)
vendor/elm-m3e/M3e/*.elm   generated M3e.* bindings (regenerated w/ fixed elm-cem)
docs/                      elm-pages v3 docs app
  app/Route/Index.elm      home: 8 live demos + Doc/docSection pattern
  app/Route/Reference.elm  /reference: reads data/reference.json (BackendTask)
  scripts/extract-reference.mjs   source -> reference.json (build:reference)
  vendor/tailwind-m3e-web/  vendored private bridge CSS
  m3e-entry.js / style.css  static assets (esbuild + tailwind CLI) -> public/
  elm-pages.config.mjs      headTagsTemplate links /style.css + /m3e.js + Symbols font
js/avt-snackbar.js          <avt-snackbar> declarative wrapper
docs-design-*.md            authoritative MISI design specs (READ THESE)
```

**Per-module compile check** (no full build):
```
bash /tmp/verify-module.sh <Module>     # if still present; else:
# build a temp app: source-directories ["." , "<repo>/vendor/elm-m3e"], modules under Ui/
```
Whole-library barrel: import every `Ui.*` into a scratch module and `elm make` it.

**Docs build & local view:**
```
cd docs && npm install && npm run build       # -> docs/dist
python3 -m http.server 8123 --directory dist  # serve (use 127.0.0.1, not localhost, on macOS)
cloudflared tunnel --url http://127.0.0.1:8123 # public URL
```

**Deploy:** Netlify, base directory `docs`; build/publish from `docs/netlify.toml`.

**Generator fix to merge:** `jackhp95/elm-custom-elements-manifest` PR #11
(`feat/resolve-ts-aliases-to-enums`, base `codegen-quality-overhaul`).

**Key design docs to read first:** `docs-design-M3E_SPLIT_REDESIGN.md` (authoritative),
`docs-design-COMPONENT_BUILDER_REDESIGN.md`, `docs-design-COMPONENT_BUILDER_ACCEPTANCE_CRITERIA.md`.

**Oracle for API truth:** the `m3e-docs` repo (`github.com/jackhp95/m3e-docs`) — validated
CEM ground truth + `scripts/lib/validate-markup.mjs` to cross-check any example composition.
