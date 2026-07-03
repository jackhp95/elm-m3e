# Action-unified behavior for clickable components

**Date:** 2026-07-03
**Status:** approved (design), implementation pending

## Problem

Clickable components (`Button`, `IconButton`, `Fab`, the chip family, `NavItem`,
`Tab`, `Step`, list items, …) can open a menu / dialog / bottom-sheet / fab-menu,
or toggle a nav-rail / drawer. In the DOM this is expressed by nesting an
**ActionElementBase** wrapper element around the clickable's *label*, e.g.

```html
<m3e-button><m3e-bottom-sheet-trigger for="share">Share</m3e-bottom-sheet-trigger></m3e-button>
```

Today the type system permits this only by *widening* each host's content slot to
admit all 13 trigger/action kinds (`Button.unnamed = [text, icon, dialogTrigger,
menuTrigger, bottomSheetTrigger, …]`) and making the caller **manually nest**
`M3e.MenuTrigger.view [ M3e.MenuTrigger.for "x" ] [ label ]`.

Two smells:

1. **Manual nesting** — callers must know the wrapper element exists and nest it.
2. **Dishonest, over-wide content types** — `Button.child` claims to accept 13
   kinds, and nothing prevents a button from carrying *both* an `onClick` **and** a
   wrapped `menu-trigger` (two conflicting "what happens on activate" behaviours).

## Decision

Model **all** "what happens on activate" as the existing `M3e.Action` value,
extending its stated invariant (it already enforces click-XOR-link structurally).
The clickable component **auto-emits** the required wrapper element around its
label; content slots tighten back to honest kinds (`[text]` / `[text, icon]` /
`[icon]`). This unifies every clickable's API on the `{ content, action }` record
shape that `AssistChip` already uses.

