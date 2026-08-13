# Implementation Plan — API reference section: 3 layer tabs + shared Types block (Phase 1)

Spec: `specs/2026-08-13-api-reference-reorg-design.md` (Phase 1 only).
Repo: `elm-m3e` (docs app under `docs/`).

## Prerequisites (this plan executes AFTER two other specs land)

This plan is sequenced **after**, not in parallel with, two smaller specs. Do not start
until both are merged:

1. **tab-sync** (`specs/2026-08-13-usage-tab-sync-design.md`). It replaces
   `Doc.Usage`'s `Model = { surfaces : Dict Int Surface }` with a single page-wide,
   persisted `activeSurface : Surface`; `SelectSurface` drops its `Int` index arg.
   **This plan wires the new API tabs against that single `activeSurface`** — an API-tab
   click and a Usage-tab click drive the SAME field. Build against `activeSurface`, never
   `Dict Int Surface`. If you are reading this and `Doc/Usage.elm` still has
   `surfaces : Dict Int Surface` / `SelectSurface Int Surface`, STOP — tab-sync has not
   landed and every step below that touches `Doc.Usage` will be wrong.

2. **naming-convention** (`specs/2026-08-13-component-api-naming-convention-design.md`).
   It renames each `M3e.Component.X` constructor `view` → `<name>` (`button`,
   `checkbox`, ...) and `el` → `required` in the elm-cem generator + regenerated
   `src/`, AND fixes `extract-reference.mjs`'s `roleOf` (line 308) to compare against the
   module's own lowercased base name instead of the literal `"view"`. **This plan's
   Constructor bucket therefore shows `button`/`required`, and its new extraction edits
   the SAME `extract-reference.mjs`.** Every `roleOf`/extraction edit below assumes the
   post-rename `roleOf` (matches `m.name === <lowercased base name>`, not `"view"`) is
   already in place — do not re-introduce or duplicate the `"view"` special-case.

Both are independent and small; landing them first is cheap and avoids reworking this
(larger) spec's tab-wiring and extraction.

## Goal

