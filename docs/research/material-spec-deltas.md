# Material 3 / m3e CEM ↔ `Ui.*` Wrapper — Spec Delta Audit

> **⚠ Largely stale (as of 2026-06-25).** A later working-tree audit
> (`slot-graph-audit.md`) found nearly every CRITICAL/HIGH delta below was
> already fixed in the code (AppBar, Nav*, SideSheet, Tabs, Paginator, Stepper,
> Card, Dialog, BottomSheet, Tooltip, Theme, Shape, …), and `Ui.Size` has since
> been retired. Treat this as a historical snapshot; grade against the working
> tree and `slot-graph-audit.md`.

> **Scope:** every module in `src/Ui/` (53 component modules + `Ui.Size` + `Ui.Theme`).
> **Oracle:** m3e-docs `data/components.json` (CEM machine-truth: tags, attributes, enums,
> defaults, slots, events, css custom properties), `data/examples_raw.json` (shipped example
> markup), and `scripts/lib/validate-markup.mjs` (the project's own structural validator).
> Color-token contract cross-checked against the `tailwind-m3e-web` bridge
> (`/Users/jhp/code/jackhp95/tailwind-m3e-web/generated/CSS_CUSTOM_PROPERTIES.md`, `src/theme.css`,
> `src/roles-extended.css`).
> **Method:** for each module the *emitted* markup (via `view`/helpers, through `M3e.*` vendor
> bindings — not doc-comment prose) was compared against the matching CEM record. Every claim below
> was verified against the CEM JSON, not from memory.
> **Design principles weighed:** D1 one `Ui` module per documented m3e component; D2 typed
> structural slots; D4 no render-path inference / no silent no-ops; D5 builder pattern.

`validateMarkup` rules (mirrored as the pass/fail bar): a tag must exist in the CEM; every attribute
on an m3e element must be a documented attribute, a property, or a global
(`slot`,`id`,`role`,`title`,`hidden`,`tabindex`,`aria-*`,`data-*`,`on*`); every closed-union
attribute value must be a member of that union; every `slot="x"` must be a real slot of the *nearest
m3e ancestor*. `ds-*` and `t-*` classes are **not** Material.

---

## Summary table

| Component | Status | Severity | One-line delta |
|---|---|---|---|
| AppBar | DELTA | **CRITICAL** | Title rendered to nonexistent default slot → dropped (m3e-app-bar has no default slot) |
| Avatar | OK | — | |
| Badge | OK | — | |
| BottomSheet | DELTA | **CRITICAL** | `open` never emitted → never opens; `onClose` never wired → undismissable |
| Breadcrumb | OK | — | |
| Button | OK | — | |
| ButtonGroup | DELTA | LOW | `variant` (`connected`) not exposed |
| Calendar | OK | — | |
| Card | DELTA | MEDIUM | 4 proprietary `ds-card-*` classes |
| Carousel | DELTA | MEDIUM | wraps items in undocumented `<m3e-slide>` (not in CEM) |
| Checkbox | DELTA | HIGH | form-field label orphaned (not anchored) |
| Chip | OK | — | |
| DatePicker | OK | — | |
| Dialog | DELTA | HIGH | `full-screen` attr not in CEM → `withFullScreen` silent no-op; +3 `ds-*` |
| Divider | OK | — | |
| ExtendedFab | DELTA | HIGH | D1: not a distinct CEM component (just `m3e-fab[extended]`); label not in `label` slot |
| Fab | OK | — | |
| FabMenu | DELTA | **CRITICAL** | children are raw `<button>`, not `m3e-menu-item`; no trigger; `triggerIcon` dropped |
| Heading | OK | — | (LOW: Elm default variant diverges from element default) |
| Icon | OK | — | |
| IconButton | OK | — | |
| List | OK | — | (LOW: `disabled` on non-interactive `m3e-list-item` is a no-op) |
| LoadingIndicator | OK | — | |
| Menu | OK | — | |
| NavigationBar | DELTA | **CRITICAL** | emits `m3e-nav-menu-item` (drawer child) inside `m3e-nav-bar`; `label`/`badge` slots dropped |
| NavigationDrawer | DELTA | HIGH | nav-menu in drawer default slot, not `start`/`end` → renders in main content |
| NavigationRail | DELTA | **CRITICAL** | same wrong child + dropped `label`/`badge` slots as NavigationBar |
| Paginator | DELTA | HIGH | `pageIndex` (camelCase) ignored; CEM attr is `page-index` → default page never set |
| Progress | OK | — | |
| RadioButton | DELTA | HIGH | radios + group have no shared `name` → grouping/keyboard/submit broken; label orphaned |
| ScrollContainer | DELTA | HIGH | `m3e-scroll-container` not in CEM (undocumented D1) |
| Search | DELTA | MEDIUM | raw `Attr.attribute "open"` duplicates typed binding |
| SegmentedButton | DELTA | HIGH | wrapped in `m3e-form-field` (D1; segmented-button is not a form-field control) |
| Select | DELTA | HIGH | option `value`=display label; double form-field wrap; label orphaned |
| Shape | DELTA | MEDIUM | doc steers callers to proprietary `ds-w-16`/`ds-h-16`; `name` attr unsurfaced |
| SideSheet | DELTA | **CRITICAL** | body/actions in drawer default slot, not `start`/`end` → panel empty; onClose unwired |
| Skeleton | OK | — | (LOW: `animation`/`shape`/`loaded` unsurfaced) |
| Slide | DELTA | MEDIUM | undocumented `<m3e-slide>`; D1 double-wrap of `slide-group` with Carousel |
| Slider | DELTA | HIGH | label orphaned; raw `Attr.attribute "value"` duplicates binding (MEDIUM) |
| Snackbar | OK | — | (intentional `<avt-snackbar>` wrapper; attr names match CEM) |
| SplitButton | DELTA | **CRITICAL** | both buttons emitted with no slot → not projected (no default slot exists) |
| SplitPane | DELTA | MEDIUM | content-panes lack `slot="start"`/`"end"`; relies on positional ordering |
| Stepper | DELTA | MEDIUM | raw `Attr.attribute "selected" "true"` duplicates `M3e.Step.selected` |
| Switch | DELTA | HIGH | form-field label orphaned |
| Tabs | DELTA | HIGH | tab badge in nonexistent `badge` slot on `m3e-tab` → dropped |
| TextField | DELTA | HIGH | form-field label orphaned |
| TextHighlight | DELTA | HIGH | `m3e-text-highlight` not in CEM (undocumented D1) |
| TimePicker | DELTA | HIGH | form-field label orphaned; renders native `<input type=time>` (documented D1 gap) |
| Toc | OK | — | (LOW: emits project `ui-toc-auto-width` class) |
| Toolbar | OK | — | |
| Tooltip | DELTA | HIGH | rich-tooltip actions not slotted → fall into content slot; +1 `ds-*`; 3 redundant raw `position` |
| **Ui.Size** | DELTA | MEDIUM | see [Size resolution](#size-resolution) |
| **Ui.Theme** | DELTA | HIGH | `t-*` classes are not Material and ship no CSS; see [Theme token remap](#theme-token-remap) |

**Tally:** 18 OK · 35 DELTA. By top severity among the deltas: **6 CRITICAL**, 13 HIGH, 12 MEDIUM,
4 LOW.

**The 6 CRITICAL deltas all share one shape: content silently routed to a slot/state the element does
not have, so it never renders — exactly the failure mode D2/D4 exist to prevent, and exactly what the
type system cannot catch (slot names are strings).**

---

## CRITICAL deltas (content silently dropped)

### AppBar — title dropped (`src/Ui/AppBar.elm:133`)
- **CEM:** `m3e-app-bar` slots are `leading`, `subtitle`, `title`, `trailing`, `leading-icon`
  (deprecated), `trailing-icon` (deprecated). **There is no default slot.** (`/tmp/cem/app-bar.json`,
  verified against `data/components.json`.)
- **Deviation:** the title is `Html.span [] [ Html.text cfg.title ]` — no `slot` attribute — so it
  lands in a default slot that does not exist and is not projected.
- **Fix:** `Html.span [ M3e.AppBar.titleSlot ] [ Html.text cfg.title ]` (vendor `titleSlot` exists).
- Secondary (MEDIUM): `AppBar.elm:146/156` use raw `Attr.attribute "slot" "leading"`/`"trailing"`
  (use `M3e.AppBar.leadingSlot`/`trailingSlot`); `AppBar.elm:166/169` use raw
  `Attr.attribute "size" "medium"/"large"` while the `Small` branch (`:163`) uses the typed
  `M3e.AppBar.size` — use the typed binding for all three. (`size` enum `'small'|'medium'|'large'`
  matches; only the binding inconsistency is the smell.)

### NavigationBar — wrong child element, label & badge dropped (`src/Ui/NavigationBar.elm`)
- **CEM:** `m3e-nav-bar`'s child is **`m3e-nav-item`**, whose slots are `(default)`, `icon`,
  `selected-icon` — **no `label` slot, no `badge` slot** (label rides the default slot).
  (`/tmp/cem/nav-bar.json`, verified.)
- **Deviation:**
  - `:221` emits `M3e.NavMenuItem.component` → `m3e-nav-menu-item`. That element belongs to the
    `nav-menu`/drawer family, **not** `nav-bar`. Destinations are not rendered as nav items.
  - `:240` puts the label in `M3e.NavMenuItem.labelSlot` (`slot="label"`) — no such slot on a nav
    item → label dropped.
  - `:250` puts a badge in `M3e.NavMenuItem.badgeSlot` (`slot="badge"`) — no such slot → badge dropped.
- **Fix:** render items with `M3e.NavItem.component`; put the label in the **default** slot (drop the
  label-slot wrapper); compose any badge inside the item content (e.g. an `m3e-badge` in the default
  region) — there is no badge slot. Use `M3e.NavItem.iconSlot`/`selectedIconSlot`/`selected`.
- Note (LOW): module defaults `mode = Auto`; CEM default is `compact`. `auto` is a valid union member,
  so this is a deliberate override, not a bug.

### NavigationRail — wrong child element, label & badge dropped (`src/Ui/NavigationRail.elm`)
- **CEM:** `m3e-nav-rail` (attr `mode`) + `m3e-nav-rail-toggle` (attr `for`). The rail's item element
  is **`m3e-nav-item`** (same slots as above); the rail's CEM record lists no rail-specific item
  element. (`/tmp/cem/nav-rail.json`.)
- **Deviation:** identical to NavigationBar — `:208` emits `m3e-nav-menu-item`; `:227` `labelSlot` and
  `:237` `badgeSlot` drop content.
- **Fix:** identical to NavigationBar — switch to `M3e.NavItem`, label to default slot, no badge slot.

### SideSheet — panel renders empty (`src/Ui/SideSheet.elm:229,241`)
- **CEM:** there is no `m3e-side-sheet`; the module reuses `m3e-drawer-container`, whose slots are
  `(default)`, `start`, `end`. The drawer panel content must be projected into `start` or `end`; the
  default slot is the **main content** region. (`/tmp/cem/drawer-container.json`, verified.)
- **Deviation:** body (`:229`) and actions (`:241`) divs carry **no slot**, so both land in the
  default (content) slot. `start`/`end` are toggled on (`:258`/`:261` via `M3e.DrawerContainer.start`/
  `end`) but nothing is slotted into them → the sheet content shows in the page body and the drawer
  panel is empty.
- **Fix:** route body+actions through `M3e.DrawerContainer.startSlot`/`endSlot` chosen by `cfg.side`.
- Secondary (HIGH): `onClose` is a required constructor arg but never wired — drawer close gestures
  never reach Elm (wire `M3e.DrawerContainer.onChange`). (LOW): `:199-219` builds `start-mode`/
  `end-mode` by hand via raw `Attr.attribute` instead of `M3e.DrawerContainer.startMode`/`endMode`
  (the `over`/`side` values are valid enum members).

### BottomSheet — never opens, undismissable (`src/Ui/BottomSheet.elm:155-166`)
- **CEM:** `m3e-bottom-sheet` attrs include `open` (default `false`) and `modal`; slots are only
  `(default)` and `header` (**no `actions` slot** — action rows use the companion
  `m3e-bottom-sheet-action`). (`/tmp/cem/bottom-sheet.json`, verified.)
- **Deviation:**
  - `open` is never emitted on the element; it defaults to `false`, so even when the view gates on
    `cfg.open` the web component stays closed and body/header never display. **Silent no-op (D4).**
  - `onClose` is a required arg (`:92`) but neither `onClosed` nor `onCancel` is wired → user dismiss
    never reaches Elm; the sheet can get stuck open.
  - `modal` has no modifier and is never emitted.
- **Fix:** emit `M3e.BottomSheet.open True` on the rendered element; wire `M3e.BottomSheet.onClosed`/
  `onCancel` to `cfg.onClose`; add a `withModal`. Replace the `ds-bottom-sheet-actions` div with
  `m3e-bottom-sheet-action` elements (there is no `actions` slot).

### SplitButton — buttons not projected (`src/Ui/SplitButton.elm:122-136`)
- **CEM:** `m3e-split-button` slots are **`leading-button`** and **`trailing-button`** only — **no
  default slot**. (`/tmp/cem/split-button.json`.)
- **Deviation:** `view` emits two bare `Html.button` children with no `slot`, so neither is projected;
  the split button does not compose. `M3e.SplitButton.leadingButtonSlot`/`trailingButtonSlot` exist
  and are unused.
- **Fix:** add `leadingButtonSlot` to the primary button and `trailingButtonSlot` to the trigger.
- Secondary (HIGH): `:152` `Outlined -> Attr.attribute "variant" "outlined"` bypasses the typed
  `M3e.SplitButton.variant M3e.SplitButton.Outlined` that the other three variants use (the literal
  value is correct; the inconsistency is the smell). (LOW): `:133` hardcodes
  `aria-label "More actions"` — make it caller-supplied for i18n.

### FabMenu — wrong child tag, no trigger, icon dropped (`src/Ui/FabMenu.elm:121-139`)
- **CEM:** `fab-menu` has three elements — `m3e-fab-menu` (container, default slot = menu contents),
  `m3e-fab-menu-trigger` (nested in a clickable element to open the menu, attr `for`), and
  `m3e-menu-item` (slots `(default)`=label, `icon`; emits `click`). (`/tmp/cem/fab-menu.json`.)
- **Deviation:**
  - `:132` renders each action as a raw `Html.button`, **not** `m3e-menu-item` — the structure the
    web component reads is absent; actions are mis/under-rendered.
  - No `m3e-fab-menu-trigger` and no `m3e-fab` to open the menu.
  - `triggerIcon` is collected in config but **never rendered** (silent no-op, D4); only
    `triggerLabel` is emitted as the container `aria-label` (`:125`).
- **Fix:** render a trigger (`m3e-fab` wrapping/adjacent `m3e-fab-menu-trigger`), render the
  `triggerIcon`, and replace the `Html.button` children with `m3e-menu-item` (label in default slot,
  glyph in `icon` slot, click via the item's `click`). Verify `M3e.FabMenuTrigger`/menu-item bindings
  exist in vendor; if missing, that is a prerequisite gap.

---

## HIGH deltas

### Tabs — badge dropped (`src/Ui/Tabs.elm:173`)
- **CEM:** `m3e-tab` slots are `(default)` and `icon` only — **no `badge` slot**. (`/tmp/cem/tabs.json`.)
- **Deviation:** `Html.span [ Attr.attribute "slot" "badge" ] [...]` lands in an undefined slot →
  badge dropped. (Icon slot at `:163` via `M3e.Tab.iconSlot` is correct.)
- **Fix:** compose the badge inside the default/icon content (e.g. an `m3e-badge` beside the label);
  remove the `slot="badge"` wrapper.

### Paginator — default page never applied (`src/Ui/Paginator.elm:151`)
- **CEM:** the attribute is **`page-index`** (kebab-case, type `number`); `M3e.Paginator.pageIndex`
  emits `page-index` correctly. (`/tmp/cem/paginator.json`.)
- **Deviation:** the `DefaultPage` branch emits `Attr.attribute "pageIndex" ...` (camelCase) — not a
  documented attribute, so it is ignored and the uncontrolled initial page is never set. (The
  `ExplicitPage` branch at `:154` correctly uses the typed binding.)
- **Fix:** `DefaultPage i -> [ Just (M3e.Paginator.pageIndex (toFloat i)) ]`.

### NavigationDrawer — panel in wrong slot (`src/Ui/NavigationDrawer.elm:216-218`)
- **CEM:** `m3e-drawer-container` slots `(default)`, `start`, `end`; the panel content goes in
  `start`/`end`, the default slot is main content. The nav-menu-item slots themselves (`icon`,
  `label`, `badge`, `selected-icon`, `toggle-icon`) **are** all real on `m3e-nav-menu-item` — this is
  the one Nav module whose item slots are correct.
- **Deviation:** `M3e.NavMenu.component` is added as a plain (default-slot) child, so the drawer panel
  shows in the main content area even though `start`/`end` are enabled.
- **Fix:** wrap the nav-menu with `M3e.DrawerContainer.startSlot`/`endSlot` per `cfg.side`. (MEDIUM:
  `:266-285` builds `start-mode`/`end-mode` via raw `Attr.attribute` — use typed `startMode`/`endMode`.)

### Dialog — `withFullScreen` silent no-op (`src/Ui/Dialog.elm:226`)
- **CEM:** `m3e-dialog` attrs are exactly `alert`, `close-label`, `disable-close`, `dismissible`,
  `no-focus-trap`, `open` — **no `full-screen`**. (`/tmp/cem/dialog.json`, verified.)
- **Deviation:** `maybeAttr cfg.fullScreen (Attr.attribute "full-screen" "true")` sets an attribute
  the element ignores → `withFullScreen` (D4 silent no-op).
- **Fix:** remove `withFullScreen` + the attr, or implement full-screen via CSS/size tokens and
  document it as a project concern, not an m3e attribute. (Plus 3 `ds-dialog-*` classes — see ds-*.)

### Tooltip — rich actions not slotted (`src/Ui/Tooltip.elm:287`)
- **CEM:** `m3e-rich-tooltip` has a real **`actions`** slot (and `subhead`); `M3e.RichTooltip.actionsSlot`
  exists. (`/tmp/cem/tooltip.json`.)
- **Deviation:** `actionsElement` builds `Html.div [ Attr.class "ds-tooltip-actions" ] [...]` with no
  slot → actions render in the tooltip body instead of the actions region.
- **Fix:** `Html.div [ M3e.RichTooltip.actionsSlot ] (...)` (removes the `ds-*` class and fixes the
  slot). (MEDIUM: `:259/272/275` use raw `Attr.attribute "position"` though typed `M3e.Tooltip.After`,
  `M3e.RichTooltip.Before`/`After` all exist — values are valid; use the bindings.)

### Form-field label anchoring — Checkbox / RadioButton / Switch / Slider / TextField / Select / TimePicker / SegmentedButton
- **CEM:** `m3e-form-field` slots are `(default)` (= **"the control of the field"**), `prefix`,
  `prefix-text`, `suffix`, `suffix-text`, `hint`, `error`. The CEM slot list does **not** include a
  `label` slot — **but** all shipped form-field examples (`examples_raw.json`, 3 occurrences) use
  `<label slot="label" for="<id>">`, and the control carries the matching `id`. Several controls
  (`m3e-select`, etc.) also expose their own `label` attribute. (`/tmp/cem/form-field.json`,
  `data/components.json`, verified.)
- **Deviation (HIGH, repeated):** every form-field-wrapping module renders its label as a bare
  default-slot `Html.label` with no `slot="label"` and a `for` only when `withId` was called. So the
  label competes with the control for the `(default)` (control) slot and is not anchored; without
  `withId` there is no `for`/`id` pair at all. File:line of each `labelElement`:
  - `TextField.elm:467-475` (placed `:458`)
  - `Select.elm:287-295`
  - `Checkbox.elm:305-313` (`m3e-checkbox` has **no** slots — label *must* be the form-field label)
  - `RadioButton.elm:263-271`
  - `Switch.elm:236-244` (`m3e-switch` has no slots)
  - `Slider.elm:323-331` (`m3e-slider`'s only slot is `(default)` for thumbs)
  - `TimePicker.elm:219-225`
- **Fix (apply uniformly):** emit `<label slot="label" for="<id>">` and always generate a stable
  control `id` (auto-derive when `withId` is omitted). No typed `M3e.FormField.labelSlot` exists, so
  `slot="label"` is a legitimate raw `Attr.attribute` here (no binding covers it). **Caveat:**
  `slot="label"` is not in the CEM slot *list* (it would fail `validateMarkup`'s slot check) though it
  *is* in the shipped examples; the cleanest spec-true alternative is to drop the form-field wrapper
  for controls that expose a native `label` attribute (notably `m3e-select`) and pass the label that
  way. Decide per control; the current default-slot approach matches neither the CEM slots nor the
  examples.

### Select — additional deltas (`src/Ui/Select.elm`)
- **HIGH `:271`:** `M3e.Option.value opt.label` binds the **display label** to the option's `value`
  attribute (CEM `m3e-option.value` is the submission value). Two options sharing a label collide.
  Fix: pass a stable value from `opt.value`, or drop `value` (selection is already driven by
  `selected`/onClick).
- **HIGH `:243-251`:** `m3e-select` is double-wrapped in `m3e-form-field` + a manual label. The
  canonical example uses `<m3e-select label="…">` with no form-field and no separate `<label>`. Prefer
  the native form.

### RadioButton — missing group `name` (`src/Ui/RadioButton.elm:243-260`)
- **CEM:** `m3e-radio` and `m3e-radio-group` both carry `name`; radios are grouped by `name`.
  (`/tmp/cem/radio-group.json`.)
- **Deviation:** neither the group nor the child radios are given a `name` → native grouping,
  keyboard-arrow navigation, and form submission are broken. Fix: thread a shared `name` (auto-derive
  if absent) onto the group and every radio. (Radio nesting in the group default slot is correct.)

### SegmentedButton — form-field wrapping (`src/Ui/SegmentedButton.elm:248`)
- **CEM:** `m3e-segmented-button`'s only slot is `(default)`; it is not documented as a form-field
  control, and `m3e-form-field`'s `error`/`hint` slots belong to a form-field, not a segmented button.
  (`/tmp/cem/segmented-button.json`, `/tmp/cem/form-field.json`.)
- **Deviation:** `view` makes `m3e-form-field` the outer element wrapping the segmented button + a
  `Html.label` + error/hint spans. This conflates two unrelated m3e components (D1) and injects the
  segmented button into a parent whose slotting contract it doesn't satisfy.
- **Fix:** render `m3e-segmented-button` standalone; if label/help is wanted, use a project layout
  primitive, not `m3e-form-field`. (MEDIUM `:295`: `<label for>` targeting a custom-element id is
  fragile.)

### ExtendedFab — D1 + label slot (`src/Ui/ExtendedFab.elm`)
- **CEM:** there is no `extended-fab`/`m3e-extended-fab`. "Extended FAB" is `m3e-fab[extended]`. The
  emitted `extended` boolean (`:162`) is a real CEM attr and valid. (`/tmp/cem/fab.json`.)
- **Deviation (HIGH, D1):** `Ui.Fab` and `Ui.ExtendedFab` wrap the *same* component, differing only by
  one boolean — a D1 violation, though a deliberate, documented split (the M3 site lists Extended FAB
  as its own page). **Human decision:** collapse into `Ui.Fab` (`withExtended`/`withLabel`-driven), or
  keep the ergonomic split and document it as an intentional carve-out (like the Button MISI carve-out).
- **Deviation (MEDIUM `:172`):** the label is bare `Html.text` in the `(default)` slot (which is for
  the icon); `m3e-fab` has a dedicated `label` slot (`M3e.Fab.labelSlot`). Fix: wrap the label in
  `Html.span [ M3e.Fab.labelSlot ]`.

### ScrollContainer & TextHighlight — not in CEM (undocumented D1)
- **CEM:** neither `m3e-scroll-container` nor `m3e-text-highlight` is one of the 53 documented
  components (`data/components.json` has no such tag — only `m3e-scrollbar-*` /
  `m3e-option-panel-text-highlight-*` CSS custom props, i.e. internal styling details). Verified
  absent.
- **Deviation:** `ScrollContainer.elm` (`vendor M3e/ScrollContainer.elm:24`) and `TextHighlight.elm`
  (`vendor M3e/TextHighlight.elm:34`) emit these tags and the doc comments present them as documented
  M3 surfaces. The elements ship via vendor bindings (so not fabricated), but their attribute surfaces
  cannot be CEM-validated.
- **Fix:** either drop the modules, or rewrite the doc comments to state explicitly that these are
  undocumented utility elements (not part of the documented M3 surface) — to keep the D1 "documented
  component" mental map honest.

### TimePicker — native control (documented D1 gap) (`src/Ui/TimePicker.elm:201-216`)
- **CEM:** there is no `m3e-time-picker`. The module renders a native `<input type=time>` inside
  `m3e-form-field`, acknowledged in its doc comment.
- **Assessment:** not a silent failure (the control renders and works; `min`/`max`/`step` are valid
  *native* input attrs, correctly via `Attr.attribute`), but it does not deliver the Material
  dial/input chrome its name implies. Acceptable stopgap **iff** listed as a known gap; graduate when
  `m3e-time-picker` lands. (Plus the orphaned-label HIGH above.)

---

## MEDIUM / LOW deltas

- **Card** (`src/Ui/Card.elm`): 4 `ds-card-*` classes — see [ds-* inventory](#ds--class-inventory).
  Slot structure (`header`/`content`/`actions`/`footer`) is correct.
- **Carousel / Slide** (`Carousel.elm:93-95`, `Slide.elm:94-96`): both wrap items in `<m3e-slide>`,
  which is **not** in the CEM (`slide-group.json` declares only `m3e-slide-group`; its default slot is
  "content to paginate"). The element ships via vendor binding but is undocumented. Also a D1 concern:
  two modules wrap the single `slide-group` component with overlapping APIs — consider consolidating.
  Fix: put items directly in the slide-group default slot, or document the undocumented `<m3e-slide>`.
- **Search** (`Search.elm:303-304`): `Attr.attribute "open" "true"` duplicates `M3e.SearchView.open`
  (used correctly in the other branch). `slot="input"`, leading slot, and applying `open` only to
  `m3e-search-view` are all correct.
- **Slider** (`Slider.elm:311`): `Attr.attribute "value"` duplicates `M3e.SliderThumb.value`
  (`value` is a real `m3e-slider-thumb` attr; only the binding bypass is the smell).
- **Stepper** (`Stepper.elm:215`): `Attr.attribute "selected" "true"` duplicates `M3e.Step.selected`
  used 5 lines later. Slots (`step`/`panel`) and step attrs are correct.
- **SplitPane** (`SplitPane.elm:104-105`): two `m3e-content-pane` children with no `slot="start"`/
  `"end"`, though CEM declares named `start`/`end` slots on `m3e-split-pane`. Relies on positional
  ordering. Fix: add the slot attributes.
- **Shape** (`Shape.elm:12-13`): the doc-comment example steers callers to proprietary `ds-w-16`/
  `ds-h-16` (not emitted, but advertised). Fix: use M3 sizing (e.g. `--m3e-shape-size`) or the `name`
  attr (the only CEM `m3e-shape` attr, currently unsurfaced).
- **ButtonGroup** (`ButtonGroup.elm`): no `withVariant`, so `connected` groups (the M3 Expressive
  point of the component) are unreachable. `M3e.ButtonGroup.variant` exists. LOW capability gap.
- **List** (`List.elm:256`): `Attr.disabled True` is emitted even on the non-interactive
  `m3e-list-item` branch (`:251`), which has no `disabled` attr — a harmless no-op. LOW.
- **Heading** (`Heading.elm:59-67`): Elm default `variant = Headline` diverges from the element default
  `display`; `withLevel` accepts any Int while CEM constrains `1..6`. Both LOW (variant always emitted
  explicitly; level unclamped).
- **Badge** (`Badge.elm`): never emits `medium` (only small/large) — a deliberate 2-type narrowing,
  valid. LOW.
- **Toc** (`Toc.elm:112`): emits project `ui-toc-auto-width` (a `ui-*` class, not `ds-*`/`t-*`/
  Material). LOW note.
- **Snackbar** (`Snackbar.elm`): intentionally emits the project `<avt-snackbar>` wrapper (not in CEM,
  by design — imperative bridge). Forwarded attr names (`action`, `dismissible`, `close-label`,
  `duration`) match `m3e-snackbar` CEM casing exactly; `message` is the wrapper's own arg (m3e uses the
  default slot). **OK.**

---

## ds-* class inventory (12 emitted call sites + 2 doc-only)

`ds-*` classes are **not Material** (D-violation). Every emitted occurrence, with the real CEM region
to use instead:

| File:line | class | Real CEM region / fix |
|---|---|---|
| `Card.elm:284` | `ds-card-media` | author markup inside `header` slot div — drop class |
| `Card.elm:289` | `ds-card-headline` | inside `header` slot div — drop class |
| `Card.elm:294` | `ds-card-subhead` | inside `header` slot div — drop class |
| `Card.elm:315` | `ds-card-actions` | redundant — element already has `actionsSlot` (`slot="actions"`) |
| `Dialog.elm:252` | `ds-dialog-headline` | redundant — element has `headerSlot` (`slot="header"`) |
| `Dialog.elm:264` | `ds-dialog-body` | dialog default slot — drop class |
| `Dialog.elm:277` | `ds-dialog-actions` | redundant — element has `actionsSlot` (`slot="actions"`) |
| `BottomSheet.elm:181` | `ds-bottom-sheet-body` | default slot — drop class |
| `BottomSheet.elm:193` | `ds-bottom-sheet-actions` | use `m3e-bottom-sheet-action` element (no `actions` slot exists) |
| `SideSheet.elm:229` | `ds-side-sheet-body` | **`start`/`end` drawer slot** (`startSlot`/`endSlot`) — currently wrong slot (CRITICAL) |
| `SideSheet.elm:241` | `ds-side-sheet-actions` | **`start`/`end` drawer slot** — currently wrong slot (CRITICAL) |
| `Tooltip.elm:287` | `ds-tooltip-actions` | `m3e-rich-tooltip` **`actions`** slot (`actionsSlot`) — currently wrong slot (HIGH) |
| `Shape.elm:12` (doc only) | `ds-w-16` | replace example with M3 sizing / `name` attr |
| `Shape.elm:13` (doc only) | `ds-h-16` | replace example with M3 sizing / `name` attr |

Note: most `ds-*` classes are co-located with a *correct* typed slot binding (Card actions, Dialog
headline/actions), so they are pure proprietary-class noise to delete. The three load-bearing ones
(SideSheet ×2, Tooltip) sit on divs that are *also* in the wrong slot — fixing the slot is the real
work; deleting the class is incidental.

---

## Raw `Attr.attribute` inventory

`grep -rn 'Attr.attribute' src/Ui` → 37 call sites. Classification:

**FINE (globals — `aria-*`, `slot` for which no typed binding exists, native attrs):**
`IconButton.elm:290,321`, `Button.elm:332`, `Fab.elm:159,169`, `ExtendedFab.elm:171`,
`FabMenu.elm:125,134,137`, `SplitButton.elm:133,135` (aria); `Search.elm:340`, `TextField.elm:530`
(`rows`, native), `TimePicker.elm:208-210` (`min`/`max`/`step`, native input attrs).

**SMELL — duplicates an existing typed vendor binding (use the binding):**
- `AppBar.elm:146,156` (`slot` → `leadingSlot`/`trailingSlot`), `AppBar.elm:166,169` (`size` → `M3e.AppBar.size`)
- `Search.elm:304` (`open` → `M3e.SearchView.open`)
- `Tooltip.elm:259,272,275` (`position` → typed `Position` variants)
- `Stepper.elm:214` (`selected` → `M3e.Step.selected`)
- `Slider.elm:310` (`value` → `M3e.SliderThumb.value`)
- `SplitButton.elm:152` (`variant "outlined"` → `M3e.SplitButton.Outlined`)
- `NavigationDrawer.elm:285` / `SideSheet.elm:219` (`start-mode`/`end-mode` → typed `startMode`/`endMode`)
- `Snackbar.elm:227-235` (`message`/`action`/`dismissible`/`close-label`/`duration`) — these target the
  project `<avt-snackbar>` wrapper, not a CEM element, so there is no binding to use; **acceptable.**

**WRONG — sets a non-CEM attribute/slot (bug, not just a smell):**
- `Paginator.elm:151` `"pageIndex"` (should be `page-index`) — HIGH, default page never applies.
- `Tabs.elm:173` `slot "badge"` — no such slot on `m3e-tab`; badge dropped — HIGH.
- `AppBar.elm:146,156` `slot "leading"/"trailing"` — names are valid (also listed under SMELL).
- `Dialog.elm:226` `"full-screen"` — not a CEM dialog attr — HIGH silent no-op.
- `Stepper.elm:214` `slot "selected"`? No — it sets the `selected` *attribute* (valid); listed as SMELL.

---

## Theme token remap

### Finding (HIGH)
`Ui.Theme` (`src/Ui/Theme.elm`) is **not** a wrapper for any m3e component. It emits a `t-{role}` class
(`t-primary`, `t-secondary`, `t-tertiary`, `t-neutral`, `t-danger`, `t-warning`) and **ships no CSS** —
the doc comment admits "The library only emits the class; it ships no CSS of its own." So out of the
box `Ui.Theme.toAttribute` is a **no-op** that depends on a `t-*` CSS convention the consuming app must
invent. This is:
1. **Not Material.** M3 has no `t-*` contract.
2. **A D1 gap.** There *is* a real `m3e-theme` element in the CEM (and a `M3e.Theme` vendor binding),
   and `Ui.Theme` does not wrap it. The "one Ui module per documented component" map is broken: the
   `theme` component (`m3e-theme` + `m3e-theme-icon`) has no faithful `Ui` wrapper, while `Ui.Theme`
   occupies the name with a non-Material class emitter.
3. **Role-name drift.** `Danger`/`Warning`/`Neutral` are not the M3 role names. The actual M3 +
   m3e-extended roles (from the bridge `generated/CSS_CUSTOM_PROPERTIES.md` and `src/roles-extended.css`)
   are: `primary`, `secondary`, `tertiary`, `error` (not "danger"), plus the **opt-in extended**
   `success`, `info`, `warning` roles — each with `on-*` and `*-container` variants. "Neutral" is a
   *palette*, not a color role; the neutral-derived roles are `surface`/`background`/`outline`.

### What @m3e/web actually exposes
- **The element:** `<m3e-theme>` (CEM `theme`) takes `color` (seed hex), `scheme`
  (`auto|light|dark`), `variant` (`content|vibrant|expressive|monochrome|neutral|tonal-spot|fidelity|
  rainbow|fruit-salad`), `contrast` (`medium|standard|high`), `density` (number), `strong-focus`
  (bool), `motion` (`standard|expressive`); default slot = the themed subtree; fires `change`. This is
  the real mechanism for "apply a theme to a subtree." (`/tmp/cem/theme.json`, verified.)
- **The tokens:** components read `--md-sys-color-*` custom properties. The full role contract present
  in the bridge: `primary`, `on-primary`, `primary-container`, `on-primary-container`; `secondary…`,
  `tertiary…`, `error…`; `surface`, `surface-variant`, `surface-bright`, `surface-dim`,
  `surface-container`(`-lowest|-low|-high|-highest`), `on-surface`, `on-surface-variant`; `background`,
  `on-background`; `outline`, `outline-variant`; `inverse-surface`, `inverse-on-surface`,
  `inverse-primary`; `surface-tint`, `scrim`, `shadow`; and (opt-in `roles-extended.css`) `success`,
  `info`, `warning` each with `on-*` and `*-container`.

### Recommendation
Split the concerns and stop pretending `t-*` is Material:

1. **Add a faithful `Ui.Theme` (or `Ui.ThemeProvider`) that wraps `<m3e-theme>`** via `M3e.Theme` —
   a builder with `withSeedColor`, `withScheme`, `withVariant`, `withContrast`, `withDensity`,
   `withStrongFocus`, `withMotion`, `onChange`, taking the themed subtree as children. This restores
   D1 (the `theme` component gets a real wrapper) and gives a *working* theming primitive with zero
   app-supplied CSS.
2. **For per-subtree role retinting** (the current `t-*` intent), expose a typed
   `ColorRole = Primary | Secondary | Tertiary | Error | Success | Info | Warning` (+ optionally
   surface/neutral roles) and emit an attribute/class that **remaps the `--md-sys-color-*` group** for
   that subtree — i.e. set `--md-sys-color-primary: var(--md-sys-color-tertiary)` etc., or lean on the
   bridge's Tailwind role utilities. Rename `Danger → Error` (the real M3 role) and drop/relabel
   `Neutral` (it is a palette; if a neutral *surface* tint is meant, expose `Surface`). Gate
   `Success`/`Info`/`Warning` behind the same opt-in posture as `roles-extended.css`, and document
   that they require that import.
3. If a class contract is still wanted, **map each role class to the real tokens in shipped CSS** (the
   library should ship it, not the app), e.g. `.theme-primary { --md-sys-color-primary: …; … }`, rather
   than leaving an undefined `t-*` no-op. Prefer the `<m3e-theme>` element where possible — it is the
   spec-true mechanism and computes the full tonal palette from a seed.

---

## Size resolution

### Finding (MEDIUM)
`Ui.Size` (`src/Ui/Size.elm`) is a shared 3-step `Small | Medium | Large`, used **only** by
`Ui.Heading`. Button, IconButton, ButtonGroup each define their own 5-step
`ExtraSmall | Small | Medium | Large | ExtraLarge`, while Fab, ExtendedFab, AppBar define their own
3-step `Small | Medium | Large`. So there are three parallel size types plus the shared one.

### What the CEM actually specifies (verified per component)
| Component (CEM tag) | `size` enum | default |
|---|---|---|
| `m3e-button` | `'small' \| 'medium' \| 'large' \| 'extra-small' \| 'extra-large'` | `small` |
| `m3e-icon-button` | `'small' \| 'medium' \| 'large' \| 'extra-small' \| 'extra-large'` | `small` |
| `m3e-button-group` | `'small' \| 'medium' \| 'large' \| 'extra-small' \| 'extra-large'` | `small` |
| `m3e-fab` | `'small' \| 'medium' \| 'large'` | `medium` |
| `m3e-app-bar` | `'small' \| 'medium' \| 'large'` | `small` |
| `m3e-heading` | `'small' \| 'medium' \| 'large'` | `medium` |
| `m3e-badge` | `'small' \| 'medium' \| 'large'` | `medium` |
| `m3e-slider` | `'small' \| 'medium' \| 'large'` | (numeric/varies) |

**Every per-component Size union maps to the exact CEM enum strings** — verified: Button/IconButton/
ButtonGroup emit `extra-small`/`extra-large` (not `extrasmall`), Fab/AppBar/Heading emit
`small`/`medium`/`large`. There is **no wrong-enum bug** here; the issue is purely the *shape* of the
abstraction.

### Recommendation
Material does not define one global size scale — each component publishes its own. The CEM bears this
out: two distinct enums (5-step for the button family, 3-step elsewhere), with **different defaults**
(`m3e-fab` defaults `medium`, the button family defaults `small`). A single shared `Ui.Size` therefore
cannot honestly represent the button family without either over-narrowing it (loses `extra-*`) or
over-widening the 3-step components (invents `ExtraSmall` for Heading/Fab/AppBar, which would be a
*silent no-op* — exactly the D4 failure the redesign targets).

**Canonical approach: per-component sizes, named per the component's own CEM enum.** Keep
component-local `Size` types (the current Button/IconButton/ButtonGroup/Fab/ExtendedFab/AppBar pattern
is correct) so each only offers values its element accepts. Then:
- **Retire the shared `Ui.Size`** or repurpose it. Right now it serves only `Ui.Heading`; fold a
  3-step `Size` into `Ui.Heading` itself (matching `m3e-heading`'s `small|medium|large`), as the other
  3-step components already do their own. A "shared scale" implies cross-component interchangeability
  that the CEM does not grant.
- If a shared *vocabulary* is desired for ergonomics, it must be the **union of all enums** with
  per-component mapping functions that **reject** unsupported values at the type level — i.e. each
  component still exposes only its valid subset (no silent no-op). That is strictly more work than
  per-component types for no spec benefit; per-component types are recommended.
- Align each module's **default** with the CEM default (e.g. ensure Fab defaults to `medium`, Button
  family to `small`) so an unspecified size matches the element's documented behavior.

---

## Appendix — verification notes
- Per-component CEM extracts were generated into `/tmp/cem/<name>.json` from
  `m3e-docs/data/components.json`; high-severity claims (app-bar/nav-bar/drawer slots, bottom-sheet
  `open`, dialog `full-screen` absence, `m3e-slide`/`m3e-scroll-container`/`m3e-text-highlight` CEM
  absence, all `size` enums, form-field slots) were re-verified directly against the source JSON.
- "Emitted" markup was distinguished from doc-comment prose throughout (e.g. `m3e-side-sheet`,
  `m3e-time-picker`, `ds-w-16` appear only in doc comments and are flagged as such).
- Modules marked OK: Avatar, Badge, Breadcrumb, Button, Calendar, Chip, DatePicker, Divider, Fab,
  Heading, Icon, IconButton, List, LoadingIndicator, Menu, Progress, Snackbar, Toolbar (18). Their
  emitted tags, attributes, enum values, and slot names all match the CEM.
