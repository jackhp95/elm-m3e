# Layer 4 builder audit — `withAttributes` retrofit

This audit covers all 52 `Ui.*` typed builders in `src/Ui/`. Two of them —
`Ui.Card` and `Ui.Toc` — were just refactored to the canonical pattern and serve
as the reference. The canonical pattern has three parts:

1. A `withAttributes : List (Attribute msg) -> X -> X` escape hatch that **appends**
   caller attributes to the **root host element's** attribute list, emitted **before**
   the builder's own structural attributes (so `variant`/`slot`/`id` win on conflict).
   `Config` gains an `attributes : List (Attribute msg)` field initialized to `[]`.
2. **No baked styling** — a builder never hardcodes a `class "..."` / Tailwind / token
   class by default. Structural `M3e.*` attributes (slots, variant/size enums) are fine.
3. **Content slots prefer typed inputs** (another `Ui.*` builder type, or a `List` of
   them) which are introspectable, with a parallel `with<Slot>EscapeHatchHtml : Html msg`
   for raw cases. Inherently arbitrary slots (media/body/footer) legitimately stay `Html msg`.

**Headline findings.** The library is in very good shape relative to the pattern.
Only the two reference modules currently have `withAttributes`; the other **50 lack it**.
**Zero modules bake styling** — the only `Attr.class` uses (`Ui.Shape`, `Ui.Skeleton`)
map a *caller-supplied* `classes` list via an explicit `withClass` modifier, which is
caller-owned, not baked. The remaining work splits into a large **mechanical-safe** set
(single obvious host, simple attribute list) and a small **tricky** set, almost all of
which are *dual-root* builders — a `m3e-form-field` (or rich/plain, or single/accordion)
wrapper that is chosen at render time by a config flag, so `withAttributes` must decide
*which* host gets the caller attributes.

---

## Per-module table

