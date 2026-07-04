# Generator Shape Selector — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

> **Post-execution correction (2026-07-04):** the plan text says "four required-bearing components (Button, IconButton, Fab, Chip)"; actual `hasRecord` gate matches **21** components in `config/slots.json`. The 17 additional: Option, RichTooltipAction, RichTooltip, Tooltip, AssistChip, FilterChip, InputChip, SuggestionChip, Heading, NavMenuItem, SearchBar, SearchView, Snackbar, SplitButton, Step, TocItem, TreeItem. Every "four" below should read "21"; the emission rule (`hasRecord` gate) was implemented correctly regardless. Task 10 DoD Step 3's expected file list is the full 21, not just the four named.

**Goal:** Refactor `elm-cem/codegen/Generate.elm` to emit shape ③
(`M3e.<Comp>`) uniformly and shape ④ (`M3e.Record.<Comp>`) where the
required record is non-empty, driven by an explicit `shapesFor` selector.
Regenerate `packages/m3e/src/` and migrate the docs-app callers whose
top-level view moves from ④ to ③.

**Architecture:** The current `hasRecord` boolean fork in `generateTopModule`
is replaced by a set-valued `shapesFor : Config -> Cem.Declaration -> Set
Shape`. Two sibling emitters — `generateShape3Module` and
`generateShape4Module` — each independently wrap the middle layer (no
cross-shape imports). Shared helpers stay factored out. Each top namespace
gets its own barrel (`M3e.elm`, new `M3e/Record.elm`).

**Tech Stack:** Elm 0.19.1; `mdgriffith/elm-codegen@0.6.3`; `elm-cem`
generator (Node.js CLI + Elm codegen); pnpm; elm-lsp-rust for migration
renames.

## Global Constraints

- Governing spec: `docs/superpowers/specs/2026-07-03-generator-shape-selector-design.md`.
- Governing ADR (amended): `docs/adr/0013-top-shape-matrix-and-translation.md`.
- Cross-spec invariants: `docs/superpowers/specs/2026-07-03-epic-138-shipping-coordination.md`.
- No cross-shape imports at the top layer. Each of ③/④/⑤ wraps `M3e.Cem.<Comp>` directly.
- No `M3e/Cem.elm` barrel changes (middle layer stays barrel-less).
- The `Elm.Arg.var` workaround at `Generate.elm:2002-2009` (multi-field required record args unannotated) is preserved for shape ④.
- Generator changes land in the `/elm-cem/` working clone (upstream repo, gitignored here); tracked-repo commits are limited to (a) regenerated `packages/m3e/src/` and (b) docs-app migration.

---

### Task 1: Introduce the `Shape` type and `shapesFor` selector

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` (add types + helper near existing `Config`/`TopModule` definitions ~L55-85)

**Interfaces:**
- Consumes: existing `Cem.Declaration`, existing `hasRecord` predicate logic.
- Produces:
  - `type Shape = Shape3 | Shape4` (extended to `Shape5` in second ship).
  - `shapesFor : Config -> Cem.Declaration -> Set Shape`.

- [ ] **Step 1: Add the `Shape` type**

Insert after the existing `TopModule` type alias (~L85):

```elm
{-| Which shape a component's top module emits. In the first ship the set is
`{Shape3}` or `{Shape3, Shape4}`; in the second ship it gains `Shape5`.
-}
type Shape
    = Shape3
    | Shape4
```

Also add `Set` to the imports if not already present. Verify with:
```
grep -n "^import Set" elm-cem/codegen/Generate.elm
```
If missing, add `import Set exposing (Set)` in the import block.

- [ ] **Step 2: Add the `shapesFor` function**

Immediately after the `Shape` type, add:

```elm
{-| Compute which top shapes a component emits. `Shape3` (double-list) is
always emitted; `Shape4` (record + double-list) is emitted iff the
required record has ≥1 field — the same condition today's `hasRecord`
gates.
-}
shapesFor : Config -> Cem.Declaration -> Set Shape
shapesFor config decl =
    let
        moduleName =
            componentModuleName decl

        slots =
            Dict.get moduleName config
                |> Maybe.map .slots
                |> Maybe.withDefault []

        requiredSingular =
            List.filter (\s -> s.required && not s.multi) slots

        extra =
            extraRequiredFields decl slots

        needsRecord =
            not (List.isEmpty requiredSingular)
                || not (List.isEmpty extra)
    in
    if needsRecord then
        Set.fromList [ Shape3, Shape4 ]

    else
        Set.singleton Shape3
```

**Note:** `componentModuleName` and `extraRequiredFields` are helpers that
must already exist near `generateTopModule`'s current `let` scope
(currently inlined at L1650-1700). If they don't exist as top-level
functions yet, they'll be extracted in Task 3; for now inline them.

- [ ] **Step 3: Sanity-check `shapesFor` against the current tree**

Add a debug scaffold — temporarily at the top of `generateFromManifest`
(~L440), insert:

```elm
let
    _ = Debug.log "shapes for Button"
        (shapesFor config (findComponent "m3e-button" components))

    _ = Debug.log "shapes for Card"
        (shapesFor config (findComponent "m3e-card" components))
