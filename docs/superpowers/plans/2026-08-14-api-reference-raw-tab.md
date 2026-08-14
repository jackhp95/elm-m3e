# Implementation Plan — API reference section: the `Raw` (4th) tab from @m3e/web's CEM manifest (Phase 2)

Spec: `specs/2026-08-13-api-reference-reorg-design.md` (Phase 2 — the deferred `Raw` tab).
Repo: `elm-m3e` (docs app under `docs/`).
Prereq: Phase 1 is SHIPPED (merged `fd959c01`) — the 3 tabs `M3e | Components | Builder`
render today via `apiLayers`/`apiSection`/`apiTabStrip` in `Route/Components/Name_.elm`,
`Layers = { m3e, components, builder }` in `Doc/Data.elm`, and
`layers: { m3e, components, builder }` in `extract-reference.mjs`. This plan ADDS the 4th
`Raw` layer/tab on top of that shipped structure.

## Investigation summary (the spec's flagged unknown — RESOLVED)

The spec deferred `Raw` because the CEM (custom-elements-manifest) data source was
"genuinely unknown". Investigated; it is clean and mechanical:

- **Manifest exists and is standard.** Path (via `@m3e/web`'s `package.json` `customElements`
  field): `docs/node_modules/@m3e/web/dist/custom-elements.json`. `@m3e/web@2.7.3`, CEM
  `schemaVersion 1.0.0`, 459 modules, **130 custom elements** carrying a `tagName`.
- **Per-element shape is rich.** Each custom-element declaration exposes
  `attributes[]` (each `{name, type:{text}, default, description, fieldName, inheritedFrom}`),
  `events[]` (`{name, type:{text}, description}`), `slots[]` (`{name, description}`; default
  slot's `name` is `""`), plus `cssProperties[]` and internal `members[]`. Spot-checks:
  `m3e-button` → 14 attrs / 4 events / 5 slots; `m3e-checkbox` → 7/5/0; `m3e-tabs` → 6/3/4;
  `m3e-divider` → 4/0/0. The spec's mapping (CEM attribute→`attr`, CEM event→`event`, CEM
  slot→`slot`) is directly satisfiable — no ambiguity, no Elm signature needed.
- **slug → tag maps mechanically.** Docs slugs are collapsed-lowercase
  (`appbar`, `bottomsheet`); CEM tags are hyphenated (`m3e-app-bar`, `m3e-bottom-sheet`).
  Rule: strip the `m3e-` prefix, remove hyphens, lowercase → key. This matches **129 of the
  139 reference slugs**. The 10 non-matches are all correct non-matches:
  - 9 are barrel/infra modules that are not custom elements at all: `action`, `attributes`,
    `build`, `events`, `html`, `kind`, `m3e`, `unsafe`, `values`. Empty `raw` layer — correct.
  - `steppernext`: no `m3e-stepper-next` element exists in the manifest (only
    `m3e-stepper`, `m3e-stepper-previous`, `m3e-stepper-reset`). Empty `raw` layer — correct.
- **One editorial special case: `progress`.** The docs consolidate two elements
  (`m3e-linear-progress-indicator`, `m3e-circular-progress-indicator`) onto one `progress`
  page. Its slug matches neither via hyphen-strip. Handle it with a tiny explicit
  slug→tags override map (`progress → both indicators`), merging both elements' members
  (this is the ONLY entry the override needs today).