| Module | Root host | Has `withAttributes` | Bakes styling | Opaque-Html slots (convert?) | Notes |
| --- | --- | --- | --- | --- | --- |
| **Card** *(ref)* | `m3e-card` | **yes** | no | media, body, footer (keep Html) | Reference. Headline/subhead typed (`Ui.Heading`) + EscapeHatchHtml; actions `List Ui.Button`. |
| **Toc** *(ref)* | `m3e-toc` | **yes** | no | title, overline (Html) | Reference. Structural attrs after `cfg.attributes`. |
| AppBar | `m3e-app-bar` | no | no | leading, trailing (`List Html`) — convert? | Title is `String`. leading/trailing could be `Ui.IconButton`/`Ui.Button` lists + EscapeHatchHtml. |
| Avatar | `m3e-avatar` | no | no | content via `image`/`initials`/`icon` ctors | Content gated by constructors; fine. |
| Badge | `m3e-badge` | no | no | content via `dot`/`count`/`label` ctors | `for` String ref; size per-ctor. |
| BottomSheet | `m3e-bottom-sheet` | no | no | header, body (Html) | Returns `text ""` when closed — target the component in the open branch. actions `List Ui.Button`. |
| Breadcrumb | `m3e-breadcrumb` | no | no | item `label` is `Html` — convert? | Host wraps `m3e-breadcrumb-item` children. Item label could be `String`/typed. |
| Button | `m3e-button` | no | no | — (label String; icons typed) | Leading/trailing icons `Ui.Icon`. Clean. |
| ButtonGroup | `m3e-button-group` | no | no | — (`List Ui.Button`) | Group-level host; per-button attrs not exposed (correct). |
| Calendar | `m3e-calendar` | no | no | header (Html) | Dates are ISO `String` by design. |
| **Checkbox** | `m3e-form-field` **or** `m3e-checkbox` | no | no | help, error (Html — slotted) | **Dual-root**: `visibleLabel` picks form-field wrapper vs bare control. |
| Chip | kind-specific `m3e-*-chip` / `m3e-*-chip-set` | no | no | chip `label` is `Html` — convert? | Kind ctors gate the element; icon typed `Ui.Icon`. Single chip vs set are two builders. |
| DatePicker | `m3e-datepicker` | no | no | — | Config-only; labels/dates `String`. |
| Dialog | `m3e-dialog` | no | no | body (Html) | `text ""` when closed; title `String` in slotted `h2`; actions `List Ui.Button`. |
| **Disclosure** | `m3e-expansion-panel` **or** `m3e-accordion` | no | no | headline, content (`Html`/`List Html`) | **Ctor-gated dual-root**: `single` vs `accordion`. Each needs its own `attributes`. |
| Divider | `m3e-divider` | no | no | — | Pure enum/primitive config. |
| ExtendedFab | `m3e-fab` | no | no | — (icon typed, label String) | Clean. |
| Fab | `m3e-fab` | no | no | — (icon typed) | Clean. |
| **FabMenu** | `Html.div` **wrapper** | no | no | — (items structured; icons typed) | **Multi-root**: wrapper div + `m3e-fab` trigger + `m3e-fab-menu`. Target the wrapper div. |
| Heading | `m3e-heading` | no | no | content (`Maybe Html`) | Terse ctors wrap `String`; `withContent` is the Html escape hatch. |
| Icon | `m3e-icon` | no | no | a11y (`Maybe Html`, sr-only) | Clean. |
| IconButton | `m3e-icon-button` | no | no | — (icon typed) | Clean. |
| List | `m3e-list` | no | no | — (item text String; icons typed) | Items are children; host = `m3e-list`. Item-level attrs not exposed (acceptable). |
| LoadingIndicator | `m3e-loading-indicator` | no | no | — | Variant enum only. |
| Menu | `m3e-menu` | no | no | — (item label String; icon typed) | Items are children. |
| NavigationBar | `m3e-navigation-bar` | no | no | — (label/badge String; icon typed) | Items are children. |
| NavigationDrawer | `m3e-drawer-container` | no | no | content (`List Html`, main region) | Dual-shape (flat items / hierarchical entries) but single clear host. |
| NavigationRail | `m3e-navigation-rail` | no | no | — (label/badge String; icon typed) | Mirrors NavigationBar. |
| Paginator | `m3e-paginator` | no | no | — | Attribute-driven; `pageAttrs` is a fn, not a content slot. |
| **Progress** | `m3e-linear-progress` **or** `m3e-circular-progress` | no | no | — | **Dispatch dual-root** on `Shape`; no slots, so just apply attrs in both branches. |
| RadioButton | `m3e-form-field` **or** `m3e-radio-group` | no | no | help, error (Html — slotted) | **Dual-root** like Checkbox; the invariant control is `m3e-radio-group`. Options typed. |
| ScrollContainer | `m3e-scroll-container` | no | no | children (`List Html`, arbitrary) | Minimal; children correctly opaque. |
| **Search** | `m3e-search-bar` **or** `m3e-search-view` | no | no | — (results `List Ui.List.Item`) | **Dispatch dual-root** on Mode. Results typed (`Ui.List.Item`). Apply attrs in both branches. |
| SegmentedButton | `m3e-segmented-button` (in `Html.div` wrapper) | no | no | help, error (Html, plain spans) | Multi-element: wrapper div + control + subscripts. Target the **control**, not the wrapper. Segments carry `String` label. |
| Select | `m3e-select` (sometimes in subscript div) | no | no | help, error (Html, plain spans) | Options typed (`Option value`); not a form-field by design. Target `m3e-select`. |
| Shape | `m3e-shape` | no | no | content (`List Html`, arbitrary) | Has existing `withClass`/`classes` (caller-owned, not baked). `withAttributes` would subsume `withClass`. |
| SideSheet | `m3e-drawer-container` | no | no | body (Html) | `text ""` when closed; actions `List Ui.Button`. |
| Skeleton | `m3e-skeleton` | no | no | — | Has existing `withClass`/`classes` (caller-owned). `withAttributes` would subsume it. |
| Slide | `m3e-slide-group` | no | no | slides (`List (List Html)`, arbitrary) | Host wraps `m3e-slide` children. |
| Slider | `m3e-form-field` **or** `m3e-slider` | no | no | help, error (Html — slotted) | **Dual-root** like Checkbox; invariant control is `m3e-slider`. Thumbs internal enum. |
| Snackbar | `Html.node "avt-snackbar"` (custom) | no | no | — | Wrapper around an *imperative* m3e API; also has `encode` port path. Attribute-driven; target the node. |
| SplitButton | `m3e-split-button` | no | no | — (label String; icon typed) | Two slotted child `button`s are structural. |
| SplitPane | `m3e-split-pane` | no | no | start, end (`List Html`) | Wraps two `m3e-content-pane`. Clean. |
| Stepper | `m3e-stepper` | no | no | step `label` (Html), `content` (`List Html`) | Headers + panels generated in parallel; container is the host. |
| **Switch** | `m3e-form-field` **or** `m3e-switch` | no | no | help, error (Html — slotted) | **Dual-root** like Checkbox; invariant control is `m3e-switch`. |
| Tabs | `m3e-tabs` | no | no | — (label String; icon typed; badge String) | Tabs generated children; icon/badge inline. |
| TextField | `m3e-form-field` | no | no | help, error, prefix, suffix (Html — slotted) | Always wraps in form-field (single host). Phantom-gated single/multi-line. |
| TextHighlight | `m3e-text-highlight` | no | no | children (`List Html`, arbitrary) | Inverted `view : List (Html msg) -> X -> Html msg` signature. |
| Theme | `m3e-theme` | no | no | children (`List Html`, subtree) | Non-visual context provider; `withAttributes` still useful (data-* / event hooks). |
| TimePicker | `m3e-form-field` | no | no | help, error (Html — slotted) | Mirrors TextField; always single form-field host. |
| Toolbar | `m3e-toolbar` | no | no | — (`List Ui.Button`) | Clean. |
| **Tooltip** | `m3e-tooltip` **or** `m3e-rich-tooltip` | no | no | rich `content` (Html) | **Phantom-gated dual-root** plain/rich. Rich actions `List Ui.Button`. |

