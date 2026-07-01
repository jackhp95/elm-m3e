# Structural blueprint — mirror matraic's m3e docs

> Captured 2026-07-01 from **https://matraic.github.io/m3e** (static HTML). Our docs
> app should render **structurally near-identical** HTML to this reference — same
> `<m3e-*>` component patterns and slot usage — while: (1) content is about **Elm +
> our API**, (2) layout uses **Tailwind utilities, not the site's custom CSS**, and
> (3) **custom layout elements are used only when essential** — prefer real m3e
> components so the docs *are* the showcase.

## The shell (→ `app/Shared.elm`)

```
m3e-theme[strong-focus]
  m3e-app-bar
    icon-button[slot=leading, toggle]         -- hamburger
      icon[name=menu] · icon[slot=selected, name=menu_open]
      drawer-toggle[for="nav-drawer"]          -- CANONICAL toggle (no Elm round-trip)
    span[slot=title]                           -- title-text + version chip
      span(title text) · m3e-chip(version)
    span[slot=trailing]                        -- npm / github / settings
      icon-button(link) + m3e-tooltip … · icon-button[toggle] + drawer-toggle[for="settings-drawer"]
  m3e-drawer-container[start, start-mode=auto, end-mode=auto]
    m3e-nav-menu[id="nav-drawer", slot=start]
      m3e-nav-menu-item[open]                  -- a GROUP
        icon[slot=icon] · span[slot=label](group title)
        m3e-nav-menu-item                      -- a LEAF (nested)
          icon[slot=icon] · a[slot=label, href="…"](link text)
    main(content)                              -- our routed page body → drawer default slot
    div[slot=end]                              -- SETTINGS live in the drawer END slot
      m3e-heading + m3e-segmented-button > m3e-button-segment(+icon) + input[type=color]
```

**Elm mapping:** `M3e.Theme` · `M3e.AppBar` (leading/title/trailing) · `M3e.IconButton` ·
`M3e.Icon` · `M3e.DrawerToggle` · `M3e.Chip` · `M3e.Tooltip` · `M3e.DrawerContainer`
(start + end slots) · `M3e.NavMenu` · `M3e.NavMenuItem` (group = `open` + `icon` slot +
`label`; leaf = `icon` slot + `label` as a `Kit.link href`) · `M3e.SegmentedButton` +
`M3e.ButtonSegment`. **Our earlier `Shared.elm` used a Native `<a>` nav + an app-bar
Card popover — both should become the real `nav-menu` hierarchy and an end-slot settings
drawer to match.** Nav leaves route via `Kit.link "/route"` (we route client-side; the
reference's `target="content-frame"` iframe is site-specific — drop it).

## A content page (→ every route body)

```
m3e-content-pane#body                          -- M3e.ContentPane wraps the page
  m3e-heading[variant=display size=large level=1]   -- page title
  p                                            -- intro prose (native)
  m3e-card[variant=outlined class=callout|install|showcase|example]
    m3e-heading[slot=header variant=title size=large]   -- card title
    p|pre|div[slot=content]                    -- card body: prose | code | a component row
  m3e-heading[variant=headline size=medium|small level=2|3]   -- section headings
  p (with inline <code>)                       -- section prose
  … repeat …
```

**Card idioms:** `callout` (heading + prose), `install` (`pre` code only), `showcase`
(`div slot=content` holding live components, e.g. five `m3e-button`s), `example` (`pre`
code). **The only native/custom elements are `p`, `pre`, `code`, and the occasional
grid wrapper** (`div.card-grid` → a Tailwind `grid` on a `Native.div`/`Layout` seam).
Everything else is a real component. That is the bar: if a page reaches for a custom
`Layout.*`/`Native.*` element where a `Card`/`Heading`/`ContentPane` would do, it's wrong.

**Elm mapping:** `M3e.ContentPane` (the page wrapper — replaces our `Layout.container`) ·
`M3e.Heading` (all headings, with `level`/`variant`/`size`) · `M3e.Card` (`header` +
`content` slots) · `Kit`/`Native` only for `p`/`pre`/`code`/grid, styled with Tailwind.

## Composition guidelines (derived here + from the CEM/config)

1. **A page = `ContentPane [ Heading(display,1), <intro p>, Card…, Heading(headline,2), … ]`.**
2. **Group related content in a `Card`** with `header` (a `Heading title`) + `content`.
3. **Live component demos go in a `showcase` Card's `content`** as a Tailwind-spaced row.
4. **Code goes in a Card `content` as `pre`** (an `example`/`install` Card).
5. **Reach for Tailwind (via a Seam/Native element) only for pure layout** a component
   can't express — grids, gaps, wraps — never for chrome a component provides.
6. **Nav is `NavMenu > NavMenuItem` groups+leaves**, never hand-rolled links.
7. **Settings/aux panels are the drawer `end` slot**, not floating cards.
8. **Slotted content must be an ELEMENT, never a bare `Kit.text`.** A slot value is
   stamped with `slot="…"` on its node; a text node can't carry an attribute, so it
   silently falls into the default slot and renders invisibly. Wrap text destined for a
   named slot in a `<span>` (`EscapeHatch.asElement (Native.span [] [ Kit.text … ])`) or
   use an element that already slots (`Kit.link → <a>`). (Bit us on the nav group labels.)

## Next (the epic)
Shell (`Shared.elm`) → content pages to the ContentPane/Card pattern → then the Studies
aligned to Material guidance (one by hand, the rest via ornith). Verified compositions
to mine: `m3e-docs/data/examples.json` + `guidance.json`.
