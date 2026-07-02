# Frictions — Settings example

> Note: the building agent was cut off by a session limit right before writing this
> file. This log was reconstructed from the committed code (which is elm-review-clean)
> and the friction notes the agent left inline as doc comments. It reflects real
> frictions hit while building, but is not the agent's own first-person account.

## 1. `NoMissingTypeExpose` vs. domain custom types in `Model`
Modelling the selected section and theme as custom types would force those types to
be **exposed** from the route module, because the `Model` alias is exposed and the
rule requires every type reachable from an exposed type to be public (the same
reason `RouteParams` is suppressed for every route). To keep the module's public API
to exactly what elm-pages needs, `section` and `theme` are held as `String` ids
instead. A presentational screen shouldn't have to widen its public API to use a
custom type internally. (Toggles *are* modelled as a `Toggle` custom type because it
lives only in `Msg`, which is already exposed.)

## 2. Phantom-row unification across a heterogeneous row list
A settings card mixes `ListItem` rows (`listItem` kind), interleaved `Divider`s
(`divider` kind), and occasionally raw layout (`html` kind). To hold them in one
`List`, they must share a single element type, so the code declares
`type alias Row msg = Element { html : Supported, listItem : Supported, divider : Supported } msg`
— the union of every capability any row needs — and relies on each producer's open
phantom row widening to fill it. This works, but the need to hand-author a union
"kitchen-sink" row type is non-obvious and easy to get wrong; a helper for
"heterogeneous children of a surface" would remove the papercut.

## 3. No natural slot for a full-width control inside `ListItem`
A density `Slider` wants to span the row, but `ListItem.trailing` is sized for a
compact control (switch/checkbox/icon). The workaround puts the full-width slider in
the `supportingText` slot with `Layout.class "w-full"` so it sits under the label.
It reads fine, but "a control that owns the row width" isn't a first-class `ListItem`
shape — a `ListItem` control/slot that spans would be cleaner.

## 4. `Avatar` needs a layout nudge to render inline
`Avatar.view` had to be given `Layout.class "flex"` (in `ListItem.leading`) to lay
out correctly — a small layout escape that shouldn't be necessary for a component
dropped into a documented slot.

## 5. Adaptive navigation is rendered twice
There is no single adaptive navigation component, so the rail (`NavRail`, desktop)
and the bottom bar (`NavBar`, mobile) are rendered as two separate trees, each
gated by Tailwind responsive-visibility (`hidden md:flex` / `md:hidden`). The item
list is shared via one `navItem` builder, but the double render + visibility hack is
boilerplate every full-app screen repeats. (Same friction reported by travel/mail/
dashboard/shop.) A `NavigationSuite`-style component that picks rail-vs-bar by
breakpoint would eliminate it.

## 6. Pinned mobile bar requires manual content padding
The mobile `NavBar` is `fixed inset-x-0 bottom-0`, so the scrolling content column
needs `pb-24 md:pb-6` to avoid being hidden behind it — a manual magic-number
offset. A bar that participates in layout (or reserves its own space) would avoid the
hand-tuned padding.

## Tooling
- The worktree lacked the gitignored `node_modules` (symlinked in by the parent) and
  `.elm-pages` (regenerated with `npm run build:assets && elm-pages gen`) — first-run
  setup that a fresh worktree always needs before `elm-review` can compile.
