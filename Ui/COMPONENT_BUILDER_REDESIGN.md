# Ui.* Component Builder — Redesign / MISI Pass

> **STATUS (2026-06-22):** Historical decision log. **Authoritative spec is now
> `M3E_SPLIT_REDESIGN.md`** in this directory, which supersedes the philosophy
> here on two points:
>
> 1. Strict 1:1 m3e-doc-page module split — `Ui.Button` and `Ui.IconButton`
>    become separate modules (this doc's unified-`Button msg` decision in §3 is
>    reversed). All other per-component MISI decisions below remain in force.
> 2. Cyclic container types co-locate in a single `Ui.Internal` (introduced at
>    first real container; not present in the components this doc covers).
>
> The per-component decisions (Avatar/Badge/Chip/Progress/Search/Snackbar/etc.)
> and the decision-log rationale are still the working reference.

> **Status:** Design spec for a future implementation session. NOT yet implemented.
> **Origin:** Issues discovered playing with the `/play` Component Builder (`/play/builder`).
> **Guiding principle:** "Make Impossible States Impossible." Help the compiler help us.
> Eliminate silent no-ops and settable-but-ignored modifiers; push required collaborators
> into constructor arguments; split inferred render-paths into explicit constructors.

## Context the implementer needs

- `Ui.*` (`src/elm/Ui/`) is a typed builder layer over `M3e.*` (`src/elm/M3e/`,
  bindings to `@m3e/web` custom elements). See `src/elm/Ui/REDESIGN_PLAN.md`.
- The `/play` Component Builder (`src/elm/App/Play/UiBuilderPlayground.elm`) is **generated**
  from the same `@figma-code-connect` annotations that drive the Figma Code Connect bridge.
  - Generator: `scripts/generate-ui-catalog.mjs` → `generated/Play/UiCatalog.elm`
  - Shared taxonomy lib: `code-connect/lib.mjs`; Figma generator: `code-connect/generate.mjs`
  - **Any annotation/grammar change must be reflected in BOTH generators**, and the
    catalog regenerated or `figma:check` fails (see memory: code-connect ↔ catalog coupling).
  - Skill: `/ui-figma-code-connect`.

## Two buckets of issue (keep them separate when implementing)

- **Bucket A — genuine `Ui.*` API / impossible-states problems.** Avatar, Badge, Button,
  Chip, Progress, Search, Snackbar.
- **Bucket B — playground/generator expressiveness gaps.** The catalog is generated from
  *design-time* annotations only, so anything that is *runtime data* (a field value, a
  select's options, a snackbar's open state, a progress value) is hardcoded to an
  empty/default and can't be exercised. CheckboxTristate, MultiSelect/FilterChips, Progress
  preview, Snackbar display.
- Several items are **both** (e.g. Progress Linear).

---

## 1. Ui.Avatar — Bucket A

**Current:** `new : Avatar msg` then `withContent : Html msg -> Avatar msg -> Avatar msg`
(content optional). `M3e.Avatar` has **no fallback glyph** — it renders only its children —
so `new` with no content is an empty colored circle. The builder's "delete label →
`withContent (Html.text "")`" is just the empty default leaking through. There is no
meaningful default; content is effectively required.

**Decision / proposed API:** content required, via three explicit constructors matching the
M3 "image / icon / initials" framing:

```elm
Ui.Avatar.image : { url : String, alt : String } -> Avatar msg
Ui.Avatar.initials : String -> Avatar msg   -- promote the existing modifier to a constructor
Ui.Avatar.icon : Ui.Icon.Icon msg -> Avatar msg
```

- **Remove the public `withContent`.** Keep it **module-internal** (the three constructors
  use it). If we ever must re-expose it, it lands with a comment:
  `-- Exposing this requires design approval.`
- `withId` stays.

**Migration:** every `Ui.Avatar.new |> withContent x` call site picks the right constructor.
`initials` callers already use the convenience fn — minimal churn.

---

## 2. Ui.Badge — Bucket A

**Current:** `new` + optional `withContent` + `withSize : Size` (Ui.Size = Small/Medium/Large).
Both "Small + content" and "Large without content" are expressible-but-wrong. M3 spec
(`docs/m3/components/badges.md`) sanctions exactly **two** types: *small* (shape only, no
text) and *large* (text/count, max 4 chars incl. `+`).