Give each component doc page's API section three layer tabs — **`M3e | Components |
Builder`** — reusing `Doc.Usage`'s `Surface` concept and the single shared/persisted
`activeSurface`. Pull the component's type aliases OUT of the Constructor bucket into a
new always-visible, un-tabbed **Types** block above the tabs. Extend
`extract-reference.mjs` with two more per-component member sources: the M3e barrel's
per-component slice (`src/M3e.elm`) and the Builder module (`src/M3e/Build/<Name>.elm`).

## Out of scope / explicitly deferred (Phase 2 — DO NOT touch here)

- **The `Raw` tab.** Phase 1 ships 3 tabs, not 4. Do not add a 4th tab, do not read or
  vendor `@m3e/web`'s custom-elements-manifest, do not add a CEM→role mapping. `Surface`
  already has a `Raw` constructor (used by Usage's `HTML` tab) — leave it alone; the API
  tab strip simply does not offer it.
- **Raw-layer "types".** The shared Types block is Elm-alias-only in Phase 1.
- **No new route/page** — everything stays inside the existing API section of
  `docs/app/Route/Components/Name_.elm`.
- **No literal-return-type grouping** — keep the existing semantic buckets
  (Constructor/Attributes/Slots/Events/Other) exactly.

## Architecture

Three moving parts, extraction → decode → render, plus a shared widget:

1. **Extraction (`docs/scripts/extract-reference.mjs`).** Today each component record
   carries one flat `members` array sourced only from `M3e.Component.<Name>`. Phase 1
   makes `members` **layered**: the existing array becomes the `components` layer, and two
   new arrays — `m3e` (barrel slice) and `builder` (`M3e.Build.<Name>`) — are added,
   each classified by the same `roleOf` + carrying `role`. Type aliases are lifted into a
   separate `types` array on the record (shared across layers).

   - **`components` layer** — unchanged source: the `M3e.Component.<Name>` module already
     exposed via the scratch package. This is today's `members`, minus the `type` members
     (those move to `types`).
   - **`m3e` layer (barrel slice)** — the barrel (`src/M3e.elm`) is already symlinked+exposed
     in the scratch project and appears in `docs.json` as module `M3e`. Its per-component
     slice is defined by BODY ownership: a barrel value belongs to component `<Name>` iff its
     body resolves to `M3e.Component.<Name>.<something>`. In practice this is exactly the
     constructor (`button = M3e.Component.Button.view` → post-rename
     `button = M3e.Component.Button.button`). See "Barrel-slice extraction strategy" below —
     this is the spec's flagged unknown; the strategy is a source-text body scan, not a
     `docs.json` walk (docs.json has no bodies).
   - **`builder` layer** — new source `src/M3e/Build/<Name>.elm`. Symlinked+exposed like the
     component modules; appears as module `M3e.Build.<Name>` in `docs.json`. Its `values`
     (`build`, `toElement`, `with*`, slot placers) classify through `roleOf` unchanged; its
     `aliases` (`Builder`, `AttrCaps`, ...) are `type` members → routed to the shared
     `types` block same as the Component layer's aliases.

2. **Decode (`docs/src/Doc/Data.elm`).** `Component.members : List Member` becomes a
   richer shape: `types : List Member` + `layers : { m3e, components, builder } : List Member`
   (a small record, decoded with graceful fallback so an older `reference.json` — flat
   `members` only — still decodes: fall back to `members` for the `components` layer, empty
   for the others, and derive `types` by filtering `kind == "type"`).

3. **Render (`docs/app/Route/Components/Name_.elm`).** `apiSection` gains: a Types block
   (un-tabbed, above), a tab strip driven by the shared `activeSurface`, and the
   selected-layer buckets below. `Top → m3e`, `Record → components`, `Build → builder`
   (label them `M3e | Components | Builder`). The page already threads `Usage.Model`
   as its own `Model` (`Route.Components.Name_:35-37`) — after tab-sync, that model carries
   `activeSurface`, so the API tabs read/write it directly. `SelectSurface` (post-tab-sync,
   no index arg) is the same Msg the API tabs emit.

4. **Shared tab-strip widget.** `Doc.Usage.surfaceTabs` (`Doc/Usage.elm:258-270`) is NOT
   reusable as-is: it closes over `UsageExample` (to compute `surfacesFor ex`) and emits
   `SelectSurface`. Factor a generic strip out (see Step 4) that both call sites use.

### Tech stack

- Elm 0.19 + elm-pages 3.5 (docs app). Render in `TypedHtml`/`M3e.*`.
- Node ESM scripts for extraction (`docs/scripts/extract-reference.mjs`), run via
  `npm run gen:reference` (`docs/package.json:9`).
- Build: `npm run build:site` (in `docs/`). Format: `docs/node_modules/.bin/elm-format`.
- Data artifact: `docs/data/reference.json` (committed; consumed by `Doc.Data.allComponents`).

### Barrel-slice extraction strategy (the spec's flagged unknown — RESOLVED)

**Finding from reading `src/M3e.elm`:** the barrel is a single FLAT module with no
per-component grouping and no comment markers. Its only per-component content is the
constructor, whose body is literally `= M3e.Component.<Name>.<ctor>` (verified: `button`
at `src/M3e.elm:297-302`, body `M3e.Component.Button.view`; post-rename this body becomes
`M3e.Component.Button.button`). Everything ELSE in the barrel is intentionally universal
and NOT per-component: the `slot*` placers (open-admittance, one flat set shared by all
components — bodies are `Ir.addAttribute (attribute "slot" "…")`, not
`M3e.Component.*`), and the IR helpers (`toHtml`, `lazy`, `key`, `mapMsg`, `text`, …).
`variant`/`elevated`/etc. from the spec's illustrative example do NOT live in the barrel at
all (they are `M3e.Attributes.*` / `M3e.Values.*`).

**Consequence:** the `m3e` layer for a component is a THIN slice — in practice the single
constructor value. That is correct and useful (it is the one-import surface the Guide
teaches), not a bug. Do not try to attribute slots or values to a component.

**Strategy (deterministic, body-based):** in `extract-reference.mjs`, read the barrel
SOURCE text (`SRC_M3E_BARREL`, already loaded by `barrelSource()`), and for each top-level
value collect `(name, ownerModule)` where `ownerModule` is the `M3e.Component.<X>` prefix
of its body's fully-qualified reference, if any. Match with:

```js
// name =\n    M3e.Component.<Owner>.<member>   (single-line re-export body)
/^([a-z][A-Za-z0-9_]*)\s*=\s*\n\s*M3e\.Component\.([A-Za-z0-9_]+)\.[a-z][A-Za-z0-9_]*\s*$/gm
```

Then the barrel slice for component `<Name>` = every barrel value whose `ownerModule`
base equals `<Name>`. Pull that value's SIGNATURE + DOC from the `M3e` module entry already
present in `docs.json` (so signatures stay type-checked, not regex-scraped) by name lookup.
This body-scan is the ownership signal; `docs.json` supplies the typed member data.

## Steps

Each step ends with format + a build/extraction check as noted. Run all commands from
`docs/` unless stated. `[tier: opus/medium]`.

---

### Step 1 — Extraction: add `builder` + `m3e` layers and lift `types` (`docs/scripts/extract-reference.mjs`)

**1a. Expose the Builder modules in the scratch package.**
`setupScratch()` (~lines 201-219) currently exposes `M3e.Component.*`. Add
`M3e.Build.*` the same way. After the `SRC_M3E_COMPONENT` block (~line 207), add:

```js
  // Builder modules (M3e.Build.*) — the pipe API surface for the Builder tab.
  const SRC_M3E_BUILD = path.join(SRC_M3E, "Build");
  const buildModules = fs.existsSync(SRC_M3E_BUILD)
    ? fs
        .readdirSync(SRC_M3E_BUILD)
        .filter((f) => f.endsWith(".elm"))
        .map((f) => "M3e.Build." + f.replace(/\.elm$/, ""))
    : [];
