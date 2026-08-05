# Spec E — Collapsing the `themed` wrapper onto the `m3e-theme` host

Date: 2026-08-05
Repo: `elm-m3e`
Status: approved design, not yet planned
Split out of: Spec B (`specs/2026-08-05-shared-elm-value-primitives-design.md`)
Sequenced after: Spec B — both change `Shared.elm`'s `view`, so they cannot run in parallel

## Why this is its own spec

This change arrived in the same working diff as the Spec B Values refactor, in the same
function, but it is a layout change with an entirely different risk profile. Bundling them
means a layout regression looks like a type-refactor bug. Spec B explicitly excludes it.

## What the change does

`view` currently has a `themed` helper that wraps children in `M3e.theme [...]` and performs
the single `M3e.toHtml` conversion, and then **each branch** supplies its own wrapper `<div>`
with its own class list:

- examples branch: `div.bg-surface.text-on-surface.h-dvh.overflow-y-auto`
- docs-shell branch: `div.bg-surface.text-on-surface.grid.h-dvh.grid-rows-[auto_1fr].overflow-hidden`

The proposed change deletes `themed` and both `<div>`s, hoisting one class list and the `dir`
attribute onto `M3e.theme` itself, with the branch reduced to an `if` selecting only the
*children*.

## Blocking problem: the two branches do not share a class list

The hoisted list is the **docs-shell** one:

```
bg-surface text-on-surface grid h-dvh grid-rows-[auto_1fr] overflow-hidden
```

Applying that to the examples branch changes `overflow-y-auto` → `overflow-hidden` and adds
`grid-rows-[auto_1fr]`. The deleted comment states exactly why that breaks:

> `h-dvh overflow-y-auto` makes each example its OWN bounded scroll region: the document
> (html/body) is fixed + non-scrolling for the stable mobile URL bar, so a full-viewport
> example must scroll itself rather than the document, or tall demos would clip.

So a tall `/examples/*` route loses its scroll region and **clips** instead of scrolling.
Additionally `grid-rows-[auto_1fr]` imposes a two-row grid on children that were authored as
plain flow content, so a multi-element example body would be laid out into rows it never
asked for.

Any version of this change must keep the class list **per branch**, not hoisted. That is
still compatible with deleting the wrapper `<div>` — the branch would select both the class
list and the children — but it is a different shape than the diff proposes.

## Second consideration: the host has `display: contents`

`@m3e/web` sets, in the shadow root:

```js
M3eThemeElement.styles = css`:host { display: contents; }`;
```

Putting `grid h-dvh overflow-hidden` on the host means relying on the CSS scoping rule that
normal declarations from the **outer** tree beat those from the shadow tree, so Tailwind's
`.grid { display: grid }` overrides `:host { display: contents }`. That is correct per spec
and will work today.

It is worth naming as a deliberate dependency rather than an accident, because the failure
mode is severe and silent: if a future `@m3e/web` marks that declaration `!important`, the
host stops generating a box and the entire app-shell layout collapses to flow content with no
compile error and no console warning. The current inner `<div>` does not have this coupling.

That is not on its own a reason to reject the change — hoisting removes a DOM node and reads
better — but it should be a conscious trade with a regression test pinning the shell's
computed layout, not an incidental consequence of tidying.

## Decided shape

**Remove the DOM node too** — hoist onto the `m3e-theme` host, accept the `display: contents`
coupling as a deliberate trade, and pin it with a regression test. The wrapper `<div>`s go
away; `themed` goes away; there is one `M3e.toHtml` call.

The one non-negotiable amendment to the original diff: **the class list stays per branch.**
The `if` selects both the class list and the children, not just the children:

```elm
{ title = View.title pageView
, body =
    [ let
        ( shellClass, children ) =
            if String.startsWith "/examples/" absolutePath then
                -- Full-viewport example routes own their scroll region: the document
                -- (html/body) is fixed + non-scrolling for the stable mobile URL bar, so
                -- a tall example must scroll ITSELF or it clips. Not the docs-shell grid.
                ( "bg-surface text-on-surface h-dvh overflow-y-auto"
                , View.body pageView
                )

            else
                -- Fixed-height, non-scrolling shell: `auto_1fr` pins the app bar while the
                -- 1fr content row (drawer + <main>) is the ONE scroll region.
                ( "bg-surface text-on-surface grid h-dvh grid-rows-[auto_1fr] overflow-hidden"
                , [ skipLink
                  , M3e.mapMsg toMsg appShellBar
                  , drawerShell toMsg model page sharedData.components (View.body pageView)
                  ]
                )
      in
      M3e.theme
        [ M3e.Theme.color model.seed
        , M3e.Theme.scheme model.scheme
        , M3e.Theme.contrast model.contrast
        , M3e.Theme.density model.density
        , TypedHtml.Attributes.dir model.dir
        , TypedHtml.Attributes.class shellClass

        -- The m3e-theme element's `density` prop/attr is NON-reactive, so the control has
        -- no effect unless we drive `--md-sys-density-scale` (which the m3e components
        -- read via density.calc) ourselves. Elm can't set a CSS custom property directly
        -- — `style` uses `node.style[key]=…` which ignores `--vars`, and
        -- `attribute "style"` gets clobbered on re-render — so it goes through a Tailwind
        -- arbitrary-property CLASS instead.
        , TypedHtml.Attributes.class (densityClass model.density)
        ]
        children
        |> M3e.toHtml
    ]
}
```

The two scroll-region comments must survive the refactor. They are the only record of why
these class lists differ, and the proposed diff deleted both while making the change they
warn against.

Note the two `class` attributes are intentional and already the existing pattern — the
density one is separate because it is a computed arbitrary-property class.

Both branches must still typecheck against `M3e.theme`'s children parameter
(`List (Element childAccepts (M3e.Theme.ChildAdmittedBy childAdm) msg)`). Binding both
branches to one `children` name in a `let` forces unification that the original two-call
structure did not require, so if the branches' element rows differ this will surface as a
compile error. If it does, keep the two `M3e.theme` calls and share only the class-list
selection — the DOM node is still removed either way.

## Verification (once the shape is settled)

- A `/examples/*` route with content taller than the viewport scrolls and does not clip, on
  desktop and on mobile viewport sizes.
- The docs shell still pins the app bar with the content row as the single scroll region; the
  mobile URL bar does not collapse on scroll.
- `dir="rtl"` still flips the shell.
- A regression assertion on the shell's computed `display` / `overflow`, so a future
  `@m3e/web` change to `:host` fails a test rather than silently reflowing the site.
- `npm run test:browser` green.
