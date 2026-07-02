# Frictions — Shop example (e-commerce storefront)

Honest log of every friction hit while building `Route.Examples.Shop`, an
adaptive full-viewport storefront screen (NavRail/NavBar chrome, AppBar with a
cart Badge, FilterChipSet toolbar, responsive Card grid, Fab).

## Tooling / setup

1. **One-time gen is a hard prerequisite and slow to discover.** `elm-review`
   cannot compile the route until `.elm-pages/` exists, so a fresh worktree
   fails cryptically until you run `npm run build:assets && elm-pages gen`. The
   dependency between elm-review and the elm-pages codegen output is invisible
   unless you already know it. Not painful once known, but a real first-run trap.

2. **`elm-pages gen` is silent on success and verbose on failure**, so the only
   reliable "did the route actually type-check as a page?" signal is the exit
   code. I ran it via `&& echo OK || echo FAILED`. A one-line success summary
   would help.

## Component API surface

3. **`IconButton` has no `child`/default-slot helper — content is a required
   record `{ content : Element any msg }`.** Every other slotted component I
   used (`Card`, `AppBar`, `FilterChip`, `NavItem`) takes content through
   `Content` slot helpers, so the shape is inconsistent: `IconButton.view
   { content = Icon.view … } attrs []`. Easy to get wrong the first time because
   the icon lives in a *record field*, not the children list.

4. **`Icon.opticalSize` takes a `Float`, not a `String`.** Neighbouring size-ish
   attributes elsewhere (e.g. `IconButton.width`, `AppBar.size`, string enums)
   are strings, and `Icon.name`/`Icon.weight`/`Icon.grade` are strings too, so I
   reached for `opticalSize "48"` and got a type error. `opticalSize` being the
   lone `Float` in an otherwise stringly-typed icon API is a surprise.

5. **No ergonomic way to *place* a `Badge` relative to its anchor.** `Badge`
   exposes a `position` axis (above/after/…) and a `for` attribute, implying the
   host component wires it up. But an `IconButton` doesn't take a badge slot, so
   to get the classic "count on the top-right of the cart button" I had to build
   the overlay myself with a `relative` wrapper + `absolute` positioned span
   (layout Tailwind, which is allowed) around a bare `Badge.view`. Would love a
   sanctioned "badge-on-a-button" pattern (e.g. an IconButton badge slot, or a
   Kit helper) so this common e-commerce affordance doesn't need hand-rolled
   absolute positioning.

6. **`NavRail` / `NavBar` are just item containers — no built-in
   responsive-swap.** Adaptive navigation (rail on desktop, bottom bar on
   mobile) is a first-class Material pattern, but here it's two separate
   components that I show/hide with `hidden md:flex` / `md:hidden` and feed the
   *same* destination list to via two near-identical wrappers (`railItem` /
   `barItem`). It works cleanly, but the duplication and the manual visibility
   toggle are boilerplate a combined "adaptive navigation" helper could absorb.

## Elm-review fights

7. **`NoMissingTypeExpose` punishes a private domain type used in the exposed
   `Model`.** I first modeled categories as a proper `type Category = All |
   Apparel | …`. Because `Model` is exposed and references `Category`, the rule
   demanded `Category` be exposed too — and the baseline only allows the one
   unavoidable `RouteParams` suppression for this file, so my second occurrence
   broke the build. Rather than widen the module's public surface (or add a
   suppression, which is banned), I followed the sibling routes' convention and
   modeled the category as a `String`. This is a genuine downgrade in type
   safety (stringly-typed category, no exhaustiveness) forced purely by the
   lint + route-module-shape interaction. The route interface is fixed
   (`Model` must be exposed) so there's no clean escape short of a wrapper type.

8. **`NoRedundantlyQualifiedType` vs. `import Kit.Surface as Surface`.** Using
   the surface role as a record field type wrote `Surface.Surface`, which the
   rule rejects. Fix was `import Kit.Surface as Surface exposing (Surface)` so
   the type is unqualified while the role constructors stay `Surface.*`. Minor,
   but the natural first spelling is the one the rule bans.

## Pull toward Tailwind styling (resisted)

9. The absolute-positioned Badge overlay (#5) and the `sticky`/`pointer-events`
   Fab wrapper are the two spots where I most wanted "just a little" non-layout
   styling. I kept both strictly layout-only (positioning, pointer-events) and
   pushed all color/shape/typography through `Kit` / `Kit.Surface` /
   `Kit.Shape`. The `aspect-square` media tiles + `Kit.Shape.corner` combo
   worked well — shape via the kit, sizing via Tailwind — and is the cleanest
   example of the intended division of labor.

## What worked well

- `Kit.Surface.view role [ Shape.corner … , Layout.class … ] kids` is a great
  primitive: background + on-color + corner + layout compose on one element with
  no seam leakage. The product media tiles and the hero banner are both just this.
- `Card` header/content/actions slots mapped naturally onto media / name+price /
  price+add-button.
- `FilterChipSet` + `FilterChip.selected` + `onClick` bound to `String`
  categories was frictionless for the single-select filter toolbar.
