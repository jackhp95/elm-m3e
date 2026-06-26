> **⚠ Historical — superseded by [ADR 0006](../adr/0006-m3e-architecture.md)** (the `M3e.*` architecture). A dogfooding record from the prior `Ui.*` builders; kept for history, not current truth.

# Slot / content-channel & relational-graph audit

> Synthesized from a 5-way parallel audit (Nav/structure · Actions · Inputs · Containers ·
> Feedback/primitives), each cross-checked against the machine-extracted slot inventory
> (`scratchpad/m3e-inventory.md`), the `M3e.*` CEM bindings, `material-spec-deltas.md`,
> and `builder-audit.md`. Date: 2026-06-25.

## 0. The reframe (read this first)

Three findings change what the slot-API work actually *is*:

1. **Content misrouting is essentially solved.** The "thermonuclear review" commit already
   fixed nearly every CRITICAL/HIGH delta in `material-spec-deltas.md` (AppBar title-drop,
   Nav wrong-child, SideSheet/Drawer wrong-slot, Tabs/Paginator/Stepper, Card/Dialog/BottomSheet
   `ds-*`, Tooltip actions, Theme `t-*`). **Zero F1-class silent-drop misroutes remain.**
   `material-spec-deltas.md` is now substantially STALE — grade against the working tree.

2. **The real remaining work is three different things, not one slot sweep:**
   - **(A) Capability gaps** — *real, valid slots the builder never exposes* (the dominant pattern).
   - **(B) A small set of genuine structural mis-wirings** (3 confirmed bugs, below).
   - **(C) Containment breadth** — most containers model only the *simplest* valid child set.

3. **`Ui.Field` extraction has a clean, grounded shape** (§4). It dissolves the F7 family by
   construction and de-duplicates ~5 modules' worth of copy-pasted form-field machinery.

Net: the F11 "promote every `String`+`Html.text` to `Html msg`, sweep all 52 modules" reshape is
**lower-value than it looked** — the audit found label-as-`String` is a deliberate, safe ergonomic
narrowing almost everywhere, not a misroute. The higher-value work is exposing missing slots and
building `Ui.Field`. See §6.

(Also: **`Ui.Size` was retired** — folded into `Ui.Heading`. The library is **52 modules**, not 54.
README / coverage-matrix / spec-delta rows referencing `Ui.Size` are stale.)

---

## 1. The three content channels (the model)

Every `<m3e-X>` accepts caller content through exactly three channels; a `Ui.*` builder's job is
to route each typed input to the correct one:

| Channel | What it is | Correct Ui shape |
|---|---|---|
| **attribute / property** | `name`, `variant`, `checked`, `for`, icon `name` | typed enum / `Bool` / `String` → `M3e.*` attr |
| **default slot** | light-DOM children projected into the element's default `<slot>` | typed children **or** arbitrary `Html msg` |
| **named slot** | `slot="title"`, `slot="leading"`, `slot="actions"` | typed builder(s) **or** `Html msg`, slot-attr injected |

Three recommended **classes** for each content input:
- **attribute-backed** — it's really an attribute/property (the F1 trap: icon glyph is `name=`, not a child).
- **enumerable→typed** — the slot's valid fillers form an enumerable set worth enforcing (`Card.actions : List Ui.Button`, `IconButton.icon : Ui.Icon`).
- **arbitrary→Html** — the slot's semantic is "arbitrary author content" (`Card.media/body/footer`); `Html msg` is the *natural primary type*, not an escape hatch.

---

## 2. The relational / containment graph

**Legend:** `→[typed]` enumerable typed children · `→Html` arbitrary author region · `⌀` leaf (no children) ·
`⚠GAP` valid child/slot the spec allows but the builder does **not** expose.