in
...
```

Run: `cd /elm-cem && pnpm run test` (or however elm-cem tests are run —
check `package.json` scripts). Verify the debug output shows `Set [Shape3,
Shape4]` for Button and `Set [Shape3]` for Card.

Then remove the debug scaffold.

- [ ] **Step 4: Commit in the elm-cem upstream repo**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem
git add codegen/Generate.elm
git commit -m "feat(codegen): introduce Shape type and shapesFor selector"
```

---

### Task 2: Change `TopModule` type and `generateTopModule` to return a list

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` around L84, L1622, L440-470.

**Interfaces:**
- Consumes: `Shape` type (Task 1).
- Produces:
  - `TopModule` type gains a `shape : Shape` field.
  - `generateTopModules : Config -> LibraryInfo -> Cem.Declaration -> List TopModule` (renamed, plural).

- [ ] **Step 1: Extend the `TopModule` type**

Replace the current `type alias TopModule` at L84-85 with:

```elm
type alias TopModule =
    { file : Elm.File
    , noun : String
    , viewType : Type.Annotation
    , shape : Shape
    }
```

- [ ] **Step 2: Rename `generateTopModule` to `generateTopModules` and stub the shape-set traversal**

Replace the signature at L1622:

```elm
generateTopModules : Config -> LibraryInfo -> Cem.Declaration -> List TopModule
generateTopModules config libraryInfo component =
    shapesFor config component
        |> Set.toList
        |> List.map (\shape ->
            case shape of
                Shape3 ->
                    generateShape3Module config libraryInfo component

                Shape4 ->
                    generateShape4Module config libraryInfo component
        )
```

The bodies of `generateShape3Module` and `generateShape4Module` will
initially stub-call the old `generateTopModule` logic; they get split out
in Tasks 4-5. For now:

```elm
generateShape3Module : Config -> LibraryInfo -> Cem.Declaration -> TopModule
generateShape3Module config libraryInfo component =
    -- TEMPORARY: reuse the existing generator body when there's no record;
    -- Tasks 4-5 will split this properly.
    let
        old =
            legacyGenerateTopModule config libraryInfo component
    in
    { old | shape = Shape3 }


generateShape4Module : Config -> LibraryInfo -> Cem.Declaration -> TopModule
generateShape4Module config libraryInfo component =
    let
        old =
            legacyGenerateTopModule config libraryInfo component
    in
    { old | shape = Shape4 }
```

Rename the current `generateTopModule` function to `legacyGenerateTopModule`
throughout the file (only one call site — the map in `topModules` at
L467 — plus the definition at L1622). Add the `shape = Shape3` field to
its returned record so it type-checks against the new `TopModule`.

- [ ] **Step 3: Update the orchestrator**

At L464-467, change:

```elm
topModules =
    components
        |> List.filter (\c -> not (isMember c))
        |> List.map (generateTopModule config libraryInfo)
```

to:

```elm
topModules =
    components
        |> List.filter (\c -> not (isMember c))
        |> List.concatMap (generateTopModules config libraryInfo)
```

Note `List.map` → `List.concatMap`.

- [ ] **Step 4: Regen + verify no drift**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e
elm-cem/bin/elm-cem.js <existing generator args — check the repo's regen script>
git diff packages/m3e/src/
```

Expected: for components with no required record, ONE file is emitted per
component (unchanged). For required-bearing components, TWO files are
emitted per component (Shape3 and Shape4 versions — but the stubs
currently produce identical output, so the second file overwrites the
first with the same content). The diff should show no functional change
at this point; the goal here is proving the plumbing works.

If the diff is non-empty in ways unrelated to shape emission, investigate
before proceeding.

- [ ] **Step 5: Commit in the elm-cem upstream repo**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem
git add codegen/Generate.elm
git commit -m "refactor(codegen): thread Shape through TopModule; plural generateTopModules"
```

---

### Task 3: Extract shared helpers used by both shape emitters

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — refactor the `let` scope of `legacyGenerateTopModule` (L1622-2064) so its helpers are top-level, or a `SharedCtx` record threaded through.

**Interfaces:**
- Produces:
  - A `SharedCtx` record or set of top-level helpers exposing: `specs`, `contentSlots`, `requiredSingular`, `extra`, `requiredType`, `build`, `attrsWith`, `reqStampedNodes`, `smartAppend`, plus the `moduleName`, `noun`, `slots`, and `setter`/`contentSetter` producers.
- Consumed by: Tasks 4-5.

- [ ] **Step 1: Define the SharedCtx type**

Near the `TopModule` type, add:

```elm
{-| Per-component context shared by both shape emitters. Extracted from
`legacyGenerateTopModule`'s let-scope so shape-specific emitters can call
into it without duplication.
-}
type alias SharedCtx =
    { config : Config
    , libraryInfo : LibraryInfo
    , component : Cem.Declaration
    , moduleName : String
    , noun : String
    , slots : List Cem.Slot
    , specs : List Attr.AttrSpec
    , requiredSingular : List Cem.Slot
    , contentSlots : List Cem.Slot
    , extra : List (String, Cem.ExtraField)  -- adjust to actual type
    , usesAction : Bool
    , requiredType : Type.Annotation
    }
