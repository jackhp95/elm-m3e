# Kit (docs/kit) — userland producers

**Copyable, NOT part of the published package.** These complete the composition
surface with things the library intentionally doesn't opinionate. Fork consumers
copy these (and adapt them) into their own app.

- **`Kit`** — `text`/`link` producers (slotted text needs a wrapper; navigation is a
  plain `<a>`). Carry the `text` / `link` kind.
- **`Native`** — native-HTML IR producers (`div`/`span`/`p`/`a`/`strong`/`ul`/`li`/
  `img`/…), carrying the `html` kind — normal HTML inside the composition.
- **`Seam`** — the single sanctioned userland boundary (see `docs/DESIGN.md` §4; #81): the
  loud, auditable break-glass built on the `*.Internal` modules. Lifts raw `Html`
  into the typed IR (`fromHtml`, `asElement`, `asAttribute`) and coerces phantom
  rows (`recast`, `recastAttr`). Collapses the former `EscapeHatch` into itself
  so there is exactly one crossing point.

Design rationale: `docs/DESIGN.md` §4. Built on the `M3e.*` library (`src/`); wired
into the repo's root + docs `source-directories`.
