# elm-cem generator requirements — extracted from the elm-m3e hand layer

> Derived 2026-06-29 by auditing all ~74 hand-written `src/M3e/*.elm` wrappers
> against their naive codegen counterparts in `vendor/elm-m3e/Cem/M3e/*.elm`.
> The hand layer is the worked example of "what the generator should emit"; every
> way it deviates from naive codegen is a generator requirement. This is the input
> spec for the elm-cem retarget (`jackhp95/elm-cem#1`).

## Method

For each component: diff the hand wrapper (the API we want) against the naive
CEM-generated module (what the generator produces today), classify every deviation
by which generator capability would absorb it, and tag reducibility:

- **MECH** — generator can produce it from CEM alone.
- **DECL** — needs a declarative external-input file (slots map + per-component overrides). Never imperative function-body injection.
- **HAND** — irreducibly hand-owned; no reasonable declarative input captures it.

## Headline conclusion (the "capture it entirely" number)

**Capture ceiling ≈ 80%.** Of ~74 components, roughly **55–60 are fully reducible**
(MECH + DECL) and **~13 carry an irreducibly hand-owned aspect**. So the honest goal
is *"the generator owns the mechanical+declarative majority; a small hand-owned set
remains for genuinely imperative / multi-native-element / cross-component cases."*
"Eliminate the hand layer" → realistically "shrink it from ~74 modules to ~13, and
make those 13 the only thing anyone hand-writes."

The irreducible ~13 (see R-HAND below): DatePicker (form-field composition, *verify*),
Snackbar (imperative open), SplitButton (cross-component composition), Field,
TextField, Select, TimePicker (form-field + native-element compositions),
BottomSheet (action injection), RadioButton (slotless-radio label wrap), Search
(inner input), Slider (auto-thumb), plus the no-element modules Text / Theme-helpers
/ Label / StepperNext. **Calendar was removed (2026-06-29):** its only hand-aspect
was the JS-Date event read-back, now a reusable generated decoder (R9).

---

## Universal requirement

### R0 — Emit the Node/Attr IR + the `{required} → [optional] → Element` shape
- **MECH. Every component.** Naive returns `Html.Html msg` from `component`; the hand layer returns `Element { s | tag : Supported } msg` built from the `M3e.Node` IR, with a `view : { required } -> List (Option msg) -> Element …` signature and an `Internal.Option` config endomorphism.
- This is the reversed IR-emission decision and the shape generalization. The Button/Heading anomaly (R2) falls out of it for free.
- **Shape exceptions to support:** thin content-only elements (`StepperNext/Previous/Reset`: `List content -> Element`) and attribute-less elements (`ContentPane`, `TextOverflow`, `DatePickerToggle`: no `List (Option msg)` param at all because CEM declares no attrs). The generator must emit the degenerate shapes, not force `[opt]` when there are no options.

---

## Mechanical requirements (generator owns outright)

### R1 — Correct DOM property emission (camelCase keys, typed encoding, reset semantics)
- **MECH. Pervasive.** This is elm-cem#1 item (a). **VERIFIED still-broken in the vendored regen 2026-06-29 (#69 did NOT land here)** — the hand layer is currently the only thing making these correct. Sub-rules, each confirmed against `vendor/elm-m3e/Cem/M3e/*.elm`:
  - **camelCase property keys** from CEM `fieldName`, not the kebab `attribute`. **Confirmed broken**, with the smoking-gun mechanism: the generator already *names the Elm function* camelCase but emits the **kebab attribute string** as the property key. E.g. `Collapsible.elm:61` declares `noAnimate : Bool -> …` whose body is `Html.Attributes.property "no-animate" …` (line 63) — so it sets `element["no-animate"]`, a key the element never observes (hand layer correctly emits `Node.property "noAnimate"`, `Collapsible.elm:180`; likewise `hideToggle` `Disclosure.elm:159`, `disableClose` `Dialog.elm:176`). Same kebab-key bug confirmed live in: `no-animate` (Collapsible), `hide-toggle` (ExpansionPanel/ExpansionHeader), `inset-start` (Divider), `fit-anchor-width`/`anchor-offset` (FloatingPanel, OptionPanel), `page-index`/`show-first-last-buttons`/`hide-page-size` (Paginator), `selected-index` (Slide), `hide-selection-indicator` (SelectionList, FilterChipSet, SegmentedButton, Select, Autocomplete), `min-rows`/`max-rows` (TextareaAutosize), `case-sensitive` (TextHighlight, Autocomplete), `strong-focus` (Theme), `hide-delay`/`show-delay` (Tooltip, RichTooltip, TooltipElementBase), `max-depth` (Toc), `disable-restore-focus` (RichTooltipAction), `disable-close` (Dialog). **Fix: reuse the camelCase field (the same source as the Elm identifier) for the `property` key — a one-site generator change.**
  - **`selected`/`checked` as real DOM properties** (`Node.property … (Encode.bool …)`), not naive's `Html.Attributes.selected`/`checked` (HTML attributes / string-properties that web components ignore). **Confirmed broken live**: `Tab.elm:79`, `Radio.elm:59`, `MenuItemCheckbox.elm:89`, `Button.elm:481`, `Step.elm:115`, `ListOption.elm:141` all use `Html.Attributes.selected`/`checked`. Also affects IconButton, NavItem, ButtonSegment.
  - **Numeric properties as numbers**, not strings. **Mixed**: Paginator `length` is correctly a `property` but typed `Float` (`Paginator.elm:88-90`) where it should be `Int` (item count); Progress/Slider `value` is **still the string attribute** `Html.Attributes.value` (`LinearProgressIndicator.elm:69`, `CircularProgressIndicator.elm:55`, `SliderThumb.elm:73`). Slide `selectedIndex` is `Float` and kebab-keyed. Target: numeric `property` with `Int`/`Float` as the DOM type dictates.
  - **Boolean reset**: emit boolean properties unconditionally (so re-render resets to `false`), per elm-m3e#59.
  - **Known codegen bug**: `Cem.M3e.StepPanel.actionsSlot` emits `slot="actions-"` (trailing dash). Generator slot-attr emission is buggy.
  - **Encoding divergence to resolve**: Icon `opticalSize` — hand uses `attribute` + Int; CEM uses `property` + Float. Pick the DOM-correct one.