```

Adjust field types to match what `legacyGenerateTopModule`'s current let
bindings return; grep for each name at L1622-1770 to find the right type.

- [ ] **Step 2: Build the SharedCtx builder**

Add:

```elm
buildSharedCtx : Config -> LibraryInfo -> Cem.Declaration -> SharedCtx
buildSharedCtx config libraryInfo component =
    let
        moduleName = componentModuleName component
        noun = ... -- move from L1650-ish
        slots = ...
        specs = ...
        requiredSingular = ...
        contentSlots = ...
        extra = ...
        usesAction = ...
        requiredType = ...
    in
    { config = config
    , libraryInfo = libraryInfo
    , component = component
    , moduleName = moduleName
    , noun = noun
    , slots = slots
    , specs = specs
    , requiredSingular = requiredSingular
    , contentSlots = contentSlots
    , extra = extra
    , usesAction = usesAction
    , requiredType = requiredType
    }
```

Populate each field by copying the corresponding let binding out of
`legacyGenerateTopModule`. Preserve the exact expression on the RHS —
this task is a pure move, no semantic change.

- [ ] **Step 3: Refactor `legacyGenerateTopModule` to consume SharedCtx**

Change the beginning of `legacyGenerateTopModule` from its current
let-scope to:

```elm
legacyGenerateTopModule : Config -> LibraryInfo -> Cem.Declaration -> TopModule
legacyGenerateTopModule config libraryInfo component =
    let
        ctx = buildSharedCtx config libraryInfo component
        -- ... body-assembly helpers stay in-scope here for now ...
    in
    ...
```

Replace let-scoped references (`slots`, `specs`, `requiredSingular`, etc.)
with `ctx.slots`, `ctx.specs`, `ctx.requiredSingular`, etc. throughout the
function body.

- [ ] **Step 4: Regen + verify no drift**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e
<regen command>
git diff packages/m3e/src/ | head -100
```

Expected: EMPTY diff. This task is a pure refactor; the emitted output
must be byte-identical to Task 2's regen.

- [ ] **Step 5: Commit**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem
git add codegen/Generate.elm
git commit -m "refactor(codegen): extract SharedCtx from legacyGenerateTopModule"
```

---

### Task 4: Split out `generateShape4Module`

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — extract the `hasRecord` branch of `legacyGenerateTopModule` (L1985-2020) into a dedicated `generateShape4Module`.

**Interfaces:**
- Consumes: `SharedCtx` (Task 3), the body-assembly helpers (`build`, `attrsWith`, `reqStampedNodes`, `smartAppend`), `Elm.Arg.var` workaround preserved.
- Produces:
  - `generateShape4Module : Config -> LibraryInfo -> Cem.Declaration -> TopModule` emitting to `M3e.Record.<Comp>`.

- [ ] **Step 1: Write the function skeleton**

Replace the stub in Task 2:

```elm
generateShape4Module : Config -> LibraryInfo -> Cem.Declaration -> TopModule
generateShape4Module config libraryInfo component =
    let
        ctx = buildSharedCtx config libraryInfo component

        -- Module path: M3e.Record.<Comp>
        modulePath =
            [ config.libraryNamespace, "Record", ctx.moduleName ]

        viewType =
            -- Same as legacyGenerateTopModule's hasRecord branch produces
            Type.function
                [ ctx.requiredType, attrsListClosed ctx, contentListType ctx ]
                (resultType ctx)

        viewDecl =
            -- Copied verbatim from L2010-2021, with Elm.Arg.var workaround preserved
            Elm.declaration "view"
                (Elm.fn3 (Elm.Arg.var "req_")
                    (Elm.Arg.var "attributes")
                    (Elm.Arg.var "content_")
                    (\reqE attributes content_ ->
                        build ctx (attrsWith ctx reqE attributes)
                            (smartAppend (reqStampedNodes ctx reqE) (contentNodes content_))
                    )
                    |> Elm.withType viewType
                )
                |> Elm.expose
                |> Elm.withDocumentation (viewDocShape4 ctx)

        setters =
            -- Same setters as legacyGenerateTopModule's hasRecord branch (attrs + slots)
            shape4Setters ctx

        contentSetters =
            shape4ContentSetters ctx

        eventAliases =
            shape4EventAliases ctx

        defaultHelpers =
            shape4DefaultHelpers ctx

        file =
            Elm.fileWith modulePath
                { docs =
                    Docs.generateViewDocumentation component
                        ++ Docs.docMetaMarker (docMetaPairs component)
                        ++ Docs.examplesSection (exampleRecords component)
                , aliases = []
                }
                (viewDecl :: setters ++ eventAliases ++ contentSetters ++ defaultHelpers)
    in
    { file = file
    , noun = ctx.noun
    , viewType = viewType
    , shape = Shape4
    }
```

Extract each helper (`attrsListClosed`, `contentListType`, `resultType`,
`build`, `attrsWith`, `reqStampedNodes`, `smartAppend`, `contentNodes`,
`shape4Setters`, `shape4ContentSetters`, `shape4EventAliases`,
`shape4DefaultHelpers`, `viewDocShape4`, `docMetaPairs`, `exampleRecords`)
from `legacyGenerateTopModule`'s let scope by moving the binding to a
top-level function that takes `SharedCtx` as its first argument.

- [ ] **Step 2: Verify module path change**

Since `modulePath = [ libraryNamespace, "Record", ctx.moduleName ]`, the
file is emitted at `packages/m3e/src/M3e/Record/<Comp>.elm`. The
generator's file-writing already supports nested paths (see how
`M3e.Cem.Html.<Comp>` is emitted at L1608).

- [ ] **Step 3: Regen and inspect Button ④**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e
<regen command>
ls packages/m3e/src/M3e/Record/
```

