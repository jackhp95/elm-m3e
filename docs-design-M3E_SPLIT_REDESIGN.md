# `Ui.*` Redesign — m3e Component Split + MISI Builder Layer

> **Status:** Approved design spec (2026-06-22). Supersedes `src/elm/Ui/REDESIGN_PLAN.md` (now dead — to be deleted).
> **Branch:** `VOLT-2003`. Backup of pre-redesign state (the inference experiment): local branch `backup/VOLT-2003-inferred-ui` @ `3e1982c357`.
> **Guiding principle:** Make Impossible States Impossible. The `Ui.*` layer mirrors the Material 3 / m3e *documented component surface* 1:1, and uses the type system — not runtime inference — to prevent invalid component/attribute compositions.

---

## 1. Background

The repo has three layers:

```
@m3e/web custom elements  (vendored Material 3 Expressive web components)
  └─ M3e.*    raw Elm bindings, one module per element (~126 modules). UNTOUCHED by this work.
       └─ Ui.*  typed builder layer. THIS is what we are redesigning.
```

The current `Ui.*` layer was built on a now-rejected philosophy (`REDESIGN_PLAN.md`): **collapse** many m3e components into mega-modules (`Ui.Field` = 12 input kinds; `Ui.Listing` = List+Menu+Tree; `Ui.Overlay` = Dialog+BottomSheet+Drawer+…) and **infer** which underlying element to render from the *presence of a modifier*.

That approach works against MISI: a single `Ui.Field` type carries dozens of modifiers that are explicitly "no-ops on irrelevant kinds" — a wide type full of meaningless states — and the rendered element is unpredictable from the call site.

A second developer (with design partner "Casey") independently started a MISI redesign on `origin/VOLT-2003-figma-code-connect`, completing 6 components. Their per-component MISI work is sound and aligned; their one structural choice we are **declining** is unifying Button (see §4).

## 2. Decisions (locked)

| # | Decision | Rationale |
|---|---|---|
| D1 | **One `Ui` module per m3e *documented component* page** (`docs/m3/components/*.md`), 1:1. No collapsing. | "Honor the m3e surface area." Gives a 1:1 mental map Material docs → m3e docs → `Ui` module, which makes rich doc-comments + Figma Code Connect trivial to keep coherent. |
| D2 | **MISI child composition = explicit typed slots.** Structural slots are typed to the child component (`Ui.Icon.Icon msg`, `Ui.Button.Button msg`), never `Html msg`. | A Card can't end up in `withLeadingIcon` because the slot's *type* forbids it. Kills positional-inference ambiguity. |
| D2b | Per-parent unions / **phantom-typed sets** only for homogeneous, order-significant sequences (e.g. `Chip Filter msg` sets, list items). | This is the legitimate use of a small union/phantom — not parent↔child constraint (which we reject). |
| D3 | **Single `Ui.Internal` module** holds every component's opaque type definition (records/unions). | Once slots are typed-to-child AND components mutually nest (card-in-list, list-of-cards), the import graph is cyclic; Elm forbids circular imports, so the types must co-locate. (elm-ui `Internal.Model` pattern.) Introduced at the first real container cycle. **Phase 3 update (2026-06-22):** through Card, Dialog, BottomSheet, SideSheet, Tooltip, List, Menu, and the Nav family, no genuine cross-module cycle emerged. m3 container slots compose one-way (Card → Button; Dialog → Button; List item → Icon/Button; Menu → Icon; Nav → Item; Tooltip's anchor is `Html msg`). m3 doesn't sanction bidirectional typed embedding (no "Card body must be a List" + "List item must be a Card"). `Ui.Internal` therefore remains *deferred*, available the moment a composite need (e.g. `Disclosure` with typed-`Ui`-content, or a `Button.group` that introspects its children's variant for connected-shape) demands it. |
| D4 | **No render-path inference, no silent no-ops in v1.** The constructor picks the element; required collaborators are constructor args. | The presence/absence of a modifier must never silently change which element renders or be silently ignored. |
| D5 | **Builder pattern**, required collaborators in the constructor, optional config via `with*` setters returning the same opaque type. | Their proven idiom; matches nri-ui and the project's existing builder convention. |
| D6 | The unified/inferred abstractions (a single smart `Button`, a single smart `Field`) are an **explicit future layer** built *on top of* the split `Ui.*` modules — out of scope here. | Keeps v1 honest and predictable; the convenience layer can be added later without disturbing the split foundation. |
| D7 | **Integration = cherry-pick their work onto `VOLT-2003`** (we keep our branch). | User directive. Histories diverged (overlapping hash-different commits) so conflicts are expected; resolve via cherry-pick-rebase, fall back to file-level adoption. |

## 3. Module list (strict m3e-doc-page mapping)

Source of truth: `docs/m3/components/*.md`. Index pages (`all-buttons`) excluded.

**Buttons family:** `Ui.Button` (buttons), `Ui.IconButton` (icon-buttons), `Ui.ButtonGroup` (button-groups), `Ui.SplitButton` (split-button), `Ui.Fab` (floating-action-button), `Ui.ExtendedFab` (extended-fab), `Ui.FabMenu` (fab-menu), `Ui.SegmentedButton` (segmented-buttons).

**Inputs family** (the `Ui.Field` explosion): `Ui.TextField` (text-fields), `Ui.Checkbox` (checkbox), `Ui.Switch` (switch), `Ui.RadioButton` (radio-button), `Ui.Slider` (sliders), `Ui.DatePicker` (date-pickers), `Ui.TimePicker` (time-pickers), `Ui.Select` (select — confirm m3e element/page).

