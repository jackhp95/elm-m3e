# Dashboard example — frictions log

Screen: a full-viewport analytics dashboard (Aperture Analytics) with adaptive
nav chrome (NavRail desktop / NavBar mobile), a top AppBar, a KPI stat-card row,
an Accounts card grid, a Budgets card with linear Progress meters, and a Recent
Activity data table built from ListItem rows + Dividers. A Fab for a primary
action.

## Setup

- `npm run build:assets && ./node_modules/.bin/elm-pages gen` ran clean the
  first time (exit 0). No friction.

## Frictions

### 1. No `Element.toElement` — I reached for a wrapper that doesn't exist

My instinct was that nested component views (which return `Element { s | card : Supported }`,
`Element { s | navRail : Supported }`, etc.) needed to be "downcast" to a plain
`Element` before dropping them into a slot helper or a `Layout.div` child list. I
wrote `Element.toElement (...)` in ~14 places. It doesn't exist: a component `view`
already IS an `Element`, and every slot helper (`Card.content`, `AppBar.trailing`,
`ListItem.trailing`, …) takes `Element any msg`, so a specific-row element unifies
straight in.

This is really a *documentation/discoverability* gap, not a code gap — the mental
model "everything is already an `Element`, `any` absorbs any row" is correct once
you know it, but nothing in the module docs makes it obvious that you never convert
between element rows. A one-line note on `Element` ("component views return
`Element`s directly; slot helpers accept `Element any msg`, so you never convert")
would have saved a whole edit pass. The Rally starting file also used
`EscapeHatch.asElement` around a Progress bar inside a `ListItem.trailing`, which
reinforced the wrong idea that conversions are normally needed — they aren't.

### 2. Function return types must name the component row, and it's easy to guess wrong

Because there's no single "opaque Element" type, every helper's return annotation
has to name the right row kind: `Element { s | card : Supported }` for a card,
`{ s | navItem : Supported }` for a nav item, `{ s | listItem : Supported }` for a
list item, `{ s | html : Supported }` for a `Layout`/`Kit`/`Surface` box, etc. I
initially annotated several helpers as `{ s | html : Supported }` when they actually
returned cards/list-items, and had to correct each. The compiler catches it, but
you can't write the signature first without knowing the exact kind name each
component tags itself with (e.g. `appBar`, `iconButton`, `navRail`). A cheat-sheet
mapping component -> row-kind would help; right now you grep the module's `view`
signature to find the `{ s | <kind> : Supported }` tail.

### 3. Row unification in heterogeneous child lists — works, but non-obvious

`Layout.div`/`Native.div` take `List (Element s msg)` with a *single* `s`, so a
list mixing (say) `Kit.body` (`{ k | html }`), a `Progress.linear`
(`{ s | progress }`), and a `Divider.view` (`{ s | divider }`) only compiles
because the open records unify into one record carrying all those kinds. This is
correct and actually elegant, but it's surprising the first time — you'd expect a
"these have different types" error. Worth a docs example: "mixed-component rows in
one layout wrapper just work; the row accumulates every kind."

### 4. `NoMissingTypeAnnotationInLetIn` on a `let` binding whose type is opaque

A `let role = if … then Kit.primary else Kit.onSurface` binding tripped
`NoMissingTypeAnnotationInLetIn`. The fix requires annotating `role : TextColor`,
which means `Kit` must expose the `TextColor` type (it does) *and* the route must
`import Kit exposing (TextColor)`. Minor, but a reminder that the opaque color type
needs to be importable for local annotations — fine here, just an extra import.

### 5. Inherited `NoMissingTypeExpose` suppression on the route (elm-pages convention)

The route's exposed `route : StatefulRoute RouteParams …` references the private
`RouteParams` alias, which `NoMissingTypeExpose` flags ("Private type `RouteParams`
should be exposed"). This is baked into the elm-pages route-module convention
(templates expose only `ActionData, Data, Model, Msg, route`) and is already in the
elm-review baseline for essentially every route file, including this one before I
touched it. I left the inherited suppression as-is rather than change the route's
public API — exposing `RouteParams` would diverge from every other route and from
what elm-pages generates. Flagging it as a genuine library/convention tension: the
sanctioned elm-pages module shape is intrinsically at odds with
`NoMissingTypeExpose`, so route files can never be suppression-free without either
a rule exception or an API change. Not something the *example* should fix.

## Non-frictions (things that went smoothly)

- `Kit` / `Kit.Surface` / `Kit.Shape` / `Layout` covered every visual + layout need
  with zero reach for raw Tailwind color/typography/shape. `Surface.view role attrs
  kids` composing with `Shape.corner` and `Layout.class` on the same element is a
  clean pattern (used for the account tiles and the app shell background).
- Adaptive nav via `hidden md:flex` / `md:hidden` wrappers around `NavRail` /
  `NavBar` was straightforward; both take the same `NavItem` children so the
  destination list is shared.
- `Progress.linear [ Progress.value used, Progress.max max ] []` for budget meters
  and `Kit.colored [ role ]` around a trend `Icon` both did exactly what I wanted.

