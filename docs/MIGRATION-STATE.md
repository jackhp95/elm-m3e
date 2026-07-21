# Migration State — elm-m3e docs app → phantom substrate

**Branch:** phantom-migration  
**Agent:** subagent:docs-app-finisher (sonnet, high effort)  
**Started:** 2026-07-20  
**Status:** COMPLETE ✅

## Gates

| Gate | Result |
|------|--------|
| 1. `elm make` full app compile | ✅ exit 0 (26 modules fixed) |
| 2. `pnpm run build:ci` (reference + elm-pages build) | ✅ exit 0 |
| 3. Playwright `146 passed` | ✅ 146/146 |
| 4. `Unsafe.fromHtml` shim count | ✅ 0 |

## What was done

### Phase 0–3 (prior agent)
- Rewired `elm.json` source-dirs to HtmlIr/TypedHtml substrates
- Migrated kit, layout, view, shared, error-page, src/Doc*, Route batch 1
- Bulk sweep of imports/tokens/arity across 49 files

### Phase 4 (prior agent, partial)
- Reduced from ~50 MODULE_NOT_FOUND → 26 modules with ~190 residue errors
- All residue: fused-barrel vocabulary (attr*, variant*, size*, slot*)

### Phase 5 (this agent — finisher)
All 26 modules with errors fixed:

**Residue class 1 — `M3e.attr<Pascal>` → `M3e.Attributes.<camel>`**
- `attrName`, `attrLevel`, `attrSelected`, `attrChecked`, `attrOpen`, `attrInset`
- `attrExtended`, `attrHref`, `attrMax`, `attrMin`, `attrStep`, `attrDiscrete`
- `attrLabelled`, `attrValue`, `attrOpticalSize`, `attrValueFloat`

**Residue class 2 — Fused enum setters → `M3e.Attributes.<attr> Value.<token>`**
- `variantFilled/Outlined/Tonal/Text/Elevated/Standard/Primary/PrimaryContainer`
- `variantDisplay/Title/Headline`
- `sizeSmall/Medium`
- `modeExpanded`

**Residue class 3 — Slot wrappers → per-component slot fns**
- `M3e.appBarSlot*` → `M3e.AppBar.*`
- `M3e.cardSlot*` → `M3e.Card.*`
- `M3e.listItemSlot*` → `M3e.ListItem.*`
- `M3e.navItemSlot*` → `M3e.NavItem.*`
- `M3e.fabSlot*` → `M3e.Fab.*`
- `M3e.searchBarSlot*` → `M3e.SearchBar.*`
- `M3e.assistChipSlot*` → `M3e.AssistChip.*`
- `M3e.slotIcon/Header/Content` → `M3e.Button.icon` / `M3e.Card.header` / `M3e.Card.content`

**Residue class 4 — Free-string icon name**
- `M3e.ariaLabel s` → `Aria.label s` (`import TypedHtml.Aria as Aria`)
- `M3e.attrName "icon-name"` → `TA.name "icon-name"` (`import TypedHtml.Attributes as TA`)
  - API gap: `M3e.Attributes.name` / `M3e.Icon.name` takes `Value ShapeName` (enum),
    not a free string. Material icon names are free strings — routed through
    `TypedHtml.Attributes.name` which is a raw string attribute setter.

**Residue class 5 — Other fixes**
- `Markup.M3e.text` → `M3e.text`
- `M3e.linear` → `M3e.linearProgressIndicator`
- `Native.node Html.input` / `Html.node "div"` → `Native.node "input"` / `"div"`
- `Element { ... } Msg` → `Element { ... } adm_ Msg` (missing third type arg)
- `type alias Row msg` → `type alias Row adm_ msg` (unbound type variable)
- `Value.Supported` → `HtmlIr.Kind.Supported`
- Duplicate `import M3e` removed from 6 files

**Build script fixes**
- `docs/scripts/extract-reference.mjs`: symlink HtmlIr/TypedHtml src into scratch
  package so `elm make --docs` finds them (the scratch project is `type: package`
  without source-directories; symlinks under `src/` are the only path)
- `docs/scripts/examples-gen/verify-examples.mjs`: add IR/TH dirs to `SRC_DIRS`

## Known pre-existing issue (out of scope)
- `build:examples-config` fails because generated examples reference `M3e.Html.*`
  (the Html layer) which doesn't exist in the phantom repo. The `build:ci` script
  skips this step and succeeds. Fix requires updating the example oracle/config.

## API gaps discovered and recorded

| Gap | Location | Workaround used |
|-----|----------|-----------------|
| `M3e.Attributes.name` / `M3e.Icon.name` takes `Value ShapeName`, not `String` — can't set Material icon names via typed API | `M3e/Attributes.elm`, `M3e/Icon.elm` | `TypedHtml.Attributes.name "icon-name"` (raw string attr) |
| `M3e.Html.*` layer absent from phantom src | generated examples only | N/A (pre-existing, not introduced here) |