**Containers / surfaces:** `Ui.Card` (cards), `Ui.Dialog` (dialogs), `Ui.BottomSheet` (bottom-sheets), `Ui.SideSheet` (side-sheets), `Ui.List` (lists), `Ui.Menu` (menus), `Ui.Carousel` (carousel), `Ui.Toolbar` (toolbars), `Ui.AppBar` (app-bars).

**Navigation:** `Ui.NavigationBar` (navigation-bar), `Ui.NavigationRail` (navigation-rail), `Ui.NavigationDrawer` (navigation-drawer), `Ui.Tabs` (tabs).

**Display / feedback / primitives:** `Ui.Chip` (chips), `Ui.Badge` (badges), `Ui.Avatar` (avatar — not a standalone m3e page; keep as project primitive), `Ui.Divider` (divider), `Ui.Tooltip` (tooltips), `Ui.Snackbar` (snackbar), `Ui.Progress` (progress-indicators), `Ui.LoadingIndicator` (loading-indicator), `Ui.Search` (search), `Ui.Icon` (primitive, used by every slot), `Ui.Heading` (typographic primitive).

≈37 modules. **Judgment calls to resolve while building** (do not block the spec):
- `extended-fab` — separate `Ui.ExtendedFab` vs an `extended` mode on `Ui.Fab`. Lean: separate module if `M3e` exposes a distinct element; otherwise a constructor on `Ui.Fab`.
- `Ui.Select` — confirm whether m3e ships a Select element distinct from text-fields/menus.
- Project primitives with no m3e page (`Ui.Avatar`, `Ui.Heading`, `Ui.Shape`, `Ui.Size`, `Ui.Theme`) stay as-is.

## 4. What survives / changes from the other dev's branch

| Component | Their state | Action under strict split |
|---|---|---|
| Progress, Avatar, Badge, Chip, Search | Single m3e page each; MISI done | **Survives ~as-is.** Aligned. |
| Button | **Unified** (`labeled`/`iconOnly` in one `Button msg` type) | **Re-split** into `Ui.Button` (labeled) + `Ui.IconButton`. iconOnly's required a11y `label` becomes `Ui.IconButton`'s required constructor field. |
| `PreferBadgeCount` rule, generator grammar (enum/icon/record-msg axes), `/play` catalog + `figma:check` pipeline | Built & tested | **Adopt wholesale.** |
| Field (Bucket B / future on their branch) | Largely untouched | **Explode** into the Inputs-family modules above. Biggest workstream; neither branch has done it. |

## 5. Documentation standard

Every public module and every exposed binding:
- elm-package documentation format (`{-| … -}`, `@docs` blocks, module overview).
- At least one runnable usage example per module.
- "When to use this vs siblings" Material guidance, sourced from `docs/m3/components/` and the m3e-docs reference (`github.com/jackhp95/m3e-docs`).
- `@figma-code-connect` annotations preserved/extended (drives both the Figma bridge and the `/play` catalog; any change must update both generators + regenerate the catalog or `figma:check` fails).

## 6. Per-component validation pipeline (adopted from their acceptance doc)

For each component change:
1. Rewrite `src/elm/Ui/<C>.elm` (API + doc annotations).
2. `node code-connect/generate.mjs` → sync `code-connect/*.figma.ts`.
3. `npm run elm-gen:build:uiCatalog` (regenerate `/play`).
4. `npm run figma:check` (drift + orphan + catalog sync).
5. `npm run build:elm`, `npm run format:elm`, `npm run elm-review -- --fix-all-without-prompt`, `npm run test:elm`.
6. `code-reviewer` + acceptance-criteria subagents (per project CLAUDE.md workflow).

## 7. Phasing

- **Phase 0 — Integrate.** Cherry-pick their Ui redesign + rule + generator + design docs onto `VOLT-2003`. Delete `src/elm/Ui/REDESIGN_PLAN.md`. Green build/test baseline.
- **Phase 1 — Pattern-lock (build together).** Two starter components:
  - **`Ui.IconButton`** — split out of their Button. Smallest real exercise of strict-split + typed-slot + required-a11y-label.
  - **`Ui.Card`** — first true container; forces the `Ui.Internal` decision and the typed-child-slot pattern early, before it's expensive to get wrong.
- **Phase 2 — Inputs family.** Explode `Ui.Field` into TextField/Checkbox/Switch/RadioButton/Slider/DatePicker/TimePicker/Select. One PR per logical batch; migrate the (few) call sites.
- **Phase 3 — Containers & nav.** `Ui.List`/`Ui.Menu`, `Ui.Dialog`/`Ui.BottomSheet`/`Ui.SideSheet`/`Ui.Tooltip`, `Ui.NavigationBar`/`Rail`/`Drawer`. Establish `Ui.Internal` here.
- **Phase 4 — Remaining + cleanup.** Fab family, ButtonGroup, SplitButton, Snackbar, Carousel; update `m3e-implement`/`m3e-verify`/`creating-uis` skill docs; audit stale `Ui.*` mentions.

## 8. Risks / notes

- **Cherry-pick conflicts.** Divergent histories; budget time for manual resolution or file-level adoption of their finished `Ui/*`, `code-connect/*`, generators, and `review/src/` rule.
- **Migration is cheap.** Only 2 files outside `src/elm/Ui/` and `src/elm/App/Play/` consume `Ui.*` today, so API churn is low-risk.
- **Keep `/play` alive** as a living spec + visual-regression target; run Playwright `@ui`/`@visual` after each phase.
- **`Ui.Internal` blast radius.** A single types module means a type change recompiles all consumers — acceptable cost for cycle-freedom; keep the module to *type definitions only*.