Chosen over the alternative *pipe-transform* (`view […] […] |> Action.opensMenu "x"`)
because the record/`Action`-field form: is consistent with the existing AssistChip
precedent, enforces exactly-one-behaviour by type, keeps content honestly typed,
and reads uniformly across all clickables. (User directive: "best solution, not the
easiest"; big generator changes acceptable pre-release.)

## Faithful DOM

`wrapContent` produces byte-for-byte the same element the manual nesting produced;
label content and sibling icon slots are unchanged. Only the *authoring* surface
changes.

## Changes

### 1. `M3e.Action` (runtime template `elm-cem/runtime/M3e/Action.elm`)

Add payload variants and capability-typed constructors:

- `opensMenu : String -> Action { c | opensMenu : Supported } msg` → wraps label in
  `<m3e-menu-trigger for=id>`.
- `opensDialog` (`m3e-dialog-trigger for`), `opensFabMenu` (`m3e-fab-menu-trigger for`).
- `opensBottomSheet : String -> …` and `opensBottomSheetWith : { for, detent : Maybe Float, secondary : Maybe Bool } -> …` (`m3e-bottom-sheet-trigger`).
- `togglesNavRail` (`m3e-nav-rail-toggle`), `togglesDrawer` (`m3e-drawer-toggle`),
  `datepickerToggle` (`m3e-datepicker-toggle`) — no `for` payload where the element takes none.
- Container-action side: `dialogAction : { returnValue : String } -> …`
  (`m3e-dialog-action return-value`), `bottomSheetAction` (`m3e-bottom-sheet-action`),
  `richTooltipAction` (`m3e-rich-tooltip-action`), stepper `reset`/`previous`.

New function alongside `toAttrs`:

```elm
wrapContent : Action capability msg -> Node msg -> Node msg
```

- Identity for `OnClick` / `Link` / `Remove` (their behaviour is host attributes via `toAttrs`).
- For each trigger/action variant, builds the wrapper node via
  `M3e.Node.fromComponent (\erased ch -> M3e.Cem.<Wrapper>.<wrapper> (List.map Attr.forget erased) ch) [ <wrapper attrs> ] [ labelNode ]`.

`toAttrs` returns `[]` for the wrapper variants (their attributes live on the
wrapper, not the host). Click/link/remove keep their current host-attribute output.

### 2. Generator (`elm-cem/codegen/Generate.elm`)

- Extend the `action:` config vocabulary (`actionCaps`) so the capability row can
  carry the new tokens (`opensMenu`, `opensDialog`, …). No parser change needed —
  `actionCaps` already splits on `,`.
- In the `view` body for components with an action field, route the **`content`
  field node** (the required-singular `unnamed` slot) through
  `M3e.Action.wrapContent <actionField>` before it is prepended to the children.
  Today `reqStampedNodes` emits `Element.toNode content` for the unnamed slot;
  change that one path to `Action.wrapContent action (Element.toNode content)` when
  an action field is present.
- `suppressedAttrs` (href/target/rel/download) and the `click`-event drop already
  fire on `usesAction`; unchanged.

### 3. Config (`config/slots.json`) — narrow scope + Action.none

Scope was **narrowed** during implementation. A required `action` field with no
escape hatch was impossible because 57/58 button examples are action-less, and
container-managed clickables (Tab, Step, NavItem, chips that only select/remove,
etc.) have no standalone activation — a required action there would be dishonest.
Resolution: add a polymorphic `M3e.Action.none` no-op that fits any capability
row, and split the hosts into two groups.

**Group A — required `action` + full vocab** (the genuinely activate-able clickables):
Button, IconButton, Fab, AssistChip, SuggestionChip.

- Add `required: { action: "action:click,link,menuTrigger,dialogTrigger,fabMenuTrigger,bottomSheetTrigger,navRailToggle,drawerToggle,datepickerToggle,dialogAction,bottomSheetAction,richTooltipAction,stepperReset,stepperPrevious" }`.
  (Cap tokens are the `Action` capability record field names, not constructor names.)
- Make the `unnamed` slot `required: true, multi: false` (so it becomes the
  `content` record field the wrapper wraps). Fab was `multi:true` → `false`.
- Tighten `unnamed.kinds` to the **honest** set: `[text, icon]` for text hosts
  (Button), `[icon]` for icon-only hosts (IconButton, Fab), `[text]` for chips.
- Decorative call sites use `action = M3e.Action.none`.

**Group B — honest-tighten only** (no action field, arity unchanged): FilterChip,
InputChip, Tab, Step, ListOption, MenuItemCheckbox, MenuItemRadio, ButtonSegment,
NavItem, ListItemButton, BreadcrumbItem, BreadcrumbItemButton, ExpansionHeader,
TocItem. Strip the trigger/action kinds from all their slots but add no `action`
field — their activation is container-managed, not standalone.

**Left wide (escape hatch):** MenuItem, ListAction legitimately nest MenuTrigger /
BottomSheetAction in real examples, so their slots stay wide.

### 4. Examples (`config/examples.rich.json` + `examples.generated.json`)

Rewrite the affected examples from manual nesting to the action field, e.g.:

```elm
M3e.Button.view
    { content = Kit.text "Share", action = M3e.Action.opensBottomSheet "share-sheet" }
    [ M3e.Button.variant M3e.Value.tonal ] []
```

Both files carry the same strict-layer Elm per example: `examples.generated.json`
holds it as `code` (compiled by the probe, embedded in module docs);
`examples.rich.json` holds it as `top` (the docs-site Usage snippet, alongside the
unchanged `mid`/`bottom`/`html` layers). The two are kept identical example-for-example.

## Verification

- `elm-cem` regen → `packages/m3e` compiles green (~379 modules).
- `gen-probe.mjs` → `ExamplesProbe` compiles green (all 106 examples).
- A negative probe: passing a trigger element into a now-`[text]` content slot must
  FAIL to compile (proves the tightening bites).

## Risks / watch-outs

- **`multi:true` → singular** for icon-only hosts (Fab, IconButton): confirm each
  hosts exactly one label/icon; adjust per-component if a host legitimately holds
  multiple default children.
- elm-codegen 6.x infinite-type-loop on 2+ field required records is why `view`
  args stay unannotated (existing note at Generate.elm ~1976) — keep that.
- `Action.elm` gains imports on ~10 `M3e.Cem.*` wrapper bottom modules; acceptable
  (Action is core library, wrappers are generated siblings).