### Navigation / structure
| Component | Host | Typed children | Arbitrary regions | ⚠ Unexposed valid children/slots |
|---|---|---|---|---|
| AppBar | `m3e-app-bar` | title/subtitle→[Heading], leading→[IconButton], trailing→[IconButton…] | leading/trailing escape hatch | — |
| Toolbar | `m3e-toolbar` | actions→[Button] | — | icon-button actions (no typed channel / Html hatch) |
| NavigationBar | `m3e-nav-bar`>`m3e-nav-item` | items→[NavItem]; item.icon→[Icon] | label (String) | `selected-icon` slot |
| NavigationRail | `m3e-nav-rail`>`m3e-nav-item` | items→[NavItem]; item.icon→[Icon] | label (String) | `m3e-nav-rail-toggle`; `selected-icon` |
| NavigationDrawer | `m3e-drawer-container`/`m3e-nav-menu` | entries→[Entry] (recursive); icon→[Icon] | `.content`→Html | `toggle-icon`/`selected-icon`; labels are String-only despite real Html slots |
| SideSheet | `m3e-drawer-container` | actions→[Button] | body→Html | main-content (default) slot left empty; body+actions share one slot div |
| Tabs | `m3e-tabs`>`m3e-tab` | tabs→[Tab]; tab.icon→[Icon] | label (String) | **`panel` channel (the switched content!)**; `next-icon`/`prev-icon` |
| Breadcrumb | `m3e-breadcrumb`>`-item` | items→[Item] | item.label→Html | item `icon` slot; host `separator` slot; `-item-button` element |
| Toc | `m3e-toc` | — (items auto-generated) | title/overline→Html | — |
| Paginator | `m3e-paginator` | ⌀ | — | 4× `*-page-icon` slots →[Icon] |
| Stepper | `m3e-stepper`>`m3e-step`+`m3e-step-panel` | steps→[Step] | label/content→Html | **`m3e-step` `error`/`hint`/`icon`/`*-icon`; `m3e-step-panel` `actions` (prev/reset nav)** |
| Slide | `m3e-slide-group`>`m3e-slide` | — | slides→Html | `next-icon`/`prev-icon`; (wraps each child in non-CEM `m3e-slide`) |
| ScrollContainer | `m3e-scroll-container`† | — | children→Html | — (†non-CEM utility element) |
| SplitPane | `m3e-split-pane`>`m3e-content-pane` | — | start/end→Html | — |

### Actions
| Component | Host | Typed children | ⚠ Unexposed |
|---|---|---|---|
| Button | `m3e-button` | leadingIcon/trailingIcon→[Icon] | `selected`/`selected-icon` slots (toggle glyph swap) |
| IconButton | `m3e-icon-button` | icon→[Icon] | — (label correctly attribute-backed via aria/title) |
| Fab | `m3e-fab` | icon→[Icon] | — |
| ExtendedFab | `m3e-fab[extended]` | icon→[Icon] | — (D1: same element as Fab) |
| FabMenu | div>`m3e-fab`+`m3e-fab-menu`>`m3e-menu-item` | triggerIcon→[Icon]; item.icon→[Icon] | — |
| SplitButton | `m3e-split-button` | leading/trailing → **plain `<button>`** (NOT Ui.Button — element styles bare buttons) | — |
| ButtonGroup | `m3e-button-group` | buttons→[Button] | — |
| SegmentedButton | `m3e-segmented-button`>`m3e-button-segment` | segments→[internal Segment] | per-segment `icon` slot; segment `value` attr; `<label for>`→CE id is fragile |