Expected: files `Button.elm`, `IconButton.elm`, `Fab.elm`, `Chip.elm` (the
four required-bearing components).

Read `packages/m3e/src/M3e/Record/Button.elm`:

```bash
head -60 packages/m3e/src/M3e/Record/Button.elm
```

Expected: identical structure to today's `packages/m3e/src/M3e/Button.elm`
except the module declaration says `module M3e.Record.Button exposing (...)`
instead of `module M3e.Button exposing (...)`.

- [ ] **Step 4: Diff against today's `M3e/Button.elm` (excluding module declaration)**

```bash
diff <(tail -n +2 packages/m3e/src/M3e/Button.elm) <(tail -n +2 packages/m3e/src/M3e/Record/Button.elm)
```

Expected: EMPTY diff (or only whitespace differences). The two files
should be byte-identical below the module declaration.

- [ ] **Step 5: Commit**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem
git add codegen/Generate.elm
git commit -m "feat(codegen): split out generateShape4Module emitting M3e.Record.<Comp>"
```

---

### Task 5: Split out `generateShape3Module` with action-attr re-exposure

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — extract the non-`hasRecord` branch of `legacyGenerateTopModule` into `generateShape3Module`, and add action-attr re-exposure for required-bearing components.

**Interfaces:**
- Consumes: `SharedCtx`, existing body-assembly helpers.
- Produces:
  - `generateShape3Module : Config -> LibraryInfo -> Cem.Declaration -> TopModule` emitting to `M3e.<Comp>`.

- [ ] **Step 1: Write the function**

Replace the Task 2 stub:

```elm
generateShape3Module : Config -> LibraryInfo -> Cem.Declaration -> TopModule
generateShape3Module config libraryInfo component =
    let
        ctx = buildSharedCtx config libraryInfo component

        modulePath =
            [ config.libraryNamespace, ctx.moduleName ]

        viewType =
            Type.function
                [ attrsListClosed ctx, contentListType ctx ]
                (resultType ctx)

        viewDecl =
            Elm.declaration "view"
                (Elm.fn2 (Elm.Arg.varWith "attributes" (attrsListClosed ctx))
                    (Elm.Arg.varWith "children" (freeChildrenType ctx))
                    (\attributes children ->
                        build ctx (forgottenAttrs attributes) (toNodeChildren children)
                    )
                    |> Elm.withType viewType
                )
                |> Elm.expose
                |> Elm.withDocumentation (viewDocShape3 ctx)

        setters =
            shape3Setters ctx

        contentSetters =
            shape3ContentSetters ctx

        eventAliases =
            shape3EventAliases ctx

        actionAttrs =
            -- NEW: re-expose middle-layer action attrs for required-bearing
            if ctx.usesAction then
                shape3ActionAttrs ctx

            else
                []

        defaultSlotHelpers =
            -- NEW: emit child/children for required-bearing components
            if ctx.usesAction then
                shape3DefaultSlotHelpers ctx

            else
                []

        file =
            Elm.fileWith modulePath
                { docs = ...
                , aliases = []
                }
                (viewDecl
                    :: setters
                    ++ eventAliases
                    ++ actionAttrs
                    ++ contentSetters
                    ++ defaultSlotHelpers
                )
    in
    { file = file
    , noun = ctx.noun
    , viewType = viewType
    , shape = Shape3
    }
```

- [ ] **Step 2: Implement `shape3ActionAttrs`**

Emits aliases of the middle-layer's `onClick`, `href`, `target`, `rel`,
`download` — but only the ones that actually exist in the middle-layer
module for this component. Reference: `Generate.elm:1720` — the existing
`setter` helper already emits attribute-setter aliases; reuse it.

```elm
shape3ActionAttrs : SharedCtx -> List Elm.Declaration
shape3ActionAttrs ctx =
    let
        cemModule =
            [ ctx.config.libraryNamespace, "Cem", ctx.moduleName ]

        actionAttrNames =
            [ "onClick", "href", "target", "rel", "download" ]

        exposedInCem name =
            -- Check whether M3e.Cem.<Comp> exposes this name by inspecting
            -- the AttrSpec list; only emit an alias if it does.
            List.any (\s -> s.elmName == name) ctx.specs
                || List.any (\ev -> eventHandlerName ctx.libraryInfo ev == name)
                       ctx.component.events
    in
    actionAttrNames
        |> List.filter exposedInCem
        |> List.map (\name -> setterAlias ctx cemModule name)