---

## Tricky cases

These don't map cleanly to "one host, one attribute list." Recommendations:

### Dual-root form-field controls — `Checkbox`, `RadioButton`, `Switch`, `Slider`
Each renders **either** a `m3e-form-field` wrapper (when `visibleLabel = True`) **or**
the bare control (`m3e-checkbox` / `m3e-radio-group` / `m3e-switch` / `m3e-slider`)
directly. The "natural host" is ambiguous because it changes at render time.

- **Recommendation:** Store a single `attributes` field in config and apply it to
  **whichever root the render path actually emits** — form-field when wrapped, the bare
  control otherwise. This keeps the public API to one `withAttributes`. The control is
  the *invariant* element, but the form-field is the *visible/outer* box when present,
  so the caller's `class "w-full"`-style intent belongs on whatever is outermost. Apply
  to the outer element of each branch. Document the branch behavior.
- **Watch out:** `help`/`error` are already slotted into the form-field; don't let caller
  attributes collide with those subscript slots. Emitting `cfg.attributes` first then
  structural attrs preserves the contract.

### Dispatch dual-root (no slots) — `Progress`, `Search`
`Progress` dispatches `m3e-linear-progress` vs `m3e-circular-progress` on the `Shape`
enum; `Search` dispatches `m3e-search-bar` vs `m3e-search-view` on `Mode`.
- **Recommendation:** Trivial — apply `cfg.attributes` in **both** dispatch branches.
  No slot interaction (`Search` results are typed `Ui.List.Item`). Low risk despite the
  branch; mechanical once you accept "two call sites."

### Constructor-gated dual-root — `Disclosure`, `Chip`, `Tooltip`
The root element is fixed at **construction** time, not render time:
- `Disclosure.single` → `m3e-expansion-panel`; `Disclosure.accordion` → `m3e-accordion`
  wrapping panels. Recommend an `attributes` field on **both** `Panel` and
  `AccordionConfig` (or a single one applied to whichever the ctor selected).
- `Chip` single vs set, and the four chip *kinds*, each pick their element in the ctor.
  Recommend the `attributes` apply to the per-kind element for a single chip, and to the
  `m3e-*-chip-set` wrapper for a set.
- `Tooltip` is phantom-typed plain/rich → `m3e-tooltip` vs `m3e-rich-tooltip`. Store
  `attributes` in the shared config and apply to whichever element is rendered.