### Inputs (see §4 for the `Ui.Field` split)
| Component | Host | Typed children | Arbitrary regions | Self-wraps `m3e-form-field`? |
|---|---|---|---|---|
| Checkbox | `m3e-checkbox` | ⌀ | hint/error→Html | **yes** (`visibleLabel`) |
| RadioButton | `m3e-radio-group`>`m3e-radio` | options→[Option] | group-label, hint/error | **yes** (`visibleLabel`) |
| Switch | `m3e-switch` | ⌀ | hint/error→Html | **yes** (`visibleLabel`) |
| Slider | `m3e-slider`>`m3e-slider-thumb` | thumbs (internal) | hint/error→Html | **yes** (`visibleLabel`) |
| TextField | `m3e-form-field`>native input | — | prefix/suffix/hint/error→Html | **yes (unconditional)** — the canonical Field |
| Select | `m3e-select`>`m3e-option` | options→[Option] | help/error (plain div, no slot) | **no** (native `label` attr; self-chromes) |
| Chip | `m3e-{assist,filter,…}-chip` | icon→[Icon]; Set→[kind-matched chips] | label→Html(+hatch) | no |
| Search | `m3e-search-bar`/`-view` | results→[List.Item]; leading→[Icon] | — | no |

### Containers
| Component | Host | Typed children | Arbitrary regions | ⚠ Unexposed valid children |
|---|---|---|---|---|
| Card | `m3e-card` | actions→[Button]; headline/subhead→[Heading] | media/body/footer→Html | — (reference builder) |
| Dialog | `m3e-dialog` | actions→[Button] | body→Html; title→text | `close-icon` slot; `m3e-dialog-action`/`-trigger` |
| BottomSheet | `m3e-bottom-sheet` | actions→[Button] (via `m3e-bottom-sheet-action`) | header/body→Html | — (but action nesting inverted — §3) |
| Menu | `m3e-menu`>`m3e-menu-item` | items→[Menu.item]; icon→[Icon] | label→text | **checkbox/radio/group items**; trigger; `trailing-icon`; positioning |
| Divider | `m3e-divider` | ⌀ | — | — |
| Disclosure | `m3e-expansion-panel`/`m3e-accordion` | accordion→[Section] | headline/content→Html | panel `actions`/`toggle-icon` |
| List | `m3e-list`>`m3e-list-item`/`-item-button` | items→[item/actionItem]; leading/trailing→[Icon] | — | **`m3e-list-option` (selectable), `m3e-expandable-list-item`, divider rows**; leading/trailing icon-only (no avatar/checkbox/Html) |

### Date/time, feedback, primitives, system
| Component | Host | Children | Notes |
|---|---|---|---|
| Calendar | `m3e-calendar` | header→Html | leaf otherwise |
| DatePicker | `m3e-datepicker` | ⌀ | unwrapped `m3e-datepicker-toggle` companion |
| TimePicker | `m3e-form-field`>native input | help/error→Html | self-wraps form-field (stopgap; no `m3e-time-picker` exists) |
| Avatar | `m3e-avatar` | icon→[Icon] | image/initials are leaf content |
| Icon | `m3e-icon` | ⌀ | fully attribute-backed (`name`) — the F1 element, correctly handled |
| Heading | `m3e-heading` | content→Html | the typescale primitive; *fills* other components' title/headline slots |
| Badge | `m3e-badge` | ⌀ | size attr + default-slot text |
| Snackbar | `avt-snackbar`→imperative `m3e-snackbar` | ⌀ | attribute-only bridge; action is a label String, not a Button |
| Tooltip | `m3e-tooltip`/`m3e-rich-tooltip` | rich.actions→[Button] | content→Html; ⚠ `subhead` slot unexposed |
| LoadingIndicator | `m3e-loading-indicator` | ⌀ | variant only |
| Progress | `m3e-linear/circular-progress` | ⌀ | value gated by constructor |
| Skeleton | `m3e-skeleton` | ⌀ | ⚠ `animation`/`shape`/`loaded` attrs unexposed |
| Shape | `m3e-shape` | content→Html | clips arbitrary subtree |
| TextHighlight | `m3e-text-highlight`† | content→Html | †non-CEM utility element |
| Theme | `m3e-theme` | content→Html (themed subtree) | system token provider; broadest containment edge |

