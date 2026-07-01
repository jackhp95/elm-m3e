# Overnight status — 2026-07-01 (night)

Morning handoff. Everything below is **committed and pushed to `main`** on both repos.

## Shipped tonight (verified, pushed)

1. **Ornith harness refit** (`scratchpad/ornith-agent.mjs`): prompt retargeted to the
   Vocab API (`view`, not `Comp.comp`); the single-file/signature-preserving constraint;
   a **signature-lock guard** (reverts + routes to the opus lane on exposed-signature
   drift; extractor tested); optional whole-project compile. Parked `ornith-migrate.mjs`.

2. **`M3e.Review.Facts`** generated (per-component valid enum tokens, required/multi
   slots) — the ADR-0012 substrate for the codegen-aware rules. Compiles; committed.

3. **Docs migration STARTED — the two hardest/most-instructive files are done:**
   - **`Shared.elm`** (the app shell, ~763 lines) — Theme/Card/AppBar/IconButton/
     SegmentedButton on real components; nav faithfully kept as a Native escape
     (`TODO(migrate)` — the `M3e.NavMenu`/`NavMenuItem` hierarchy needs a design call).
   - **`Route.Styles.Color`** — a fully-migrated **proof route** that nails down the
     repeatable pattern below.

## IMPORTANT correction to last night's read

The docs app is **uniformly on the old hand API** — *no* route compiled before, and my
earlier per-route "error counts" were unreliable (Elm caps reported errors, and the
`Shared` dependency error confounded them). Also key: the docs `Layout` module is
already **Element-based** (returns `Element`, built on `Native`), so each route's
Node/Element composition must be reconciled, not just its component calls. That's why
the blind sed pass backfired (reverted via git — the safety net worked).

## The route-migration cookbook (validated on Color.elm)

Per route, apply and compile:
1. **Imports:** add `import EscapeHatch`, `import Kit`; make the Element *type* and
   `Supported` visible: `import M3e.Element as Element exposing (Element)`,
   `import M3e.Value as Value exposing (Supported)`. Module renames per
   `docs/MIGRATION_OLD_TO_NEW.md` §3 (NavigationRail→NavRail, RadioButton→Radio, …).
2. **Heading:** `Heading.view { label = X, variant = V } [attrs]`
   → `Heading.view { content = Kit.text X } [ Heading.variant V, ...attrs ] []`.
   `Heading.level` takes a **String** now (`"1"`, not `1`).
3. **Card:** single mixed list → two lists `[attrs] [content]`; `Card.headline`→`header`,
   `Card.body [ els ]`→`Card.content (el)`.
4. **Divider:** `Divider.view []` → `Divider.view [] []` (two lists).
5. **IconButton:** `{ content = Icon.view [ Icon.name g ] [], ariaLabel = l } [attrs] []`
   (required-record shape; icon is the `content` field, 3 args).
6. **Node→Element composition:** `Node.text`→`Kit.text`, `Node.raw h`→`EscapeHatch.fromHtml h`,
   `Element.html h`→`EscapeHatch.fromHtml h`. Drop inner `|> Element.toNode`; convert
   once at the `View.body` boundary with `body = List.map Element.toNode [ … ]`
   (`View.body` is `List (Node msg)`; `Layout.*` return `Element`).
7. **Leaf-helper annotations:** open rows `Element { s | heading : Supported } msg` etc.
   (closed rows won't unify in mixed lists).
8. **Slot kinds:** typed slots want a specific kind (`AppBar.leading` wants `{iconButton}`,
   `AppBar.title` wants `{text}` so use `Kit.text`); coerce with `EscapeHatch.asElement`
   when you must place a wrapped element into a typed slot.

## Docs migration progress — 9 files done (all compile, committed)

**Done:** `Shared` (shell) + routes `Styles/{Color,Typography,Motion,Density}`,
`GettingStarted/{BrowserSupport,Overview,Installation}`, `Reference`.

**Reusable helper saved:** `scratchpad/route_migrate.py` — `migrate_common(s)` does the
safe cookbook transforms (imports, `Node.text`→`Kit.text`, `Node.raw`/`Element.html`
→`EscapeHatch.fromHtml`, `Node.element "X"`→`Native.node (Html.node "X")`,
`Node.rawAttr`→`Seam.asAttribute`, `Heading.level` Int→String, `Card.headline`→`header`,
`Divider.view []`→`[] []`, drop inner `|> Element.toNode`); `fix_headings(s)` does the
`Heading.view { label, variant }`→`{ content = Kit.text .. }` split. Then per file:
hand-fix Card two-list splits, add open-row annotations (`{ s | heading }` for headings,
`{ s | card }` for cards, `{ s | html }` for Layout/Native), and wrap `View.body` with
`List.map Element.toNode [ … ]`. Compile after each.

**Remaining routes** (same cookbook; a few have component-specific rebuilds):
- `Index` — Button `{label,variant}`→`[attrs][Button.child (Kit.text ..)]`; **Avatar**
  rebuild (new `M3e.Avatar` is `view [] [child]` with no `image`/`ariaLabel` — put a
  `Native.img` in the default slot + aria via `Seam`); Icon `{name}`→`[Icon.name ..]`; 2 Cards.
- `Styles/Shape` — **surface-don't-guess**: uses a `CemShape` enum module, `Shape.name`,
  and `Shape.attributes` (raw passthrough); the new `M3e.Shape` API differs. Needs a design call.
- `Studies` + `Studies/{Reply,Shrine,Rally,Crane,Settings}` — the app-clone demos (heavier).
- `Components/Name_` — the 375-site component showcase (largest).

A full elm-pages build + tunnel needs **all** routes green (elm-pages compiles every route),
so the tunnel is still gated on finishing the remaining ~8 files.

## Still teed up (not started)

- **Task #7** port the old review config off dead paths (it currently misfires — e.g.
  `NoMissingFacadeEntry` on `M3e.Progress`, surfacing a real gap: variant-group modules
  aren't in the barrel). Generalize `NoRawLayoutOutsideLayoutModule` → configurable Seam gate.
- **Task #8** the `ValidEnumValue` rule (`rule : List Fact -> Rule`, facts injected) —
  blocked on #7 + adding `../packages/m3e/src` to `review/elm.json` source-dirs; no
  `elm-test` binary here to unit-test it tonight.