```

and add `...buildModules,` to the `exposed` array (~line 218, after `...componentModules,`).
(`M3e.Build` is a directory of already-symlinked modules — the `src/M3e` symlink at line 175
covers them; no extra symlink needed. Confirm `M3e.Build.*` compiles under `--docs`: each
Build module carries a full `@docs` block per `src/M3e/Build/Button.elm:9-14`.)

**1b. Build the barrel per-component ownership map.**
`barrelSource()` already reads the barrel text. Add a sibling exported helper that returns
`Map<ownerBaseName, Array<barrelValueName>>` using the body-scan regex from the strategy
section. Add near `barrelSource` (~line 167):

```js
// Barrel per-component ownership: each top-level barrel value whose body is a
// re-export `name =\n    M3e.Component.<Owner>.<member>` belongs to <Owner>.
// This is the barrel's ONLY per-component content — slot placers and IR helpers
// are universal and deliberately excluded. Keyed by lowercased owner base name
// (the component slug), value is the list of barrel value names (usually one: the
// constructor). (spec: 2026-08-13-api-reference-reorg §"Extraction gains 2 more sources")
function barrelSliceByOwner() {
  const src = fs.readFileSync(SRC_M3E_BARREL, "utf8");
  const byOwner = new Map();
  for (const m of src.matchAll(
    /^([a-z][A-Za-z0-9_]*)\s*=\s*\n\s*M3e\.Component\.([A-Za-z0-9_]+)\.[a-z][A-Za-z0-9_]*\s*$/gm
  )) {
    const [, valueName, owner] = m;
    const slug = owner.toLowerCase();
    if (!byOwner.has(slug)) byOwner.set(slug, []);
    byOwner.get(slug).push(valueName);
  }
  return byOwner;
}
```

**1c. Index the raw `docs.json` module entries by module name** so the builder + barrel
lookups can pull typed members. In the run section, after `modules = buildDocsJson();`
(~line 387), add:

```js
const modulesByName = new Map(modules.map((m) => [m.name, m]));
```

and thread `modulesByName` into `moduleEntry` (change its signature to
`moduleEntry(mod, modulesByName)` and update the `.map(...)` call at ~line 403 to
`.map((m) => moduleEntry(m, modulesByName))`).

**1d. Reshape `moduleEntry` output: split `types`, add `layers`.**
Inside `moduleEntry` (~lines 320-371), after the existing `members` array is built and
`roleOf`-classified (~line 348), split it and assemble the two new layers. Replace the
current `return { …, members }` (~lines 355-370) with a version that computes:

```js
  // Types (aliases/unions) are shared across the M3e + Components layers, so they
  // leave the per-layer bucket set and become a page-wide block. (Phase 1: Elm
  // aliases only; Raw-layer types are Phase 2.)
  const types = members.filter((m) => m.kind === "type");
  const componentsLayer = members.filter((m) => m.kind !== "type");

  // Builder layer: M3e.Build.<Name>'s own members (aliases → shared types; values
  // classify through roleOf unchanged). Absent module ⇒ empty layer.
  const buildMod = modulesByName.get("M3e.Build." + name.replace(/^Component\./, ""));
  // Pass `slug` as ctorName so `roleOf(m, ctorName)` (renamed per the naming-convention
  // plan — no longer special-cases the literal "view") still tags the ctor. Harmless for
  // the builder layer, which has no ctor-role member.
  const builderMembers = buildMod ? membersOf(buildMod, slug) : [];
  for (const t of builderMembers.filter((m) => m.kind === "type")) {
    if (!types.some((x) => x.name === t.name)) types.push(t);
  }
  const builderLayer = builderMembers.filter((m) => m.kind !== "type");

  // M3e barrel slice: barrel values owned by this component (see barrelSliceByOwner).
  const barrelMod = modulesByName.get("M3e");
  const ownedNames = new Set(barrelSlice.get(slug) || []);
  const m3eLayer = barrelMod
    ? membersOf(barrelMod, slug).filter((m) => ownedNames.has(m.name) && m.kind !== "type")
    : [];
