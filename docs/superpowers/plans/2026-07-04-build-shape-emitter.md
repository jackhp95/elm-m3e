> **SUPERSEDED (2026-07-04)** — Replaced by `docs/superpowers/plans/2026-07-04-build-shape-crossbar.md`.
> The emitter Tasks 4–10 in this file were rewritten during the crossbar redesign;
> Tasks 1–3 survived. See `docs/superpowers/specs/2026-07-04-build-shape-crossbar-design.md`
> for design rationale.

# ⑤ Build Shape Emitter Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Ship the ⑤ Build shape emitter: `generateBuildModule` in `elm-cem`, plus regenerated `packages/m3e/src/M3e/Build/*.elm` (128 per-component modules + `Internal.elm`), delivering compile-time enforcement of duplicate-singular impossibility and required-multi presence.

**Architecture:** New emitter sibling of `generateShape3Module` / `generateShape4Module` in `elm-cem/codegen/Generate.elm`. Consumes `SharedCtx` for per-component data. Emits phantom-typed `Builder attrCaps slotCaps msg` with four setter templates (consuming-singular, passthrough-multi, ratchet-required-multi, plus required-singular via the seed record). Ratchet pattern validated in `elm-cem/spikes/build-shape/ratchet-check/`. Prior art in `elm-cem/spikes/build-shape/codegen/src/Spike.elm` (~354 lines) demonstrates every elm-codegen call needed.

**Tech Stack:** Elm 0.19.1; `mdgriffith/elm-codegen@0.6.3`; `elm-cem` (Node.js CLI + Elm codegen); pnpm; existing `packages/m3e` package layout.

## Global Constraints

