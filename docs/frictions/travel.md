# Frictions — Travel example app

Building a full-viewport trip-planning screen (adaptive nav rail/bottom bar, search
hero, category tabs, horizontal destination rails) from `M3e.*` + the kit. Every
friction below is specific to what actually got in the way.

## 1. `SearchBar` `input` slot forces a raw Html escape hatch

`SearchBar.view` requires `{ input : Element any msg }`, but there is no m3e text-field
/ input component that fits it — the only path is `Native.node Html.input [] []`, i.e. a
bare, unstyled HTML `<input>`. This is the one place the "m3e components as much as
possible" rule can't be honored: the search bar's *content* is hand-rolled HTML. It
works because `<m3e-search-bar>` styles its slotted input, but the discoverability is
poor — I only found the pattern by grepping `data/examples.json`, not from the type or
docs. A first-class `M3e.TextField`/`M3e.Input` (or a `SearchBar.input` convenience that
takes a placeholder/value/onInput) would remove the only Html import in the file.

## 2. No shape control on `Card` media — needed a `Surface` + `Shape.corner` block

The brief wants "shape-clipped media on the media block." `Card` has a `header` slot but
no media slot and no way to clip/round an inner region. Placeholder media therefore is a
`Surface.view <role> [ Shape.corner Shape.large, ... ] [...]` block placed in
`Card.header`. That works and is fully kit-driven (no Tailwind color/shape), but there is
no "media" affordance on `Card` itself, so the rounding is on my inner surface rather
than the card understanding it has media. A `Card.media` slot (or documented convention)
would help.

## 3. `AssistChip` requires an `action` even when the chip is purely decorative

The rating chip ("★ 4.9") is really a label, not an interaction. But
`AssistChip.view` requires `{ content, action }` where `action` is a non-optional
`Action` (click or link). I had to invent an `Action.onClick` target
(`SetDest Saved`) just to satisfy the type. A plain `Chip.view { content }` exists and
is optional-action, but `Chip` puts the star in a less prominent spot; `AssistChip`
reads better as a rating pill. Net: a decorative chip is forced to be interactive. An
`Action.none` (or optional action) would fix this.

## 4. `NavRail` / `NavBar` share `NavItem` but differ only by responsive wrapper

`NavRail` and `NavBar` both take `NavItem` children with an identical shape, so the rail
item and bar item builders are byte-for-byte identical except for which component wraps
them. To swap rail↔bar responsively I wrap each in a `Layout.div "hidden md:flex"` /
`"md:hidden"`. That means the whole nav (and its `NavItem` list) is rendered twice into
the DOM, one copy hidden at every breakpoint. There is no single adaptive-navigation
component that picks rail vs. bar itself, so the duplication + responsive-visibility hack
is the only route.

## 5. Horizontal rails: `overflow-x-auto` is fine, but card width must be Tailwind

The rails are `flex gap-4 overflow-x-auto` (allowed layout Tailwind). Cards must not
shrink, so each is wrapped in `w-56 shrink-0`. Sizing a card is layout, so this is legal
under the rules, but it's a reminder that `Card` has no intrinsic sizing knob — width is
entirely the caller's Tailwind. Fine for this brief; worth noting the component is fully
size-agnostic.

## 6. `NoMissingTypeExpose` fights domain enums in `Model`

I modeled nav destination and category as custom types (`Dest`, `Category`) inside
`Model`. Because `Model` is exposed, `NoMissingTypeExpose` demands the nested types be
exposed too, and the file's suppression baseline (inherited from the old "Crane"
content) only allowed **1** error (`RouteParams`). Adding two enums blew past the
allowance. Fix without new suppressions: add `Dest` and `Category` to the module's
`exposing (...)` list. Slightly odd for a leaf route to export its private enums, but
it's the rule-clean path. The sibling routes (`Dashboard`, etc.) dodge this only because
their `Model` is `{}`.

## 7. `Native.node` takes m3e `Attr`, not `Html.Attribute`

`Native.node` / `Native.div` want `List (Attr c msg)`, so any layout class on a native
element goes through `Layout.class` (or `Seam.asAttribute (Attr.class ...)`). Minor, but
easy to trip on: you can't pass `Html.Attributes.class` directly, and `Layout.class` is
the ergonomic wrapper — not obvious until you read `Layout.elm`.

## Tooling notes

- One-time setup (`npm run build:assets && elm-pages gen`) worked first try; regenerating
  after the `Model`/`Msg` change was a no-op for route wiring since `RouteParams` was
  unchanged.
- `elm-review` is the compile gate here; it surfaces both type errors and lint. Final run
  is clean ("I found no errors!") with no new suppressions.