```

where `membersOf(mod, ctorName)` is a small extracted helper (factor the existing
byName/ordered loop, ~lines 325-348, into `function membersOf(mod, ctorName)` that returns
the ordered member list, tagging each via `roleOf(m, ctorName)` — the 2-arg `roleOf` the
naming-convention plan introduced). The primary `members` array is `membersOf(mod, slug)`;
reuse the helper for `buildMod`/`barrelMod`, passing `slug` in every case (the barrel's
per-component ctor is named `slug` too, so its ctor still classifies correctly).
Compute `const barrelSlice = barrelSliceByOwner();` once at module top (near line 51) so it
isn't rebuilt per component.

Final record `return`:

```js
  return {
    name, module: mod.name, slug,
    category: override ? override.category : "",
    label: override ? override.label : name,
    summary: summary(over), overview: over,
    types,
    layers: { m3e: m3eLayer, components: componentsLayer, builder: builderLayer },
  };
```

**1e. Only reshape the real component records.** The barrel `M3e` and Builder modules
themselves are still walked by `moduleEntry` in the current `modules.filter(...)` at
~line 400 (`m.name === "M3e" || /^M3e\./.test(m.name)`). That filter would now emit
records for `M3e.Build.*` and re-emit `M3e` as components. Tighten it so ONLY the barrel
+ `M3e.Component.*` become page records (they map to `categories.json` slugs); the Build
modules are consumed as layer sources, never as their own pages:

```js
  .filter((m) => m.name === "M3e" || /^M3e\.Component\./.test(m.name)
                 || (/^M3e\./.test(m.name) && !/^M3e\.Build\./.test(m.name)))
```

(Confirm against `config/categories.json` that no `build`-prefixed slug is expected; the
`M3e.Build.*` records must NOT surface in the nav or the all-components spec's slug list.)

**1f. Update the UI-guard loop** (~lines 411-426) — it iterates `c.members`, which no
longer exists. Change it to iterate over `[...c.types, ...c.layers.m3e, ...c.layers.components,
...c.layers.builder]` so the phantom-`Ui.*` guard still scans every emitted member.

**Check:** run extraction and eyeball a few records:

```
cd docs && npm run gen:reference
node -e "const d=require('./data/reference.json'); const b=d.find(c=>c.slug==='button'); console.log(JSON.stringify({types:b.types.map(t=>t.name), m3e:b.layers.m3e.map(m=>m.name), components:b.layers.components.length, builder:b.layers.builder.map(m=>m.name).slice(0,6)},null,2));"
```

Expect: `button` has non-empty `types` (aliases like `Attrs`, `Is`, `Content`), `m3e:
["button"]` (the ctor, per the thin-slice finding), a non-empty `components` list, and a
`builder` list including `build`, `toElement`, `withVariant`, etc. Also spot-check a
component with slots (e.g. `card`) and a simple one (e.g. `divider`).

---

### Step 2 — Decode: layered members + shared types (`docs/src/Doc/Data.elm`)

Read current shape: `Member` (`Doc/Data.elm:18-19`), `Component` (`22-30`),
`componentDecoder` (`43-54`). `Member` is unchanged. Replace `members : List Member`
on `Component` with the layered shape and add `types`. Add:

```elm
type alias Layers =
    { m3e : List Member, components : List Member, builder : List Member }