```

Adjust `setterAlias` to match the existing `setter` helper's signature at
L1720. Study that helper's body and mirror the pattern.

- [ ] **Step 3: Implement `shape3DefaultSlotHelpers`**

Emits `child` and `children` setters for the default (unnamed) slot,
matching `M3e.Card`'s convention at `packages/m3e/src/M3e/Card.elm:196-241`:

```elm
shape3DefaultSlotHelpers : SharedCtx -> List Elm.Declaration
shape3DefaultSlotHelpers ctx =
    [ Elm.declaration "child"
        (Elm.fn (Elm.Arg.varWith "el" (Type.namedWith [...] "Element" [ Type.var "any", Type.var "msg" ]))
            (\el -> Elm.apply (external contentModule "slot") [ Elm.string "", el ])
            |> Elm.withType (childType ctx)
        )
        |> Elm.expose
        |> Elm.withDocumentation "Place content in the default slot."
    , Elm.declaration "children"
        (Elm.fn (Elm.Arg.varWith "els" (Type.list (Type.namedWith [...] "Element" [ Type.var "any", Type.var "msg" ])))
            (\els -> Elm.apply (Elm.value { importFrom = [ "List" ], name = "map", annotation = Nothing })
                [ Elm.fn (Elm.Arg.var "el") (\el -> Elm.apply (external contentModule "slot") [ Elm.string "", el ])
                , els
                ])
            |> Elm.withType (childrenType ctx)
        )
        |> Elm.expose
        |> Elm.withDocumentation "Place multiple elements in the default slot."
    ]
```

Copy the exact types from `M3e.Card`'s emitted `child` / `children` for
reference.

- [ ] **Step 4: Regen and inspect Button ③**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e
<regen command>
head -30 packages/m3e/src/M3e/Button.elm
grep -E "^(onClick|href|target|rel|download|child|children) :" packages/m3e/src/M3e/Button.elm
```

Expected: `M3e.Button.view` is now `List Attr -> List Content -> Element`
(no required record). The setters `onClick`, `href`, `target`, `rel`,
`download`, `child`, `children` are all exposed. All the existing
`variant`, `disabled`, `icon`, etc. setters remain.

- [ ] **Step 5: Diff Card ③ against today's Card**

```bash
diff packages/m3e/src/M3e/Card.elm <regen>/packages/m3e/src/M3e/Card.elm
```

Expected: EMPTY diff (Card was already ③; the refactor should be
byte-identical for optional-only components).

- [ ] **Step 6: Verify no `legacyGenerateTopModule` calls remain**

```bash
grep -n "legacyGenerateTopModule" elm-cem/codegen/Generate.elm
```

Expected: only the definition (which can now be deleted). Delete the
`legacyGenerateTopModule` function.

- [ ] **Step 7: Commit**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem
git add codegen/Generate.elm
git commit -m "feat(codegen): split out generateShape3Module with action-attr re-exposure"
```

---

### Task 6: Add `M3e/Record.elm` barrel emission

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — extend `generateBarrelModule` (L2179-2270) to emit per-shape barrels.

**Interfaces:**
- Consumes: `viewTypeByNoun` extended to shape-aware (Task 7 finalizes).
- Produces:
  - `M3e/Record.elm` barrel with lowercase re-exports for ④-emitting components.
  - `M3e.elm` re-exports scoped to ③-emitting components (essentially: all of them, but the underlying `view` referenced is ③'s).

- [ ] **Step 1: Change the orchestrator's barrel emission**

At L491-492, replace the single `barrelModule` binding with:

```elm
barrelShape3 =
    generateBarrelModule libraryInfo sharedSpecs sharedEvents
        (barrelViewTypesForShape Shape3 topModules)
        (barrelComponentsForShape Shape3 topModules components isMember)

barrelShape4 =
    generateBarrelModule libraryInfo sharedSpecs sharedEvents
        (barrelViewTypesForShape Shape4 topModules)
        (barrelComponentsForShape Shape4 topModules components isMember)
        |> withModulePath [ libraryInfo.moduleName, "Record" ]
```

Add both to the module output list further down (find where
`barrelModule` is added to the files list and replace with both).

- [ ] **Step 2: Implement `barrelViewTypesForShape`**

```elm
barrelViewTypesForShape : Shape -> List TopModule -> Dict String Type.Annotation
barrelViewTypesForShape shape topModules =
    topModules
        |> List.filter (\t -> t.shape == shape)
        |> List.map (\t -> ( t.noun, t.viewType ))
        |> Dict.fromList
```

- [ ] **Step 3: Implement `barrelComponentsForShape`**

```elm
barrelComponentsForShape :
    Shape
    -> List TopModule
    -> List Cem.Declaration
    -> (Cem.Declaration -> Bool)
    -> List Cem.Declaration
barrelComponentsForShape shape topModules allComponents isMember =
    let
        emittedNouns =
            topModules
                |> List.filter (\t -> t.shape == shape)
                |> List.map .noun
                |> Set.fromList
    in
    allComponents
        |> List.filter (\c -> not (isMember c))
        |> List.filter (\c -> Set.member (componentNoun c) emittedNouns)
```

- [ ] **Step 4: Add `withModulePath` helper**

`generateBarrelModule` currently emits at `[ libraryInfo.moduleName ]`
(the top-level `M3e.elm`). For the ④ barrel we need to override that:

```elm
withModulePath : List String -> Elm.File -> Elm.File
withModulePath path file =
    -- elm-codegen's Elm.File is transparent: just rewrite the path field.
    -- Actually: check whether Elm.fileWith accepts a path override, or
    -- add a modulePath parameter to generateBarrelModule.
    ...
