# 5. Heterogeneous chrome slots stay `Html msg`

Date: 2026-06-24

## Status

**Superseded by [ADR 6](0006-m3e-architecture.md).** This ADR's decision —
"heterogeneous chrome slots keep `Html msg` as the primary type" — was made
before the introspectable IR + view-style model, which require **view once**
(the whole app composes as builder data, converting to `Html msg` only at the
root). A slot taking `Html msg` forces an early conversion, so heterogeneous
slots are now **phantom-row unions of valid child kinds** plus the slot-capable
`element` escape (ADR 6 §2, §4), not `Html msg`. The call-site heuristic below
("look at 3–5 call sites first") is retired in favor of the Material content
taxonomy. Kept for history.

## Context

[ADR 4](0004-styling-free-builders.md) says content slots prefer typed
builder inputs (with `EscapeHatchHtml` parallels) over opaque `Html msg`. A
naive read pushes that rule everywhere — including `AppBar.leading` and
`AppBar.trailing`.

When that conversion was attempted (`withLeading : Ui.IconButton msg`,
`withTrailing : List (Ui.IconButton msg)`), real call sites pushed back:

| Study | Leading | Trailing |
| ----- | ------- | -------- |
| Rally | a branded `span + Ui.Icon` ("savings" glyph) | `monthSelect` (Ui.Select) + `refreshButton` (Ui.IconButton) |
| Reply | a div-wrapped `Ui.IconButton` (for a menu anchor id) | `searchBar` (Ui.Search) + `notificationsButton` (Ui.IconButton) + `Ui.Avatar` |
| Shared (docs shell) | a `Ui.IconButton` (menu) | a quick scheme toggle (IconButton) + a settings *popover* (relative div + panel) + a github link (IconButton with `withHref`) |

Trailing is genuinely a mix of `IconButton`/`Search`/`Avatar`/`Select` and
the occasional positioned wrapper. Leading is sometimes a branded icon, not
an icon button.

## Decision

When a slot's semantic is **"arbitrary author content composed of multiple
builder kinds plus the occasional layout wrapper,"** keep it `Html msg` as
the PRIMARY type. Don't introduce an `EscapeHatchHtml` parallel — `Html` is
the natural shape, not an opt-out. Document the slot as accepting "composed
`Ui.*` builders via `|> view` plus whatever else the layout needs."

Applies to (so far): `Ui.AppBar.withLeading`, `Ui.AppBar.withTrailing`,
`Ui.Card.withMedia`, `Ui.Card.withBody`, `Ui.Card.withFooter`,
`Ui.NavigationDrawer.withContent`, `Ui.Stepper` panel content,
`Ui.SplitPane.with{Start,End}`.

This refines [ADR 4](0004-styling-free-builders.md) rather than contradicting
it: typed slots apply where the slotted alternatives form an enumerable set
the library should enforce (e.g. `Card.headline : Ui.Heading`,
`Card.actions : List Ui.Button`, `IconButton.icon : Ui.Icon`); arbitrary-
content slots stay `Html msg`.

## Consequences

- The `Ui.AppBar` typed-slot attempt was reverted; signatures remain
  `withLeading : Html msg -> AppBar -> AppBar` and
  `withTrailing : List (Html msg) -> AppBar -> AppBar`. The win that *did*
  land — IconButton's `withHref/withTarget/withRel/withDownload` — stands on
  its own and lets external-link buttons drop their `<a>` wrappers.
- Recipe for future per-builder API choices: look at 3–5 real call sites
  *first*. If they all reach for the same `Ui.*` builder type, type the slot.
  If they reach for different builder kinds (or include layout wrappers like
  popover anchors), keep `Html msg` as primary.
- This means F10's "convert opaque-Html slots to typed builder inputs" item
  is **bounded**, not universal. The slot-typing decisions that landed
  (Card.headline/subhead, Breadcrumb labels, Chip labels, IconButton.icon,
  the canonical typed-button-list slots like Card.actions, etc.) are the set
  the audit found genuinely enforceable.