type alias Component =
    { name : String
    , slug : String
    , category : String
    , label : String
    , summary : String
    , overview : String
    , types : List Member
    , layers : Layers
    }
```

`componentDecoder` (`map7` → `map8`): decode `types` and `layers` with backward-compatible
fallbacks so an older flat `reference.json` still decodes:

```elm
componentDecoder : Decode.Decoder Component
componentDecoder =
    Decode.map8 Component
        (Decode.field "name" Decode.string)
        (Decode.field "slug" Decode.string)
        (Decode.oneOf [ Decode.field "category" Decode.string, Decode.succeed "" ])
        (Decode.oneOf [ Decode.field "label" Decode.string, Decode.field "name" Decode.string ])
        (Decode.oneOf [ Decode.field "summary" Decode.string, Decode.succeed "" ])
        (Decode.field "overview" Decode.string)
        (Decode.oneOf
            [ Decode.field "types" (Decode.list memberDecoder)
            , legacyMembers |> Decode.map (List.filter (\m -> m.kind == "type"))
            ]
        )
        layersDecoder


legacyMembers : Decode.Decoder (List Member)
legacyMembers =
    Decode.oneOf [ Decode.field "members" (Decode.list memberDecoder), Decode.succeed [] ]


layersDecoder : Decode.Decoder Layers
layersDecoder =
    Decode.oneOf
        [ Decode.field "layers"
            (Decode.map3 Layers
                (Decode.field "m3e" (Decode.list memberDecoder))
                (Decode.field "components" (Decode.list memberDecoder))
                (Decode.field "builder" (Decode.list memberDecoder))
            )
        , legacyMembers
            |> Decode.map (\ms -> Layers [] (List.filter (\m -> m.kind /= "type") ms) [])
        ]
```

Export `Layers` from the module header (`Doc/Data.elm:1-8`).

**Keep `.members` alive for the OTHER consumers.** Removing `members` from the record
breaks three other pages that read it — `Route.Guide.Reference`
(`Guide/Reference.elm:218-276`, groups `c.members` for the barrel reference), plus
`Route.Components.All` and `Route.GettingStarted.Welcome` (both `import Doc.Data`;
confirm during implementation whether they touch `.members`). Rather than rewrite all
three now (out of scope — they render the barrel/all-components views, not the per-component
API section), add a flat `members` accessor to `Doc.Data` that reconstructs the old list, so
those pages compile untouched:

```elm
{-| The flat member list the barrel/all-components pages still consume — the union of
this component's types and every layer, de-duplicated by name (a value re-exported into
more than one layer appears once). The per-component API page (Name_) uses `.types` +
`.layers` directly instead; this accessor exists only so the other reference consumers
keep compiling after the record went layered.
-}
members : Component -> List Member
members c =
    let
        dedupe : List Member -> List Member
        dedupe =
            List.foldl
                (\m ( seen, acc ) ->
                    if Set.member m.name seen then
                        ( seen, acc )

                    else
                        ( Set.insert m.name seen, m :: acc )
                )
                ( Set.empty, [] )
                >> Tuple.second
                >> List.reverse
    in
    dedupe (c.types ++ c.layers.m3e ++ c.layers.components ++ c.layers.builder)