**The `Ui.Icon` is the universal leaf** — it is the single most-reused typed child (fills icon
slots across AppBar, Button, IconButton, Fab, Nav*, Tabs, Breadcrumb, Menu, List, Chip, Avatar,
Paginator…). **`Ui.Button` is the universal action child** (Card/Dialog/BottomSheet/SideSheet/
Toolbar/ButtonGroup/Tooltip actions). **`Ui.Heading` is the universal title child.** These three
are the backbone of the typed-slot graph.

---

## 3. Confirmed structural bugs (not just gaps)

1. **BottomSheet — action nesting inverted.** `m3e-bottom-sheet-action` must be *nested inside*
   the clickable (`<m3e-button><m3e-bottom-sheet-action/></m3e-button>`); current code emits
   `m3e-bottom-sheet-action [ Button.view ]` (action wraps button). Auto-close-on-activate may
   not fire. (`BottomSheet.elm:243-247`)
2. **Dialog — `withDismissible` mis-wired.** It maps to `M3e.Dialog.dismissible` (= "present a
   close *button*"), but its doc claims it controls Escape/scrim dismissal. The attribute that
   governs Escape/scrim is `disable-close`, which `Ui.Dialog` never emits — so Escape/scrim
   dismissal is always on, regardless of the flag. Rename/split into `disableClose`.
3. **SegmentedButton — fragile label anchor + dropped value.** `<label for>` points at a
   custom-element id (fragile), and `M3e.ButtonSegment.value` is never emitted (segments carry
   no submission value).

These are small, isolated, and high-value — fix independent of any sweep.

---

## 4. `Ui.Field` — the synthesized surface

The `m3e-form-field` real surface (authoritative): slots `prefix`, `prefix-text`, `suffix`,
`suffix-text`, `hint`, `error`; **default slot = the control**; attrs `variant`(filled|outlined,
default outlined), `float-label`, `hide-required-marker`, `hide-subscript`. **`label` is NOT a CEM
slot** — shipped examples use `<label slot="label" for=id>` in the default slot.

```elm
Ui.Field.new { label = "Dark mode" }            -- or withLabelHtml
    |> Ui.Field.withVariant Filled | Outlined    -- form-field variant attr
    |> Ui.Field.withHint  (Html msg)             -- hint slot
    |> Ui.Field.withError (Html msg)             -- error slot (wins over hint)
    |> Ui.Field.withPrefix (Html msg)            -- prefix / prefix-text slot
    |> Ui.Field.withSuffix (Html msg)            -- suffix / suffix-text slot
    |> Ui.Field.withRequiredMarker Bool          -- inverts hide-required-marker
    |> Ui.Field.withId String                    -- the for/id anchor (auto-derived if absent)
    |> Ui.Field.view (control : Html msg)        -- the bare control fills the default slot
```

This collapses the `slugify`/`controlId`/`labelElement`/`subscriptElements`/`prefixSlot`/`suffixSlot`
machinery currently **duplicated verbatim across Checkbox, Radio, Switch, Slider, TextField** into one place.

**Which controls compose into it:**

| Control | Composes? | Bare surface handed to Field | Note |
|---|---|---|---|
| TextField | ✅ canonical | native `<input>`/`<textarea>`(+autosize) | already uses every real Field slot; the template |
| Checkbox | ✅ | `m3e-checkbox` (no slots) | label has nowhere else to live |
| Switch | ✅ | `m3e-switch` | **`handleIcons` stays on control** (intrinsic) |
| Slider | ✅ | `m3e-slider`+thumbs | **`labelled`/`discrete` stay on control** (intrinsic) |
| RadioButton | ✅ (group label only) | `m3e-radio-group`+`m3e-radio` | per-option labels stay in each radio |
| **Select** | ⚠ exception | `m3e-select` (native `label` attr) | self-chromes — route hint/error at most, **never label/variant** |
| Chip / Search / TimePicker | ❌ / ❌ / already-is | — | not form-field controls (TimePicker already wraps one) |

**Two tensions to decide:** (a) `label` is not a CEM slot — Field emits `<label slot="label" for=id>`
(matches examples, fails strict `validateMarkup`) **or** prefers a native `label` attr where the
control has one (Select does; the bare toggles don't). (b) Not every "chrome-looking" input migrates:
`Switch.handleIcons`, `Slider.labelled/discrete`, `Select.label` are control-intrinsic and stay put.

---

## 5. Capability gaps — exposing valid slots/children (the dominant work)

Prioritized by user-visible value:

**High value (structural content that's currently unreachable):**
- **Tabs `panel` channel** — the actual content the tabs switch between has no typed home.
- **Stepper** — `m3e-step` `error`/`hint`/`icon` slots + `m3e-step-panel` `actions` (no built-in next/back/reset).
- **List children** — `m3e-list-option` (selection lists), `m3e-expandable-list-item`, divider rows; leading/trailing beyond `Ui.Icon` (avatar/checkbox/Html).
- **Menu children** — `m3e-menu-item-checkbox`/`-radio`/`-group`; a trigger; positioning.

**Medium value (decoration/customization slots):**
- Paginator 4× `*-page-icon`; Breadcrumb item-`icon` + `separator`; Nav `selected-icon` (Bar/Rail/Drawer); Slide/Tabs/SlideGroup `next-icon`/`prev-icon`.
- Tooltip `subhead`; Dialog `close-icon`; Disclosure panel `actions`/`toggle-icon`; Chip(input) `avatar`/`remove-icon`.
- Skeleton `animation`/`shape`/`loaded`; Select `m3e-optgroup`.

**New primitive — `Ui.Text` (F3):** justified for the **body** typescale roles
(`body-large/medium/small`) Heading doesn't cover. Caveat: there is **no `m3e-body`/`m3e-text`
element** — `Ui.Text` would have to emit a semantic `<p>`/`<span>` and apply the
`--md-sys-typescale-body-*` custom properties (shipped by the library, mirroring the Theme fix),
not delegate to an element. Keep it clearly distinct from Heading (no `level`, no heading semantics).

---

## 6. Implications for the F11 slot sweep (refined)

The audit **narrows** F11. Promoting `String`+`Html.text` labels to `Html msg` library-wide is
**low value**: visible-text labels (Button/ExtendedFab/menu items/segments/nav/tabs) are
constrained single-line labels where `String` is a deliberate, safe narrowing — not a misroute.
The AppBar `Slotted = Attribute msg -> Html msg` mechanism is the right *implementation* for the
genuinely-heterogeneous slots, but those are few (AppBar leading/trailing already done; Card
media/body/footer already `Html`). 

**Recommendation:** drop the "sweep all 52" framing. Instead:
1. Build **`Ui.Field`** (§4) — highest leverage; dissolves F7; de-dupes 5 modules.
2. Fix the **3 structural bugs** (§3) — cheap, isolated.
3. Expose **high-value capability gaps** (§5) — Tabs panels, Stepper, List/Menu children.
4. Apply the `Slotted`/typed-slot pattern **only** where a slot is genuinely heterogeneous and
   still `Html`-wrapped-with-a-span — a short, targeted list, not 52 modules.
5. Add **`Ui.Text`**; finish the **stale-doc cleanup** (§7).

The **Playwright contract harness** (already decided) should land alongside step 1 and gate steps
1–3, since those touch property/shadow-DOM behavior that `Test.Html` cannot see.

---

## 7. Stale-doc cleanup (facts that drifted)

- `material-spec-deltas.md`: AppBar, Nav*, SideSheet, Tabs, Paginator, Stepper, SplitButton, FabMenu,
  SegmentedButton, ExtendedFab, ButtonGroup, Card, Dialog, BottomSheet, Tooltip, Heading, Theme, Shape,
  TimePicker rows are all **resolved in-tree** — regrade or archive.
- **`Ui.Size` retired** (folded into `Ui.Heading`) — remove from spec-delta, builder-audit, coverage-matrix; library is **52 modules**.
- README / coverage-matrix "54 modules" / "Carousel" references are stale (Carousel removed; Size folded).