Conclusion: cleanly implementable. This plan reads the manifest in `extract-reference.mjs`,
emits a 4th `raw` member list per component, extends `Layers`/decoder with `raw`, and adds
the `Raw` surface to the API tab strip. `Doc.Usage.Surface` already has the `Raw`
constructor (label "Raw", used by Usage's own `HTML` tab), so no new surface is introduced.

## Out of scope / non-goals (respect Phase-1's boundaries)

- **Stays inside the existing API section** of `docs/app/Route/Components/Name_.elm`. No new
  route/page.
- **Reuses the shared tab widget** (`Usage.tabStrip`) and the shared/persisted
  `activeSurface` — adding `Raw` to `apiLayers` is the whole render change.
- **Keeps the semantic buckets** exactly (Constructor/Attributes/Slots/Events/Other). CEM
  attrs → Attributes, CEM events → Events, CEM slots → Slots. No Constructor/Other for Raw
  (custom elements have no ctor member), so those buckets simply stay empty on the Raw tab.
- **CSS custom properties are NOT surfaced** in this plan. The manifest carries them
  (`m3e-button` alone has 385), the docs already have a Styles/tokens surface, and dumping
  385 rows per component into the API section is noise. If wanted later, that is its own
  follow-up (a 6th bucket or a separate collapsible) — deferred, not part of Raw's semantic
  buckets here.
- **No CEM-sourced "types".** The spec left this optional; CEM `type.text` values are raw JS
  types (`boolean`, `Event`, union strings), not Elm aliases, so they do NOT feed the shared
  Elm Types block. Each Raw member carries its `type.text` inline as its "signature" instead
  (renders as `disabled : boolean`), which is enough. The shared Types block stays
  Elm-alias-only.

## Architecture

Three moving parts mirror Phase 1: extraction → decode → render.

1. **Extraction (`docs/scripts/extract-reference.mjs`).** Load and index the CEM by tag once
   at module top. In `moduleEntry`, resolve the component's tag(s) from its `slug`, pull the
   matching element declaration(s), and map their `attributes`/`events`/`slots` into
   `Member` records with `role` `attr`/`event`/`slot` (matching the `roleOf` vocabulary
   Phase 1's `apiGroups` already buckets on). Emit them as `layers.raw`. Unmatched slug ⇒
   empty `raw` list (correct for the 10 infra/sub-component slugs).

2. **Decode (`docs/src/Doc/Data.elm`).** `Layers` grows a `raw` field
   (`{ m3e, components, builder, raw }`); `layersDecoder` decodes `raw` with an empty-list
   fallback so a pre-Phase-2 `reference.json` still decodes. `members` accessor unions `raw`
   in too.

3. **Render (`docs/app/Route/Components/Name_.elm`).** `apiLayers` gains a 4th tuple
   `( Usage.Raw, "Raw", component.layers.raw )`. That single line makes `apiTabStrip` (which
   maps `apiLayers` to `(label, surface)` pairs) offer the 4th tab, and `apiSection`'s
   `activeSurface` filter select the raw layer when `Raw` is active. The Phase-1
   `Maybe.withDefault component.layers.m3e` fallback for `Raw` is removed (Raw is now a real
   entry). `memberRow` renders a Raw member as `name : type.text` with the CEM description as
   supporting text — no `memberRow` change needed (it already handles `kind == "value"` with
   a non-empty `signature`).

### Tech stack

- Elm 0.19 + elm-pages 3.5 (docs app). Render in `TypedHtml`/`M3e.*`.
- Node ESM extraction (`docs/scripts/extract-reference.mjs`), run via `npm run gen:reference`
  (`docs/package.json` `gen:reference`).
- Build: `npm run build:site` (in `docs/`). Format: `docs/node_modules/.bin/elm-format`.
- Data artifact: `docs/data/reference.json` (regenerated; consumed by `Doc.Data.allComponents`).
- CEM source: `docs/node_modules/@m3e/web/dist/custom-elements.json` (read at extraction time,
  not vendored — it ships in the installed `@m3e/web` package the docs already depend on).

### CEM member-mapping strategy (deterministic)

For a component with resolved tag `t` (declaration `d` from the manifest):

- `d.attributes[]` → one `Member` each: `{ name: a.name, kind: "value", signature:
  a.type?.text || "", doc: a.description || "", role: "attr" }`.
- `d.events[]` → `{ name: e.name, kind: "value", signature: e.type?.text || "", doc:
  e.description || "", role: "event" }`.
- `d.slots[]` → `{ name: s.name || "(default)", kind: "value", signature: "", doc:
  s.description || "", role: "slot" }`. (Default slot's manifest `name` is `""`; render it
  as `(default)` so the row is not blank.)

Order within each kind = manifest order (stable, authored). Concatenate attrs, then slots,
then events (buckets re-group by `role` in the render anyway, so concat order only sets
intra-bucket order). No `ctor`/`other` roles are produced.

## Steps

Each step ends with format + a build/extraction check as noted. Run all commands from
`docs/` unless stated. `[tier: opus/medium]`.

---

### Step 1 — Extraction: read the CEM, emit a `raw` layer (`docs/scripts/extract-reference.mjs`)

**1a. Load + index the manifest by tag, once at module top.** Near the other one-time
module-level setup (e.g. right after `const barrelSlice = barrelSliceByOwner();`, ~line 190),
add:

```js
// The @m3e/web custom-elements-manifest (CEM). Its declared path is the package's
// package.json `customElements` field: dist/custom-elements.json. Standard CEM 1.0.0 —
// each custom-element declaration carries `tagName` + attributes/events/slots. Indexed by
// tagName so the per-component `raw` layer (Phase 2 / Raw tab) can look an element up by the
// component's slug. (spec: 2026-08-13-api-reference-reorg §Phasing — Raw tab.)
const CEM_PATH = path.resolve(
  REPO,
  "docs/node_modules/@m3e/web/dist/custom-elements.json"
);
const cemByTag = new Map();
if (fs.existsSync(CEM_PATH)) {
  const cem = JSON.parse(fs.readFileSync(CEM_PATH, "utf8"));
  for (const mod of cem.modules || []) {
    for (const d of mod.declarations || []) {
      if (d.customElement && d.tagName) cemByTag.set(d.tagName, d);
    }
  }
} else {
  console.warn(
    `⚠ CEM manifest not found at ${path.relative(REPO, CEM_PATH)} — ` +
      `Raw tabs will be empty. (Is @m3e/web installed?)`
  );
}

// slug → CEM tag(s). The common rule: strip the `m3e-` prefix and hyphens, lowercase, and
// match against the docs slug (matches 129/139 slugs). A few docs pages consolidate multiple
// elements or have no element; the override map covers the only such component with a real
// element today (`progress` = both progress indicators). Slugs absent from both the stripped
// index and the override get an empty Raw layer — correct for infra/barrel modules
// (`action`, `html`, `m3e`, …) and sub-components with no own element (`steppernext`).
const cemTagByStripped = new Map();
for (const tag of cemByTag.keys()) {
  cemTagByStripped.set(tag.replace(/^m3e-/, "").replace(/-/g, ""), tag);
}
const CEM_SLUG_OVERRIDES = {
  // Docs `progress` page consolidates the two indicator elements onto one page.
  progress: ["m3e-linear-progress-indicator", "m3e-circular-progress-indicator"],
};
function cemTagsForSlug(slug) {
  if (CEM_SLUG_OVERRIDES[slug]) return CEM_SLUG_OVERRIDES[slug];
  const tag = cemTagByStripped.get(slug);
  return tag ? [tag] : [];
}
```

**1b. Map a CEM element declaration to `Member`s.** Add a helper near `membersOf`
(~line 364):

```js
// Map a CEM custom-element declaration's attributes/events/slots to reference `Member`s.
// CEM attribute → role `attr`, event → `event`, slot → `slot` (the same vocabulary the API
// section's apiGroups buckets on). There is no Elm signature — a member's `signature` is the
// CEM `type.text` (e.g. `boolean`, `Event`), its `doc` the CEM description. No ctor/other.
function cemMembers(decl) {
  const attrs = (decl.attributes || []).map((a) => ({
    name: a.name,
    kind: "value",
    signature: (a.type && a.type.text) || "",
    doc: (a.description || "").trim(),
    role: "attr",
  }));
  const slots = (decl.slots || []).map((s) => ({
    name: s.name || "(default)",
    kind: "value",
    signature: "",
    doc: (s.description || "").trim(),
    role: "slot",
  }));
  const events = (decl.events || []).map((e) => ({
    name: e.name,
    kind: "value",
    signature: (e.type && e.type.text) || "",
    doc: (e.description || "").trim(),
    role: "event",
  }));
  return [...attrs, ...slots, ...events];
}
```

**1c. Build the `raw` layer in `moduleEntry` and add it to `layers`.** In `moduleEntry`
(~line 392), after `m3eLayer` is computed (~line 420) and before the `return`, add:

```js
  // Raw layer: the underlying custom element(s)' CEM attributes/events/slots (Phase 2).
  // Empty for infra/barrel slugs and sub-components with no own element.
  const rawLayer = cemTagsForSlug(slug).flatMap((tag) => {
    const decl = cemByTag.get(tag);
    return decl ? cemMembers(decl) : [];
  });
```

and extend the returned `layers`:

```js
    layers: { m3e: m3eLayer, components: componentsLayer, builder: builderLayer, raw: rawLayer },
```

**1d. Extend the UI-guard loop + the member counter to include `raw`.** The phantom-`Ui.*`
guard iterates every emitted member (`extract-reference.mjs:507`); add `...c.layers.raw` to
its member spread so Raw members are scanned too:

```js
  for (const m of [...c.types, ...c.layers.m3e, ...c.layers.components, ...c.layers.builder, ...c.layers.raw]) {
```

and the closing `totalMembers` reducer (~line 524) gains `+ c.layers.raw.length`.
(CEM prose is @m3e/web's own; it will not contain `Ui.` — the guard is just kept complete.)

**Check:**

```
cd docs && npm run gen:reference
node -e "const d=require('./data/reference.json'); const b=d.find(c=>c.slug==='button'); const raw=b.layers.raw; console.log('button raw count:', raw.length); console.log('roles:', [...new Set(raw.map(m=>m.role))].join(',')); console.log('attrs sample:', raw.filter(m=>m.role==='attr').slice(0,4).map(m=>m.name+':'+m.signature)); console.log('events:', raw.filter(m=>m.role==='event').map(m=>m.name)); console.log('slots:', raw.filter(m=>m.role==='slot').map(m=>m.name));"
node -e "const d=require('./data/reference.json'); const p=d.find(c=>c.slug==='progress'); console.log('progress raw count (should merge both indicators):', p.layers.raw.length); const s=d.find(c=>c.slug==='steppernext'); console.log('steppernext raw (should be 0):', s.layers.raw.length);"
```

Expect: `button` raw has ~14 attrs / 4 events / 5 slots with roles `attr,slot,event`, attrs
like `disabled:boolean`, `variant:...`; events `beforeinput,input,change,click`; slots
`(default),icon,selected,selected-icon,trailing-icon`. `progress` raw is non-empty (both
indicators merged). `steppernext` raw is `0`. Spot-check `divider` (attrs-only, 0 events/slots)
and `card` (has slots).

---

### Step 2 — Decode: add `raw` to `Layers` (`docs/src/Doc/Data.elm`)

Read current: `Layers` (`Doc/Data.elm:31-32`), `layersDecoder` (`84-95`), `members`
accessor (`105-122`). Add the `raw` field.

**2a. Extend the `Layers` record** (`Doc/Data.elm:31-32`):

```elm
type alias Layers =
    { m3e : List Member, components : List Member, builder : List Member, raw : List Member }
```

Update the doc comment above it (`25-30`) to mention the 4th `raw` layer (the underlying
custom element's CEM attributes/events/slots).

**2b. `layersDecoder` (`map3` → `map4`)**, decoding `raw` with an empty-list fallback so a
pre-Phase-2 `reference.json` (three-layer) still decodes, and the legacy-flat branch fills
`raw = []`:

```elm
layersDecoder : Decode.Decoder Layers
layersDecoder =
    Decode.oneOf
        [ Decode.field "layers"
            (Decode.map4 Layers
                (Decode.field "m3e" (Decode.list memberDecoder))
                (Decode.field "components" (Decode.list memberDecoder))
                (Decode.field "builder" (Decode.list memberDecoder))
                (Decode.oneOf [ Decode.field "raw" (Decode.list memberDecoder), Decode.succeed [] ])
            )
        , legacyMembers
            |> Decode.map (\ms -> Layers [] (List.filter (\m -> m.kind /= "type") ms) [] [])
        ]
```

**2c. Union `raw` into the flat `members` accessor** (`Doc/Data.elm:122`) so barrel/all-
components consumers still see every member:

```elm
    dedupe (c.types ++ c.layers.m3e ++ c.layers.components ++ c.layers.builder ++ c.layers.raw)
```

**Format:** `node_modules/.bin/elm-format --yes src/Doc/Data.elm`. (Do not build yet —
`Name_.elm`'s `apiLayers` still omits `raw`; Step 3 adds it and removes the `Raw` fallback,
keeping the record exhaustive.)

---

### Step 3 — Render: offer the 4th `Raw` tab (`docs/app/Route/Components/Name_.elm`)

Read current: `apiLayers` (`Route/Components/Name_.elm:229-234`), `apiSection`
(`244-262` — note the `Maybe.withDefault component.layers.m3e` fallback comment at 253-255
that exists precisely because `Raw` had no tab), `apiTabStrip` (`288-292`), `apiGroups`
(`300-307`), `memberRow` (`333-355`).

**3a. Add the `Raw` entry to `apiLayers`** (`229-234`):

```elm
apiLayers : Doc.Data.Component -> List ( Usage.Surface, String, List Doc.Data.Member )
apiLayers component =
    [ ( Usage.Top, "M3e", component.layers.m3e )
    , ( Usage.Record, "Components", component.layers.components )
    , ( Usage.Build, "Builder", component.layers.builder )
    , ( Usage.Raw, "Raw", component.layers.raw )
    ]
```

Update its doc comment (`223-228`) — `Raw` is no longer Phase 2 / omitted; it now maps
`Usage.Raw → the CEM-sourced raw layer`.

**3b. `apiTabStrip` needs no change** — it already derives its `(label, surface)` list from
`apiLayers` (`290-292`), so the 4th tab appears automatically. Update its doc comment
(`284-287`) to say `M3e | Components | Builder | Raw` and drop the "Raw is Phase 2" note.

**3c. `apiSection`: the `Raw` entry is now real, so the fallback becomes a true default.**
The existing `Maybe.withDefault component.layers.m3e` (`255`) was a Phase-1 stopgap for when
`activeSurface == Raw` had no matching layer. With `Raw` in `apiLayers`, the filter now
matches `Raw` directly and the fallback only fires for a genuinely-unmatched surface (none
exist). Leave the `withDefault` as a harmless safety net but update the comment (`253-254`)
to note all four surfaces now match:

```elm
                -- Every Surface (Top/Record/Build/Raw) now maps to a layer; the
                -- withDefault is an unreachable safety net.
                |> Maybe.withDefault component.layers.m3e
```

**3d. `memberRow` needs no change.** A Raw member is `kind == "value"` with a non-empty
`signature` (the CEM `type.text`) → renders `name : type.text` (`341-345`), CEM description
as supporting text. A slot member has empty `signature` → renders just its `name`
(`(default)`, `icon`, …), which is correct. Verify by reading — do not edit.

**3e. `apiGroups` needs no change.** CEM roles are `attr`/`slot`/`event`, already bucketed by
the existing Attributes/Slots/Events groups (`300-307`). Constructor and Other stay empty on
the Raw tab (custom elements have no ctor/other member) and those empty groups drop out via
`apiGroup`'s `[] -> Nothing` (`315-317`). No new bucket.

**Format:** `node_modules/.bin/elm-format --yes app/Route/Components/Name_.elm`.

---

### Step 4 — Regenerate data + build the site

```
cd docs
npm run gen:reference          # re-extract with the 4th `raw` layer
npm run build:site             # elm-pages build + search index
```

`build:site` compiles Elm (catches the `Layers` record / decoder / render type changes) and
pre-renders every component page. Fix any compile error surfaced here before moving on. Do
NOT rely on the dev server for interactivity verification (see Step 5's caveat).

---

### Step 5 — Testing (spec §Testing + Phase-2 addendum)

> **MEMORY CAVEAT — verify interactivity on PROD, never dev.** The docs DEV server
> (`:1234`, elm-pages `npm run dev`) does NOT wire Elm event listeners onto SSR-hydrated
> `<m3e-*>` nodes — tab clicks appear dead there and that is a FALSE NEGATIVE. Test tab
> interactivity against the PROD build only (`:1239` gate).

1. **`raw` layer is non-empty and correct in `reference.json`** (Step 1 check). Acceptance:
   `button`'s `layers.raw` has its 14 CEM attributes, 4 events, 5 slots with the right roles;
   `divider` has attrs only; `progress` merges both indicators; `steppernext`/`action` are
   empty.
2. **The 4th tab renders.** From the built `dist` (or the pre-rendered HTML), confirm a
   component page's API tab strip shows FOUR tabs `M3e | Components | Builder | Raw` (Phase 1
   showed three). Spot-check across shapes: `button` (all three raw kinds), `divider`
   (attrs-only raw), `card` (raw slots), and one empty-raw slug (`steppernext` — its Raw tab
   renders with all buckets empty, i.e. the tab exists but shows no member rows).
3. **A spot-checked component's Raw tab lists the right CEM members.** On `button`'s Raw tab
   (PROD `:1239`, click `Raw`): the Attributes bucket lists `disabled`, `href`, `shape`,
   `size`, `variant`, … (`disabled : boolean`); the Events bucket lists `change`, `click`,
   `input`, `beforeinput`; the Slots bucket lists `(default)`, `icon`, `selected`,
   `selected-icon`, `trailing-icon`. Descriptions render as supporting text.
4. **Shared surface still moves all tabs (PROD `:1239`).** Clicking the API `Raw` tab moves
   every Usage example's tab to its `Raw`/`HTML` surface, and clicking a Usage `HTML` tab
   moves the API section to `Raw` — both read/write the single `activeSurface` (Phase-1
   behavior, now extended to the 4th surface).
5. **Types block unchanged.** The shared Elm Types block still renders once, above the tabs,
   Elm-alias-only (no CEM types leaked into it).

If a browser spec asserts the API strip has exactly three tabs, update that assertion to four
(note it; it is a one-line expected-count change, in-scope for this plan).

---

## Verification checklist (done-gate)

- [ ] Phase 1 (`fd959c01`) present: `apiLayers`/`Layers`/`layers` are the 3-layer shape before starting.
- [ ] `npm run gen:reference` succeeds; every component record carries `layers.raw` (non-empty for the 129 mapped slugs, empty for the 10 infra/sub-component slugs).
- [ ] `button.layers.raw` matches the manifest: 14 attrs / 4 events / 5 slots, correct roles (Step 1 check).
- [ ] `progress` merges both indicator elements; `steppernext`/`action` have empty `raw`.
- [ ] `npm run build:site` compiles clean (`Layers` `map4`, exhaustive record, render).
- [ ] Every touched `.elm` ran through `elm-format`.
- [ ] Component pages render FOUR tabs `M3e | Components | Builder | Raw` (Step 5.2).
- [ ] `button`'s Raw tab lists the right CEM attrs/events/slots with descriptions (Step 5.3), verified PROD `:1239`.
- [ ] API `Raw` tab click moves Usage tabs and vice versa (Step 5.4).
- [ ] Shared Elm Types block unchanged, Elm-alias-only (Step 5.5).
- [ ] No new route/page; shared tab widget + shared `activeSurface` reused; semantic buckets unchanged; CSS custom props NOT surfaced.

## Blast radius

- `docs/scripts/extract-reference.mjs` — reads the CEM (installed dependency, not vendored),
  emits `layers.raw`. `reference.json` schema gains one field per component's `layers`.
- `docs/src/Doc/Data.elm` — `Layers` gains `raw`; decoder `map4` with empty-list fallback
  (older three-layer artifacts still decode).
- `docs/app/Route/Components/Name_.elm` — one `apiLayers` tuple + three doc-comment updates;
  no new render function (the shared strip/section/memberRow absorb Raw unchanged).
- `docs/data/reference.json` — regenerated, committed.
- Any browser spec asserting a three-tab count → bump to four (Step 5).
- The other `reference.json` consumers (`Route.Guide.Reference`, `Components.All`, `Welcome`)
  read via `Doc.Data.members`, which now unions `raw` too — no signature change, they keep
  compiling; the barrel reference page simply sees the extra raw members folded in (dedup by
  name keeps duplicates out). If that page should NOT list raw CEM attrs, scope a follow-up —
  but the accessor's union is behavior-preserving for the per-component API page this plan
  targets.

## Dependency on a CEM version bump

`extract-reference.mjs` reads the installed `@m3e/web`'s manifest at generate time, so a
future `@m3e/web` bump automatically refreshes the Raw layer on the next `gen:reference` — no
code change. If a bump renames a tag such that the hyphen-strip rule stops matching a slug,
that slug's Raw tab silently empties; the Step 1 check (per-slug raw counts) catches it, and
the fix is a one-line `CEM_SLUG_OVERRIDES` entry. Worth a lightweight guard later (warn on
any nav slug whose `raw` is unexpectedly empty), but not required for this plan.