- **Recommendation:** All three are clean because the choice is explicit and compile-time
  visible; just thread `attributes` to the selected element. Slightly more than mechanical
  because there are two emit sites, but no ambiguity.

### Multi-root wrapper — `FabMenu`
Renders a plain `Html.div` wrapping a `m3e-fab` trigger and a `m3e-fab-menu`. There is no
single `M3e.*` host.
- **Recommendation:** Target the **wrapper div** for `withAttributes` (caller positions/
  sizes the whole menu unit). If callers later need to style the trigger specifically,
  that's a separate `withTrigger*` concern, not `withAttributes`.

### Wrapper-with-subscripts — `SegmentedButton`, `Select`
Render a layout wrapper/`div` containing label + control + help/error subscript spans.
- **Recommendation:** Target the **control element** (`m3e-segmented-button` /
  `m3e-select`), not the layout wrapper, so the contract matches "host = the M3 control."
  This is a judgment call; document it. (Contrast `FabMenu`, where the div *is* the unit.)

### Custom imperative wrapper — `Snackbar`
Not an `M3e.*` component at all — a `Html.node "avt-snackbar"` bridge to an imperative
`M3eSnackbar.open()` API, plus an `encode` port path.
- **Recommendation:** `withAttributes` targets the `avt-snackbar` node for the declarative
  `view` path. The `encode`/port path has no host and is out of scope for `withAttributes`.

### Non-visual provider — `Theme`
`m3e-theme` is a context/token provider, not a visible box.
- **Recommendation:** Still add `withAttributes` (useful for `data-*`, `id`, theme-changed
  observability). Mechanically identical to a single-host builder; flagged only because the
  "host" is conceptually invisible.

### Opaque-Html content slots worth considering for typing (not blockers)
`AppBar.leading`/`trailing`, `Breadcrumb` item `label`, `Chip` `label`. These are currently
`Html msg`. They *could* become typed (`Ui.IconButton`/`Ui.Button` lists, `String`, etc.)
with `EscapeHatchHtml` parallels, matching `Card`. Lower priority than `withAttributes`;
none block the escape-hatch retrofit.

### Redundancy to retire — `Shape.withClass`, `Skeleton.withClass`
Both expose a caller-owned `classes` list via `withClass`, mapped through `Attr.class`.
This is **not** baked styling, but it overlaps with `withAttributes` (a caller could pass
`Attr.class "..."`). When these adopt `withAttributes`, consider deprecating `withClass`
in favor of the canonical escape hatch to avoid two ways to do the same thing.

---

## Mechanical-safe list

Single obvious `M3e.*` host, a flat attribute list at the `view`'s `component` call, no
render-time root ambiguity. Adding `withAttributes` here is: add `attributes : List
(Attribute msg)` to `Config` (init `[]`), add the modifier, and prepend `cfg.attributes`
to the host's attribute list. **34 modules:**

```
AppBar            Avatar            Badge             BottomSheet
Breadcrumb        Button            ButtonGroup       Calendar
DatePicker        Dialog            Divider           ExtendedFab
Fab               Heading           Icon              IconButton
List              LoadingIndicator  Menu              NavigationBar
NavigationDrawer  NavigationRail    Paginator         ScrollContainer
Shape             SideSheet         Skeleton          Slide
SplitButton       SplitPane         Stepper           Tabs
TextField         TextHighlight     TimePicker        Toolbar
```

(38 entries above; `BottomSheet`/`Dialog`/`SideSheet` have a closed-state `text ""`
branch and `TextHighlight` has an inverted `view` signature, but all four still have a
single unambiguous host — apply attrs to that host in the open/normal branch.)

**Not mechanical (handle per "Tricky cases"):** `Checkbox`, `RadioButton`, `Switch`,
`Slider` (dual-root form-field); `Progress`, `Search` (dispatch dual-root); `Disclosure`,
`Chip`, `Tooltip` (ctor-gated dual-root); `FabMenu` (wrapper div); `SegmentedButton`,
`Select` (wrapper-with-subscripts, target the control); `Snackbar` (custom imperative
node); `Theme` (non-visual provider — mechanically easy but conceptually special).