```

Import `Set` and export `members`. In `Guide/Reference.elm` (and any other consumer),
change bare `c.members` field access to the `Doc.Data.members c` call (one-line mechanical
substitution — those files already `import Doc.Data`).

**Format:** `node_modules/.bin/elm-format --yes src/Doc/Data.elm`. (Do not build yet —
`Name_.elm` still references the old `.members` field; Step 3 fixes it.)

---

### Step 3 — Render: Types block + tab strip + per-layer buckets (`docs/app/Route/Components/Name_.elm`)

Read current: `view` wires `apiSection component.members` (`Route.Components.Name_:131`),
`apiSection` (`221-226`), `apiGroups` (`234-241` — includes `"type"` in the Constructor
bucket), `apiGroup`/`memberRow` (`247-289`).

**3a. Thread the shared surface + component into the section.** `view` has `model : Model`
(= `Usage.Model`, which post-tab-sync carries `activeSurface`). Change the `apiSection`
call at line 131 to pass the whole component and the model's surface:

```elm
        ++ [ apiSection model.activeSurface component ]
```

(`Usage.Model` field name: match whatever tab-sync named it — the spec says `activeSurface`.
If tab-sync exposed it via an accessor rather than a bare field, use that; do not reach into
a `Dict`.)

**3b. Map `Surface` → layer + label.** `Surface` is exported from `Doc.Usage`
(`Doc/Usage.elm:1-10`, includes `Surface`). Import it. Add a helper mapping the three
Phase-1 surfaces to their layer list + tab label. `Raw` is intentionally omitted from the
API tab strip (Phase 2):

```elm
{-| The three Phase-1 API layers, in tab order, each mapping a `Surface` to its
label and the member list to render. `Raw` is Phase 2 (no tab here) — the CEM
manifest source is deferred. `Top → M3e barrel slice`, `Record → Components`,
`Build → Builder`, reusing the shared `Surface` so a Usage-tab click and an
API-tab click move the same `activeSurface`.
-}
apiLayers : Doc.Data.Component -> List ( Surface, String, List Doc.Data.Member )
apiLayers component =
    [ ( Usage.Top, "M3e", component.layers.m3e )
    , ( Usage.Record, "Components", component.layers.components )
    , ( Usage.Build, "Builder", component.layers.builder )
    ]
```

(This requires `Doc.Usage` to expose the `Surface` constructors `Top`/`Record`/`Build`.
Currently the header exports the `Surface` type but NOT its constructors
(`Doc/Usage.elm:3` exposes `Surface`, opaque). **Change the export to `Surface(..)`** so
`Name_` can pattern-match/construct them. Confirm nothing depends on the type staying
opaque — it is only used inside `Doc.Usage` today, so opening it is safe.)

**3c. Rewrite `apiSection`** to render, top-to-bottom: heading → Types block →
tab strip → selected-layer buckets. `apiGroups` loses the `"type"` role from the
Constructor bucket (types now render in the shared block):

```elm
apiGroups : List ( String, List String )
apiGroups =
    [ ( "Constructor", [ "ctor" ] )
    , ( "Attributes", [ "attr" ] )
    , ( "Slots", [ "slot" ] )
    , ( "Events", [ "event" ] )
    , ( "Other", [ "other", "" ] )
    ]


apiSection : Surface -> Doc.Data.Component -> Element (TypedHtml.Grouping.DivIs s) adm_ msg
apiSection activeSurface component =
    let
        activeLayer : List Doc.Data.Member
        activeLayer =
            apiLayers component
                |> List.filter (\( s, _, _ ) -> s == activeSurface)
                |> List.head
                |> Maybe.map (\( _, _, ms ) -> ms)
                -- activeSurface is Raw (Phase 2, no API tab) or unmatched: fall
                -- back to the M3e layer so the section is never blank.
                |> Maybe.withDefault component.layers.m3e
    in
    TypedHtml.div [ TA.class "space-y-6" ]
        (Doc.sectionHeadingWithId (Doc.slugify "API") "API"
            :: typesBlock component.types
            ++ [ apiTabStrip activeSurface component ]
            ++ List.filterMap (apiGroup activeLayer) apiGroups
        )