```

Given `Elm.File`'s structure (see the `RuntimeFile` type alias at L93 for
the shape), it's easier to add a `modulePath` parameter to
`generateBarrelModule`:

```elm
generateBarrelModule :
    LibraryInfo
    -> List Attr.AttrSpec
    -> List Cem.Event
    -> List String  -- module path
    -> Dict String Type.Annotation
    -> List Cem.Declaration
    -> Elm.File
generateBarrelModule libraryInfo specs events modulePath viewTypeByNoun components =
    -- change L2268: Elm.fileWith modulePath { ... }
```

Update L491-492 to pass `[ libraryInfo.moduleName ]` for the ③ barrel and
`[ libraryInfo.moduleName, "Record" ]` for the ④ barrel.

- [ ] **Step 5: Regen and inspect barrels**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e
<regen command>
ls packages/m3e/src/M3e.elm packages/m3e/src/M3e/Record.elm
head -30 packages/m3e/src/M3e/Record.elm
grep -E "^(button|iconButton|fab|chip) :" packages/m3e/src/M3e/Record.elm
```

Expected: `M3e/Record.elm` exists with `button`, `iconButton`, `fab`,
`chip` re-exports. `M3e.elm` still exists with all 127 lowercase entries;
the four required-bearing entries now alias `M3e.<Comp>.view` (③), not
`M3e.Record.<Comp>.view` (④).

- [ ] **Step 6: Verify `M3e.button` in `M3e.elm` points at the ③ view**

```bash
grep -A 3 "^button =" packages/m3e/src/M3e.elm
```

Expected:
```
button =
    M3e.Button.view
```

The signature above `button =` should be 2-args (`List Attr -> List Content
-> Element`), not the 3-args hybrid.

- [ ] **Step 7: Commit**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem
git add codegen/Generate.elm
git commit -m "feat(codegen): emit M3e/Record.elm barrel alongside M3e.elm; shape-scoped entries"
```

---

### Task 7: Extend `viewTypeByNoun` with shape/arity metadata (facts handoff)

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — augment `viewTypeByNoun` (L469) with per-shape info; update `generateFactsModule` (search for it).

**Interfaces:**
- Produces:
  - Per-component shape/arity metadata emitted into `M3e.Review.Facts` under a schema the facts spec consumes.

- [ ] **Step 1: Locate the facts emitter**

```bash
grep -n "Review.Facts\|generateFactsModule\|reviewFacts" elm-cem/codegen/Generate.elm
```

Find the function that emits `M3e.Review.Facts.elm`.

- [ ] **Step 2: Add shape-metadata fields to the emitted Fact record**

The current `Fact` type in `packages/m3e/src/M3e/Review/Facts.elm` is:

```elm
type alias Fact =
    { component : String
    , module_ : String
    , enums : List ( String, List String )
    , requiredSlots : List String
    , multiSlots : List String
    }
```

Extend it — **exact schema TBD by the facts spec; this task lays the
groundwork with a first cut and calls out the coordination point**:

```elm
type alias Fact =
    { component : String
    , module_ : String
    , enums : List ( String, List String )
    , requiredSlots : List String
    , multiSlots : List String
    , shapes : List Shape       -- NEW: which shapes exist for this component
    , requiredAttrs : List String  -- NEW: for D1 missing-required-attribute rule
    }
```

- [ ] **Step 3: Extend `viewTypeByNoun` collector or add a sibling collector**

The generator collects `viewTypeByNoun : Dict String Type.Annotation`
today. Add either a sibling `factsByNoun` or extend the dict's value type:

```elm
factsByNoun =
    topModules
        |> List.foldl
            (\t acc ->
                Dict.update t.noun
                    (\existing ->
                        case existing of
                            Just fact ->
                                Just { fact | shapes = t.shape :: fact.shapes }

                            Nothing ->
                                Just
                                    { component = t.noun
                                    , module_ = t.noun  -- adjust
                                    , enums = ...
                                    , requiredSlots = ...
                                    , multiSlots = ...
                                    , shapes = [ t.shape ]
                                    , requiredAttrs = extractRequiredAttrs t
                                    }
                    )
                    acc
            )
            Dict.empty
```

Pass this to the facts emitter.

- [ ] **Step 4: Coordination note**

Add a comment at the top of the facts emitter linking to the coordination
doc's invariant:

```elm
-- CROSS-SPEC INVARIANT (see docs/superpowers/specs/2026-07-03-epic-138-shipping-coordination.md):
-- The `shapes` and `requiredAttrs` fields emitted here are consumed
-- verbatim by the review rules spec. Schema changes must land in both
-- specs simultaneously.
```

- [ ] **Step 5: Regen and inspect Facts**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e
<regen command>
head -40 packages/m3e/src/M3e/Review/Facts.elm
grep -A 8 "^{ component = \"m3e-button\"" packages/m3e/src/M3e/Review/Facts.elm
```

Expected: the emitted `Fact` for `m3e-button` includes `shapes = [ Shape3,
Shape4 ]` and `requiredAttrs = [...]` populated from CEM+config.