**Decision / proposed API:** collapse to the M3 two-type model. **No size axis** (Medium was
non-spec; designers don't use it; YAGNI). Content lives in the content-bearing constructors:

```elm
Ui.Badge.dot   : Badge msg          -- small; NO content slot at all
Ui.Badge.count : Int -> Badge msg   -- large; numeric; we apply the spec "999+" truncation
Ui.Badge.label : String -> Badge msg -- large; short status text
```

- `withId`, `withFor` (anchor to an element id) stay.
- Drop `withSize` and the `Ui.Size` dependency here.

**New elm-review rule:** flag `Ui.Badge.label (String.fromInt n)` and steer to
`Ui.Badge.count n` (so counts get spec truncation and stay typed). Lives in `review/src/`.

**Decided:** the `999+` / 4-char truncation lives inside `Ui.Badge.count` (spec rule in one
place; callers pass a raw `Int`).

---

## 3. Ui.Button — Bucket A (largest)

**Current problems:**
- One `Config` stores **both** `LabeledVariant` and `IconVariant`; `view` infers
  labeled-vs-icon from the content list; the irrelevant variant setter is a **silent no-op**.
- Icon-only buttons require an a11y label, enforced only by a **runtime visual dev-flag**
  (`missingA11yFlag`) — not the type system.
- `resolveDisabled` **silently** turns "no onClick and no href" into `Disabled` — hides
  wiring bugs.
- **No size axis**, though `M3e.Button` supports `Size` XS→XL.

**Decision:** label-first pipeline (chosen), nri-ui-modeled, multiple constructors.

```elm
Ui.Button.labeled "Save"
    |> Ui.Button.withVariant Ui.Button.Filled      -- only the 5 labeled variants exist here
    |> Ui.Button.withSize Ui.Button.Medium
    |> Ui.Button.withOnClick Save
    |> Ui.Button.view

Ui.Button.iconOnly { icon = trash, label = "Delete" }  -- a11y label TYPE-required
    |> Ui.Button.withIconVariant Ui.Button.Standard    -- only the 4 icon variants exist here
    |> Ui.Button.view
```

**Type design (chosen): single `Button msg` type, variant in the constructor (NO phantom
types).** The variant is the *only* kind-specific knob; everything else is genuinely shared.
A variant *setter* on a shared type can never be safe (`withVariant Filled` on an `iconOnly`
button compiles and silently no-ops — distinct variant types don't help, because the *button*
doesn't carry its kind). So move the variant into the constructor, where the kind-specific
type makes a mismatch a plain compile error:

```elm
type Button msg     -- single opaque type, NO phantom kind

labeled  : { label : String, variant : LabeledVariant } -> Button msg
iconOnly : { icon : Ui.Icon.Icon msg, label : String, variant : IconVariant } -> Button msg

-- LabeledVariant (5: Filled/Tonal/Outlined/Elevated/Text) and IconVariant
-- (4: Standard/Filled/Tonal/Outlined) are DISTINCT types, so the wrong-set
-- variant is a compile error. Both kinds carry a variant.

-- shared pipeline setters (valid on both kinds):
withSize, withShape, withOnClick, withHref, withDisabled, withId
    : ... -> Button msg -> Button msg
withLeadingIcon, withTrailingIcon : Ui.Icon.Icon msg -> Button msg -> Button msg  -- labeled only in practice
view : Button msg -> Html msg
```

- The wrong-set variant (`Elevated` on icon-only) is unrepresentable — distinct types.
- Configuring the variant for the wrong *kind* is impossible — it's a constructor field, not
  a cross-kind setter.
- The icon-only a11y `label` is a required constructor field (today: runtime `missingA11yFlag`).
- **No phantom types**, so `group`/`segmented` take `List (Button msg)` and mix both kinds
  freely — no `toGeneric` escape hatch needed (this removes a prior open question).
- Trade-off accepted: variant is a required constructor field, not a defaulted `|> withVariant`
  setter. (`withLeadingIcon`/`withTrailingIcon` are only meaningful on `labeled`; they remain
  shared setters and are simply unused on icon-only — a benign no-op, not a contradiction.)

**Add Size** (`ExtraSmall | Small | Medium | Large | ExtraLarge`, maps to `M3e.Button.Size`).

**Action modeling (replace the silent `resolveDisabled`):** make the action explicit.
**Decided:** `withHref` and `withOnClick` are **setters** (not separate `link`/`iconLink`
constructors) — it's the same `<m3e-button>` element either way, so a setter is the lower-
surface choice; they are mutually exclusive (last-write-wins, or model the action as a single
`Maybe Action` field internally). Do **not** auto-disable: a button with no action and no
explicit disabled state should be a lint/review smell, not a silent behavior change. (nri makes
the action a required attribute; we approximate with the elm-review rule below.)

**`loading` / `error` states:** nri has them; `M3e.Button` has **no native equivalent**.
Out of scope for v1; if needed later, compose (swap content for a spinner + `disabledInteractive`).
Documented as a known gap.

**`toggle` / `selected`:** `M3e.Button` supports it, but **leave selection to `Ui.Field`**
(segmented single-select) so there aren't two ways to model it.

**Composition helpers (`floating`/FAB, `group`, `segmented`) — "incorporate the extra bits":**
keep them as helpers consuming built `Button`s. With the single `Button msg` type they take
`List (Button msg)` and mix labeled + icon buttons freely (no type-erasure needed).

**Migration:** large blast radius. `new |> withContent [Content.text …]` →
`labeled "…"`; `new |> withContent [Content.icon …]` → `iconOnly {…}`; leading/trailing icons
become `withLeadingIcon`/`withTrailingIcon`. Audit every call site; expect a multi-file change.

---

## 4. Ui.Card — Bucket B (playground only)

**Finding:** the API is fine (granular slot setters; typed `withActions : List (Ui.Button.Button msg)`).
The `/play` preview wraps the card in a centered flex box with **no width constraint**, and the
actions row uses `ds-flex ds-gap-2` (design-system classes). Reads as a **playground preview**
problem, not the component.

**Action:** reproduce in browser during implementation (`/play/builder`, Ui.Card). Give the
preview container a sensible width; verify `ds-*` classes load in `/play`. **Confirm with Casey
whether the card also renders wrong on a real app page** (he believed it was builder-only).

---

## 5. Ui.Chip — Bucket A

**Current problems:**
- Non-spec **`basic`** kind (M3 has exactly four: assist, filter, input, suggestion).
- One `ChipConfig` for all kinds; `withSelected` is a no-op except Filter, `withRemovable`
  a no-op except Input — **silent no-ops**.
- **No outlined/elevated style axis**, though every M3e chip module exposes
  `variantOutlined` / `variantElevated`. Part of why the kinds "all look the same."
- `viewSet` infers the wrapper via `List.all (kind == Filter)`; a **mixed set silently
  falls back** to the basic `ChipSet`.

**Spec semantics (`docs/m3/components/chips.md`):** assist = button-like action; filter =
toggle/multi-select; input = represents an entity, **trailing remove required**; suggestion =
dynamically-generated action. **Color is token-driven, not per-instance** — there is no
"colorable chip" API; differentiation is behavioral + the outlined/elevated style + selected
state. (This is the "when to use what" guidance Casey remembered — it's the M3 spec itself.)

**Decision / proposed API:** kill `basic`; per-kind constructors taking required collaborators;
expose only valid modifiers per kind; add the style axis.

```elm
Ui.Chip.assist     { label : Html msg, onClick : msg }        -- + optional leading icon
Ui.Chip.filter     { label : Html msg, selected : Bool, onToggle : msg }  -- + optional trailing
Ui.Chip.input      { label : Html msg, onRemove : msg }       -- remove REQUIRED per spec
Ui.Chip.suggestion { label : Html msg, onClick : msg }

-- style axis (default outlined; elevated only on images/busy backgrounds per spec):
Ui.Chip.withElevated : Bool -> Chip kind msg -> Chip kind msg   -- or a Style type
Ui.Chip.withDisabled : ...   -- valid on all four
Ui.Chip.withIcon : Ui.Icon.Icon msg -> ...  -- leading icon
```

- No shared `withSelected` / `withRemovable` that silently no-op.
- **Typed sets:** a filter set holds only filter chips, an input set only input chips, etc.
  (phantom kind or per-kind set constructors), so a heterogeneous set is unrepresentable
  rather than silently downgraded.

**Decided:** `assist`/`suggestion` support `withHref` (M3e.AssistChip exposes
href/download/target — these chips can act as links), mirroring Button's action handling.

---

## 6. Ui.Field — Bucket B (+ one noted A)

**Findings:**
- **CheckboxTristate not testable:** generated render hardcodes `Ui.Field.tristate Nothing …`;
  the value (Nothing / Just True / Just False) is runtime data, so there's no knob. Only a
  `Disabled` axis is exposed.
- **MultiSelect / FilterChips not demoable:** generated as `Ui.Field.multiSelect [] [] …` —
  **empty options** → renders nothing. Same will affect singleSelect's segmented/radio/select.
- **Inputs too narrow:** preview container has no width; `M3e.FormField` sizes to intrinsic
  content → collapses narrow.

**Decisions:**
- **Sample data (yes):** extend the generator to synthesize canned demo data for previews —
  sample options for select-family, and a synthetic value knob. *(See cross-cutting §10.)*
- **Tristate value knob:** synthetic axis `Value ∈ {Unchecked, Checked, Indeterminate}`.
- **Narrow inputs = fix in the `/play` preview (option A), NOT the component.** Real forms
  control field width via layout; baking a min-width into `Ui.Field` would fight responsive
  layout (and the no-negative-margins / restructure-DOM instinct). Give the preview container
  a sensible width.

**Noted (Bucket A, likely out of scope — Field is huge / Phase 1):** `withInstant` is a
silent no-op on most kinds (only `boolean`, `multiSelect`); `withMaxLength` *presence*
silently flips text → `<input>` vs `<textarea>`. Modifier-as-hidden-signal. Flagged for a
later ticket, not this effort.

---

## 7. Ui.Progress — Bucket A + B

**Finding (real bug):** `attrsLinear` never sets a mode/indeterminate attribute;
`attrsCircular` **does** add `indeterminate True` when `value == Nothing`. So `linear` with no
value renders an empty *determinate* bar (invisible); `circular` with no value animates. The
playground previews both with no value → circular spins, linear shows nothing.

**Decision (MISI):** make value-presence the determinant; value required on the determinate
constructors; `indeterminate` is the *only* no-value path.

```elm
Ui.Progress.linear        : Int -> Progress msg   -- determinate; value required
Ui.Progress.circular      : Int -> Progress msg
Ui.Progress.indeterminate : Shape -> Progress msg -- already exists; only no-value path
-- remove withValue and the ambiguous "determinate without value" state
withMax : Int -> Progress msg -> Progress msg     -- keep
```

- Playground previews `indeterminate` (animated) for both shapes, or a fixed sample value.

---

## 8. Ui.Search — Bucket A (now in scope)

**Finding:** same silent-no-op disease. Its own docs admit `withClearable` is "a no-op when
items are present," and `withDefaultOpen` / `withExplicitOpenState` are "silently dropped in
SearchBar mode." The bar-vs-view mode is *inferred* from `withItems` presence.

> The original "clearable doesn't update until next keystroke" report is **not** a real-world
> case (Casey: "that's fine"); likely the m3e clear affordance only appears when the input has
> a value. Not fixing that; fixing the silent-no-op modeling.

**Decision (MISI):** explicit constructors so no setter is ever silently ignored:

```elm
Ui.Search.bar : Search msg                         -- SearchBar; withClearable valid; NO open-state
    |> Ui.Search.withClearable True
Ui.Search.withResults : List (Item () msg) -> Search msg  -- SearchView; open-state valid; NO clearable
    |> Ui.Search.withDefaultOpen True
-- shared: withId, withQuery, withPlaceholder
```

(Exact split — two constructors vs one constructor + a results setter that changes the type —
to be finalized in implementation; the requirement is: clearable only where it applies,
open-state only where it applies.)

---

## 9. Ui.Snackbar — Bucket A (deepest; "have both")

**Finding (authoritative, from `@m3e/web` `SnackbarElement.d.ts` + `Snackbar.d.ts`):**
`<m3e-snackbar>` is an **imperative singleton**, not declarative. It has a static
`M3eSnackbar.open(message, action?, dismissible?, options?)`, a static `current` (one at a
time), `duration` default **3000ms** auto-dismiss, an `actionCallback`, and **no `open`/`show`
attribute**. So `Ui.Snackbar.view : … -> Html msg` models an imperative/transient thing as
inline HTML — which is why it doesn't show in `/play` and wouldn't reliably show in a real app.

**Feasibility (confirmed in repo):** port-driven effects are idiomatic here (`Effect.fromCmd`,
`Effect.domFocus`), and third-party elements are already wrapped in custom-element shims
(`src/js/custom_elements/avt-flatpickr.js`, `floating-tooltip.js`, `floating-menu.js`); a
popover polyfill exists (`src/js/stateless.js`).

**Decision: have BOTH, sharing one builder.** `Ui.Snackbar` stays the *description* builder
(message, action, dismissible, closeLabel, duration) — single source of truth. Two presentations:

1. **Imperative (honest default):** `Ui.Snackbar.show : Snackbar msg -> Effect …` (or
   `Effect.showSnackbar`) encodes config to a port → `M3eSnackbar.open(...)`. Fire-and-forget
   toasts ("Saved", "Undo").
2. **Declarative (state-driven):** `Ui.Snackbar.view : Snackbar msg -> Html msg` renders our
   own `<avt-snackbar>` wrapper (avt-flatpickr pattern) that drives the underlying element
   open on connect/attr-change. Elm owns visibility via `Maybe` state. **The playground uses
   this path** with a "Show snackbar" trigger.

**Caveats for the doc/impl:**
- The imperative `actionCallback` is JS → the "Undo" handler needs a **port round-trip** back
  to a `msg` (subscription).
- `<m3e-snackbar>` is a hard **singleton** (`static current`) → two declaratively-rendered
  snackbars can't be visible at once; the wrapper must reconcile with the singleton.
- `withCloseLabel` is only meaningful with `withDismissible True` (moot once it's an options
  record on the builder).

---

## 10. Cross-cutting — generator can't express runtime data

One root cause behind four Bucket-B bugs (tristate value, multiSelect/filterChips options,
progress value, snackbar trigger). **Durable fix:** extend the `@figma-code-connect` annotation
grammar (and BOTH generators + `code-connect/lib.mjs`) with **sample/demo data**:

- sample options for select-family (`Ui.Field.singleSelect`/`multiSelect`),
- a synthetic value axis for tristate / progress,
- an imperative-trigger marker for snackbar (renders a "Show" button in the playground).

One generator feature → fixes tristate, selects, progress, and snackbar demos at once, and
keeps Figma Dev Mode + `/play` in sync. Regenerate `generated/Play/UiCatalog.elm` after.

---

## elm-review rules to add (`review/src/`)

- **`Badge.label (String.fromInt …)` → `Badge.count …`** (see §2).
- *(Consider)* a rule discouraging a no-action `Ui.Button` that isn't explicitly disabled
  (replaces the removed `resolveDisabled` silent inference, §3).

## Verification checklist for the implementation session

- [ ] Browser-verify Card layout in `/play/builder` (and whether it's app-wide). (§4)
- [ ] Browser-verify the `<avt-snackbar>` wrapper actually shows + auto-dismisses. (§9)
- [ ] After any annotation change: regenerate catalog, run `figma:check`, run
      `npm run build:elm`, `npm run format:elm`, `npm run elm-review -- --fix-all-without-prompt`.
- [ ] Audit all call sites for Avatar/Badge/Button/Chip/Progress migrations.

## Decision log (resolved with Casey)

- Avatar: 3 constructors; `withContent` internal + approval comment.
- Badge: collapse to M3 (dot + count/label), no size; `999+` truncation inside `Ui.Badge.count`;
  elm-review rule for count.
- Button: single `Button msg` type (NO phantom types); `labeled`/`iconOnly` constructors with
  the **variant in the constructor record** (distinct `LabeledVariant`/`IconVariant` types);
  iconOnly a11y label required; add Size; explicit action (no auto-disable); FAB/group/segmented
  take `List (Button msg)` and mix kinds freely; no toggle (→ Field); loading = known gap.
- Card: playground/preview issue; verify in browser.
- Chip: kill `basic`; per-kind constructors; add outlined/elevated; typed sets; no per-instance
  color; `assist`/`suggestion` support `withHref` (link behavior).
- Field: synthesize sample data; tristate value knob; narrow inputs fixed in playground (A).
- Progress: MISI — value required; `indeterminate` is only no-value path; drop `withValue`.
- Search: in scope; explicit constructors; kill silent no-ops.
- Snackbar: have both — shared builder + imperative Effect + declarative `<avt-snackbar>` wrapper.

## Still open (resolve during implementation)

- Button: internal action representation — separate `onClick`/`href` fields with last-write-wins,
  or a single `Maybe Action` field. Behavior is the same; pick whichever is cleaner to read. (§3)
- All decisions from the discussion are otherwise resolved (see Decision log).