```

**Note on `msg`:** the tab strip emits `Usage.Msg` (a `SelectSurface`), so `apiSection`'s
return type must be over `Usage.Msg`, not the free `msg` the old signature used. The page's
`Msg = Usage.Msg` (`Route.Components.Name_:39-40`) and `view` already `M3e.mapMsg
PagesMsg.fromMsg` over the whole pane (`:124`), so returning `Usage.Msg`-typed elements from
`apiSection` composes cleanly — mirror `Usage.usageBlocks`' own `... Msg` return type.

**3d. Types block** (un-tabbed, once per page; empty ⇒ nothing):

```elm
{-| The component's type aliases/unions, shared across the M3e and Components
layers (the barrel re-exports them verbatim). Rendered once, above the tab strip
— NOT inside any tab — since they aren't layer-specific. Empty ⇒ nothing.
-}
typesBlock : List Doc.Data.Member -> List (Element (TypedHtml.Grouping.DivIs s) adm_ Usage.Msg)
typesBlock types =
    case types of
        [] ->
            []

        _ ->
            [ TypedHtml.div [ TA.class "space-y-3" ]
                [ Doc.sectionLabel "Types"
                , M3e.card [ M3e.Attributes.variant Value.outlined ]
                    [ M3e.Component.Card.content (M3e.list [] (List.map memberRow types)) ]
                ]
            ]
```

**3e. Tab strip** — via the shared widget from Step 4:

```elm
{-| The 3-tab API layer strip (`M3e | Components | Builder`), driven by the shared
`activeSurface`. A click emits the SAME `SelectSurface` the Usage tabs emit, so
both move together. `Raw` is Phase 2 and not offered here.
-}
apiTabStrip : Surface -> Doc.Data.Component -> Element { s | tabs : M3e.Kind.Brand } adm_ Usage.Msg
apiTabStrip activeSurface component =
    Usage.tabStrip
        activeSurface
        (List.map (\( surf, lbl, _ ) -> ( lbl, surf )) (apiLayers component))
```

**Format:** `node_modules/.bin/elm-format --yes app/Route/Components/Name_.elm`.

---

### Step 4 — Factor a shared, generic tab strip out of `Doc.Usage` (`docs/src/Doc/Usage.elm`)

`surfaceTabs` (`Doc/Usage.elm:258-270`) is not reusable as-is (closes over `UsageExample`
+ emits `SelectSurface index …` — post-tab-sync it emits `SelectSurface …`, still coupled
to `UsageExample` for `surfacesFor`). Extract the pure strip and have both callers use it.

Add a generic strip that takes the current surface + an explicit `(label, surface)` list:

```elm
{-| A generic single-select layer tab strip: one `Tab` per `(label, surface)`, the
one matching `current` marked selected, each click a `SelectSurface`. Shared by the
Usage examples (offered surfaces = `surfacesFor ex`) and the API section (offered
surfaces = the three Phase-1 layers). `Tabs` paginates natively on narrow viewports.
-}
tabStrip : Surface -> List ( String, Surface ) -> Element { s | tabs : M3e.Kind.Brand } adm_ Msg
tabStrip current entries =
    M3e.tabs []
        (List.map
            (\( lbl, surface ) ->
                M3e.tab
                    [ M3e.Attributes.selected (surface == current)
                    , M3e.Events.onClick (SelectSurface surface)
                    ]
                    [ M3e.text lbl ]
            )
            entries
        )
```

Rewrite the Usage-side `surfaceTabs` to delegate:

```elm
surfaceTabs : Surface -> UsageExample -> Element { s | tabs : M3e.Kind.Brand } adm_ Msg
surfaceTabs current ex =
    tabStrip current (surfacesFor ex)