- [ ] **Step 6: Commit**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem
git add codegen/Generate.elm
git commit -m "feat(codegen): emit shapes + requiredAttrs into M3e.Review.Facts (D1/D2 handoff)"
```

---

### Task 8: Regenerate the full library and stage tracked-repo diff

**Files:**
- Modify (via regen): all files under `packages/m3e/src/M3e/`.

- [ ] **Step 1: Clean regen**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e
rm -rf packages/m3e/src/M3e/
<regen command from elm-cem>
```

- [ ] **Step 2: Inspect the new file inventory**

```bash
ls packages/m3e/src/M3e/ | head -30
ls packages/m3e/src/M3e/Record/
```

Expected:
- ~127 files at `packages/m3e/src/M3e/<Comp>.elm` (all components, all shape ③).
- 4 files at `packages/m3e/src/M3e/Record/{Button,IconButton,Fab,Chip}.elm`.
- `packages/m3e/src/M3e.elm` and `packages/m3e/src/M3e/Record.elm` barrels.

- [ ] **Step 3: Compile check (packages/m3e alone)**

```bash
cd packages/m3e
elm make --docs=/tmp/m3e-docs.json
```

Expected: `Success! Compiled N modules.` If it errors, investigate — most
likely an issue with the ③ or ④ emitter that needs fixing in Generate.elm.

- [ ] **Step 4: Sanity-check byte-identity for Card ③**

Compare Card's emission before and after:

```bash
git show HEAD:packages/m3e/src/M3e/Card.elm > /tmp/card-before.elm
diff /tmp/card-before.elm packages/m3e/src/M3e/Card.elm
```

Expected: EMPTY diff. Card is optional-only and its ③ output must not
change.

- [ ] **Step 5: Sanity-check the Button ④ move**

```bash
git show HEAD:packages/m3e/src/M3e/Button.elm > /tmp/button-before.elm
diff <(tail -n +2 /tmp/button-before.elm) <(tail -n +2 packages/m3e/src/M3e/Record/Button.elm)
```

Expected: EMPTY diff. Today's `M3e.Button.view` (④ hybrid) is now at
`M3e.Record.Button.view` byte-identically (module declaration aside).

- [ ] **Step 6: Do NOT commit yet — Task 9 does the docs-app migration in the same commit**

The regen alone breaks docs-app. Stage but don't commit; the docs-app
migration fixes the callers, then Task 9 commits both together.

```bash
git add packages/m3e/src/
git status --short | head
```

---

### Task 9: Migrate docs-app callers via elm-lsp-rust

**Files:**
- Modify: `docs/app/**/*.elm` — call sites of `M3e.Button.view`, `M3e.IconButton.view`, `M3e.Fab.view`, `M3e.Chip.view`, and their barrel forms `M3e.button`, `M3e.iconButton`, `M3e.fab`, `M3e.chip` (only calls with the record-first-arg form).

- [ ] **Step 1: Identify all break sites**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e
elm make docs/app/... 2>&1 | grep -E "(TYPE MISMATCH|expected .* args)" | head -20
```

Or more precisely — grep for the four component names' call patterns:

```bash
grep -rn "M3e\.\(Button\|IconButton\|Fab\|Chip\)\.view\s*{" docs/app/
grep -rn "M3e\.\(button\|iconButton\|fab\|chip\)\s*{" docs/app/
```

Compile the list of files and specific call sites that break.

- [ ] **Step 2: Rewrite `M3e.<Comp>.view` → `M3e.Record.<Comp>.view` for the four components**

For each break site, rewrite the module reference. Use elm-lsp-rust's
rename tool where possible, or `sed` for straightforward cases:

```bash
# Preview
find docs/app -name '*.elm' -exec grep -l 'M3e\.Button\.view\s*{' {} \;

# Execute (per file — check each with git diff before proceeding)
sed -i '' 's|M3e\.Button\.view|M3e.Record.Button.view|g' <file>
sed -i '' 's|M3e\.IconButton\.view|M3e.Record.IconButton.view|g' <file>
sed -i '' 's|M3e\.Fab\.view|M3e.Record.Fab.view|g' <file>
sed -i '' 's|M3e\.Chip\.view|M3e.Record.Chip.view|g' <file>
```

**Caution:** if any call sites use `M3e.Button.view` WITHOUT a following
record (they exist as ③-style callers today — unlikely but possible),
those should NOT be rewritten. Manually inspect each match if unsure.

- [ ] **Step 3: Rewrite barrel calls `M3e.button {...}` → `M3e.Record.button {...}`**

Same pattern:

```bash
sed -i '' 's|M3e\.button\s*{|M3e.Record.button {|g' <file>
sed -i '' 's|M3e\.iconButton\s*{|M3e.Record.iconButton {|g' <file>
sed -i '' 's|M3e\.fab\s*{|M3e.Record.fab {|g' <file>
sed -i '' 's|M3e\.chip\s*{|M3e.Record.chip {|g' <file>
```

- [ ] **Step 4: Add necessary imports**

Each file that gained a `M3e.Record.<Comp>` call needs an import if not
already present. For each modified file, ensure:

```elm
import M3e.Record.Button
import M3e.Record.IconButton  -- as needed
-- etc.
```

Or, if using the barrel form (`M3e.Record.button`):

```elm
import M3e.Record
```

- [ ] **Step 5: Format**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e
elm-format docs/app --yes
```