- Governing spec: `docs/superpowers/specs/2026-07-04-build-shape-emitter-design.md`.
- Governing ADR (amended): `docs/adr/0013-top-shape-matrix-and-translation.md`.
- Cross-spec coordination: `docs/superpowers/specs/2026-07-03-epic-138-shipping-coordination.md`.
- ⑤ is purely additive. No changes to first-ship generator dispatch, Facts schema (beyond adding `Shape5` to the enum), or review rules.
- Every top shape returns `Element supported msg` — `build` returns `Element`, not `Html`. Single eager point unchanged.
- All 128 components emit ⑤ (uniform, no gating). Degenerate components produce empty `AttrCaps` / `SlotCaps`.
- No `M3e.Build.elm` barrel.
- Named type aliases (`AttrCaps`, `SlotCaps`) referenced by name to keep `docs.json` clean (spike learning #2).
- Every exposed declaration MUST have `|> Elm.withDocumentation "..."` (spike learning #5).
- `M3e.Build.Internal` emitted by the generator; not a hand-written checked-in file.
- The regen command (from HANDOFF.md):
  ```
  PATH="/Users/jhp/code/jackhp95/elm-m3e/elm-cem/node_modules/.bin:$PATH" \
    node elm-cem/bin/elm-cem.js \
      --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json \
      --config-from=config/slots.json \
      --config-from=config/examples.generated.json \
      --output=packages/m3e/src
  ```
- Test suites:
  - elm-cem: `cd elm-cem && PATH="./node_modules/.bin:$PATH" pnpm run test` — 116 passing at start.
  - review: `PATH="./docs/node_modules/.bin:/Users/jhp/.elm/elm-tooling/elm-test-rs/3.0.0:$PATH" elm-test-rs --project review review/tests/*.elm` — 78 passing at start.
  - packages/m3e compile: `cd packages/m3e && PATH="/Users/jhp/code/jackhp95/elm-m3e/node_modules/.bin:$PATH" elm make src/M3e.elm --output=/dev/null` — 378 modules at start.

---

## File Structure Overview

**Modified files (elm-cem clone):**
- `elm-cem/codegen/Generate.elm` — the main changes. Extends `Shape`, `shapesFor`, `generateTopModules`, adds `generateBuildModule` + `Internal` emission, extends `ExampleRecord`, extends emitted `M3e.Review.Facts` shape enum.
- `elm-cem/tests/src/GoldenTest.elm` — fixture + assertions for `X/Build/*` modules.

**New files (outer repo, generated):**
- `packages/m3e/src/M3e/Build/Internal.elm` (generated).
- `packages/m3e/src/M3e/Build/<Comp>.elm` × 128 (generated).

**Modified files (outer repo):**
- `packages/m3e/elm.json` — `exposed-modules` list gains 129 entries (auto-synced by `bin/elm-cem.js::syncExposedModules`).
- `packages/m3e/src/M3e/Review/Facts.elm` — regenerated with `Shape5` in the enum + every component's `shapes` list.
- `config/examples.rich.json` / `config/examples.generated.json` — one component (Button) gains a `codeShape5` sample.

**New tests:**
- `packages/m3e/tests/BuildShapeTest.elm` — positive type-behavior test.
- `packages/m3e/tests/BuildShapeNegative.elm` — separate file for negative case (must fail compilation). Not run by elm-test-rs; verified via a `test` step that intentionally runs `elm make` and expects failure.

---

### Task 1: Add `Shape5` to the `Shape` type + extend `shapesFor` + extend emitted Facts

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — the `Shape` type (~line 220), `shapesFor` (~line 260), and `generateReviewFacts.shapeName` / emitted `type Shape` alias (~line 895).

**Interfaces:**
- Produces: `type Shape = Shape3 | Shape4 | Shape5`; `shapesFor` result always contains `Shape5`; emitted `M3e.Review.Facts.Shape` alias includes `Shape5`.

- [ ] **Step 1: Extend the internal `Shape` type**

In `elm-cem/codegen/Generate.elm`, locate the `type Shape` declaration (currently `Shape3 | Shape4`, with a doc comment mentioning "in the second ship it gains `Shape5`"). Replace with:

```elm
{-| Which shape a component's top module emits.

- `Shape3` — always emitted; the loose double-list top layer (`M3e.<Comp>`).
- `Shape4` — emitted when the component has a required record.
- `Shape5` — always emitted; the compile-time-safe Build shape (`M3e.Build.<Comp>`).
-}
type Shape
    = Shape3
    | Shape4
    | Shape5
```

- [ ] **Step 2: Extend `shapesFor` to always include `Shape5`**

Find `shapesFor : Config -> LibraryInfo -> Cem.Declaration -> List Shape`. Its current body returns `[ Shape3 ]` or `[ Shape3, Shape4 ]`. Append `Shape5` unconditionally:

```elm
shapesFor : Config -> LibraryInfo -> Cem.Declaration -> List Shape
shapesFor config libraryInfo decl =
    let
        base =
            -- existing computation returning [ Shape3 ] or [ Shape3, Shape4 ]
            <existing body>
    in
    base ++ [ Shape5 ]
```

Preserve the existing shape-3/shape-4 logic verbatim; only append.

- [ ] **Step 3: Extend `generateReviewFacts.shapeName`**

Find `shapeName` (near line 895). Add the `Shape5` case:

```elm
shapeName shape =
    case shape of
        Shape3 ->
            "Shape3"

        Shape4 ->
            "Shape4"

        Shape5 ->
            "Shape5"
```

- [ ] **Step 4: Extend the emitted `M3e.Review.Facts.Shape` alias**

Find the string that emits the `Shape` type alias in the Facts module (search for `"type Shape"` in `generateReviewFacts`'s `contents` binding). Extend it to include `Shape5`:

```elm
"type Shape\n    = Shape3\n    | Shape4\n    | Shape5\n\n\n"
```

- [ ] **Step 5: Extend `generateTopModules` to no-op on `Shape5` (temporarily)**

Find `generateTopModules` (the dispatch loop). It currently maps over `shapesFor` and dispatches `Shape3` and `Shape4`. Add a `Shape5 ->` case that produces an empty file (no-op) for this task — full emission comes in Task 4. Example:

```elm
generateTopModules config libraryInfo component =
    shapesFor config libraryInfo component
        |> List.filterMap
            (\shape ->
                case shape of
                    Shape3 ->
                        Just (generateShape3Module config libraryInfo component)

                    Shape4 ->
                        Just (generateShape4Module config libraryInfo component)

                    Shape5 ->
                        Nothing
            )
```

Note the switch from `List.map` to `List.filterMap` so `Nothing` results drop cleanly. Preserve the `.file`/`.noun`/`.viewType`/`.shape` fields on the returned `TopModule` records.

- [ ] **Step 6: Update `ShapesForTest.elm` to expect `Shape5`**

In `elm-cem/tests/src/ShapesForTest.elm`, update every expected output to append `Shape5`. Example: a test expecting `[ Shape3 ]` now expects `[ Shape3, Shape5 ]`; a test expecting `[ Shape3, Shape4 ]` now expects `[ Shape3, Shape4, Shape5 ]`.

- [ ] **Step 7: Run the elm-cem tests + regen**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
PATH="./node_modules/.bin:$PATH" pnpm run test 2>&1 | tail -3
```
Expected: all tests pass (116 or more, depending on ShapesForTest updates).

Regen from the outer repo:

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
PATH="/Users/jhp/code/jackhp95/elm-m3e/elm-cem/node_modules/.bin:$PATH" \
  node elm-cem/bin/elm-cem.js \
    --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json \
    --config-from=config/slots.json \
    --config-from=config/examples.generated.json \
    --output=packages/m3e/src 2>&1 | tail -5
```

Verify `M3e.Review.Facts` now shows `Shape5`:

```bash
head -20 packages/m3e/src/M3e/Review/Facts.elm
grep '"button"' packages/m3e/src/M3e/Review/Facts.elm | grep -o 'shapes = [^]]*\]'
```

Expected: type alias includes `Shape5`; Button's shapes list is `[ Shape3, Shape4, Shape5 ]`.

Compile:

```bash
cd packages/m3e && \
PATH="/Users/jhp/code/jackhp95/elm-m3e/node_modules/.bin:$PATH" \
  elm make src/M3e.elm --output=/dev/null 2>&1 | tail -1
```
Expected: `Success!` (378 modules — no Build modules yet).

- [ ] **Step 8: Commit in the elm-cem clone**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
git add codegen/Generate.elm tests/src/ShapesForTest.elm && \
git commit -m "feat(codegen): add Shape5 to Shape enum + shapesFor + Facts (no emission yet)"
```

- [ ] **Step 9: Commit the outer repo regen**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
git add packages/m3e/src/M3e/Review/Facts.elm && \
git commit -m "regen(m3e): Facts.Shape enum + shapes lists include Shape5"
```

---

### Task 2: Emit `M3e/Build/Internal.elm`

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — add `generateBuildInternalModule` function, wire into `generateFromManifest`.

**Interfaces:**
- Produces: `M3e/Build/Internal.elm` emitted alongside other runtime modules; exposes `Available`, `Used`, `NotFilled`, `Filled` as custom types.
- Consumed by: Task 4+ (`generateBuildModule` references these markers).

- [ ] **Step 1: Add `generateBuildInternalModule` helper**

Add near the other generator sub-emitters (e.g. after `generateBottomVocabModule`). Reference `elm-cem/spikes/build-shape/codegen/src/Spike.elm` lines 90-135 for the exact `Elm.customType` pattern (the spike's `internalFile` demonstrates emitting `Available`/`Used`; extend to include `NotFilled`/`Filled`):

```elm
generateBuildInternalModule : LibraryInfo -> Elm.File
generateBuildInternalModule libraryInfo =
    let
        markerType name docString =
            Elm.customType name [ Elm.variant name ]
                |> Elm.expose
                |> Elm.withDocumentation docString
    in
    Elm.fileWith [ libraryInfo.moduleName, "Build", "Internal" ]
        { docs =
            """Marker types for `""" ++ libraryInfo.moduleName ++ """.Build.*` capability-row phantoms.

The `Available → Used` transition guards optional-singular setters: applying a
setter twice is a compile-time TYPE MISMATCH. The `NotFilled → Filled` ratchet
guards required-multi slots: `build` refuses to type-check when a required-multi
slot has zero applications."""
        , aliases = []
        }
        [ markerType "Available" "Optional-singular capability that has not yet been used."
        , markerType "Used" "Optional-singular capability that has been used and cannot be applied again."
        , markerType "NotFilled" "Required-multi slot that has not yet been filled. `build` requires `Filled`."
        , markerType "Filled" "Required-multi slot that has been filled at least once."
        ]
```

- [ ] **Step 2: Wire into `generateFromManifest`**

Find `generateFromManifest` (~line 440-540). Locate where the runtime-ish modules are assembled (e.g., where `barrelModule` or `valueModule` is added to the file list). Add:

```elm
buildInternalModule =
    generateBuildInternalModule libraryInfo
```

And include it in the final `List Elm.File` returned from `generateFromManifest`. Search for a construct like `runtimeModules ++ groupModules ++ (barrelModule :: barrelRecordModules ++ ...)` — append `buildInternalModule` to the front:

```elm
buildInternalModule
    :: runtimeModules
    ++ groupModules
    ++ (barrelModule :: barrelRecordModules)
    ++ (valueModule :: reviewFactsModule :: bottomVocabModule :: cemVocabModule :: componentModules)
```

- [ ] **Step 3: Regen and verify the file exists**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
PATH="/Users/jhp/code/jackhp95/elm-m3e/elm-cem/node_modules/.bin:$PATH" \
  node elm-cem/bin/elm-cem.js \
    --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json \
    --config-from=config/slots.json \
    --config-from=config/examples.generated.json \
    --output=packages/m3e/src 2>&1 | tail -3

cat packages/m3e/src/M3e/Build/Internal.elm
```

Expected: file exists, exposes `Available, Used, NotFilled, Filled` custom types with doc comments.

- [ ] **Step 4: Compile check**

```bash
cd packages/m3e && \
PATH="/Users/jhp/code/jackhp95/elm-m3e/node_modules/.bin:$PATH" \
  elm make src/M3e/Build/Internal.elm --output=/dev/null 2>&1 | tail -1
```
Expected: `Success!`

Full package compile:

```bash
elm make src/M3e.elm --output=/dev/null 2>&1 | tail -1
```
Expected: `Success! Compiled 379 modules.` (378 + Internal).

Also verify elm.json exposed-modules was auto-synced:

```bash
grep '"M3e.Build.Internal"' packages/m3e/elm.json
```
Expected: match on one line.

- [ ] **Step 5: Commit in elm-cem clone**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
git add codegen/Generate.elm && \
git commit -m "feat(codegen): emit M3e/Build/Internal.elm (Available, Used, NotFilled, Filled)"
```

- [ ] **Step 6: Commit outer repo regen**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
git add packages/m3e/src/M3e/Build/Internal.elm packages/m3e/elm.json && \
git commit -m "regen(m3e): add M3e/Build/Internal.elm marker types"
```

---

### Task 3: Extend `ExampleRecord` with `codeShape5`

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — `ExampleRecord` type alias, `exampleDecoder`.

**Interfaces:**
- Produces: `ExampleRecord.codeShape5 : Maybe String` field, decoded from optional `"codeShape5"` JSON field.
- Consumed by: Task 4+ (`generateBuildModule` docstring assembly).

- [ ] **Step 1: Extend the `ExampleRecord` type alias**

Find `ExampleRecord` (~line 51-52). Current shape (after issue #143's `codeShape4`):

```elm
type alias ExampleRecord =
    { title : String
    , code : String
    , section : Maybe String
    , codeShape4 : Maybe String
    }
```

Add `codeShape5 : Maybe String`:

```elm
type alias ExampleRecord =
    { title : String
    , code : String
    , section : Maybe String
    , codeShape4 : Maybe String
    , codeShape5 : Maybe String
    }
```

- [ ] **Step 2: Extend `exampleDecoder`**

Find `exampleDecoder` (~line 363). Bump the mapN version and add the new decoder:

```elm
exampleDecoder =
    Json.Decode.map5
        (\t c s c4 c5 ->
            { title = t, code = c, section = s, codeShape4 = c4, codeShape5 = c5 }
        )
        (opt "title" Json.Decode.string "")
        (opt "code" Json.Decode.string "")
        (Json.Decode.maybe (Json.Decode.field "section" Json.Decode.string))
        (Json.Decode.maybe (Json.Decode.field "codeShape4" Json.Decode.string))
        (Json.Decode.maybe (Json.Decode.field "codeShape5" Json.Decode.string))
```

- [ ] **Step 3: Update ShapesForTest fixtures**

`elm-cem/tests/src/ShapesForTest.elm` and `elm-cem/tests/src/ExampleDocsTest.elm` construct `ExampleRecord` values in fixtures. Add `codeShape5 = Nothing` to each. Grep to find them:

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
grep -rn "codeShape4" tests/ | head
```

For each hit, add the new field with `Nothing` default.

- [ ] **Step 4: Run tests**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
PATH="./node_modules/.bin:$PATH" pnpm run test 2>&1 | tail -3
```
Expected: all pass.

- [ ] **Step 5: Commit in elm-cem clone**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
git add codegen/Generate.elm tests/src/ShapesForTest.elm tests/src/ExampleDocsTest.elm && \
git commit -m "feat(codegen): add codeShape5 to ExampleRecord + decoder"
```

---

### Task 4: `generateBuildModule` skeleton — file emission with empty `Builder` / `AttrCaps` / `SlotCaps`

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — add `generateBuildModule` as a sibling of `generateShape3Module` / `generateShape4Module`.
- Modify: `elm-cem/tests/src/GoldenTest.elm` — assert `X/Build/Button.elm` and `X/Build/Foo.elm` exist in the emitted set.

**Interfaces:**
- Consumes: `SharedCtx` (from Task 3 of the shape-selector work), `Facts.callSite` in review context (unrelated), and `Internal` marker types from Task 2.
- Produces: `generateBuildModule : Config -> LibraryInfo -> Cem.Declaration -> TopModule` emitting to `M3e/Build/<Comp>.elm`. This task ships a SKELETON: module path, `type alias Builder`, `type alias AttrCaps`, `type alias SlotCaps` (empty rows for now), no seed / setters / build.

- [ ] **Step 1: Write the skeleton `generateBuildModule`**

Add near the other `generateShapeNModule` functions. Reference `elm-cem/spikes/build-shape/codegen/src/Spike.elm` lines 137-200 for the `Builder` custom type + `AttrCaps`/`SlotCaps` alias patterns.

```elm
generateBuildModule : Config -> LibraryInfo -> Cem.Declaration -> TopModule
generateBuildModule config libraryInfo component =
    let
        ctx =
            buildSharedCtx config libraryInfo component

        lib =
            libraryInfo.moduleName

        modulePath =
            [ lib, "Build", ctx.moduleName ]

        internalModule =
            [ lib, "Build", "Internal" ]

        -- Empty capability rows for this task; Tasks 5-9 populate them.
        attrCapsAlias =
            Elm.alias "AttrCaps" (Type.record [])
                |> Elm.expose
                |> Elm.withDocumentation "Per-component attribute capability row for the phantom-typed Builder."

        slotCapsAlias =
            Elm.alias "SlotCaps" (Type.record [])
                |> Elm.expose
                |> Elm.withDocumentation "Per-component slot capability row for the phantom-typed Builder."

        -- Private Fields record — the payload the opaque Builder wraps.
        -- For this task, an empty record; Tasks 5+ populate.
        fieldsAlias =
            Elm.alias "Fields" (Type.record [])

        builderType =
            Elm.customTypeWith "Builder"
                [ "attrCaps", "slotCaps", "msg" ]
                [ Elm.variantWith "Builder"
                    [ Type.namedWith [] "Fields" [ Type.var "msg" ] ]
                ]
                |> Elm.expose
                |> Elm.withDocumentation ("Opaque builder for `<" ++ (component.tagName |> Maybe.withDefault "unknown") ++ ">`; see `.build` for the terminal.")

        file =
            Elm.fileWith modulePath
                { docs = "The ⑤ Build shape for `<" ++ (component.tagName |> Maybe.withDefault ctx.moduleName) ++ ">` — phantom-typed pipeline API. Import qualified: `import " ++ String.join "." modulePath ++ " as " ++ ctx.moduleName ++ "`."
                , aliases = []
                }
                [ builderType
                , attrCapsAlias
                , slotCapsAlias
                , fieldsAlias
                ]
    in
    { file = file
    , noun = ctx.noun
    , viewType = Type.namedWith [ lib, "Element" ] "Element" [ Type.var "s", Type.var "msg" ]
    , shape = Shape5
    }
```

- [ ] **Step 2: Wire `Shape5` dispatch in `generateTopModules`**

Replace the `Shape5 -> Nothing` case (from Task 1 Step 5) with:

```elm
Shape5 ->
    Just (generateBuildModule config libraryInfo component)
```

Switch back to `List.map` (or keep `List.filterMap` with `Just`). Match the pre-Task-1 style.

- [ ] **Step 3: Extend GoldenTest fixture assertions**

In `elm-cem/tests/src/GoldenTest.elm`, add a test asserting that Build modules exist for both fixture components:

```elm
        , describe "⑤ Build shape emission"
            [ test "emits X/Build/Button.elm and X/Build/Foo.elm" <|
                \_ ->
                    let
                        paths =
                            emitted |> List.map .path |> List.sort
                    in
                    Expect.all
                        [ \ps -> Expect.equal True (List.member "X/Build/Button.elm" ps)
                        , \ps -> Expect.equal True (List.member "X/Build/Foo.elm" ps)
                        , \ps -> Expect.equal True (List.member "X/Build/Internal.elm" ps)
                        ]
                        paths
            , test "Build module declares Builder, AttrCaps, SlotCaps" <|
                \_ ->
                    let
                        buildButton =
                            contentsOf "X/Build/Button.elm"
                    in
                    Expect.all
                        [ expectContains "type Builder attrCaps slotCaps msg"
                        , expectContains "type alias AttrCaps"
                        , expectContains "type alias SlotCaps"
                        ]
                        buildButton
            ]
```

- [ ] **Step 4: Update the module-structure test**

Extend the existing "emits the full 3-layer module set" test's expected file list to include `X/Build/Button.elm`, `X/Build/Foo.elm`, `X/Build/Internal.elm`. Preserve alphabetic sort order.

- [ ] **Step 5: Run tests**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
PATH="./node_modules/.bin:$PATH" pnpm run test 2>&1 | tail -3
```
Expected: all pass.

- [ ] **Step 6: Regen and compile**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
PATH="/Users/jhp/code/jackhp95/elm-m3e/elm-cem/node_modules/.bin:$PATH" \
  node elm-cem/bin/elm-cem.js \
    --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json \
    --config-from=config/slots.json \
    --config-from=config/examples.generated.json \
    --output=packages/m3e/src 2>&1 | tail -3

ls packages/m3e/src/M3e/Build/ | wc -l
cd packages/m3e && \
PATH="/Users/jhp/code/jackhp95/elm-m3e/node_modules/.bin:$PATH" \
  elm make src/M3e.elm --output=/dev/null 2>&1 | tail -1
```
Expected: 129 files under `M3e/Build/` (128 components + Internal). `Success!` compile.

- [ ] **Step 7: Commit both repos**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
git add codegen/Generate.elm tests/src/GoldenTest.elm && \
git commit -m "feat(codegen): generateBuildModule skeleton (Builder/AttrCaps/SlotCaps aliases)"

cd /Users/jhp/code/jackhp95/elm-m3e && \
git add packages/m3e/src/M3e/Build/ packages/m3e/elm.json && \
git commit -m "regen(m3e): 128 M3e/Build/<Comp>.elm skeletons"
```

---

### Task 5: Seed function emission

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — add seed logic to `generateBuildModule`.

**Interfaces:**
- Consumes: `SharedCtx.requiredType` (the required-record type for Shape4), `SharedCtx.slots`, `SharedCtx.specs`, `SharedCtx.extra`.
- Produces: `<comp> : <RequiredRecord> -> Builder AttrCaps SlotCaps msg` seed function. `Fields` private alias populated with all fields (required + optional). Private `defaults` value initializing all optional fields to `Nothing` / `[]`.

- [ ] **Step 1: Compute the `Fields` alias**

Populate `fieldsAlias`. The record type has:
- One field per required-singular slot (from `ctx.requiredSingular`) — kind: the slot's element kind type.
- One field per optional-singular attr — kind: `Maybe (attrInputType)`.
- One field per event — kind: `Maybe (Decoder Msg)`.
- One field per optional-singular slot — kind: `Maybe (Content or Element)`.
- One field per optional-multi and required-multi slot — kind: `List (Content or Element)`.
- One field per extra (e.g., `action`) — kind depends on `extraFieldType` (existing helper).

Reference `SharedCtx.requiredType` for the required-singular field types. For optional attrs, reference `attrInputType lib s` from the existing generator.

Draft:

```elm
fieldEntries : List ( String, Type.Annotation )
fieldEntries =
    List.concat
        [ List.map (\s -> ( reqFieldName s, elementKindType s.kinds )) ctx.requiredSingular
        , List.map (\( f, k ) -> ( safeField f, extraFieldType k )) ctx.extra
        , List.map (\s -> ( safeField s.elmName, Type.maybe (attrInputType lib s) )) optionalSpecs
        , List.map (\ev -> ( safeField (eventHandlerName libraryInfo ev), Type.maybe decoderMsgType )) events
        , List.map (\s -> ( safeField (Naming.decapitalize (Naming.pascal s.name)), Type.maybe (elementKindType s.kinds) )) optionalSingularSlots
        , List.map (\s -> ( safeField (Naming.decapitalize (Naming.pascal s.name)), Type.list (elementKindType s.kinds) )) multiSlots
        ]

fieldsAlias =
    Elm.alias "Fields" (Type.record fieldEntries)
```

Where `optionalSpecs`, `optionalSingularSlots`, `multiSlots` are locally computed from `ctx.specs` and `ctx.slots` — filter out required-singular (they're in the required record) and split multi from singular.

- [ ] **Step 2: Emit a private `defaults` value**

```elm
defaultsExpr : Elm.Expression
defaultsExpr =
    -- Only optional / multi fields need defaults; required-singular is filled by the seed.
    Elm.record
        (List.concat
            [ List.map (\( f, _ ) -> ( safeField f, Elm.value { importFrom = [], name = "Debug.todo", annotation = Nothing } )) ctx.requiredSingular  -- placeholder; overridden by seed body
            , List.map (\s -> ( safeField s.elmName, Elm.value { importFrom = [], name = "Maybe.Nothing", annotation = Nothing } )) optionalSpecs
            -- ... etc for other categories
            ]
        )
```

**Simplification:** rather than emitting a top-level `defaults` value, inline the record literal in the seed body. The seed passes required-singular values from `req` directly and hardcodes `Nothing`/`[]` for optionals. That produces a longer seed body but avoids naming collisions and simplifies emission.

Preferred approach:

```elm
seedBodyRecord : Elm.Expression -> Elm.Expression
seedBodyRecord reqE =
    Elm.record
        (List.concat
            [ List.map (\s -> ( reqFieldName s, Elm.get (reqFieldName s) reqE )) ctx.requiredSingular
            , List.map (\( f, _ ) -> ( safeField f, Elm.get (safeField f) reqE )) ctx.extra
            , List.map (\s -> ( safeField s.elmName, Elm.value { importFrom = [ "Maybe" ], name = "Nothing", annotation = Nothing } )) optionalSpecs
            , List.map (\ev -> ( safeField (eventHandlerName libraryInfo ev), Elm.value { importFrom = [ "Maybe" ], name = "Nothing", annotation = Nothing } )) events
            , List.map (\s -> ( safeField (Naming.decapitalize (Naming.pascal s.name)), Elm.value { importFrom = [ "Maybe" ], name = "Nothing", annotation = Nothing } )) optionalSingularSlots
            , List.map (\s -> ( safeField (Naming.decapitalize (Naming.pascal s.name)), Elm.list [] )) multiSlots
            ]
        )
```

- [ ] **Step 3: Emit the seed function**

```elm
seedDecl =
    Elm.declaration ctx.noun
        (Elm.fn (Elm.Arg.varWith "req" ctx.requiredType)
            (\reqE ->
                Elm.apply (Elm.value { importFrom = [], name = "Builder", annotation = Nothing })
                    [ seedBodyRecord reqE ]
            )
            |> Elm.withType (Type.function [ ctx.requiredType ] (Type.namedWith modulePath "Builder" [ Type.namedWith modulePath "AttrCaps" [], Type.namedWith modulePath "SlotCaps" [], Type.var "msg" ]))
        )
        |> Elm.expose
        |> Elm.withDocumentation ("Seed a `Builder` for `<" ++ (component.tagName |> Maybe.withDefault ctx.moduleName) ++ ">` with the required fields.")
```

For components with no required record (empty `requiredType`), the seed takes no argument:

```elm
if List.isEmpty ctx.requiredSingular && List.isEmpty ctx.extra then
    -- No required record; seed takes no args
    Elm.declaration ctx.noun
        (Elm.apply (Elm.value { importFrom = [], name = "Builder", annotation = Nothing })
            [ emptyFieldsRecord ]
            |> Elm.withType (Type.namedWith modulePath "Builder" [ ... ])
        )
        |> Elm.expose
        |> Elm.withDocumentation "Seed a `Builder`."
else
    -- Above pattern
```

Add `seedDecl` to the file's declarations list.

- [ ] **Step 4: Update `AttrCaps` and `SlotCaps` alias contents**

Both are still empty in this task's scaffolding — but the Fields record is now populated. Later tasks (setters) will populate the caps rows.

For components with no required record and no optional/multi fields (rare edge cases), the seed still emits — just with an empty record.

- [ ] **Step 5: Regen and inspect Button's seed**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
PATH="/Users/jhp/code/jackhp95/elm-m3e/elm-cem/node_modules/.bin:$PATH" \
  node elm-cem/bin/elm-cem.js ...

head -50 packages/m3e/src/M3e/Build/Button.elm
```

Expected: `button : { content : ..., action : ... } -> Builder AttrCaps SlotCaps msg` function present with a body constructing a `Builder` value.

- [ ] **Step 6: Compile check**

```bash
cd packages/m3e && \
PATH="/Users/jhp/code/jackhp95/elm-m3e/node_modules/.bin:$PATH" \
  elm make src/M3e.elm --output=/dev/null 2>&1 | tail -1
```
Expected: `Success!`

- [ ] **Step 7: Run elm-cem tests**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
PATH="./node_modules/.bin:$PATH" pnpm run test 2>&1 | tail -3
```
Expected: all pass.

- [ ] **Step 8: Commit both repos**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
git add codegen/Generate.elm && \
git commit -m "feat(codegen): emit seed function + Fields payload in Build module"

cd /Users/jhp/code/jackhp95/elm-m3e && \
git add packages/m3e/src/M3e/Build/ && \
git commit -m "regen(m3e): Build modules gain seed functions"
```

---

### Task 6: Setter template — optional-singular (attr, event, slot)

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — add optional-singular setter emission logic.

**Interfaces:**
- Consumes: `SharedCtx.specs`, `ctx.events`, `optionalSingularSlots` (computed from `ctx.slots`), `Internal.Available`/`Internal.Used` marker types.
- Produces: One setter per optional-singular attr, event, and slot per component. Type: `<InputType> -> Builder { a | <field> : Available } s msg -> Builder { a | <field> : Used } s msg`. Also populates `AttrCaps` / `SlotCaps` type aliases with the corresponding `Available` fields.

- [ ] **Step 1: Populate `AttrCaps` and `SlotCaps`**

Replace the empty `attrCapsAlias` and `slotCapsAlias` with populated rows:

```elm
attrCapsFields =
    List.concat
        [ List.map (\s -> ( safeField s.elmName, available )) optionalSpecs
        , List.map (\ev -> ( safeField (eventHandlerName libraryInfo ev), available )) events
        ]

slotCapsFields =
    -- populated in Tasks 7 (multi passthrough — no field entry needed) and 9 (required-multi — NotFilled)
    -- for THIS task, only optional-singular slots contribute
    List.map (\s -> ( safeField (Naming.decapitalize (Naming.pascal s.name)), available )) optionalSingularSlots

available = Type.namedWith internalModule "Available" []

attrCapsAlias =
    Elm.alias "AttrCaps" (Type.record attrCapsFields) |> Elm.expose |> Elm.withDocumentation "..."

slotCapsAlias =
    Elm.alias "SlotCaps" (Type.record slotCapsFields) |> Elm.expose |> Elm.withDocumentation "..."
```

- [ ] **Step 2: Emit consuming-singular setter template**

Reference `elm-cem/spikes/build-shape/codegen/src/Spike.elm` lines 200-260 for `variantSetterDecl` — the exact `Elm.Arg.customType "Builder" identity |> Elm.Arg.item (Elm.Arg.var "f")` destructure and the `Type.function ... withType` overriding pattern.

```elm
consumingSingularAttrSetter : Attr.AttrSpec -> Elm.Declaration
consumingSingularAttrSetter s =
    let
        inputType =
            attrInputType lib s

        signature =
            Type.function
                [ inputType
                , Type.namedWith modulePath "Builder"
                    [ Type.extensible "a" [ ( safeField s.elmName, available ) ]
                    , Type.var "s"
                    , Type.var "msg"
                    ]
                ]
                (Type.namedWith modulePath "Builder"
                    [ Type.extensible "a" [ ( safeField s.elmName, used ) ]
                    , Type.var "s"
                    , Type.var "msg"
                    ]
                )
    in
    Elm.declaration s.elmName
        (Elm.fn2 (Elm.Arg.varWith "value" inputType)
            (Elm.Arg.customType "Builder" identity |> Elm.Arg.item (Elm.Arg.var "f"))
            (\valueE fE ->
                Elm.apply (Elm.value { importFrom = [], name = "Builder", annotation = Nothing })
                    [ Elm.updateRecord [ ( safeField s.elmName, Elm.apply (Elm.value { importFrom = [ "Maybe" ], name = "Just", annotation = Nothing }) [ valueE ] ) ] fE ]
            )
            |> Elm.withType signature
        )
        |> Elm.expose
        |> Elm.withDocumentation (Attr.docString s)
```

Same helper for events (with `decoderMsgType` as input) and optional-singular slots (with `elementKindType s.kinds` as input, and slot field goes on `slotCaps` instead of `attrCaps` — pass the row parameter as `"s"` and put the field on that row).

- [ ] **Step 3: Add setters to the file's declaration list**

Extend `generateBuildModule`'s emitted declaration list:

```elm
setters =
    List.map consumingSingularAttrSetter optionalSpecs
        ++ List.map consumingSingularEventSetter events
        ++ List.map consumingSingularSlotSetter optionalSingularSlots
```

Order in the file's declaration list: `viewDecl :: setters ++ [buildDecl (Task 9)]`. For now (Task 6) skip `buildDecl` — the file compiles without it as long as `AttrCaps`/`SlotCaps`/`Builder`/`Fields`/`seed`/setters are all there. `build` lands in Task 9.

- [ ] **Step 4: Extend GoldenTest assertions**

Add a test that asserts Button's Build module contains a `variant` setter with the consuming-singular signature:

```elm
        , test "Build module has consuming-singular attr setter" <|
            \_ ->
                buildButton
                    |> expectContains "variant : M3e.Value.Value"  -- input type prefix
                    |> Expect.all
                        [ \_ -> Expect.pass ]

        , test "Build module setter type mentions Available and Used" <|
            \_ ->
                Expect.all
                    [ expectContains "Available"
                    , expectContains "Used"
                    ]
                    buildButton
```

- [ ] **Step 5: Regen and inspect Button's variant setter**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
PATH="/Users/jhp/code/jackhp95/elm-m3e/elm-cem/node_modules/.bin:$PATH" \
  node elm-cem/bin/elm-cem.js ...

grep -A 5 "^variant :" packages/m3e/src/M3e/Build/Button.elm | head
```

Expected: `variant : M3e.Value.Value ... -> Builder { a | variant : Available } ... -> Builder { a | variant : Used } ...`.

- [ ] **Step 6: Compile check**

```bash
cd packages/m3e && \
PATH="/Users/jhp/code/jackhp95/elm-m3e/node_modules/.bin:$PATH" \
  elm make src/M3e.elm --output=/dev/null 2>&1 | tail -1
```
Expected: `Success!`

- [ ] **Step 7: Run elm-cem tests**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
PATH="./node_modules/.bin:$PATH" pnpm run test 2>&1 | tail -3
```
Expected: all pass.

- [ ] **Step 8: Commit both repos**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
git add codegen/Generate.elm tests/src/GoldenTest.elm && \
git commit -m "feat(codegen): emit consuming-singular setters (attr, event, slot) in Build module"

cd /Users/jhp/code/jackhp95/elm-m3e && \
git add packages/m3e/src/M3e/Build/ && \
git commit -m "regen(m3e): Build modules gain consuming-singular setters"
```

---

### Task 7: Setter template — optional-multi (passthrough)

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — add optional-multi setter emission.

**Interfaces:**
- Consumes: `optionalMultiSlots` (computed from `ctx.slots`).
- Produces: One setter per optional-multi slot. Type: `<InputType> -> Builder a s msg -> Builder a s msg` — no phantom-row change. Body appends to the slot's list field.

- [ ] **Step 1: Emit passthrough-multi setter template**

```elm
optionalMultiSlotSetter : SlotSpec -> Elm.Declaration
optionalMultiSlotSetter s =
    let
        fieldName =
            safeField (Naming.decapitalize (Naming.pascal s.name))

        inputType =
            elementKindType s.kinds

        signature =
            Type.function
                [ inputType
                , Type.namedWith modulePath "Builder"
                    [ Type.var "a"
                    , Type.var "s"
                    , Type.var "msg"
                    ]
                ]
                (Type.namedWith modulePath "Builder"
                    [ Type.var "a"
                    , Type.var "s"
                    , Type.var "msg"
                    ]
                )
    in
    Elm.declaration s.name  -- setter name derived from slot name via camelCase
        (Elm.fn2 (Elm.Arg.varWith "el" inputType)
            (Elm.Arg.customType "Builder" identity |> Elm.Arg.item (Elm.Arg.var "f"))
            (\elE fE ->
                Elm.apply (Elm.value { importFrom = [], name = "Builder", annotation = Nothing })
                    [ Elm.updateRecord [ ( fieldName, Elm.apply (Elm.value { importFrom = [ "List" ], name = "append", annotation = Nothing }) [ Elm.get fieldName fE, Elm.list [ elE ] ] ) ] fE ]
            )
            |> Elm.withType signature
        )
        |> Elm.expose
        |> Elm.withDocumentation ("Add an element to the `" ++ s.name ++ "` (multi) slot.")
```

Setter name: kebab-slot-name camelCased. Reuse the existing `slotSetterName` helper from the Facts spec task.

- [ ] **Step 2: Add to the declaration list**

Extend the emitted declaration list:

```elm
setters =
    List.map consumingSingularAttrSetter optionalSpecs
        ++ List.map consumingSingularEventSetter events
        ++ List.map consumingSingularSlotSetter optionalSingularSlots
        ++ List.map optionalMultiSlotSetter optionalMultiSlots
```

- [ ] **Step 3: Extend GoldenTest fixture with an optional-multi slot**

Modify `buttonDecl` in `GoldenTest.elm` to include an optional-multi slot. Alternatively, extend `fooDecl`'s config to include one. Simplest: modify `buttonDecl` — add a slot `{ name = "children", ... }` and configure it as `multi = True, required = False` in `fooConfig` (rename to `fixtureConfig` if needed).

- [ ] **Step 4: Add GoldenTest assertion**

```elm
        , test "Build module has optional-multi passthrough setter" <|
            \_ ->
                buildButton
                    |> expectContains "children :"
                    |> Expect.all [ \_ -> Expect.pass ]
```

Verify the signature contains `Builder a s msg -> Builder a s msg` (no `Available` / `Used` mention).

- [ ] **Step 5: Regen, compile, tests**

Standard regen + `elm make` + `pnpm run test`. Expected: all pass.

- [ ] **Step 6: Commit both repos**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
git add codegen/Generate.elm tests/src/GoldenTest.elm && \
git commit -m "feat(codegen): emit optional-multi passthrough setters in Build module"

cd /Users/jhp/code/jackhp95/elm-m3e && \
git add packages/m3e/src/M3e/Build/ && \
git commit -m "regen(m3e): Build modules gain optional-multi setters"
```

---

### Task 8: Setter template — required-multi (ratchet)

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — add required-multi ratchet setter emission.

**Interfaces:**
- Consumes: `requiredMultiSlots` (computed from `ctx.slots`).
- Produces: One ratchet setter per required-multi slot. Type: `<InputType> -> Builder a { s | <field> : filled } msg -> Builder a { s | <field> : Filled } msg`. Also updates `SlotCaps` to start required-multi fields at `NotFilled` (not `Available`).

- [ ] **Step 1: Update `SlotCaps` alias to include required-multi as `NotFilled`**

Extend `slotCapsFields`:

```elm
slotCapsFields =
    List.concat
        [ List.map (\s -> ( safeField (slotSetterName s), available )) optionalSingularSlots
        , List.map (\s -> ( safeField (slotSetterName s), notFilled )) requiredMultiSlots
        ]

notFilled = Type.namedWith internalModule "NotFilled" []
```

Optional-multi slots do NOT contribute to `slotCaps` (passthrough — no field entry).

- [ ] **Step 2: Emit ratchet setter template**

```elm
requiredMultiSlotSetter : SlotSpec -> Elm.Declaration
requiredMultiSlotSetter s =
    let
        fieldName =
            safeField (slotSetterName s)

        inputType =
            elementKindType s.kinds

        -- Input row: { s' | <field> : filled }  where `filled` is a TYPE VARIABLE
        -- Output row: { s' | <field> : Filled } where `Filled` is a CONCRETE type
        signature =
            Type.function
                [ inputType
                , Type.namedWith modulePath "Builder"
                    [ Type.var "a"
                    , Type.extensible "s'" [ ( fieldName, Type.var "filled" ) ]
                    , Type.var "msg"
                    ]
                ]
                (Type.namedWith modulePath "Builder"
                    [ Type.var "a"
                    , Type.extensible "s'" [ ( fieldName, Type.namedWith internalModule "Filled" [] ) ]
                    , Type.var "msg"
                    ]
                )
    in
    Elm.declaration (slotSetterName s)
        (Elm.fn2 (Elm.Arg.varWith "el" inputType)
            (Elm.Arg.customType "Builder" identity |> Elm.Arg.item (Elm.Arg.var "f"))
            (\elE fE ->
                Elm.apply (Elm.value { importFrom = [], name = "Builder", annotation = Nothing })
                    [ Elm.updateRecord [ ( fieldName, Elm.apply (Elm.value { importFrom = [ "List" ], name = "append", annotation = Nothing }) [ Elm.get fieldName fE, Elm.list [ elE ] ] ) ] fE ]
            )
            |> Elm.withType signature
        )
        |> Elm.expose
        |> Elm.withDocumentation ("Add an element to the required `" ++ s.name ++ "` slot. Must be called at least once before `build`.")
```

The critical difference from the passthrough-multi setter is the phantom-row structure: input uses a type variable `filled` (accepts any state), output uses concrete `Filled`.

- [ ] **Step 3: Add to the declaration list**

```elm
setters =
    List.map consumingSingularAttrSetter optionalSpecs
        ++ List.map consumingSingularEventSetter events
        ++ List.map consumingSingularSlotSetter optionalSingularSlots
        ++ List.map optionalMultiSlotSetter optionalMultiSlots
        ++ List.map requiredMultiSlotSetter requiredMultiSlots
```

- [ ] **Step 4: Extend GoldenTest fixture with a required-multi slot**

Extend `fooConfig` in `GoldenTest.elm` — add a slot `{ name = "row", multi = True, required = True }`. This makes `fooDecl` have both required-singular (unnamed → in the required record) AND required-multi (row → ratchet setter).

- [ ] **Step 5: Add GoldenTest assertion**

```elm
        , test "Build module has required-multi ratchet setter" <|
            \_ ->
                let
                    buildFoo = contentsOf "X/Build/Foo.elm"
                in
                buildFoo
                    |> Expect.all
                        [ expectContains "row :"
                        , expectContains "NotFilled"
                        , expectContains "Filled"
                        , expectContains "s' | row : filled" -- lowercase = type var
                        ]
```

- [ ] **Step 6: Regen, compile, tests**

Standard regen + `elm make` + `pnpm run test`. Expected: all pass.

- [ ] **Step 7: Commit both repos**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
git add codegen/Generate.elm tests/src/GoldenTest.elm && \
git commit -m "feat(codegen): emit required-multi ratchet setters in Build module"

cd /Users/jhp/code/jackhp95/elm-m3e && \
git add packages/m3e/src/M3e/Build/ && \
git commit -m "regen(m3e): Build modules gain required-multi ratchet setters"
```

---

### Task 9: `build` terminal

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — add `build` terminal emission.

**Interfaces:**
- Consumes: The Builder's `Fields` payload, ⑤'s output type `Element supported msg`.
- Produces: `build : Builder a { s | <required-multi rows Filled> } msg -> Element ... msg`. Uses the same view construction path as Shape3/Shape4 (`build` calls into the same middle-layer component constructor).

- [ ] **Step 1: Reference the Shape3/Shape4 view construction**

Look at `generateShape3Module` and `generateShape4Module` in `elm-cem/codegen/Generate.elm`. Both use a `build` local helper (a different `build`, the one from `SharedCtx`) that assembles the view expression: `M3e.Element.fromNode (M3e.Node.fromComponent ...)`. The ⑤ `build` terminal does the same assembly, but the input is a `Builder` (destructured to `Fields`) rather than direct attrs / content lists.

- [ ] **Step 2: Emit the `build` terminal**

```elm
buildDecl : Elm.Declaration
buildDecl =
    let
        outputRowConstraint =
            -- Every required-multi slot must be Filled
            List.map (\s -> ( safeField (slotSetterName s), Type.namedWith internalModule "Filled" [] )) requiredMultiSlots

        signature =
            Type.function
                [ Type.namedWith modulePath "Builder"
                    [ Type.var "a"
                    , Type.extensible "s" outputRowConstraint
                    , Type.var "msg"
                    ]
                ]
                (Type.namedWith [ lib, "Element" ] "Element"
                    [ -- kind row for the output
                      Type.extensible "kind" [ ( ctx.noun ++ safeField "", supportedT ) ]
                    , Type.var "msg"
                    ]
                )
    in
    Elm.declaration "build"
        (Elm.fn (Elm.Arg.customType "Builder" identity |> Elm.Arg.item (Elm.Arg.var "f"))
            (\fE ->
                -- Construct the same view expression Shape3/Shape4 do,
                -- but reading fields from fE (the Fields record).
                buildViewExpr ctx fE
            )
            |> Elm.withType signature
        )
        |> Elm.expose
        |> Elm.withDocumentation ("Build the `<" ++ (component.tagName |> Maybe.withDefault "") ++ ">` element from a `Builder`.")
```

`buildViewExpr` mirrors the assembly in `generateShape4Module`'s `viewDecl` — but reads from `fE` (a record) instead of arguments. Reference `generateShape4Module`'s body-assembly helpers (`build`, `attrsWith`, `reqStampedNodes`, `smartAppend`, `contentNodes`) — they're already scoped under `SharedCtx` and can be reused. Adapt to read from the record: replace each argument reference with `Elm.get "fieldName" fE`.

For each field the assembly needs, unpack from `fE`:
- Attrs: `Elm.get "variant" fE` etc., then `Maybe.withDefault Nothing` handling for optional attrs.
- Content list: `List.map contentOfSetter fE.<slotName>` per slot.

Draft an intermediate helper:

```elm
buildViewExpr : SharedCtx -> Elm.Expression -> Elm.Expression
buildViewExpr ctx fE =
    let
        -- Convert optional attr fields into a Maybe-flattened list of Attr values
        attrsList =
            Elm.list
                (List.map (attrFromField fE) ctx.specs
                    ++ List.map (eventFromField fE) events
                )

        -- Convert required-singular slots + optional/multi slots into a content list
        contentList =
            Elm.list (List.concatMap (contentFromField fE) ctx.slots)
    in
    Elm.apply (ref [ lib, "Element" ] "fromNode")
        [ Elm.apply (ref [ lib, "Node" ] "fromComponent")
            [ Elm.apply (ref [ lib, "Cem", ctx.moduleName ] (Naming.decapitalize ctx.moduleName)) [ attrsList, contentList ]
            ]
        ]
```

`attrFromField`, `eventFromField`, `contentFromField` are small helpers — each takes a spec/slot + the `Fields` record expression and produces an `Elm.Expression` for the attr / content contribution.

The simplest MVP for this task: emit a `build` that produces a valid `Element` value, even if some optional-attr wiring is imperfect. Iterate in follow-ups if there are bugs.

- [ ] **Step 3: Add `buildDecl` to the file's declaration list**

```elm
declarations =
    [ builderType
    , attrCapsAlias
    , slotCapsAlias
    , fieldsAlias
    , seedDecl
    ]
        ++ setters
        ++ [ buildDecl ]
```

- [ ] **Step 4: Extend GoldenTest assertion**

```elm
        , test "Build module has build terminal" <|
            \_ ->
                buildButton
                    |> Expect.all
                        [ expectContains "build :"
                        , expectContains "Element" -- return type
                        ]
```

- [ ] **Step 5: Regen, compile, tests**

Standard regen + `elm make src/M3e.elm` + `pnpm run test`. Expected: all pass.

If compile fails for a specific component's `build` (e.g., a type mismatch in `buildViewExpr`), fix and iterate. This is the most complex task in the plan — expect 1-2 rounds of debugging.

- [ ] **Step 6: Commit both repos**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
git add codegen/Generate.elm tests/src/GoldenTest.elm && \
git commit -m "feat(codegen): emit build terminal in Build module"

cd /Users/jhp/code/jackhp95/elm-m3e && \
git add packages/m3e/src/M3e/Build/ && \
git commit -m "regen(m3e): Build modules gain build terminal — ⑤ shape fully wired"
```

---

### Task 10: Type-behavior test

**Files:**
- Create: `packages/m3e/tests/BuildShapeTest.elm` — positive cases (must compile).
- Create: `packages/m3e/tests/BuildShapeNegative.elm` — negative cases (must fail compilation with expected errors).
- Create: `packages/m3e/tests/run-build-shape-tests.sh` — orchestration script.

**Interfaces:**
- Produces: A test-harness proving the compile-time guarantees.

- [ ] **Step 1: Write the positive test**

Create `packages/m3e/tests/BuildShapeTest.elm`:

```elm
module BuildShapeTest exposing (main)

{-| Positive type-behavior test for ⑤ Build shape.

Each function below MUST compile. If any of them fails to compile, the
Build shape's type-safety guarantee is broken.
-}

import M3e.Action
import M3e.Build.Button as Button
import M3e.Build.Grid as Grid
import M3e.Icon
import M3e.Value
import Kit


{-| Happy path: Button seed + variant + build. -}
buttonHappy =
    Button.button { content = Kit.text "Click me", action = M3e.Action.none }
        |> Button.variant M3e.Value.filled
        |> Button.build


{-| Optional-multi setters can be applied any number of times. -}
buttonWithMultipleIcons =
    Button.button { content = Kit.text "Multi-icon", action = M3e.Action.none }
        |> Button.icon (M3e.Icon.view [] [])
        |> Button.build


{-| Required-multi ratchet: at least one child. -}
gridWithOneChild =
    Grid.grid
        |> Grid.child (Kit.text "row 1")
        |> Grid.build


{-| Required-multi ratchet: multiple children. Both calls must compile. -}
gridWithMultipleChildren =
    Grid.grid
        |> Grid.child (Kit.text "row 1")
        |> Grid.child (Kit.text "row 2")
        |> Grid.build


main =
    -- Trivial main to satisfy elm make on an application module.
    Debug.todo "unused"
```

(Adjust component names based on real M3e components; if `Grid` doesn't have a required-multi default slot, pick a component that does — grep `packages/m3e/src/M3e/Review/Facts.elm` for a component with `requiredSlots` non-empty and `multiSlots` overlap.)

- [ ] **Step 2: Write the negative test**

Create `packages/m3e/tests/BuildShapeNegative.elm`:

```elm
module BuildShapeNegative exposing (main)

{-| Negative type-behavior test for ⑤ Build shape.

Each function below MUST FAIL to compile with a TYPE MISMATCH.
The harness runs elm make and expects failure.
-}

import M3e.Action
import M3e.Build.Button as Button
import M3e.Build.Grid as Grid
import M3e.Value
import Kit


{-| Double-apply of variant: TYPE MISMATCH between Available and Used. -}
doubleVariant =
    Button.button { content = Kit.text "x", action = M3e.Action.none }
        |> Button.variant M3e.Value.filled
        |> Button.variant M3e.Value.tonal    -- FAILURE HERE
        |> Button.build


{-| Missing required-multi: TYPE MISMATCH between NotFilled and Filled. -}
missingRequiredMulti =
    Grid.grid
        |> Grid.build    -- FAILURE HERE


main =
    Debug.todo "unused"
```

- [ ] **Step 3: Write the orchestration script**

Create `packages/m3e/tests/run-build-shape-tests.sh`:

```bash
#!/usr/bin/env bash
# Orchestrate positive + negative type-behavior tests for ⑤ Build shape.
set -uo pipefail

cd "$(dirname "$0")/../.."
export PATH="./node_modules/.bin:$PATH"

positive="packages/m3e/tests/BuildShapeTest.elm"
negative="packages/m3e/tests/BuildShapeNegative.elm"

echo "== Positive: $positive must compile =="
if ! elm make "$positive" --output=/dev/null 2>&1; then
    echo "FAIL: positive test did not compile"
    exit 1
fi
echo "OK: positive compiled"

echo
echo "== Negative: $negative must NOT compile =="
if elm make "$negative" --output=/dev/null 2>&1; then
    echo "FAIL: negative test compiled but should not have"
    exit 1
fi

# Check for the expected error messages
out=$(elm make "$negative" --output=/dev/null 2>&1 || true)
if ! grep -q "Available" <<< "$out" || ! grep -q "Used" <<< "$out"; then
    echo "FAIL: negative test failed but not with the expected Available/Used mismatch"
    echo "$out"
    exit 1
fi
if ! grep -q "NotFilled" <<< "$out" || ! grep -q "Filled" <<< "$out"; then
    echo "FAIL: negative test failed but not with the expected NotFilled/Filled mismatch"
    echo "$out"
    exit 1
fi
echo "OK: negative failed as expected"

echo
echo "== ALL BUILD SHAPE TYPE TESTS PASSED =="
```

`chmod +x packages/m3e/tests/run-build-shape-tests.sh`.

- [ ] **Step 4: Update `packages/m3e/elm.json` if needed**

The tests are in `packages/m3e/tests/`, which may or may not already be in `source-directories`. Check:

```bash
cat packages/m3e/elm.json | head -20
```

If not present, tests might live under a different structure. Simplest: put them in a location `elm make` can compile directly, like `packages/m3e/tests/` with its own `elm.json` (application type).

Alternative simpler: put the tests directly under `packages/m3e/src/` temporarily during the test run, and remove after. But that's hacky. Prefer a proper application `elm.json` for the tests folder.

- [ ] **Step 5: Run the orchestration script**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
bash packages/m3e/tests/run-build-shape-tests.sh
```
Expected: `ALL BUILD SHAPE TYPE TESTS PASSED`.

- [ ] **Step 6: Commit**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
git add packages/m3e/tests/ && \
git commit -m "test(m3e): type-behavior test for ⑤ Build shape (positive + negative compile checks)"
```

---

### Task 11: `codeShape5` authoring for Button + regen + DoD verification

**Files:**
- Modify: `config/examples.rich.json` — add a `codeShape5` field to at least one Button example.
- Modify: `config/examples.generated.json` — reflect the same change.
- Regen: full library.

**Interfaces:**
- No new interfaces — this is data authoring + verification.

- [ ] **Step 1: Add a `codeShape5` example for Button**

Locate a Button example in `config/examples.rich.json`. Add a `codeShape5` field with a Shape5 pipeline example, e.g.:

```json
{
  "title": "Filled button with add icon",
  "top": "M3e.Button.view [ M3e.Button.variant M3e.Value.filled ] [ M3e.Button.child (Kit.text \"New\"), M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name \"add\" ] []) ]",
  "codeShape4": "M3e.Record.Button.view { content = Kit.text \"New\", action = M3e.Action.none } [ M3e.Record.Button.variant M3e.Value.filled ] [ M3e.Record.Button.icon (M3e.Icon.view [ M3e.Icon.name \"add\" ] []) ]",
  "codeShape5": "M3e.Build.Button.button { content = Kit.text \"New\", action = M3e.Action.none } |> M3e.Build.Button.variant M3e.Value.filled |> M3e.Build.Button.icon (M3e.Icon.view [ M3e.Icon.name \"add\" ] []) |> M3e.Build.Button.build"
}
```

Same edit to `config/examples.generated.json`.

- [ ] **Step 2: Regen**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
PATH="/Users/jhp/code/jackhp95/elm-m3e/elm-cem/node_modules/.bin:$PATH" \
  node elm-cem/bin/elm-cem.js \
    --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json \
    --config-from=config/slots.json \
    --config-from=config/examples.generated.json \
    --output=packages/m3e/src 2>&1 | tail -3
```

- [ ] **Step 3: Verify Button's Build module docstring shows the Shape5 example**

```bash
head -40 packages/m3e/src/M3e/Build/Button.elm
```
Expected: docstring contains the `M3e.Build.Button.button {...} |> ...` pipeline.

- [ ] **Step 4: DoD verification**

```bash
# Module count
ls packages/m3e/src/M3e/Build/*.elm | wc -l
# Expected: 129 (128 components + Internal)

# Package compile
cd packages/m3e && \
PATH="/Users/jhp/code/jackhp95/elm-m3e/node_modules/.bin:$PATH" \
  elm make src/M3e.elm --output=/dev/null 2>&1 | tail -1
# Expected: Success! Compiled 507 modules.

# Docs compile
cd /Users/jhp/code/jackhp95/elm-m3e/docs && \
PATH="./node_modules/.bin:$PATH" \
  elm make app/Shared.elm src/Doc.elm --output=/dev/null 2>&1 | tail -1
# Expected: Success!

# elm-cem tests
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && \
PATH="./node_modules/.bin:$PATH" pnpm run test 2>&1 | tail -3
# Expected: all pass

# Review tests
cd /Users/jhp/code/jackhp95/elm-m3e && \
PATH="./docs/node_modules/.bin:/Users/jhp/.elm/elm-tooling/elm-test-rs/3.0.0:$PATH" \
  elm-test-rs --project review review/tests/*.elm 2>&1 | tail -3
# Expected: 78 pass (unchanged from before ⑤)

# elm-review error count
PATH="./docs/node_modules/.bin:$PATH" elm-review --config review/ docs/app 2>&1 | grep "I found" | tail -1
# Expected: same count as before ⑤ (84 or wherever we left off after Task C) — ⑤ is inert to the review net

# Type-behavior test
bash packages/m3e/tests/run-build-shape-tests.sh
# Expected: ALL BUILD SHAPE TYPE TESTS PASSED
```

- [ ] **Step 5: Commit the config + regen**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
git add config/examples.rich.json config/examples.generated.json packages/m3e/src/ packages/m3e/elm.json && \
git commit -m "$(cat <<'EOF'
feat(m3e): finalize ⑤ Build shape ship

Adds Shape5 example for Button in the docstring, regenerates all 128
M3e.Build.<Comp> modules + M3e.Build.Internal. Package compiles at 507
modules (was 378).

⑤ delivers compile-time enforcement of:
- Duplicate optional-singular setter = TYPE MISMATCH (Available → Used).
- Missing required-multi slot = TYPE MISMATCH (NotFilled → Filled).
- Missing required-singular = same as ④ (inherited from the seed record).

Purely additive; docs-app compiles unchanged, review tests unchanged,
elm-review error count unchanged (⑤ is inert to the review net per ADR 0013).

Per docs/superpowers/specs/2026-07-04-build-shape-emitter-design.md.

Generated with [Claude Code](https://claude.ai/code)
via [Happy](https://happy.engineering)

Co-Authored-By: Claude <noreply@anthropic.com>
Co-Authored-By: Happy <yesreply@happy.engineering>
EOF
)"
```

---

## Self-Review Notes

**Spec coverage:**
- Spec §2 (in scope):
  - `generateBuildModule` in Generate.elm → Tasks 4, 5, 6, 7, 8, 9.
  - `M3e/Build/Internal.elm` → Task 2.
  - `Shape5` in Shape/shapesFor/Facts → Task 1.
  - `codeShape5` in ExampleRecord → Task 3.
  - GoldenTest additions → Tasks 4, 6, 7, 8, 9.
  - Type-behavior test → Task 10.
- Spec §2 (out of scope): correctly not implemented (no barrel, no rules, no config authoring beyond `codeShape5`).
- Spec §3-9 all mapped.
- Spec §10 (DoD) — Task 11 verifies each item.

**Placeholder scan:**
- No TBDs/TODOs.
- Task 9 Step 2 has a caveat "MVP for this task: emit a `build` that produces a valid `Element` value" — this is guidance for the implementer, not a placeholder. If the initial `buildViewExpr` produces wrong output, the compile / GoldenTest / type-behavior tests will catch it and force iteration within Task 9.
- Task 5 Step 2 mentions "Simplification: rather than emitting a top-level `defaults` value, inline the record literal in the seed body." This is a decision the implementer takes; both approaches produce valid Elm. Preferred approach fully specified.

**Type consistency:**
- `Shape5` used consistently across Tasks 1, 4, 9.
- `AttrCaps`, `SlotCaps`, `Fields`, `Builder` naming consistent from Task 4 onward.
- Ratchet pattern (Task 8) uses `filled` (type var) as input row + `Filled` (concrete) as output row — matches the spike's validated pattern in `elm-cem/spikes/build-shape/ratchet-check/`.
- Setter names use `slotSetterName` helper consistently (from Task 3 of the earlier Facts spec ship).

## Execution Handoff

Plan complete and saved to `docs/superpowers/plans/2026-07-04-build-shape-emitter.md`. Two execution options:

**1. Subagent-Driven (recommended)** — I dispatch a fresh subagent per task, review between tasks, fast iteration.

**2. Inline Execution** — Execute tasks in this session using executing-plans, batch execution with checkpoints.

Which approach?