### R3 — Shared `M3e.Value` token vocabulary
- **MECH.** Already designed (#54, shipped in the hand layer). Collect enum literals manifest-wide, mint bare axis-neutral tokens, give each component a closed supported-row. Generator emits this.

---

## Declarative requirements (need external-input files)

### R4 — Slot → children typing + the closed-row composition model  *(elm-cem#1 external input #1; the big one)*
- **DECL. Pervasive.** Naive emits bare `iconSlot : Html.Attribute`; the hand layer types slots so children are documented and (optionally) enforced. **Needs `slots.json`** — per slot: the allowed child kinds + an `arbitraryAllowed` flag (does the Material spec permit arbitrary children here?).

#### Verified row mechanics (compiled probes against the real API, 2026-06-29)

These were settled empirically with `elm make`, not asserted — the behavior is non-obvious and easy to get wrong.

- **Open slot rows are affordance, NOT enforcement.** The current hand layer types slots with *open* rows, e.g. `Card.actions : List (Element { s | button : Supported } msg)`. Elm merges any two open records, so the row keeps **nothing** out:
  - `Card.actions [ Icon.view … ]` — wrong kind (`{ s | icon }`) → **compiles**.
  - `Card.actions [ M3e.html … ]` — raw html (`{ s | html }`) → **compiles**.
  The row only drives autocomplete and documents intent. **Contrast R3:** `Value` setters use *closed* rows, so `Button.view { variant = Value.small … }` is a **TYPE MISMATCH** (small ∉ the closed `{ elevated, filled, tonal, outlined, text }`). So **R3 enforces at compile time; open-row R4 does not** — exactly the "protection lives on the setter argument" note.

- **Closed slot rows DO enforce — without killing escapes.** Switching the typed-shorthand setter to a *closed* row (no `s |`) recovers real compile-time safety:
  - `actions : List (Element { button : Supported } msg)` ← `Button.view` ✅; ← `Icon.view` ❌ *TYPE MISMATCH* (compiler even hints "Maybe icon should be button?"); ← `M3e.html` ❌ *TYPE MISMATCH*.
  - Escapes survive, because they live elsewhere: (a) the universal `Element.fromNode : Node msg -> Element any msg` — `any` is a bare type variable, so it punches through *any* row by design (the loudest, elm-review-greppable hatch); and (b) separate named escape setters (below).

- **Open producers + closed consumers ⇒ heterogeneous coexistence WITH enforcement.** Because component `view`s return *open* rows, a mixed child list widens to the *union* row, which is then checked against the closed slot:
  - multi-kind slot `{ button, iconButton }` ← `[ Button.view, IconButton.view ]` → ✅ (both coexist);
  - single-kind slot `{ button }` ← `[ Button.view, IconButton.view ]` → ❌ (iconButton rejected);
  - multi-kind slot `{ button, iconButton }` ← `[ …, Icon.view ]` → ❌ (icon rejected).
  - **Generator rule:** generated `view`s MUST return open rows (`Element { s | tag : Supported } msg`); generated typed slots SHOULD use closed rows enumerating every allowed kind (`{ button : Supported, iconButton : Supported }`).

#### The named per-slot gradient (the emitted API shape)

For each slot, `slots.json` gives the allowed kinds + `arbitraryAllowed`; the generator emits a gradient whose **name loudness encodes distance from the happy path**:

| name | accepts | emitted when |
|---|---|---|
| `trailingIcon` (typed shorthand, often a constructor `{ name : String } -> Option`) | the blessed kind | one per allowed child kind |
| `trailing` / `trailingSlot` | arbitrary spec-allowed content — a closed row of *all* allowed kinds (or `Element any` if the slot is genuinely open) | **only if** `arbitraryAllowed` |
| `trailing_Element` | `Element any msg` — an off-spec IR element | always (escape) |
| `trailing_ESCAPE_HATCH_HTML` | raw `Html msg` — out-of-our-hands / third-party markup | always (escape) |

The *presence* of a friendly `trailingSlot` is itself the signal that arbitrary content is blessed; its *absence* marks an opinionated slot. The `element` escape is the extensibility seam — e.g. a company logo where only Material icons are "blessed" — letting consumers define their own helpers cleanly. `html` / `fromRawHtml` is the last resort for markup we can't express in the IR (third-party widgets, etc.).

- **Proposed `fromRawHtml : Html msg -> Element any msg`** — a *universal-row* raw-html lift (fits everywhere, like `fromNode`), replacing today's row-restricted `M3e.html : Html msg -> Element { s | html : Supported }` (which a closed slot correctly rejects). "html allowed anywhere," gated by elm-review rather than by types.

#### Enforcement split (the resolved model)

The **type system** (closed slot rows) polices the easy/common path — wrong kind or stray html is a compile error with a helpful hint. **elm-review** polices *only* the explicit escapes (`*_Element`, `*_ESCAPE_HATCH_HTML`, `fromNode`/`fromRawHtml`), proposing an alternative or requiring a suppression. The two split the work; together they make **easy path = correct path**. This is a stronger position than "open rows everywhere + elm-review as sole enforcer" — that was only forced by the hand layer's *choice* of open slot rows, not by the type system.

#### Content/text positions take an `Element`, not a `String` (the text-resolver model, resolved 2026-06-29)

Today most components hard-bake `String → Html.text` at the setter type (`{ label : String }` → `Node.text req.label`), and some manufacture a `span[slot]` (List overline). That bakes *two* opinions a consumer can't escape: that text renders via `Html.text`, and that the wrapper is a `span`. Real-world counterexample: a team whose "text" is a `<translate key="…">` web component, not a text node.

**Resolution:** content positions take `Element { s | element : Supported } msg`. `M3e.text` is merely the *default constructor* for that type; any function producing it qualifies, so a team supplies its own and uses it at the call site — **no ambient/global config**.

```elm
-- library default — LAZY: holds a Text node, does NOT eager-wrap
M3e.text : String -> Element { s | element : Supported } msg
M3e.text str = Internal.fromNode (Node.text str)

-- a team's own resolver — same type, built around their component
translate : String -> Element { s | element : Supported } msg
translate key = Internal.fromNode (Node.element "translate" [ Node.attribute "key" key ] [])

Button.view { label = M3e.text "submit" } []       -- default → Html.text
Button.view { label = translate "btn.submit" } []  -- team → <translate key=…>
```

The "span if slotted, else `Html.text`" decision happens at **placement** (the R8 `intoSlot` helper), keyed off the node's own constructor — the component supplies the slot name, the constructor supplies the rendered shape, nothing is ambient:
- default-slot child → `Element.toNode` as-is → `M3e.text` stays a bare `Html.text` (no span); `translate` is its element.
- named-slot child → `intoSlot name` → `M3e.text`'s `Text` self-wraps in `span[slot]`; `translate`'s element stamps directly.

The phantom tag `{ element : Supported }` is therefore a **"placeable" promise** (it can always be placed into a named slot), not a claim about the current node shape. `M3e.text` must be *lazy* (hold the `Text`, defer the span) for the default-slot "no span" behavior; this is why named-slot content **must** be placed through `intoSlot`. Raw still stays out of named slots (uses `fromNode`/default regions). See R11 for the `String`-stays-correct cases (attribute-valued text).

### R5 — Multi-tag grouping  *(elm-cem#1 external input #3 — but FAR bigger than "Progress")*
- **DECL. ~20 components.** The dominant structural pattern: one logical module spans several CEM tags. Two flavors the schema must express:
  - **Container + typed item family**: Menu (7 tags), List (8), Tabs (3), Tree (2), Stepper (3), Disclosure (2), Breadcrumb (2), SegmentedButton (2), RadioButton (2), Nav* (2–3), Slide (2), Tooltip (2). A parent `view` plus typed item/sub constructors (`item`, `option`, `section`, `treeItem`, …). *Structural design (parallel item-config types, per-member option collisions like `itemLeadingIcon`/`checkboxLeadingIcon`, recursion, relational rows like `triggerFor`) is a separate pass — see Open design decisions.*
  - **Variant-split by required arg**: Chip (5 tags by kind), Progress (linear/circular by `shape`), Fab vs ExtendedFab (same `m3e-fab` tag, split by always-on `extended`). One module, tag chosen by a required field.
- This is the single largest schema surface. elm-cem#1 #3 named it but scoped it as rare; it is the norm.

#### Resolved 2026-06-29 — the variant-split flavor collapses onto a shared `Action` value (don't replicate hand shapes)

The hand layer splits into separate constructors/modules whenever a component has a **required behavioral argument that differs by variant** — because Elm records have no optional-but-typed fields and `List (Option msg)` is homogeneous (no option can change the config's type). That single root cause produced four disguises: Chip's `assist`/`suggestion`/`filter`/`input` (4 constructors), `Fab` vs `ExtendedFab` (2 modules), Menu's local `ItemAction = Click msg | Link String` ADT, and Chip's **runtime** `case c.href` href/onClick precedence (not type-enforced). The action-wiring `case`/`Maybe.map` cluster is also **copy-pasted three times** (Chip, Button, Fab each re-derive the same href/click attrs).

The fix uses vocabulary we already have — an opaque wrapper carrying a `Supported` **capability row** (same idea as `Element`'s `supported` row):

```elm
module M3e.Action exposing (Action, onClick, link, linkWith, toggle, remove, toAttrs)

type Action capability msg
    = Action (Payload msg)

type Payload msg                       -- private; never exported
    = OnClick msg
    | Link LinkSpec
    | Toggle msg                       -- fires on `change`
    | Remove msg

type alias LinkSpec =
    { href : String, target : Maybe String, rel : Maybe String, download : Maybe String }

onClick  : msg -> Action { c | click : Supported } msg
link     : String -> Action { c | link : Supported } msg          -- 90% case (href only)
linkWith : LinkSpec -> Action { c | link : Supported } msg        -- full anchor (Button/Fab)
toggle   : msg -> Action { c | toggle : Supported } msg
remove   : msg -> Action { c | remove : Supported } msg

link url = linkWith { href = url, target = Nothing, rel = Nothing, download = Nothing }

toAttrs : Action capability msg -> List (Node.Attr msg)   -- the SINGLE source of action→DOM wiring
```

A consumer pins the capability row to declare which actions it admits; the row is fixed at each constructor, so the built value is monomorphic and composes with the homogeneous option list.

- **Required-vs-optional moves to the binding site, not separate functions/modules:**
  - **Required** (Chip kinds, Menu `item`): `action` is a required record field —
    `assist : { label : String, action : Action { click : Supported, link : Supported } msg } -> …`,
    `input  : { …, action : Action { remove : Supported } msg } -> …`,
    `filter : { …, action : Action { toggle : Supported } msg } -> …`.
    `Action.toggle x` passed to `assist` is a **type error** (its row has no `toggle`) — this is "Never on the other," generalized. href XOR onClick is now structural: `action` is one field, so both can't coexist.
  - **Optional** (Button — honoring Button.elm's deliberate "no action is degenerate-but-valid, caught by NoActionlessButton review rule"): `action : Action { click, link } msg -> Option msg`. Same value, different binding site; the review rule is unchanged.
- **`Fab`/`ExtendedFab` merge.** `Fab.view` *already* sets `extended` when `label` is supplied; the only real difference is a11y (icon-only needs `ariaLabel`; extended's visible `label` *is* the accessible name). Same discriminated-required-arg pattern → one constructor, drop the `ExtendedFab` module:
  ```elm
  type FabContent = IconOnly { icon : String, ariaLabel : String } | Extended { icon : String, label : String }
  view : FabContent -> List (Option msg) -> Element { s | fab : Supported } msg
  ```
- **`ChipSet` reverses.** Not a module that *contains* chips — a set-builder *in* `Chip` that consumes them; the `{ chip : Supported }` row already guarantees only chips go in:
  `set : { chips : List (Element { chip : Supported } msg) } -> List (SetOption msg) -> Element { s | chipSet : Supported } msg`.
- **`target`/`rel`/`download` bundle into the link** (decided 2026-06-29). Today they're free-floating options on Button/Fab — a footgun (`target "_blank"` with no `href` renders a dead attribute). Folding them into `LinkSpec` makes "target without href" unrepresentable; `toAttrs` standardizes on plain `Node.attribute "href"` (not the `Cem.href` rawAttr wrappers — href/target/rel/download are universal free-string anchor attrs with no enum to guard, and `Action` is a shared cross-component module). Net: 8 hand-written options across 2 modules → 3 optional `LinkSpec` fields wired once.
- **What `Action` deletes:** `ItemAction` (Menu); Chip's `onClick`/`href` options + the runtime `case c.href`; Button/Fab `target`/`rel`/`download` options (+ Config fields, defaults, rawAttr lines); `ExtendedFab.elm` (~180 lines); the three copies of the action-wiring cluster. (`Chip.removeLabel` *stays* — it's the remove button's accessible label, an a11y attribute, not the handler.)
- **Where `Action` STOPS (deliberately not over-unified):** Menu `checkboxItem`/`radioItem` carry **stateful** bindings (`onChange : Bool -> msg`, `checked`/`selected` property) — a form-control concern, not a fire-and-forget action. And the `itemLeadingIcon`/`checkboxLeadingIcon`/`radioLeadingIcon` triplication is **parallel-config-type** duplication, not an action problem. Both belong to the container+items structural pass.
- **Schema impact.** The variant-split descriptor declares, per member: tag, the required-arg's accepted `Action` capability row (or `discriminator` like Fab's `FabContent` / Progress's `shape`), and whether the action binds as a required field or an option. `Progress` (linear/circular by `shape`) stays a discriminator with no `Action` (no behavioral arg).

#### Resolved 2026-06-29 — the container+items flavor is two reuses of the R4 row mechanism (verified by compiled probe)

The whole flavor (Menu/List/Tree/Tabs/…) reduces to mechanisms already shipped — no bespoke machinery. The one genuinely new piece (capability-tagged options) was **verified by compiling probes**, not assumed.

- **Per-member option triplication dissolves by applying R4's open-producer/closed-consumer rule to the *option list*.** Today Menu writes `itemLeadingIcon`/`checkboxLeadingIcon`/`radioLeadingIcon` — three identical bodies (`Menu.elm:142/170/199`) — only because three parallel `Config` types each need their own option set under one module namespace. Replace with **one shared item `Config` + one capability-tagged option type** (item-family-local; `Internal.Option` is untouched, so blast radius is contained):
  ```elm
  type MenuItemOption capability msg = MenuItemOption (MenuItemConfig msg -> MenuItemConfig msg)  -- capability is phantom

  -- shared options carry an OPEN row naming their own capability → usable by any kind
  leadingIcon  : Element { icon : Supported } msg -> MenuItemOption { c | leadingIcon  : Supported } msg
  trailingIcon : Element { icon : Supported } msg -> MenuItemOption { c | trailingIcon : Supported } msg
  disabled     : Bool -> MenuItemOption { c | disabled : Supported } msg
  -- kind-specific options carry their kind's capability
  checked  : Bool -> MenuItemOption { c | checkbox : Supported } msg   -- checkbox only
  selected : Bool -> MenuItemOption { c | radio    : Supported } msg   -- radio only
  ```
  Each constructor's option-list param uses a **closed** capability row enumerating exactly what that kind admits:
  ```elm
  item         : { label, action } -> List (MenuItemOption { leadingIcon : Supported, trailingIcon : Supported, disabled : Supported } msg) -> Element { menuItem : Supported } msg
  checkboxItem : { label, onChange : Bool -> msg } -> List (MenuItemOption { leadingIcon : Supported, trailingIcon : Supported, disabled : Supported, checkbox : Supported } msg) -> Element { menuItem : Supported } msg
  ```
  Open option rows merge in a list; the closed constructor row rejects any capability it doesn't name — exactly the slot-children mechanism, moved onto options. **Result:** `leadingIcon`/`trailingIcon`/`disabled` written **once** (no prefixes), and `checked True` on a plain `item` becomes a **compile error** (was a silent no-op). Safety goes *up* while the code shrinks.
  - **Compiled-probe results (2026-06-29):** shared options reused on both kinds ✅; kind-specific option on its kind ✅; `checked` on `item` ❌ *TYPE MISMATCH naming the stray `checkbox` field*; `selected` on `checkboxItem` ❌ *names `radio`*; empty list ✅; one shared list passed to both kinds, annotated **and** unannotated (top-level), ✅. `applyOptions` folds unchanged (capability is phantom). Caveat: as with R3/R4 rows, annotations on intermediate `let`-bound lists are load-bearing (an over-wide inferred row defers the error) — not a new tax.
- **Recursion (Tree) needs no new vocabulary.** `treeItem`'s `children : List (Element { treeItem : Supported } msg)` is just a child slot whose row references the constructor's *own* output kind. Schema: a member self-reference flag (`childKind: self`).
- **Container × item matrix (List, 8 tags) is R4 again.** The container's `items` field is a **closed row = the union of accepted item kinds** (`{ listItem : Supported, divider : Supported, subheader : Supported }`); items are open-row producers, so heterogeneous lists coexist iff every kind is in the union. No new design.
- **Stateful bindings stay required record fields**, not `Action`: `checkboxItem { …, onChange : Bool -> msg }`, `radioItem { …, onClick : msg }` (a control without its handler is degenerate). This honors the Action boundary drawn above.
- **`triggerFor` is not a container+item concern** — an ordinary sibling helper `triggerFor : String -> Element { s | element : Supported } msg` referencing a menu's `id` via a runtime string. No type-level link worth inventing (the id is a DOM attribute). Schema: a plain "trigger" member.
- **Shared config carries every field** (`checked`/`selected`/`onChange`) even for plain items, sitting at defaults — a slightly wider record, but the closed rows prevent *setting* them, so no wrong behavior. Accepted cost vs. per-kind configs.
- **Schema impact.** The container+items descriptor declares, per group: container tag + the accepted item-kind **union row**; per member — tag, kind-row name, which shared/capability options apply, required behavioral fields (Action vs. stateful handler), and a `childKind: self` flag for recursion. Cross-module reuse is the *pattern* (capability rows, `Action`, `Element`), not one global `Item` type — Menu/List/Tree item shapes differ enough that a single shared `M3e.Item` would over-unify.

### R6 — Required-content / accessible-name designation  *(elm-cem#1 external input #2)*
- **DECL. Pervasive.** Two sub-types:
  - **Accessible-name on no-text controls**: required `ariaLabel`/`name` → `aria-label` on Checkbox, Switch, Fab, IconButton, Avatar, Slider, ChipSet(filter/input). CEM has no such attribute; it's pure a11y convention.
  - **Required content slot/text**: `label`/`headline`/`message`/`content` as required fields rendered into a slot or as a text child — Button, Heading, Chip, Tabs.tab, Tree.treeItem, Menu items, Dialog, BottomSheet, Collapsible, Snackbar, etc.

### R7 — Optionality rule (drive required-vs-optional from CEM `default`)
- **DECL/MECH.** elm-cem#1's optionality rule. **Confirmed live divergences**: `Button.variant`, `Heading.variant`, `ExtendedFab.variant` are hand-coded as *required* despite non-sentinel CEM defaults (`text`/`display`/`primary-container`). Under the rule they become optional. (Card already does it right.) Sentinel defaults (`null`/`""`/`0`) may stay required by editorial choice (Paginator.length, Toc.for).

### R8 — Slot placement (the hand layer's wrapper markup is mostly deletable)  *(NEW — only partly implied by elm-cem#1 #1)*
- **DECL (a small per-slot `wrap` mode → one shared helper) + a little HAND (genuine element injection).** CEM names slots but never describes the *wrapper markup* the hand layer injects, and m3e's shadow-DOM `::slotted` CSS makes some of it mandatory. Inventory of where the hand layer currently wraps:
  - **`div[slot=x]` region wrappers**: Card (header/content/footer/actions), Dialog (actions), Disclosure, SideSheet (start/end), SplitPane (content-pane), Tooltip (rich actions). Card also groups headline+subhead into one `content` div.
  - **`span[slot=x]` text wrappers**: Button.selectedLabel, Fab/ExtendedFab label, List overline/supporting-text, Tree label, Toc title/overline, Menu group, Dialog headline, Disclosure header.
  - **Injected child elements absent from CEM**: BottomSheet (`injectSheetAction` mutates the node tree), Search (inner `<input type=search slot=input>`), Slider (auto `<m3e-slider-thumb>`), RadioButton (`<label>` sibling wrap of slotless `<m3e-radio>`), SplitPane (`<m3e-content-pane>` wrap), Nav* (badge as `<m3e-badge>` child), Fab (icon child).

- **Which wrappers survive — VERIFIED against m3e's shadow-DOM CSS (2026-06-29, `card.js` / `dialog.js`).** Same-named slots *do* coexist at the platform level, but each m3e component's `::slotted(...)` CSS imposes a **per-slot structural contract** that overrides that freedom. The check (which reversed an earlier "wrappers are deletable" draft):
  - **Container-region slots NEED a single wrapper.** Card/Dialog `actions` (and Card `header`/`footer`) are styled as one flex container:
    ```css
    /* dialog.js */
    ::slotted([slot="actions"])      { display: flex; align-items: center; column-gap: 0.5rem; }
    ::slotted([slot="actions"][end]) { justify-content: flex-end; }
    ```
    `column-gap`/`justify-content` + the documented `<div slot="actions" end>` only make sense on **one** element holding the buttons. Stamping `slot="actions"` on each button applies these to each *button's own children* — wrong layout. So multiple children **must** be wrapped in one `div[slot=x]`; the wrapper is m3e's contract, not our opinion.
  - **Direct-child slots must NOT be wrapped.** Card styles media by *direct* child: `::slotted(img[slot="header"]) { border-radius: … }`. Wrapping an `<img>` in `div[slot=header]` loses that styling — so an image goes straight into the slot. (Card's current `mediaSection` div is therefore a latent bug — **confirmed** by the 2026-06-29 wrap-mode audit: the direct-child media pattern is platform-wide.)
  - **Text / single-element slots** stamp directly (no grouping): Dialog `header` is one typographic element, List overline a single span — `M3e.text`'s span *is* that element.
  - **Raw html is still never auto-wrapped** (your call): the `Raw` branch of placement no-ops; if you want raw in a slot you stamp it yourself (`Html.div [ attribute "slot" "x" ] […]`).

  The single-child cases use one shared placement helper:
  ```elm
  intoSlot : String -> Node msg -> Node msg
  intoSlot name node =
      case node of
          Element el -> Element { el | attrs = Attribute "slot" name :: el.attrs }  -- stamp
          Text _     -> Node.element "span" [ Attribute "slot" name ] [ node ]       -- text carrier
          Raw _      -> node                                                          -- raw: caller's job
  ```
  …and container-region slots use a grouping helper (`group name children = Node.element "div" [ slot name ] children`).

- **Net: a per-slot wrapper flag IS needed (this corrects the earlier "derive, don't declare").** CEM lists slot *names*, not CSS contracts, so the generator can't detect container-region vs direct-child mechanically. `slots.json` must mark each slot `wrap: container-div | direct | text-span | none`. It's still mostly **one shared helper per mode** — not bespoke per-component markup — but the *mode* is declared.

- **Wrap-mode audit — VERIFIED across the remaining wrapping components (2026-06-29, `@m3e/web` dist `::slotted` CSS).** Closes the prior open item; the four-mode model holds, and the real-world distribution is clear: **`direct` and `text-span` dominate; `container-div` is rare (only genuine multi-child flex regions); element-injection is HAND.**

  | component | tag | slot(s) | `::slotted` evidence | mode |
  |---|---|---|---|---|
  | SideSheet | `m3e-drawer-container` | `start`, `end` | `[slot=start/end]{height:100%; width:token}` — a sized panel region (one fixed-width panel; N un-wrapped children would each become a panel) | **container-div** |
  | SplitPane | `m3e-split-pane` | (panes) | **no `::slotted` rule** — uses real `<m3e-content-pane>` child *elements* | **element injection → HAND** |
  | Tooltip | `m3e-tooltip` | `actions` | `[slot=actions]{display:flex; column-gap:.5rem}` + `[slot=actions][end]{justify-content:flex-end}` — same one-flex-container contract as Dialog/Card actions | **container-div** |
  | Tooltip | | default content | no `::slotted` | text-span / none |
  | List | `m3e-list-item` | `leading`, `trailing` | styled by element tag: `img[slot=leading]`, `video[slot=leading]`, `m3e-icon[slot=leading]` (border-radius, object-fit, icon size/color) — wrapping breaks all of it | **direct** |
  | List | | `overline`, `supporting-text`, `trailing-supporting-text` | typographic `font-size`/`color` on `[slot=x]` | **text-span** |
  | List | | `items` (expandable) | `[slot=items]{display:flex; flex-direction:column}` — hand stamps `slot=items` per child (List.elm:553); CSS applies per element | direct (per-child stamp) |
  | Menu | `m3e-menu-item` | `icon`, `trailing-icon` | `[slot=icon/trailing-icon]{flex:none; width:1em; font-size}` — direct icon | **direct** |
  | Menu | | label | default text, no `::slotted` | text-span / none |
  | Toc | `m3e-toc-item` | `overline`, `title` | typographic `font-size` on `[slot=x]` | **text-span** |
  | Tree | `m3e-tree-item` | `icon`, `selected-icon`, `toggle-icon`, `open-toggle-icon` | icon sizing on direct element | **direct** |
  | Tree | | `label` | `a[slot=label]{all:unset}` — single element (a `M3e.text` span or a direct `<a>`) | **text-span** (single-element) |

  Cross-cutting findings:
  - **Media/icon slots are styled by element *tag* (`img`/`video`/`m3e-icon`/`a`), so their mode is mandatorily `direct`** — wrapping in a `div` silently drops the styling. This is the same contract as Card's `img[slot=header]`, now confirmed as a *platform-wide pattern* (List/Tree/Menu/Card all do it). **Card's `mediaSection` `div` wrap is therefore confirmed a latent bug** (R8 earlier note upgraded from "likely" to "confirmed").
  - **The hand `List` is the correct reference**: `leading`/`trailing` via `withSlot` (direct stamp, List.elm:807/811), `overline`/`supporting` via `span[slot]` (text-span, 808/810) — matches the CSS exactly. Generated output should mirror it.
  - **`container-div` is reserved for genuine multi-child flex regions** — only `actions`-style action bars (Dialog/Card/Tooltip) and full-panel regions (SideSheet start/end). Everywhere else is `direct` or `text-span`.
  - This `wrap` mode is **correlated with R4 slot typing**: a `direct` media/icon slot also constrains the allowed child kind (`img`/`video`/`m3e-icon`), so `slots.json`'s `wrap` and allowed-kinds fields co-vary.

- **Genuine element injection stays HAND** (this is *not* slot-wrapping): BottomSheet `injectSheetAction`, Field `id`-stamping (node-tree mutation), Search inner `<input>`, Slider auto `<m3e-slider-thumb>`, RadioButton `<label>` sibling, **SplitPane `<m3e-content-pane>` wrap (confirmed: no `::slotted` contract — it's real child elements, not a slotted region)**. These compose new elements, not parent a child into a slot.

### R9 — Event → typed-payload decoders  *(elm-cem#1 external input #6)*
- **Fully DECL/MECH — NO truly-HAND cases** (corrected 2026-06-29 after inspecting codegen + the Calendar/Tree hand modules). The modular base is **already shipped in codegen**: each component emits the generic listener `onX : Json.Decode.Decoder msg -> Html.Attribute msg`, and `Cem.M3e.Common` exposes reusable decoders (e.g. `targetValue`) — codegen docstrings even teach `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`. So "listener + bring-your-own-decoder + compose" (the requested modularity) exists today.
- What the hand layer adds is the **typed-payload convenience** `onX : (payload -> msg) -> Option` with the decoder pre-baked. The generator should emit these from an event-override descriptor:
  - `target.value` / `target.checked` / `target.selected` (form controls) — shared `Common` decoders.
  - `detail.X` extraction (Paginator `detail.pageIndex`; Menu/Select `newState`) — `Common.detailField "pageIndex"`.
  - multi-event → one msg (`onClose` ← `closed`+`cancel`; `onToggle` ← `opened`/`closed` → Bool) — override lists the source events.
  - `Decode.succeed msg` for plain clicks.
- **The two cases I previously marked HAND both dissolve:**
  - **Date is a reusable helper, not hand code.** Calendar's `datePropertyDecoder` is generic except for one JSON path: `Decode.at ["target","date"] Decode.value |> andThen (Encode.encode 0 >> decodeString string)` — `Encode.encode` triggers `Date.prototype.toJSON()` → ISO string. Generalizes to `Common.dateValue` / `dateAt : List String -> Decoder String`. CEM can't *infer* Date-ness (the `change` event is prose-only), so the event-override declares `{ source: target.date, type: Date }`; the generator then emits the convenience from the built-in Date→ISO helper.
  - **Tree degrades to plain-msg, which is mechanical.** `Tree.onChange : msg -> Option` — the event carries non-serialisable live DOM refs, so no payload decoder is *possible*; that's a data limitation expressed as "no typed-payload convenience available," generated as `Decode.succeed msg`. Not hand-written.
- Schema: per-event a small decoder descriptor (source path + target type + multi-event fan-in); a `plain` form (no payload) for the Tree-style case. No `hand` escape needed.

### R10 — Universal escape hatches  *(elm-cem#1 comment 2)*
- **MECH + DECL.** Confirmed prototypes: `attributes : List (Node.Attr msg)` on Shape, ScrollContainer, Skeleton, Progress (ADR 0007 CSS-var passthrough). Plus IconButton.extraContent, NavigationDrawer.content. Generalize: every component gets `extraAttrs` + a shared `M3e.Attr.attributes`. Content escape (`M3e.html`/`fromNode`) already universal. *(`href/target/rel/download` is no longer an escape-hatch concern — it folds into the shared `M3e.Action` link value, R5.)*

### R11 — Configurable text handling (the text-resolver model)
- **DECL. Resolved 2026-06-29 — the resolution is structural, not a per-component override.** The `String → Html.text` opinion lives at the *setter type*; the fix is to type rendered-content positions as `Element { s | element : Supported } msg` and let `M3e.text` be the default constructor (full mechanics in R4 "Content/text positions take an `Element`"). Consequences for the generator:
  - **Two categories of "text", split by destination:**
    - **Slotted/child content** (Button/Chip/Heading label, List headline/overline, Dialog headline, Tree label, …) → emit an `Element { s | element : Supported } msg` parameter. The consumer passes `M3e.text "…"` (or their own resolver, e.g. a `<translate>` helper). Placement via R8 `intoSlot`. This **deletes** the per-component `Html.text`/`span[slot]` markup (e.g. List's manufactured `span`).
    - **Attribute-valued text** (Breadcrumb `item-label`, Badge count, `aria-label`, SegmentedButton value-defaults-to-label) → stays `String`. There is no element to swap — the string becomes a DOM **attribute**, not slotted content — so `String` is *correct*, not an opinion to escape.
  - **Breadcrumb is the instructive split:** its label is used as *both* a slotted text child (→ `Element`/`M3e.text`) **and** an `item-label` attribute (→ `String`). The override declares both destinations; the generator wires the `Element` to the child and a `String` to the attribute (or derives the attr string from the label when it's plain text).
  - **Badge `999+` truncation** is value-formatting on the attribute/text-value path, independent of the resolver model.
  - `M3e.text` itself must be **lazy** (holds a `Text` node, defers the `span` to placement) so default-slot text stays a bare `Html.text` while named-slot text self-wraps. No ambient/global text-renderer config — the resolver is just the constructor the consumer chose.

### R12 — Typed-argument overrides  *(this is the Icon example — keep it DECL, never imperative)*
- **DECL.** Where m3e passes a value through untyped but we want Elm type-safety without vendoring or a review rule: Icon `weight` (ADT `W100..W700` → string), Icon glyph `name`, Heading `level` (Int clamped 1..6 → string), ThemeIcon/Theme `scheme`. Express as a declarative **argument-type override** (a named typed wrapper around the passthrough) in the overrides file — **not** function-body injection. *If a customization can't be expressed declaratively, it stays hand-owned.*

### R13 — Surface curation (omission / include list)
- **DECL.** The hand layer deliberately omits chunks of the CEM surface: FormAssociated read-back internals (`dirty/pristine/touched/untouched/willvalidate/validationmessage`), `disabledInteractive`, `onBeforeinput`/`onInput`, navigation labels, etc. Generator design decision: **emit the full surface and let an override file curate**, or emit a curated default. Recommend full-surface + optional skip-list, so nothing is silently unavailable.

### R-EXTRA — Misc declarative bits
- `role="group"` injection (ChipSet) — a static-attribute override.
- Auto-id via `slugify` when `id` omitted (Select, TextField, TimePicker) — a fallback-id strategy flag.
- Name-collision renames (elm-cem#1 #5): `textVariant`, `formType` (Elm `type` keyword), `min`/`max` (drop CEM's `Attr` suffix), `forId`. A small rename map.

---

## Irreducibly hand-owned  (R-HAND — the ~20% / ~14 modules)

These cannot be captured by any declarative input; they stay hand-written (the residual "hand layer"), and the generator should leave designated holes for them:

- **No custom element / Tailwind**: `Text`, `Label`, Theme typescale helpers (elm-cem#1 #4 skip list).
- **Native-element compositions** (`m3e-form-field` + native `<input>`/`<label>`/`<textarea>`): `Field`, `TextField`, `Select`, `TimePicker`, and `DatePicker` (toggle + input + calendar composition — *verify separately; HAND for composition, not for dates*). Includes `Node.setAttribute` IR-rewrite (Field stamps `id` onto the control node).
- **Imperative-only**: `Snackbar` (opened via JS `M3eSnackbar.open`, no declarative `open`); needs the JS wrapper / port.
- ~~**JS-Date decode**: `Calendar`, `DatePicker`~~ — **REMOVED (2026-06-29).** The Date read-back is a reusable generated decoder (R9), not hand code. `Calendar` verified **fully reducible** (date/label attrs + `startView` enum + clean `header` slot + the R9 Date convenience) and leaves this list. `DatePicker` stays below for its form-field/multi-element *composition*, not for dates *(verify separately)*.
- **Cross-component composition**: `SplitButton` calls `Button.view` for its leading slot — this is also the **#70 phantom-row leak** (SplitButton's variant row widened to match Button's, admits `Value.text` upstream rejects).
- **Node-tree mutation**: `BottomSheet` (`injectSheetAction`).
- **Slotless-element workarounds**: `RadioButton` (`<label>` sibling wrap), `Search` (inner `<input>`), `Slider` (hidden auto-thumb).
- **Upstream CEM bug**: `StepperNext` has no vendored module (CEM tagging bug); blocks generation until fixed upstream.

---

## Implied external-input schema (expanded from elm-cem#1)

1. **`slots.json`** — per component, per slot: allowed child element kinds + `arbitraryAllowed` (R4, drives the closed-row typed shorthands and whether a friendly `…Slot` rung is emitted) **and** a wrapper mode `wrap: container-div | direct | text-span | none` (R8 — required because m3e's `::slotted` CSS imposes per-slot contracts CEM doesn't expose; verified on Card/Dialog). Each mode maps to one shared helper (`group`/`intoSlot`/`Element.toNode`), not bespoke markup. Bespoke element-*injection* (BottomSheet, Search, Slider, RadioButton) is declared separately and is HAND.
2. **`overrides.<component>`** — required-content/a11y-name designation (R6), multi-tag grouping definition (R5), event-decoder descriptors (R9), typed-argument overrides (R12), surface skip-list (R13), static-attr injections + auto-id + renames (R-EXTRA), and a `hand-owned` flag (R-HAND) that tells the generator to skip / leave a hole.

Everything else flows mechanically from CEM (R0, R1, R3, R7, R10).

## Resolved design decisions

- **R4 slot enforcement (settled 2026-06-29, verified by compiled probes):** generated `view`s return *open* rows (enable heterogeneous child coexistence); generated typed slots use *closed* rows enumerating allowed kinds (real compile-time enforcement). Escapes relocate to named siblings (`*_Element`, `*_ESCAPE_HATCH_HTML`) + universal `fromNode`/`fromRawHtml`, policed by elm-review. Easy path = correct path.
- **Slot placement / wrappers (settled 2026-06-29, verified against m3e CSS):** wrapping is driven by a per-slot `wrap` mode (`container-div`/`direct`/`text-span`/`none`), each mapped to one shared helper — not bespoke per-component markup. m3e's `::slotted` CSS imposes the contract: container-region slots (Card/Dialog actions, Card header/footer) **need** a single `div[slot]` (verified `column-gap`/`[end]` styling); direct-child slots (`img[slot=header]`) must **not** be wrapped; text/single-element slots stamp directly; raw is never auto-wrapped. Same-named slots coexist at the platform level but the component CSS overrides that for layout regions.
- **Text as a resolver (settled 2026-06-29):** rendered content positions take `Element { s | element : Supported } msg`, not `String`; `M3e.text` is the lazy default constructor and consumers can supply their own (e.g. a `<translate>` resolver) with no ambient config. Attribute-valued text stays `String`. (See R4 / R11.)
- **Shared `Action` value for variant-split components (settled 2026-06-29):** the recurring "required behavioral arg differs by variant" root cause (Chip kinds, Fab/ExtendedFab, Menu `ItemAction`, href/onClick precedence) collapses onto one opaque `M3e.Action` carrying a `Supported` capability row + a single `toAttrs` wiring function. Required-vs-optional is decided at the binding site (record field vs option), not by separate constructors/modules. `linkWith`/`LinkSpec` bundles `target/rel/download` with `href` (unrepresentable without it). `ExtendedFab` and `ChipSet` modules dissolve (FabContent discriminator; `Chip.set`). Does NOT cover stateful checkbox/radio bindings or parallel-config-type duplication. (See R5.)
- **Container+items via capability-tagged options (settled 2026-06-29, compiled-probe-verified):** per-member option triplication (`itemLeadingIcon`/`checkboxLeadingIcon`/`radioLeadingIcon`) collapses to one shared item config + one capability-tagged option type, reusing R4's open-producer/closed-consumer rule on the option list — shared options written once, wrong-kind options become compile errors. Recursion (Tree) falls out of self-referential kind rows; container×item matrix (List) is a closed union row; stateful item handlers stay required fields; `triggerFor` is a plain sibling helper. Option type is item-family-local (`Internal.Option` untouched). (See R5.)

## Open design decisions

- **Surface curation default** (R13): full-surface-then-skip vs curated-default. *Recommend full + skip-list.*
- ~~**Wrapper-mode coverage** (R8)~~ — **RESOLVED 2026-06-29.** Audited SideSheet/SplitPane/Tooltip/List/Menu/Toc/Tree `::slotted` CSS; wrap modes assigned (see R8 audit table). Confirmed the direct-child media/icon pattern is platform-wide (Card `mediaSection` bug confirmed), `container-div` is rare (action bars + full panels only), and SplitPane is element-injection (HAND). `wrap` co-varies with R4 allowed-kinds.
- **Decoder descriptor language** (R9): how much of the `target.x`/`detail.x`/multi-event space is declarative vs `opaque`.
- ~~**Multi-tag grouping** (R5)~~ — **RESOLVED 2026-06-29.** Both flavors settled in R5: variant-split → shared `M3e.Action`; container+items → two reuses of the R4 row mechanism (closed item-kind union rows for containers; capability-tagged options for the per-member collision, verified by compiled probe) + required-field stateful bindings + self-referential child rows for recursion. Remaining sub-item: write the single `groups` schema covering both flavors (descriptor fields enumerated in R5).

## Internal-inconsistency cleanups (not generator concerns, but noted)
- `SegmentedButton` and `Tooltip` use bespoke `Option` ADTs + manual `foldl` instead of `Internal.Option`/`applyOptions`. Normalize before/while generating.
- `ThemeIcon.Scheme` is a local ADT while `Theme.Scheme` is a `Value` row — pick one.
