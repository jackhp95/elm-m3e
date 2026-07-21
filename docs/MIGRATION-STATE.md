# Migration State — elm-m3e docs app → phantom substrate

**Branch:** phantom-migration  
**Agent:** subagent:docs-app-migrator (sonnet, high effort)  
**Started:** 2026-07-20

## What's done

### Phase 0 — Setup
- [x] Symlinked `/Users/jack/Documents/code/elm-m3e/docs/node_modules` → `docs/node_modules`
- [x] Copied `.elm-pages/` from main checkout into phantom docs
- [x] Updated `docs/elm.json` source-dirs:
  - Removed `../../elm-cem/markup/src`
  - Added `../../elm-html-intermediate-representation/src`
  - Added `../../elm-typed-html/src`

## Error count at phase start: ~50+ MODULE NOT FOUND errors

## Next step: Phase 1 — Mechanical import/type remapping across all 62 .elm files

## Key mappings discovered

| Old import | New import |
|---|---|
| `Markup.Element as Element exposing (Element)` | `HtmlIr.Element exposing (Element)` |
| `Markup.Node as Node exposing (Node)` | `HtmlIr.Node as Node exposing (Node)` |
| `Markup.Html.Attr exposing (Attr)` | `HtmlIr.Attribute exposing (Attr)` |
| `Markup.Kind.Shared` | `HtmlIr.Kind.Shared` |
| `Markup.Aria as Aria` | `TypedHtml.Aria as Aria` |
| `Markup.Atoms.text` | `M3e.text` |
| `Markup.Atoms` (import removed) | usages → `M3e.text` |
| `Markup.Attributes as Attrs` | `M3e.Attributes as Attrs` |
| `M3e.Token as Value` / `M3e.Token.Supported` | `M3e.Values` / `HtmlIr.Kind.Supported` |
| `M3e.Native.*` | `TypedHtml.*` / per-module |
| `M3e.Kind` | `M3e.Kind` (unchanged) |
| `M3e.Kind.Brand` | `M3e.Kind.Brand` (unchanged) |

## Shorthand attrs that are gone from barrel (must use per-component):

| Old `M3e.*` | New |
|---|---|
| `M3e.schemeAuto/Light/Dark` | `M3e.Theme.scheme M3e.Values.auto/light/dark` |
| `M3e.contrastStandard/Medium/High` | `M3e.Theme.contrast M3e.Values.standard/medium/high` |
| `M3e.attrColor s` | `M3e.Theme.color s` |
| `M3e.attrDensity f` | `M3e.Theme.density f` |
| `M3e.sizeSmall` | `M3e.AppBar.size M3e.Values.small` |
| `M3e.attrLevel n` | `M3e.Attributes.level n` (or `M3e.Heading.level`) |
| `M3e.variantDisplay` | `M3e.Heading.variant M3e.Values.display` |
| `M3e.variantTitle` | `M3e.Heading.variant M3e.Values.title` |
| `M3e.variantOutlined` | `M3e.Attributes.variant M3e.Values.outlined` |
| `M3e.variantFilled` | `M3e.Attributes.variant M3e.Values.filled` |
| `M3e.attrName s` | `M3e.Attributes.name s` |
| `M3e.attrHref s` | `M3e.Attributes.href s` |
| `M3e.attrTarget s` | `M3e.Attributes.target s` |
| `M3e.attrRel s` | `M3e.Attributes.rel s` |
| `M3e.attrChecked b` | `M3e.Attributes.checked b` |
| `M3e.attrOpen b` | `M3e.Attributes.open b` |
| `M3e.attrSelected b` | `M3e.Attributes.selected b` |
| `M3e.attrStart b` | `M3e.Attributes.start b` |
| `M3e.attrEnd b` | `M3e.Attributes.end b` |
| `M3e.startModeAuto` | `M3e.DrawerContainer.startMode M3e.Values.auto` |
| `M3e.endModeAuto` | `M3e.DrawerContainer.endMode M3e.Values.auto` |
| `M3e.appBarSlotTitle el` | `M3e.AppBar.title el` |
| `M3e.appBarSlotSubtitle el` | `M3e.AppBar.subtitle el` |
| `M3e.appBarSlotLeading el` | `M3e.AppBar.leading el` |
| `M3e.appBarSlotTrailing el` | `M3e.AppBar.trailing el` |
| `M3e.cardSlotHeader el` | `M3e.Card.header el` (TBC) |
| `M3e.cardSlotContent el` | `M3e.Card.content el` (TBC) |
| `M3e.navMenuItemSlotLabel el` | `M3e.NavMenuItem.label el` |
| `M3e.navMenuItemSlotIcon el` | `M3e.NavMenuItem.icon el` |
| `M3e.formFieldSlotLabel id el` | `M3e.FormField.label id el` (TBC) |
| `M3e.formFieldSlotHint el` | `M3e.FormField.hint el` (TBC) |
| `M3e.formFieldSlotDefault id el` | `M3e.FormField.default id el` (TBC) |
| `M3e.drawerContainerSlotStart el` | `M3e.DrawerContainer.start el` |
| `M3e.drawerContainerSlotEnd el` | `M3e.DrawerContainer.end el` |

## Kit/Seam changes needed

- `Seam.elm` (kit/): uses `Markup.Element.Internal`, `Markup.Html.Attr.Internal`, `Markup.Node.Internal`, `M3e.Seam.*` — all need to move to new IR
- `kit/Native.elm`: uses `M3e.Native` which is now `TypedHtml`
- `kit/Kit.elm`: uses old `M3e.Token`, `Markup.Element`, etc.
- `src/Layout.elm`: uses `Markup.Element`, `Markup.Html.Attr`

## Known sharp edges / API gaps found

- `M3e.Native.type_` (String → Attr) has NO direct equivalent; TypedHtml has no `type_` string setter. Need `M3e.Unsafe.fromHtml` or `HtmlIr.Internal` escape for `input[type=color]` / `input[type=email]`.
- `Markup.Kind.Shared` → `HtmlIr.Kind.Shared` (different package/module name)
- Element arity: old = `Element supports msg`, new = `Element accepts admittedBy msg` (TWO phantom rows)
- `Node.toHtml` was `Markup.Node.toHtml`, now `HtmlIr.Node.toHtml`
- `Element.toNode` was `Markup.Element.toNode`, now `HtmlIr.Element.toNode`
- `Seam.recast` / `Seam.asElement` etc. reference `Markup.*Internal` — these need to be rewritten against HtmlIr.Internal

## Phase 2 status: NOT STARTED