```

(Its old `Int` index param is already gone post-tab-sync; if tab-sync left the signature
as `surfaceTabs current ex`, this is a body-only change. Update its call site in
`exampleBlock`, `Doc/Usage.elm:182`, accordingly if the arity changed.)

Export `tabStrip` from the module header (`Doc/Usage.elm:1-10`) alongside `surfaceTabs`
(add `tabStrip` and, if not already, keep `Surface(..)` per Step 3b).

**Format:** `node_modules/.bin/elm-format --yes src/Doc/Usage.elm`.

---

### Step 5 — Regenerate data + build the site

```
cd docs
npm run gen:reference          # re-extract with the new layered schema
npm run build:site             # elm-pages build + search index
```

`build:site` compiles Elm (catches any decode/render type errors) and pre-renders every
component page. Fix any compile error surfaced here before moving on. Do NOT run only the
dev server for verification (see Step 6).

---

### Step 6 — Testing (spec §"Testing (Phase 1)")

> **MEMORY CAVEAT — verify interactivity on PROD, never dev.** The docs DEV server
> (`:1234`, elm-pages `npm run dev`) does NOT wire Elm event listeners onto SSR-hydrated
> `<m3e-*>` nodes (`elmFs` unset) — tab clicks will appear dead there and that is a FALSE
> NEGATIVE. Test tab interactivity against the PROD build only: build, then serve the gate
> on `:1239` (`npm run serve` / the `test:browser` gate serves `dist` on 1239).

1. **Static render, multiple shapes** (from the built `dist`, or read the pre-rendered
   HTML): spot-check 3–4 components spanning shapes — one with slots (`card` or `list`),
   one with events (`button` / `checkbox`), one attrs-only simple (`divider`), and one to
   confirm the Builder tab is non-empty (`button` has `M3e/Build/Button.elm`). Each must
   render all THREE tabs (`M3e | Components | Builder`) with correct, non-empty member
   lists where expected (the `M3e` tab may be a single-member list — the ctor — which is
   correct per the thin-slice finding, not a bug).
2. **Types block once per page.** Confirm the Types block renders ONCE, above the tabs,
   and contains exactly the aliases that used to live in the Constructor bucket — and that
   switching tabs does NOT change it (it is outside the tab strip).
3. **Shared surface, both directions (PROD `:1239`):**
   - Click an API-section tab (e.g. `Builder`) → every Usage example's tab strip on the
     same page moves to `Build` (or its per-example fallback when it doesn't offer `Build`,
     per the tab-sync fallback rule).
   - Click a Usage-example tab (e.g. `M3e`) → the API section's active tab moves to `M3e`.
   Both work because both read/write the single `activeSurface`.
4. **Constructor bucket** now shows `button`/`required` (post naming-convention), no longer
   `view`/`el`, and no longer contains the type aliases.

If `usage.spec.ts` / any browser spec asserts on the old flat member DOM or per-example
index-keyed tabs, note it — the tab-sync spec already owns updating `usage.spec.ts` for the
page-wide model; this plan should only need to confirm the API-section additions don't break
those selectors. Do not expand scope into rewriting Usage's spec here.

---

## Verification checklist (done-gate)

- [ ] tab-sync + naming-convention are merged (Prerequisites) before starting.
- [ ] `npm run gen:reference` succeeds; `reference.json` records carry `types` + `layers.{m3e,components,builder}`.
- [ ] `npm run build:site` compiles clean (no Elm errors).
- [ ] Every touched `.elm` ran through `elm-format`.
- [ ] 3–4 component pages render 3 tabs with correct non-empty lists (Step 6.1).
- [ ] Types block renders once/page, un-tabbed, with the former Constructor-bucket aliases (Step 6.2).
- [ ] API-tab click moves Usage tabs and vice versa, verified on PROD `:1239` (Step 6.3).
- [ ] `Route.Guide.Reference` / `Components.All` / `Welcome` still compile via `Doc.Data.members`.
- [ ] No `Raw` tab added; no CEM manifest touched; no new route/page; semantic buckets unchanged.

## Blast radius

- `docs/scripts/extract-reference.mjs` (schema of `reference.json` changes — the ONLY
  consumers are `Doc.Data`/`Route.Components.Name_` and the Guide reference route; the
  decoder's legacy fallbacks keep an old artifact readable during the transition).
- `docs/src/Doc/Data.elm`, `docs/app/Route/Components/Name_.elm`, `docs/src/Doc/Usage.elm`.
- `docs/data/reference.json` (regenerated, committed).
- The other `reference.json` consumers — `Route.Guide.Reference`
  (`Guide/Reference.elm:218-276`), `Route.Components.All`, `Route.GettingStarted.Welcome` —
  read `c.members`. Step 2 keeps them compiling via the `Doc.Data.members` accessor (union of
  `types` + all layers, de-duped); each bare `.members` access becomes `Doc.Data.members c`.
  No behavior change to those pages.
