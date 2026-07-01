# Overnight status — matraic-matching pass (night 2, 2026-07-01)

Tunnel (rebuilt after every change): **https://lounge-guardian-posts-parcel.trycloudflare.com**
All work committed + pushed to `main`. Reference blueprint: `docs/M3E_DOCS_STRUCTURE.md`.

## Done tonight — converging the docs on matraic.github.io/m3e

**Shell (`app/Shared.elm`)**
- Nav is the real `m3e-nav-menu > m3e-nav-menu-item` hierarchy (groups w/ icon slot +
  label, leaves = `Kit.link`), matching the reference (was a Native `<a>` punt).
- **Bug fixed at the library layer:** applying an attribute to a *text node* now
  promotes it to a `<span>` (`M3e.Node.addAttr`), so slotted text (e.g. nav group
  labels) renders `<span slot="label">…</span>` automatically — no userland wrapping.
  (Regenerated; `elm-cem` runtime + `packages/m3e` both committed.)
- Page-body wrapper padding trimmed `py-10/px-12` → `py-2/px-2` (ContentPane already
  pads; matraic's `#body` just has `margin-inline: 1rem`).

**Content pages**
- Every page wrapped in real `m3e-content-pane` (was custom `Layout.container`/`div`).
- **Typography now matches matraic:** prose is body-large (bumped `text-body-md`→`lg`);
  inline `code` + `pre` are `0.875em` with a subtle `surface-container-low` tint +
  primary text (base rules in `style.css`, like matraic's `main.css`). Code/pre no
  longer carry the smaller conflicting `text-body-*` utilities.
- Section **dividers removed** — matraic separates with heading/card margins, not rules.

**Tooling / hygiene**
- Adopted `elm-format` after every `.elm` edit (docs/node_modules/.bin) — prevents the
  scripted-edit indentation breakage; banked to project memory.

## The remaining matraic gap — content demos → **showcase Cards**

The one structural difference left: matraic wraps live component demos in
`m3e-card class="showcase"` (a `div[slot=content]` holding the components) and code in
`m3e-card class="example/install"` (a `pre[slot=content]`). Ours still shows demos in
bare `Layout.div` grids. Converting them:
- Highest "showcase the components" value; also naturally tightens spacing.
- **Best done with your eyes on the tunnel** — it's per-page and visual, and I can't
  see pixels. The pattern per page: wrap the demo row in `Card.view [ Card.variant
  Value.outlined ] [ Card.content (Native.div "…grid…" [ demos ]) ]`; code samples in a
  Card `content` `pre`. Pages: Styles/{Color,Typography,Density,Motion}, Getting-Started.

## Layer notes (per your hint)
- Typography/spacing = **docs app** (CSS base + content classes); the components carry
  the type scale, we just stopped overriding it. Right layer.
- The text-node-slot fix = **library runtime** (M3e.Node) — it's a primitive-level
  correctness fix, so it lives there and now protects every consumer.
- If the per-component reference pages (`/components/:name`, currently stubbed) are
  restored, matching matraic's generated component pages (install card + usage +
  variants showcase) is a **data-driven/generator** concern — pull from the CEM/facts
  (`M3e.Review.Facts` + `m3e-docs/data`) rather than hand-writing 50 pages.

## Also still open (earlier)
- Studies (5) + Name_ + Shape are compiling **stubs** (rich views in git) → ornith.
- elm-review rules: `ValidEnumValue` (#8) on the shipped `M3e.Review.Facts`; port the
  old-era review config (#7).