- [ ] **Step 6: Compile docs-app to verify**

```bash
cd docs/app
<the app's compile command; check package.json>
```

Expected: compiles clean. If not, iterate on remaining break sites.

- [ ] **Step 7: Run the full check gate**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e
pnpm run check
```

Expected: passes. This is the DoD gate from the spec.

- [ ] **Step 8: Commit both the regen and the migration**

```bash
git add packages/m3e/src/ docs/app/
git status
git commit -m "$(cat <<'EOF'
feat(m3e): regen with shape ③/④ split — API break for four components

Regenerates packages/m3e/src/ from the updated elm-cem generator that
uniformly emits shape ③ (M3e.<Comp>) and shape ④ (M3e.Record.<Comp>) with
④ pruned where the required record is empty. Follow-through migration of
docs-app callers for the four required-bearing components.

Breaking changes:
- M3e.Button.view, M3e.IconButton.view, M3e.Fab.view, M3e.Chip.view move
  from 3-arg hybrid (④) to 2-arg double-list (③).
- The 3-arg hybrid now lives at M3e.Record.<Comp>.view.
- M3e.elm barrel entries for these four components point at ③.
- New M3e/Record.elm barrel surfaces the ④ shortcut (M3e.Record.button
  etc.) for the four required-bearing components.

Per ADR 0013's namespace assignment; ⑤ ships in the second wave.

Governing spec:
docs/superpowers/specs/2026-07-03-generator-shape-selector-design.md

Generated with [Claude Code](https://claude.ai/code)
via [Happy](https://happy.engineering)

Co-Authored-By: Claude <noreply@anthropic.com>
Co-Authored-By: Happy <yesreply@happy.engineering>
EOF
)"
```

---

### Task 10: Verify Definition of Done

**Files:** none modified — this is a checkpoint against the spec's §11 DoD.

- [ ] **Step 1: `Generate.elm` refactored with `shapesFor` + per-shape emitters**

```bash
grep -n "shapesFor\|generateShape3Module\|generateShape4Module" /Users/jhp/code/jackhp95/elm-m3e/elm-cem/codegen/Generate.elm
```

Expected: all three appear. No remaining references to `hasRecord` at the
top-level dispatch (may still be used internally in `shapesFor`).

- [ ] **Step 2: ③ modules exist for every component**

```bash
ls /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/src/M3e/*.elm | wc -l
```

Expected: ~127 files (matching CEM component count minus group-folded ones).

- [ ] **Step 3: ④ modules exist for the four required-bearing components only**

```bash
ls /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/src/M3e/Record/
```

Expected: exactly `Button.elm`, `IconButton.elm`, `Fab.elm`, `Chip.elm`.

- [ ] **Step 4: Both barrels exist and are correct**

```bash
head -5 /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/src/M3e.elm
head -5 /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/src/M3e/Record.elm
```

Expected: `M3e.elm` exposes ~127 lowercase entries; `M3e/Record.elm`
exposes exactly `button`, `iconButton`, `fab`, `chip`.

- [ ] **Step 5: Facts module carries shapes + requiredAttrs**

```bash
head -20 /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/src/M3e/Review/Facts.elm
grep -A 8 '"m3e-button"' /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/src/M3e/Review/Facts.elm | head -12
```

Expected: `shapes = [Shape3, Shape4]` and `requiredAttrs = [...]` fields
present on Button's fact record.

- [ ] **Step 6: `pnpm run check` still passes**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e
pnpm run check
```

Expected: pass. Repeat of Task 9 Step 7 — final gate.

- [ ] **Step 7: Update the epic**

```bash
gh issue view 138 --json body -q .body > /tmp/issue-138.md
# Manually check off B1 and B2 in the shipped list; mark M3e/Record.elm
# barrel emission as noted in the first ship's completed pieces.
```

Then edit and push via `gh issue edit 138 --body-file /tmp/issue-138.md`.

- [ ] **Step 8: Final commit if any (should not be — all changes committed in Task 9)**

```bash
git status
```

Expected: clean.

---

## Self-Review Notes

Spec coverage: every section of the design doc maps to at least one task
(§4 `shapesFor` → T1, §5 shape ③ setters → T5, §6 code structure → T2-5,
§7 barrels → T6, §8 facts handoff → T7, §9 migration → T9, §10 invariants
→ T7 comment + T9's check gate, §11 DoD → T10).

Placeholder scan: some steps reference "adjust to actual type" or "check
the repo's regen script" — these are unavoidable without live access to the
gitignored elm-cem clone at plan-writing time. The implementer resolves
them by grepping the actual file when executing.

Type consistency: `SharedCtx` used consistently in T3-5. `Shape` type used
consistently in T1-2, T6-7. `TopModule.shape` field added in T2, used in
T6-7.

## Execution Handoff

Plan complete and saved to `docs/superpowers/plans/2026-07-03-generator-shape-selector.md`. Two execution options:

**1. Subagent-Driven (recommended)** — I dispatch a fresh subagent per task, review between tasks, fast iteration.

**2. Inline Execution** — Execute tasks in this session using executing-plans, batch execution with checkpoints.

Which approach?
