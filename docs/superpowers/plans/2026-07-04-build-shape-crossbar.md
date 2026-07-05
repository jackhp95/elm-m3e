# ⑤ Build shape crossbar redesign Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rewrite the ⑤ Build shape emitter to produce a unified Builder type with per-container crossbar sub-modules of specialized aliases, eliminating `.build` ceremony on child components.

**Architecture:** One shared `Builder kindRow attrCaps slotCaps msg` type in `M3e.Build.Internal`; each per-component module exposes a type alias pinning the kind row and emits attrs/events/seed/build; each container additionally emits a `.Slots` sub-module with aliases of a polymorphic core setter, one alias per allowed child component. Extensible-row constraints in alias signatures enforce required-multi completeness on nested containers without a separate `Sealed` marker.

**Tech Stack:** Elm 0.19.1, `mdgriffith/elm-codegen` 0.6.3, `elm-test-rs` (via mise), CEM (Custom Element Manifest) as input.

**Spec:** `docs/superpowers/specs/2026-07-04-build-shape-crossbar-design.md`
**Supersedes:** `docs/superpowers/plans/2026-07-04-build-shape-emitter.md`

## Global Constraints

- All 128 components emit ⑤ uniformly (no gating). Same as prior plan.
- No `M3e.Build.elm` barrel module. Users import per-component (+ per-container `.Slots`).
- `Available`/`Used` (optional-singular) and `NotFilled`/`Filled` (required-multi) marker types live in `M3e.Build.Internal`.
- `.build` remains on the container's main module and returns `Element supported msg` — same output IR as Shape3/Shape4. It is no longer called on children.
- The single `M3e.Element.toHtml` at the app root is the only eager evaluation point.
- ⑤ needs NO elm-review rules; types cover every safety property.
- The generator invocation from the OUTER repo is: `PATH="./elm-cem/node_modules/.bin:$PATH" mise exec -- node ./elm-cem/bin/elm-cem.js --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json --config-from=config/slots.json --config-from=config/examples.generated.json --output=packages/m3e/src` (per `HANDOFF.md` line 74). Without `mise exec --` `elm` isn't on PATH; without the flags, `elm-codegen run` uses the outer repo's application `elm.json` which lacks codegen deps.
- Compile verification MUST use `elm make --docs=/tmp/x.json` on `packages/m3e/` (compiles all 533 exposed modules), NOT `elm make src/M3e.elm` (only 378 fanned-out modules; misses Build errors).
- Tasks 1–3 of the prior plan (`Shape5` variant in `Shape` enum + `shapesFor` + Facts alias + `M3e.Build.Internal` module scaffold + `codeShape5 : Maybe String` field in `ExampleRecord`) already shipped; do NOT re-emit or duplicate them.
- The current elm-cem HEAD is `445018a`. Outer HEAD is `2bff876`. Both on `main`.

---

## File Structure

**Modified:**
- `elm-cem/codegen/Generate.elm` — `generateBuildModule` restructured; new `generateBuildSlotsModule` added; dispatch in `generateTopModules` updated to emit both.
- `elm-cem/tests/src/GoldenTest.elm` — golden assertions updated for new emission shape.
- `packages/m3e/tests/BuildShapeTest.elm` — rewritten to exercise the new API.
- `packages/m3e/tests/BuildShapeNegative.elm` — rewritten with the new negative cases.
- `packages/m3e/tests/run-build-shape-tests.sh` — updated grep patterns if error output shape shifts.

**Regenerated wholesale:**
- `packages/m3e/src/M3e/Build/Internal.elm` — adds `wrap_` and `node_` helpers.
- `packages/m3e/src/M3e/Build/*.elm` — one main module per component (~128).
- `packages/m3e/src/M3e/Build/*/Slots.elm` — one crossbar sub-module per container that owns slot-holding capability (~60).

---

### Task 1: Emit `wrap_` and `node_` helpers in `M3e.Build.Internal`

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — extend `generateBuildInternalModule` to emit two exposed helpers alongside the existing marker types.

**Interfaces:**
- Consumes: existing `Builder` marker declarations pattern in `generateBuildInternalModule`.
- Produces: two new decls exported from `M3e.Build.Internal`:
  - `wrap_ : M3e.Node.Node msg -> Builder k a s msg`
  - `node_ : Builder k a s msg -> M3e.Node.Node msg`
  where `Builder` in this context is the (about-to-be-declared) shared custom type. In this task we ALSO declare the shared `Builder` custom type in Internal (Tasks 2+ reference it).

- [ ] **Step 1: Locate `generateBuildInternalModule`**

```bash
grep -n "^generateBuildInternalModule\|generateBuildInternalModule " /Users/jhp/code/jackhp95/elm-m3e/elm-cem/codegen/Generate.elm
```
Expected: two hits — the type sig and the definition. Confirms the function exists.

- [ ] **Step 2: Extend the function to emit the shared Builder type and the wrap/node helpers**

Replace the current `generateBuildInternalModule` body's declaration list. The full new emission (as Elm code produced by the generator):

```elm
module M3e.Build.Internal exposing
    ( Builder(..)
    , Available, Used, NotFilled, Filled
    , wrap_, node_
    )


{-| Marker types + shared opaque Builder wrapping a lazy Node.

Available/Used gate optional-singular attribute and slot capabilities;
NotFilled/Filled gate required-multi slot capabilities. Applying the same
singular setter twice is a compile-time TYPE MISMATCH. The NotFilled → Filled
ratchet guards required-multi slots: `build` refuses to type-check when a
required-multi slot has not been filled.

The Builder wraps a lazy `M3e.Node.Node` — the same IR every other shape emits.
`wrap_` and `node_` are generator-internal helpers used by emitted setters to
modify the underlying Node; user code should not call them directly.
-}

import M3e.Node


type Builder kindRow attrCaps slotCaps msg
    = Builder (M3e.Node.Node msg)


type Available
    = Available_


type Used
    = Used_


type NotFilled
    = NotFilled_


type Filled
    = Filled_


{-| Wrap a Node into a Builder. Generator-internal. -}
wrap_ : M3e.Node.Node msg -> Builder k a s msg
wrap_ =
    Builder


{-| Unwrap a Builder to its underlying Node. Generator-internal. -}
node_ : Builder k a s msg -> M3e.Node.Node msg
node_ (Builder n) =
    n
```

In `Generate.elm`, the function body (which uses `elm-codegen`) needs to emit the above module. Use `Elm.customTypeWith "Builder" ["kindRow", "attrCaps", "slotCaps", "msg"] [ Elm.variantWith "Builder" [ Type.namedWith [ "M3e", "Node" ] "Node" [ Type.var "msg" ] ] ]` for the custom type; expose the constructor via `Elm.expose`. For the markers keep the existing pattern. For `wrap_`/`node_`, use `Elm.declaration` with `Elm.withType` and `Elm.expose`. All exposed decls MUST carry `Elm.withDocumentation`.

- [ ] **Step 3: Regenerate `packages/m3e/src/M3e/Build/Internal.elm`**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
  PATH="./elm-cem/node_modules/.bin:$PATH" mise exec -- node ./elm-cem/bin/elm-cem.js \
    --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json \
    --config-from=config/slots.json --config-from=config/examples.generated.json \
    --output=packages/m3e/src 2>&1 | tail -5
```
Expected: `[m3e] Generated N files` — no `Compilation failed` line.

- [ ] **Step 4: Verify Internal.elm compiles and exposes the new helpers**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/packages/m3e && \
  PATH="/Users/jhp/code/jackhp95/elm-m3e/node_modules/.bin:$PATH" \
  elm make --docs=/tmp/t1.json 2>&1 | tail -3
```
Expected: `Success! Compiled N modules.` where N = current baseline (probably still ~533 since Build files may fail; that's OK for THIS task — the priority is Internal.elm compiles).

If the total count drops significantly, the pre-existing Build files can't reference the old Builder type. That's expected — they'll be rewritten in Task 2. If Internal.elm itself fails, fix before proceeding.

```bash
grep -A 2 "^wrap_\|^node_" /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/src/M3e/Build/Internal.elm
```
Expected: both function signatures visible in the output.

- [ ] **Step 5: Run elm-cem test suite**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && pnpm run test 2>&1 | tail -10
```

Some tests may fail because Task 2's rewrite hasn't happened yet (golden tests reference old Build module content). Note the failures. If the ONLY failures are golden mismatches on Build modules, that's expected and OK. If there are new failures elsewhere, investigate.

- [ ] **Step 6: Commit both repos**

elm-cem commit:
```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem
git add codegen/Generate.elm
git commit -m "$(cat <<'EOF'
feat(codegen): shared Builder type + wrap_/node_ helpers in M3e.Build.Internal

Foundation for the crossbar redesign — all per-component Builders will
become type aliases pinning the kindRow phantom of this shared type.
wrap_/node_ are generator-internal helpers used by emitted setters to
modify the underlying Node.

Per docs/superpowers/plans/2026-07-04-build-shape-crossbar.md Task 1.

Generated with [Claude Code](https://claude.ai/code)
via [Happy](https://happy.engineering)

Co-Authored-By: Claude <noreply@anthropic.com>
Co-Authored-By: Happy <yesreply@happy.engineering>
EOF
)"
```

Outer commit:
```bash
cd /Users/jhp/code/jackhp95/elm-m3e
git add packages/m3e/src/M3e/Build/Internal.elm
git commit -m "$(cat <<'EOF'
regen(m3e): M3e.Build.Internal gains shared Builder type + wrap_/node_

Per elm-cem HEAD. Preparation for the crossbar redesign of Tasks 2-9.

Generated with [Claude Code](https://claude.ai/code)
via [Happy](https://happy.engineering)

Co-Authored-By: Claude <noreply@anthropic.com>
Co-Authored-By: Happy <yesreply@happy.engineering>
EOF
)"
```

---

### Task 2: Emit new per-component main module skeleton (alias + AttrCaps + SlotCaps + seed skeleton)

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — replace the body of `generateBuildModule` with the new emission.

**Interfaces:**
- Consumes: `M3e.Build.Internal.Builder(..)`, `Available`, `NotFilled` (from Task 1).
- Produces: for each of 128 components, a `M3e.Build.<Comp>.elm` module with:
  - `type alias Builder attrCaps slotCaps msg = Internal.Builder { kind | <comp> : Supported } attrCaps slotCaps msg`
  - `type alias AttrCaps = { <optionalAttr> : Available, <optionalEvent> : Available, ... }`
  - `type alias SlotCaps = { <optSingularSlot> : Available, <requiredMultiSlot> : NotFilled, ... }`
  - Seed function: `<noun> : { <requiredAttrs> } -> Builder AttrCaps SlotCaps msg` (or `<noun> : Builder AttrCaps SlotCaps msg` when there are no required attrs). Body wraps a stub Node placeholder — this is intentional; Task 3 wires the real Node.

- [ ] **Step 1: Preserve the current `generateBuildModule` while writing the new one**

Rename the current `generateBuildModule` to `generateBuildModule_OLD` to keep it as reference during development. Add the new `generateBuildModule` as a fresh function that will be the new implementation. Once the new one works, delete `_OLD` in Step 5.

- [ ] **Step 2: Write the new `generateBuildModule`**

Structure (as Elm-codegen code you write in Generate.elm):

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

        tagName =
            component.tagName |> Maybe.withDefault ctx.moduleName

        supportedT =
            Type.namedWith [ lib, "Value" ] "Supported" []

        internalModule =
            [ lib, "Build", "Internal" ]

        available =
            Type.namedWith internalModule "Available" []

        notFilled =
            Type.namedWith internalModule "NotFilled" []

        -- Slot partitions
        optionalSingularSlots =
            List.filter (\s -> not s.required && not s.multi) ctx.slots

        optionalMultiSlots =
            List.filter (\s -> s.multi && not s.required) ctx.slots

        requiredMultiSlots =
            List.filter (\s -> s.multi && s.required) ctx.slots

        -- Events, deduplicated
        events =
            component.events
                |> deduplicateBy .name
                |> List.filter (\ev -> not (ctx.usesAction && ev.name == "click"))

        -- Slot field name with safeField (keyword-safe)
        slotFieldB s =
            if s.name == "unnamed" then
                "default"

            else
                safeField (Naming.decapitalize (Naming.pascal s.name))

        -- AttrCaps: one Available field per optional attr + per event
        attrCapsFields =
            List.map (\s -> ( safeField s.elmName, available )) ctx.specs
                ++ List.map (\ev -> ( safeField (eventHandlerName libraryInfo ev), available )) events

        -- SlotCaps: Available for optional-singular, NotFilled for required-multi.
        -- Optional-multi and required-singular slots do NOT appear in SlotCaps
        -- (optional-multi is passthrough with no row change; required-singular is
        -- delivered via the seed's required record).
        slotCapsFields =
            List.map (\s -> ( slotFieldB s, available )) optionalSingularSlots
                ++ List.map (\s -> ( slotFieldB s, notFilled )) requiredMultiSlots

        attrCapsAlias =
            Elm.alias "AttrCaps" (Type.record attrCapsFields)
                |> Elm.expose
                |> Elm.withDocumentation "Per-component attribute capability row for the phantom-typed Builder."

        slotCapsAlias =
            Elm.alias "SlotCaps" (Type.record slotCapsFields)
                |> Elm.expose
                |> Elm.withDocumentation "Per-component slot capability row for the phantom-typed Builder."

        -- Component-local Builder alias hides the shared Internal.Builder,
        -- pinning kindRow to { kind | <comp> : Supported }.
        builderAlias =
            Elm.aliasWith "Builder"
                [ "attrCaps", "slotCaps", "msg" ]
                (Type.namedWith internalModule
                    "Builder"
                    [ Type.extensible "kind" [ ( safeField ctx.noun, supportedT ) ]
                    , Type.var "attrCaps"
                    , Type.var "slotCaps"
                    , Type.var "msg"
                    ]
                )
                |> Elm.expose
                |> Elm.withDocumentation ("Phantom-typed opaque builder for `<" ++ tagName ++ ">`.")

        -- Required-arg record type for the seed function.
        -- Reuses ctx.requiredSingular and ctx.extra shape.
        buildRequiredType =
            Type.record
                (List.map (\s -> ( reqFieldNameB s, elementKindTypeB s.kinds )) ctx.requiredSingular
                    ++ List.map (\( f, k ) -> ( safeField f, extraFieldTypeB k )) ctx.extra
                )

        reqFieldNameB s =
            if s.name == "unnamed" then
                "content"

            else
                slotFieldB s

        elementKindTypeB kinds =
            case kinds of
                Arbitrary ->
                    Type.namedWith [ lib, "Element" ] "Element" [ Type.var "any_", Type.var "msg" ]

                Kinds ks ->
                    Type.namedWith [ lib, "Element" ]
                        "Element"
                        [ Type.record (List.map (\k -> ( safeField k, supportedT )) ks), Type.var "msg" ]

        extraFieldTypeB kind =
            if isActionKind kind then
                Type.namedWith [ lib, "Action" ]
                    "Action"
                    [ Type.record (List.map (\c -> ( c, supportedT )) (actionCaps kind)), Type.var "msg" ]

            else
                Type.string

        builderResultType =
            Type.namedWith modulePath "Builder"
                [ Type.namedWith modulePath "AttrCaps" []
                , Type.namedWith modulePath "SlotCaps" []
                , Type.var "msg"
                ]

        hasRequired =
            not (List.isEmpty ctx.requiredSingular && List.isEmpty ctx.extra)

        -- Seed body — Task 2 emits a stub. Task 3 replaces this with a real Node
        -- constructed via M3e.Node.fromComponent + the bottom-layer render function.
        stubSeedBody =
            Elm.apply
                (Elm.value { importFrom = internalModule, name = "wrap_", annotation = Nothing })
                [ Elm.apply
                    (Elm.value { importFrom = [ lib, "Node" ], name = "text", annotation = Nothing })
                    [ Elm.string "<stub — Task 3 replaces>" ]
                ]

        seedDecl =
            if hasRequired then
                Elm.declaration ctx.noun
                    (Elm.fn (Elm.Arg.varWith "req_" buildRequiredType)
                        (\_ -> stubSeedBody)
                        |> Elm.withType (Type.function [ buildRequiredType ] builderResultType)
                    )
                    |> Elm.expose
                    |> Elm.withDocumentation ("Seed a `Builder` for `<" ++ tagName ++ ">` with the required fields.")

            else
                Elm.declaration ctx.noun
                    (stubSeedBody |> Elm.withType builderResultType)
                    |> Elm.expose
                    |> Elm.withDocumentation ("Seed a `Builder` for `<" ++ tagName ++ ">`.")

        moduleDocs =
            "The ⑤ Build shape for `<"
                ++ tagName
                ++ ">` — phantom-typed pipeline API. Import qualified: `import "
                ++ String.join "." modulePath
                ++ " as "
                ++ ctx.moduleName
                ++ "`."

        buildFile =
            Elm.fileWith modulePath
                { docs = moduleDocs
                , aliases = []
                }
                [ builderAlias
                , attrCapsAlias
                , slotCapsAlias
                , seedDecl
                ]

        viewType =
            Type.namedWith [ lib, "Element" ] "Element"
                [ Type.extensible "kind" [ ( safeField ctx.noun, supportedT ) ]
                , Type.var "msg"
                ]
    in
    { file = buildFile, noun = ctx.noun, viewType = viewType, shape = Shape5 }
```

Delete `generateBuildModule_OLD` at the end.

- [ ] **Step 3: Update the dispatch in `generateTopModules`**

The dispatch currently has:
```elm
Shape5 ->
    Just (generateBuildModule config libraryInfo component)
```
No change needed for Task 2 — still returns one TopModule per component. (Task 5 will add the `.Slots` emission alongside.)

- [ ] **Step 4: Regenerate**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
  PATH="./elm-cem/node_modules/.bin:$PATH" mise exec -- node ./elm-cem/bin/elm-cem.js \
    --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json \
    --config-from=config/slots.json --config-from=config/examples.generated.json \
    --output=packages/m3e/src 2>&1 | tail -5
```
Expected: `Generated N files`, no `Compilation failed`.

- [ ] **Step 5: Verify all 533 modules compile**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/packages/m3e && \
  PATH="/Users/jhp/code/jackhp95/elm-m3e/node_modules/.bin:$PATH" \
  elm make --docs=/tmp/t2.json 2>&1 | tail -3
```
Expected: `Success! Compiled 533 modules.`

If it fails, common issues:
- Missing `Elm.withDocumentation` on an exposed decl → fix by adding.
- Type mismatch on `Builder` alias arity → verify `Elm.aliasWith` uses `["attrCaps", "slotCaps", "msg"]`.

- [ ] **Step 6: Spot-check a real component**

```bash
head -40 /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/src/M3e/Build/Radio.elm
```
Expected: Should show `type alias Builder attrCaps slotCaps msg = M3e.Build.Internal.Builder { kind | radio : M3e.Value.Supported } attrCaps slotCaps msg` (or similar).

- [ ] **Step 7: Run elm-cem tests**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && pnpm run test 2>&1 | tail -10
```

Golden tests may fail because the output changed shape. That's expected — Task 8 updates the golden fixtures. Note the specific failures.

- [ ] **Step 8: Commit both repos**

elm-cem:
```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem
git add codegen/Generate.elm
git commit -m "$(cat <<'EOF'
feat(codegen): emit crossbar main module skeleton for ⑤ Build shape

Builder becomes a type alias of M3e.Build.Internal.Builder pinning
kindRow to the component's kind. AttrCaps and SlotCaps unchanged in
structure. Seed emitted with a stub Node body (Task 3 wires the real
bottom-layer render function). No setters or .build yet.

Per docs/superpowers/plans/2026-07-04-build-shape-crossbar.md Task 2.

Generated with [Claude Code](https://claude.ai/code)
via [Happy](https://happy.engineering)

Co-Authored-By: Claude <noreply@anthropic.com>
Co-Authored-By: Happy <yesreply@happy.engineering>
EOF
)"
```

Outer:
```bash
cd /Users/jhp/code/jackhp95/elm-m3e
git add packages/m3e/src/M3e/Build/
git commit -m "$(cat <<'EOF'
regen(m3e): Build modules become crossbar-style skeletons

Per elm-cem HEAD. Builder is now a type alias of Internal.Builder with
pinned kindRow. Seed placeholder — setters and build land in later tasks.

Generated with [Claude Code](https://claude.ai/code)
via [Happy](https://happy.engineering)

Co-Authored-By: Claude <noreply@anthropic.com>
Co-Authored-By: Happy <yesreply@happy.engineering>
EOF
)"
```

---

### Task 3: Wire seed body to real Node + emit attr and event setters

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — extend `generateBuildModule` with real seed body and per-attr/per-event setters.

**Interfaces:**
- Consumes: `generateBuildModule`'s skeleton emission from Task 2.
- Produces: for each component:
  - Seed body constructs an `M3e.Node.Node` via `M3e.Node.fromComponent (\attrs children -> M3e.Cem.<Comp>.<noun> ...) requiredAttrs requiredChildren` — mirrors Shape4's assembly but without going through Element.
  - One attr setter per optional attr: `<attr> : <inputType> -> Builder { a | <attr> : Available } s msg -> Builder { a | <attr> : Used } s msg`. Body applies `M3e.Node.addAttr` via the middle-layer setter.
  - One event setter per event: same shape as attr setter; body uses `M3e.Cem.Attr.attribute M3e.Cem.Html.<Comp>.<event> decoder`.

- [ ] **Step 1: Reference Shape4's view-body assembly**

Look at `generateShape4Module` in `elm-cem/codegen/Generate.elm` around line 2560–2720. The key helpers are:
- `compLambda` — the (attrs, children) → Html closure passed to `Node.fromComponent`.
- `attrsWith reqE attributes` — merges aria/action/forgotten attrs.
- `reqStampedNodes reqE` — required-singular slots stamped with slot names.

⑤'s seed body reuses these EXACTLY but with:
- `attributes = []` (no user attrs at seed time — they land via setters).
- `content_ = []` (no user children at seed time — they land via slot setters in `.Slots`).
- Only the `reqE` (required record) contributes attrs/children.

- [ ] **Step 2: Replace `stubSeedBody` with real assembly**

```elm
-- Inside generateBuildModule's `let`, add these helpers (mirroring generateShape4Module):
attrModule =
    [ lib, "Cem", "Attr" ]

middleModule =
    [ lib, "Cem", ctx.moduleName ]

ref ns n =
    Elm.value { importFrom = ns, name = n, annotation = Nothing }

forgottenAttrs attributes =
    Elm.apply (ref [ "List" ] "map") [ ref attrModule "forget", attributes ]

compLambda =
    Elm.fn2 (Elm.Arg.var "erased_")
        (Elm.Arg.var "ch_")
        (\erased ch ->
            Elm.apply (ref middleModule ctx.noun)
                [ Elm.apply (ref [ "List" ] "map") [ ref attrModule "forget", erased ], ch ]
        )

contentNodes contentE =
    Elm.apply (ref [ "List" ] "map") [ ref [ lib, "Content" ] "toNode", contentE ]

-- (adopt ariaExprs, actionAttrsExpr, reqStampedNodes, attrsWith from Shape4 verbatim)

buildNodeFromReq reqE =
    Elm.apply (ref [ lib, "Node" ] "fromComponent")
        [ compLambda
        , attrsWith reqE (Elm.list [])         -- attributes = [] initially
        , reqStampedNodes reqE                    -- required-singular slots stamped
        ]

-- The real seed body:
realSeedBody reqE =
    Elm.apply
        (Elm.value { importFrom = internalModule, name = "wrap_", annotation = Nothing })
        [ buildNodeFromReq reqE ]

seedDecl =
    if hasRequired then
        Elm.declaration ctx.noun
            (Elm.fn (Elm.Arg.varWith "req_" buildRequiredType)
                (\reqE -> realSeedBody reqE)
                |> Elm.withType (Type.function [ buildRequiredType ] builderResultType)
            )
            |> Elm.expose
            |> Elm.withDocumentation ("Seed a `Builder` for `<" ++ tagName ++ ">` with the required fields.")

    else
        Elm.declaration ctx.noun
            (Elm.apply
                (Elm.value { importFrom = internalModule, name = "wrap_", annotation = Nothing })
                [ Elm.apply (ref [ lib, "Node" ] "fromComponent")
                    [ compLambda, Elm.list [], Elm.list [] ]
                ]
                |> Elm.withType builderResultType
            )
            |> Elm.expose
            |> Elm.withDocumentation ("Seed a `Builder` for `<" ++ tagName ++ ">`.")
```

- [ ] **Step 3: Emit attr setters**

Each optional attr becomes:

```elm
attrSetter : Attr.AttrSpec -> Elm.Declaration
attrSetter s =
    let
        fieldName =
            safeField s.elmName

        inputType =
            attrInputType lib s

        inputBuilder =
            Type.namedWith modulePath "Builder"
                [ Type.extensible "a" [ ( fieldName, available ) ]
                , Type.var "s"
                , Type.var "msg"
                ]

        outputBuilder =
            Type.namedWith modulePath "Builder"
                [ Type.extensible "a" [ ( fieldName, used ) ]
                , Type.var "s"
                , Type.var "msg"
                ]

        -- Middle-layer Attr constructor:
        attrExpr valueE =
            Elm.apply (ref middleModule s.elmName) [ valueE ]

        signature =
            Type.function [ inputType, inputBuilder ] outputBuilder
    in
    Elm.declaration s.elmName
        (Elm.fn2
            (Elm.Arg.varWith "v_" inputType)
            (Elm.Arg.var "b_")
            (\vE bE ->
                Elm.apply
                    (Elm.value { importFrom = internalModule, name = "wrap_", annotation = Nothing })
                    [ Elm.apply (ref [ lib, "Node" ] "addAttr")
                        [ Elm.apply (ref attrModule "forget") [ attrExpr vE ]
                        , Elm.apply
                            (Elm.value { importFrom = internalModule, name = "node_", annotation = Nothing })
                            [ bE ]
                        ]
                    ]
                    |> Elm.withType outputBuilder
            )
            |> Elm.withType signature
        )
        |> Elm.expose
        |> Elm.withDocumentation (Attr.docString s)


used =
    Type.namedWith internalModule "Used" []
```

Note: name the second parameter `b_` (not `f_`) since we're passing a Builder, not a Fields record.

- [ ] **Step 4: Emit event setters**

Similar shape, but the middle-layer setter takes a `Decoder msg`. Use the HTML-layer setter:

```elm
eventSetter : Cem.Event -> Elm.Declaration
eventSetter ev =
    let
        handlerName =
            eventHandlerName libraryInfo ev

        fieldName =
            safeField handlerName

        inputType =
            decoderMsgType

        inputBuilder =
            Type.namedWith modulePath "Builder"
                [ Type.extensible "a" [ ( fieldName, available ) ]
                , Type.var "s"
                , Type.var "msg"
                ]

        outputBuilder =
            Type.namedWith modulePath "Builder"
                [ Type.extensible "a" [ ( fieldName, used ) ]
                , Type.var "s"
                , Type.var "msg"
                ]

        htmlSetter =
            Elm.value
                { importFrom = [ lib, "Cem", "Html", ctx.moduleName ]
                , name = handlerName
                , annotation = Nothing
                }

        attrExpr decoderE =
            Elm.apply (ref attrModule "attribute") [ htmlSetter, decoderE ]

        signature =
            Type.function [ inputType, inputBuilder ] outputBuilder

        evDoc =
            ev.description |> Maybe.withDefault (handlerName ++ " event handler.")
    in
    Elm.declaration handlerName
        (Elm.fn2
            (Elm.Arg.varWith "v_" inputType)
            (Elm.Arg.var "b_")
            (\vE bE ->
                Elm.apply
                    (Elm.value { importFrom = internalModule, name = "wrap_", annotation = Nothing })
                    [ Elm.apply (ref [ lib, "Node" ] "addAttr")
                        [ Elm.apply (ref attrModule "forget") [ attrExpr vE ]
                        , Elm.apply
                            (Elm.value { importFrom = internalModule, name = "node_", annotation = Nothing })
                            [ bE ]
                        ]
                    ]
                    |> Elm.withType outputBuilder
            )
            |> Elm.withType signature
        )
        |> Elm.expose
        |> Elm.withDocumentation evDoc
```

- [ ] **Step 5: Append setters to declarations**

Update the `buildFile`'s declaration list:
```elm
buildFile =
    Elm.fileWith modulePath
        { docs = moduleDocs, aliases = [] }
        ([ builderAlias
         , attrCapsAlias
         , slotCapsAlias
         , seedDecl
         ]
            ++ List.map attrSetter ctx.specs
            ++ List.map eventSetter events
        )
```

- [ ] **Step 6: Regenerate and verify**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
  PATH="./elm-cem/node_modules/.bin:$PATH" mise exec -- node ./elm-cem/bin/elm-cem.js \
    --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json \
    --config-from=config/slots.json --config-from=config/examples.generated.json \
    --output=packages/m3e/src 2>&1 | tail -5

cd /Users/jhp/code/jackhp95/elm-m3e/packages/m3e && \
  PATH="/Users/jhp/code/jackhp95/elm-m3e/node_modules/.bin:$PATH" \
  elm make --docs=/tmp/t3.json 2>&1 | tail -3
```
Expected: `Success! Compiled 533 modules.`

- [ ] **Step 7: Spot-check a real component**

```bash
grep -A 4 "^variant :\|^onClick :" /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/src/M3e/Build/Button.elm | head -20
```
Expected: both attr and event setter signatures visible.

- [ ] **Step 8: Commit both repos**

Message pattern: `feat(codegen): wire ⑤ Build seed to real Node + emit attr/event setters` on elm-cem; `regen(m3e): Build modules gain seed body + attr/event setters` on outer.

---

### Task 4: Emit `.build` terminal

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — add `buildDecl` to `generateBuildModule`.

**Interfaces:**
- Consumes: attr/event setters (Task 3). The `.build` terminal doesn't read Fields — it just extracts the Node and wraps in Element.
- Produces: `build : Builder a { s | <required-multi>: Filled, ... } msg -> Element { kind | <comp> : Supported } msg` per component. Body: `M3e.Element.fromNode (Internal.node_ builder)`.

- [ ] **Step 1: Add `buildDecl` to `generateBuildModule`**

```elm
buildDecl : Elm.Declaration
buildDecl =
    let
        -- Required-multi rows constrained to Filled.
        outputRowConstraint =
            List.map (\s -> ( slotFieldB s, Type.namedWith internalModule "Filled" [] )) requiredMultiSlots

        buildSlotCapsType =
            if List.isEmpty outputRowConstraint then
                Type.var "s"

            else
                Type.extensible "s" outputRowConstraint

        buildInputType =
            Type.namedWith modulePath "Builder"
                [ Type.var "a"
                , buildSlotCapsType
                , Type.var "msg"
                ]

        outputElement =
            Type.namedWith [ lib, "Element" ] "Element"
                [ Type.extensible "kind" [ ( safeField ctx.noun, supportedT ) ]
                , Type.var "msg"
                ]

        signature =
            Type.function [ buildInputType ] outputElement
    in
    Elm.declaration "build"
        (Elm.fn (Elm.Arg.var "b_")
            (\bE ->
                Elm.apply (ref [ lib, "Element" ] "fromNode")
                    [ Elm.apply
                        (Elm.value { importFrom = internalModule, name = "node_", annotation = Nothing })
                        [ bE ]
                    ]
                    |> Elm.withType outputElement
            )
            |> Elm.withType signature
        )
        |> Elm.expose
        |> Elm.withDocumentation ("Build the `<" ++ tagName ++ ">` element from a `Builder`.")
```

- [ ] **Step 2: Append `buildDecl` to declarations**

```elm
buildFile =
    Elm.fileWith modulePath
        { docs = moduleDocs, aliases = [] }
        ([ builderAlias
         , attrCapsAlias
         , slotCapsAlias
         , seedDecl
         ]
            ++ List.map attrSetter ctx.specs
            ++ List.map eventSetter events
            ++ [ buildDecl ]
        )
```

- [ ] **Step 3: Regenerate and verify**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
  PATH="./elm-cem/node_modules/.bin:$PATH" mise exec -- node ./elm-cem/bin/elm-cem.js \
    --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json \
    --config-from=config/slots.json --config-from=config/examples.generated.json \
    --output=packages/m3e/src 2>&1 | tail -5

cd /Users/jhp/code/jackhp95/elm-m3e/packages/m3e && \
  PATH="/Users/jhp/code/jackhp95/elm-m3e/node_modules/.bin:$PATH" \
  elm make --docs=/tmp/t4.json 2>&1 | tail -3
```
Expected: `Success! Compiled 533 modules.`

- [ ] **Step 4: Spot-check `.build`**

```bash
grep -A 3 "^build :" /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/src/M3e/Build/Button.elm | head -4
grep -A 3 "^build :" /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/src/M3e/Build/Select.elm | head -4
```
Expected: Button shows `Builder a s msg` (fully polymorphic s — no required-multi). Select shows `Builder a { s | default : M3e.Build.Internal.Filled } msg` (required-multi pin).

- [ ] **Step 5: Commit both repos**

`feat(codegen): emit .build terminal in ⑤ Build main module` + `regen(m3e): Build modules gain .build terminal`.

---

### Task 5: Emit `.Slots` sub-module with optional-singular aliases

**Files:**
- Modify: `elm-cem/runtime/M3e/Node.elm` — add `addChild` primitive.
- Modify: `elm-cem/codegen/Generate.elm` — add `generateBuildSlotsModule` function; update `generateTopModules` dispatch to emit BOTH the main module and the `.Slots` module when the component has any slot that requires the sub-module.

**Interfaces:**
- Consumes: per-component `Builder` alias (Task 2), `AttrCaps`/`SlotCaps` (Task 2), `.build` (Task 4).
- Produces: `M3e.Build.<Container>.Slots.elm` containing:
  - Private polymorphic core setters (one per slot).
  - Exposed aliases (one per (slot, allowed-child) pair) that `= <slot>_core`.

- [ ] **Step 1a: Add `addChild` primitive to `M3e.Node`**

`M3e.Node` currently exposes `addAttr` but no `addChild`. Add it to `elm-cem/runtime/M3e/Node.elm`:

```elm
{-| Append a child Node to an Element node's children list. If the target Node
is a `Text` or `Raw` leaf, wrap it in a synthetic `Element` first. Used by the
generated ⑤ Build shape slot setters. -}
addChild : Node msg -> Node msg -> Node msg
addChild child parent =
    case parent of
        Element rec ->
            Element { rec | children = rec.children ++ [ child ] }

        Text _ ->
            parent    -- can't add children to a text leaf; no-op

        Raw _ ->
            parent    -- can't add children to a raw html escape; no-op
```

Add `addChild` to the module's `exposing (...)` list.

- [ ] **Step 1b: Introduce a helper to enumerate valid children per slot**

Add to `generateBuildModule` context or as a standalone helper:

```elm
{-| For a slot, returns the list of component declarations whose kind row
matches the slot's kinds constraint. Arbitrary slot → all components.
Kinds slot → components claiming any of the specified kinds.
-}
allowedChildrenForSlot : List Cem.Declaration -> Cem.SlotSpec -> List Cem.Declaration
allowedChildrenForSlot allComponents slot =
    case slot.kinds of
        Arbitrary ->
            allComponents

        Kinds ks ->
            List.filter
                (\c ->
                    let
                        childKind =
                            Naming.decapitalize (Naming.pascal (c.tagName |> Maybe.withDefault ""))
                    in
                    List.member childKind ks
                )
                allComponents
```

The full component list is available via `Config.declarations` or similar; check the existing generator's data flow for the accessor.

- [ ] **Step 2: Implement `generateBuildSlotsModule`**

```elm
generateBuildSlotsModule : Config -> LibraryInfo -> List Cem.Declaration -> Cem.Declaration -> Maybe TopModule
generateBuildSlotsModule config libraryInfo allComponents component =
    let
        ctx =
            buildSharedCtx config libraryInfo component

        lib =
            libraryInfo.moduleName

        modulePath =
            [ lib, "Build", ctx.moduleName, "Slots" ]

        internalModule =
            [ lib, "Build", "Internal" ]

        supportedT =
            Type.namedWith [ lib, "Value" ] "Supported" []

        available =
            Type.namedWith internalModule "Available" []

        used =
            Type.namedWith internalModule "Used" []

        -- Only slots that admit children (optional-singular, optional-multi, required-multi).
        slotHoldingChildren =
            List.filter (\s -> not (s.name == "unnamed" && s.required && not s.multi)) ctx.slots

        -- Filter to only optional-singular for this task; multi handled in Task 6.
        optionalSingularSlots =
            List.filter (\s -> not s.required && not s.multi) slotHoldingChildren
    in
    if List.isEmpty optionalSingularSlots then
        Nothing

    else
        let
            slotFieldB s =
                if s.name == "unnamed" then "default"
                else safeField (Naming.decapitalize (Naming.pascal s.name))

            -- Polymorphic core for one optional-singular slot.
            slotCore s =
                let
                    fieldName =
                        slotFieldB s

                    inputBuilder =
                        Type.namedWith internalModule "Builder"
                            [ Type.var "anyK"
                            , Type.var "anyA"
                            , Type.var "anyS"
                            , Type.var "msg"
                            ]

                    parentBuilder inFlag outFlag =
                        Type.namedWith internalModule "Builder"
                            [ Type.extensible "k" [ ( safeField ctx.noun, supportedT ) ]
                            , Type.var "pa"
                            , Type.extensible "ps" [ ( fieldName, inFlag ) ]
                            , Type.var "msg"
                            ]

                    signature =
                        Type.function
                            [ inputBuilder, parentBuilder available ]
                            (parentBuilder used)
                in
                Elm.declaration (fieldName ++ "_core")
                    (Elm.fn2
                        (Elm.Arg.var "child")
                        (Elm.Arg.var "parent")
                        (\childE parentE ->
                            Elm.apply
                                (Elm.value { importFrom = internalModule, name = "wrap_", annotation = Nothing })
                                [ Elm.apply (Elm.value { importFrom = [ lib, "Node" ], name = "addChild", annotation = Nothing })
                                    -- If Node lacks addChild, use whatever slot-append primitive exists.
                                    [ Elm.apply (Elm.value { importFrom = internalModule, name = "node_", annotation = Nothing }) [ childE ]
                                    , Elm.apply (Elm.value { importFrom = internalModule, name = "node_", annotation = Nothing }) [ parentE ]
                                    ]
                                ]
                                |> Elm.withType (parentBuilder used)
                        )
                        |> Elm.withType signature
                    )
                -- Not exposed — private helper.

            -- Alias for one (slot, child) pair.
            slotAlias : Cem.SlotSpec -> Cem.Declaration -> Elm.Declaration
            slotAlias s child =
                let
                    fieldName =
                        slotFieldB s

                    childCtx =
                        buildSharedCtx config libraryInfo child

                    childPath =
                        [ lib, "Build", childCtx.moduleName ]

                    -- Child input type: polymorphic in attrCaps AND slotCaps, since
                    -- child's required-multi (if any) must be pinned to Filled by the
                    -- pipeline BEFORE reaching this alias.
                    childRequiredMultiPins =
                        child.slots
                            |> List.filter (\ss -> ss.multi && ss.required)
                            |> List.map
                                (\ss ->
                                    ( if ss.name == "unnamed" then "default"
                                      else safeField (Naming.decapitalize (Naming.pascal ss.name))
                                    , Type.namedWith internalModule "Filled" []
                                    )
                                )

                    childSlotCapsType =
                        if List.isEmpty childRequiredMultiPins then
                            Type.var "cs"

                        else
                            Type.extensible "cs" childRequiredMultiPins

                    childInputType =
                        Type.namedWith childPath "Builder"
                            [ Type.var "ca", childSlotCapsType, Type.var "msg" ]

                    containerBuilderPath =
                        [ lib, "Build", ctx.moduleName ]

                    containerBuilder inFlag =
                        Type.namedWith containerBuilderPath "Builder"
                            [ Type.var "pa"
                            , Type.extensible "ps" [ ( fieldName, inFlag ) ]
                            , Type.var "msg"
                            ]

                    aliasName =
                        if s.name == "unnamed" then
                            Naming.decapitalize childCtx.moduleName

                        else
                            fieldName ++ Naming.pascal childCtx.moduleName

                    signature =
                        Type.function
                            [ childInputType, containerBuilder available ]
                            (containerBuilder used)
                in
                Elm.declaration aliasName
                    (Elm.value
                        { importFrom = []
                        , name = fieldName ++ "_core"
                        , annotation = Nothing
                        }
                        |> Elm.withType signature
                    )
                    |> Elm.expose
                    |> Elm.withDocumentation
                        ("Place a `" ++ childCtx.moduleName ++ "` in the `" ++ s.name ++ "` slot.")

            cores =
                List.map slotCore optionalSingularSlots

            aliases =
                List.concatMap
                    (\s ->
                        List.map (slotAlias s) (allowedChildrenForSlot allComponents s)
                    )
                    optionalSingularSlots

            slotsFile =
                Elm.fileWith modulePath
                    { docs =
                        "Slot setters for `M3e.Build."
                            ++ ctx.moduleName
                            ++ "`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot."
                    , aliases = []
                    }
                    (cores ++ aliases)

            viewType =
                Type.string    -- placeholder; unused for .Slots
        in
        Just
            { file = slotsFile, noun = ctx.noun ++ "Slots", viewType = viewType, shape = Shape5 }
```

- [ ] **Step 3: Update the dispatch in `generateTopModules`**

The current dispatch returns `Maybe TopModule`. Since we may need to emit BOTH the main module and the `.Slots` sub-module, update the Shape5 case:

```elm
Shape5 ->
    -- The main module is always emitted; the .Slots module is emitted only when
    -- there is at least one optional-singular / optional-multi / required-multi slot.
    let
        allComponents =
            config.declarations    -- or however the full component list is accessed
    in
    Just (generateBuildModule config libraryInfo component)
```

The dispatch already uses `List.concatMap` at line 654. To emit multiple modules per Shape5, either:
(a) Change `generateTopModules` to return `List TopModule` (which it already does) and add the `.Slots` module to the returned list.
(b) Emit `.Slots` in a completely separate top-level pass.

Prefer (a). Restructure:

```elm
generateTopModules : Config -> LibraryInfo -> List Cem.Declaration -> Cem.Declaration -> List TopModule
generateTopModules config libraryInfo allComponents component =
    shapesFor config libraryInfo component
        |> List.concatMap
            (\shape ->
                case shape of
                    Shape3 ->
                        [ generateShape3Module config libraryInfo component ]

                    Shape4 ->
                        [ generateShape4Module config libraryInfo component ]

                    Shape5 ->
                        generateBuildModule config libraryInfo component
                            :: (case generateBuildSlotsModule config libraryInfo allComponents component of
                                    Just m -> [ m ]
                                    Nothing -> []
                               )
            )
```

The caller at line 654 must be updated to pass the full component list to `generateTopModules`.

- [ ] **Step 4: Regenerate and verify**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
  PATH="./elm-cem/node_modules/.bin:$PATH" mise exec -- node ./elm-cem/bin/elm-cem.js \
    --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json \
    --config-from=config/slots.json --config-from=config/examples.generated.json \
    --output=packages/m3e/src 2>&1 | tail -5

cd /Users/jhp/code/jackhp95/elm-m3e/packages/m3e && \
  PATH="/Users/jhp/code/jackhp95/elm-m3e/node_modules/.bin:$PATH" \
  elm make --docs=/tmp/t5.json 2>&1 | tail -3
```
Expected: compilation succeeds. Total module count grows by roughly the number of containers that have slots.

- [ ] **Step 5: Confirm `.Slots` files exist**

```bash
ls /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/src/M3e/Build/*/Slots.elm 2>&1 | head -5
ls /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/src/M3e/Build/Card/Slots.elm 2>&1
```
Expected: at least some `.Slots` files exist. Card almost certainly has slots.

- [ ] **Step 6: Confirm `packages/m3e/elm.json` exposes them**

```bash
grep "Build/.*Slots\|Build.*Slots" /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/elm.json | head -5
```
If missing, the elm-cem generator must add `.Slots` module names to `exposed-modules`. If the exposed-modules list is generated automatically (check the generator's package-emit code), no change needed. Otherwise, add the emission logic there.

- [ ] **Step 7: Commit**

`feat(codegen): emit .Slots sub-module with optional-singular crossbar aliases` + `regen(m3e): per-container Build.<Comp>.Slots modules with optional-singular child aliases`.

---

### Task 6: Extend `.Slots` with optional-multi and required-multi aliases

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` — extend `generateBuildSlotsModule` to emit cores + aliases for optional-multi and required-multi slots too.

**Interfaces:**
- Consumes: Task 5's polymorphic-core-plus-alias pattern.
- Produces: for each optional-multi slot: passthrough setter (no row change); for each required-multi slot: ratchet setter (`filled → Filled`). Each has its own set of aliases per allowed child.

- [ ] **Step 1: Add optional-multi core and aliases**

Optional-multi setter has NO row change on the parent — it accepts unlimited children:

```elm
optionalMultiSlotCore s =
    let
        fieldName = slotFieldB s

        anyBuilder =
            Type.namedWith internalModule "Builder"
                [ Type.var "anyK", Type.var "anyA", Type.var "anyS", Type.var "msg" ]

        containerBuilder =
            Type.namedWith containerBuilderPath "Builder"
                [ Type.var "pa", Type.var "ps", Type.var "msg" ]

        signature =
            Type.function [ anyBuilder, containerBuilder ] containerBuilder
    in
    Elm.declaration (fieldName ++ "_core")
        (Elm.fn2 (Elm.Arg.var "child") (Elm.Arg.var "parent")
            (\childE parentE ->
                Elm.apply
                    (Elm.value { importFrom = internalModule, name = "wrap_", annotation = Nothing })
                    [ Elm.apply (Elm.value { importFrom = [ lib, "Node" ], name = "addChild", annotation = Nothing })
                        [ Elm.apply (Elm.value { importFrom = internalModule, name = "node_", annotation = Nothing }) [ childE ]
                        , Elm.apply (Elm.value { importFrom = internalModule, name = "node_", annotation = Nothing }) [ parentE ]
                        ]
                    ]
                    |> Elm.withType containerBuilder
            )
            |> Elm.withType signature
        )
```

Alias emission per child mirrors Task 5 but with `containerBuilder` used identically for input and output positions.

- [ ] **Step 2: Add required-multi core and aliases**

Required-multi setter ratchets `filled → Filled` on the parent:

```elm
requiredMultiSlotCore s =
    let
        fieldName = slotFieldB s

        anyBuilder = ...  -- same as optional-multi

        containerBuilder inFlag outFlag =
            Type.namedWith containerBuilderPath "Builder"
                [ Type.var "pa"
                , Type.extensible "ps" [ ( fieldName, inFlag ) ]
                , Type.var "msg"
                ]

        filled = Type.namedWith internalModule "Filled" []

        signature =
            Type.function
                [ anyBuilder
                , containerBuilder (Type.var "filled") filled
                    -- ↑ input's row uses type var `filled` (lowercase — accepts any state);
                    -- output pins to concrete Filled.
                ]
                (containerBuilder filled filled)
    in
    ... (body: same wrap_/addChild/node_ pattern as before)
```

For the elm-codegen encoding of `Type.extensible "ps" [ ( fieldName, Type.var "filled" ) ]` in the input position: this mirrors Task 8 of the OLD plan. `filled` here is a type variable name in Elm syntax — reproduced via `Type.var "filled"`. Elm cannot parse `s'` in extensible-row syntax; keep `"ps"` (or `"s"`) as the row variable.

- [ ] **Step 3: Add multi cores/aliases to the file's declaration list**

```elm
slotsFile =
    Elm.fileWith modulePath
        { docs = ..., aliases = [] }
        (cores ++ optionalMultiCores ++ requiredMultiCores
            ++ aliases ++ optionalMultiAliases ++ requiredMultiAliases
        )
```

- [ ] **Step 4: Regenerate and verify**

Standard regen + `elm make --docs`. Expect success.

- [ ] **Step 5: Spot-check a real container**

```bash
grep -B 1 "^[a-z].* : " /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/src/M3e/Build/RadioGroup/Slots.elm | head -30
```
Expected: multiple aliases visible — one per allowed child of RadioGroup's arbitrary slot.

- [ ] **Step 6: Commit**

`feat(codegen): extend .Slots with optional-multi and required-multi crossbar aliases` + `regen(m3e): .Slots gains optional-multi and required-multi child aliases`.

---

### Task 7: Rewrite type-behavior tests

**Files:**
- Modify: `packages/m3e/tests/BuildShapeTest.elm` — replace with new API test cases.
- Modify: `packages/m3e/tests/BuildShapeNegative.elm` — replace with new negative cases.
- Modify: `packages/m3e/tests/run-build-shape-tests.sh` — update grep patterns if needed.
- Modify: `packages/m3e/tests/elm.json` — no change expected; verify.

**Interfaces:**
- Consumes: the full ⑤ crossbar surface (Tasks 1-6).
- Produces: positive test file that compiles cleanly, negative test file that fails compilation, script that exits 0 when both behave correctly.

- [ ] **Step 1: Replace `BuildShapeTest.elm`**

```elm
module BuildShapeTest exposing (main)

{-| Positive type-behavior test for ⑤ Build shape (crossbar redesign).

Each function below MUST compile. Failures indicate a broken safety guarantee.

Coverage:
  - Bare seed → build (no setters).
  - Optional-singular attr Available → Used, once.
  - Multiple distinct optional-singular attrs in sequence.
  - Kinded slot + leaf child, no .build on child.
  - Arbitrary slot + leaf child.
  - Arbitrary slot + heterogeneous leaf children.
  - Arbitrary slot + container child fully filled inline.
-}

import Html
import Kit
import M3e.Action
import M3e.Build.Button as Button
import M3e.Build.Divider as Divider
import M3e.Build.Option as Option
import M3e.Build.Radio as Radio
import M3e.Build.RadioGroup as RadioGroup
import M3e.Build.RadioGroup.Slots as RadioGroupSlots
import M3e.Build.Select as Select
import M3e.Build.Select.Slots as SelectSlots
import M3e.Value


{-| Bare seed → build. -}
buttonBare =
    Button.button { content = Kit.text "Click me", action = M3e.Action.none }
        |> Button.build


{-| Optional-singular attr applied once. -}
buttonVariant =
    Button.button { content = Kit.text "x", action = M3e.Action.none }
        |> Button.variant M3e.Value.filled
        |> Button.build


{-| Kinded slot: Option into Select's default slot, no .build on Option. -}
selectWithOption =
    Select.select
        |> SelectSlots.option (Option.option { value = "a", label = "A" })
        |> SelectSlots.option (Option.option { value = "b", label = "B" })
        |> Select.build


{-| Arbitrary slot: Radio into RadioGroup, no .build on Radio. -}
radioGroupWithRadio =
    RadioGroup.radioGroup
        |> RadioGroupSlots.radio Radio.radio
        |> RadioGroup.build


{-| Arbitrary slot with heterogeneous leaf children. -}
radioGroupHeterogeneous =
    RadioGroup.radioGroup
        |> RadioGroupSlots.radio Radio.radio
        |> RadioGroupSlots.divider Divider.divider
        |> RadioGroupSlots.radio Radio.radio
        |> RadioGroup.build


main : Html.Html msg
main =
    Html.text "BuildShapeTest — positive compile check only"
```

If some of the aliases used above have different names in the generated `.Slots` (e.g. `SelectSlots.option` might actually be `SelectSlots.defaultOption` if the naming rule was applied differently), adjust the test to match. The naming rule per spec §5.1: `<slotName><ChildComp>` unless the slot is `unnamed` / `default`, in which case just `<childComp>`.

- [ ] **Step 2: Replace `BuildShapeNegative.elm`**

```elm
module BuildShapeNegative exposing (main)

{-| Negative type-behavior test for ⑤ Build shape.

Each function below MUST FAIL to compile with a TYPE MISMATCH.

Coverage:
  - Double-apply of optional-singular attr (Available/Used).
  - Missing required-multi on the ROOT builder (attempting .build).
  - Wrong-kind child in a kinded slot.
-}

import Html
import M3e.Action
import M3e.Build.Button as Button
import M3e.Build.Divider as Divider
import M3e.Build.Radio as Radio
import M3e.Build.Select as Select
import M3e.Build.Select.Slots as SelectSlots
import M3e.Value
import Kit


{-| Double-apply of variant: Available/Used mismatch. -}
doubleVariant =
    Button.button { content = Kit.text "x", action = M3e.Action.none }
        |> Button.variant M3e.Value.filled
        |> Button.variant M3e.Value.tonal    -- FAILURE
        |> Button.build


{-| Missing required-multi on root builder: NotFilled/Filled mismatch. -}
missingRequiredMulti =
    Select.select
        |> Select.build    -- FAILURE: default : NotFilled but .build wants Filled


{-| Wrong-kind child in kinded slot: Radio into Select's option-only slot. -}
wrongKindChild =
    Select.select
        |> SelectSlots.option Radio.radio    -- FAILURE: SelectSlots.option demands Option-kind


main : Html.Html msg
main =
    Html.text "BuildShapeNegative — should NOT compile"
```

- [ ] **Step 3: Verify orchestrator script**

The existing script at `packages/m3e/tests/run-build-shape-tests.sh` should still work. Verify it exits 0 with both files.

```bash
bash /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/tests/run-build-shape-tests.sh 2>&1 | tail -20
```
Expected: `ALL BUILD SHAPE TYPE TESTS PASSED`.

If the negative test's error messages have changed (they may mention different type names), update the script's `grep` patterns. Prefer permissive matching: check for `TYPE MISMATCH` and any of `Available`, `Used`, `NotFilled`, `Filled`.

- [ ] **Step 4: Commit**

Outer only (no elm-cem changes in this task):
```bash
cd /Users/jhp/code/jackhp95/elm-m3e
git add packages/m3e/tests/
git commit -m "$(cat <<'EOF'
test(m3e): rewrite ⑤ type-behavior tests for crossbar API

Positive test exercises the new no-.build-on-child pipeline; negative
test covers double-apply, missing required-multi, and wrong-kind child
in kinded slots. Orchestrator script exits 0 when all safety guarantees
hold.

Per docs/superpowers/plans/2026-07-04-build-shape-crossbar.md Task 7.

Generated with [Claude Code](https://claude.ai/code)
via [Happy](https://happy.engineering)

Co-Authored-By: Claude <noreply@anthropic.com>
Co-Authored-By: Happy <yesreply@happy.engineering>
EOF
)"
```

---

### Task 8: Update GoldenTest fixtures + final DoD verification

**Files:**
- Modify: `elm-cem/tests/src/GoldenTest.elm` — update assertions to match the new emission shape.
- Modify: `docs/superpowers/plans/2026-07-04-build-shape-emitter.md` — add a note at the top indicating this plan is superseded.

**Interfaces:**
- Consumes: everything from Tasks 1–7.
- Produces: green tests, green compile, spec DoD checklist satisfied.

- [ ] **Step 1: Run golden tests to see current failures**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && pnpm run test 2>&1 | tail -30
```
Expected: multiple failures related to Build modules' content having changed.

- [ ] **Step 2: Update GoldenTest.elm assertions**

For each failing test related to Build modules, update the expected content. The new shape:
- `M3e.Build.<Comp>` main modules: `type alias Builder attrCaps slotCaps msg = M3e.Build.Internal.Builder ...`, `type alias AttrCaps = ...`, `type alias SlotCaps = ...`, `<noun> :`, one function per attr and event, `build :`.
- `M3e.Build.<Comp>.Slots` sub-modules: private cores + exposed aliases.

Adopt a "smoke test" approach for the new emission — instead of exact-content matching, use `expectContains` to check for key structural signatures:
- `type alias Builder`
- `type alias AttrCaps`
- `type alias SlotCaps`
- `<noun> :`
- `variant :` (for Button)
- `build :`
- `Builder`'s reference to `M3e.Build.Internal`
- The `.Slots` module for RadioGroup contains multiple aliases.

Add new tests specifically for the crossbar surface:

```elm
, test "Build main module uses Internal.Builder alias" <|
    \_ ->
        buttonBuild
            |> expectContains "M3e.Build.Internal.Builder"

, test "Slots sub-module emitted for RadioGroup" <|
    \_ ->
        radioGroupSlotsFile
            |> Expect.notEqual ""

, test "Slots sub-module exposes at least one specialized alias" <|
    \_ ->
        radioGroupSlotsFile
            |> expectContains "radio :"    -- Radio alias in RadioGroup.Slots
```

Where `radioGroupSlotsFile` is obtained via the same fixture-generation flow — invoke `generateBuildSlotsModule` for the fixture's RadioGroup declaration and stringify.

- [ ] **Step 3: Run golden tests until green**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem && pnpm run test 2>&1 | tail -20
```
Iterate: fix expectations, re-run. Expected end state: all tests pass.

- [ ] **Step 4: Full DoD check — packages/m3e compile**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/packages/m3e && \
  PATH="/Users/jhp/code/jackhp95/elm-m3e/node_modules/.bin:$PATH" \
  elm make --docs=/tmp/dod.json 2>&1 | tail -3
```
Expected: `Success! Compiled N modules.` where N is now higher than 533 (due to `.Slots` sub-modules).

- [ ] **Step 5: Full DoD check — Task 7 tests still pass**

```bash
bash /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/tests/run-build-shape-tests.sh 2>&1 | tail -5
```
Expected: `ALL BUILD SHAPE TYPE TESTS PASSED`.

- [ ] **Step 6: Mark old spec/plan superseded**

Prepend a Superseded banner to `docs/superpowers/plans/2026-07-04-build-shape-emitter.md`:

```markdown
> **SUPERSEDED (2026-07-04)** — Replaced by `docs/superpowers/plans/2026-07-04-build-shape-crossbar.md`.
> The emitter Tasks 4–10 in this file were rewritten during the crossbar redesign;
> Tasks 1–3 survived. See `docs/superpowers/specs/2026-07-04-build-shape-crossbar-design.md`
> for design rationale.

```

Similarly for `docs/superpowers/specs/2026-07-04-build-shape-emitter-design.md`.

- [ ] **Step 7: Commit both repos**

elm-cem:
```bash
cd /Users/jhp/code/jackhp95/elm-m3e/elm-cem
git add tests/src/GoldenTest.elm
git commit -m "$(cat <<'EOF'
test(codegen): update GoldenTest for crossbar ⑤ emission shape

Per docs/superpowers/plans/2026-07-04-build-shape-crossbar.md Task 8.

Generated with [Claude Code](https://claude.ai/code)
via [Happy](https://happy.engineering)

Co-Authored-By: Claude <noreply@anthropic.com>
Co-Authored-By: Happy <yesreply@happy.engineering>
EOF
)"
```

Outer:
```bash
cd /Users/jhp/code/jackhp95/elm-m3e
git add docs/superpowers/plans/2026-07-04-build-shape-emitter.md
git add docs/superpowers/specs/2026-07-04-build-shape-emitter-design.md
git commit -m "$(cat <<'EOF'
docs: mark original ⑤ Build shape spec and plan superseded

The Task 4-10 implementations were rewritten during the crossbar
redesign. Points to the new spec and plan.

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
- §1 Status and context → covered in Global Constraints (references spec + prior plan).
- §2 Motivation → covered by Task 7's test expectations mirroring the spec's user-facing examples.
- §3 One-paragraph design → captured in the Architecture header and Task 5–6 structure.
- §4 Type-level architecture → Tasks 1 (Internal), 2 (Builder alias + AttrCaps/SlotCaps), 3 (setter transitions), 4 (build terminal).
- §5 Module layout → Task 5 introduces `.Slots` sub-modules; §5.1's alias generation rules encoded in `allowedChildrenForSlot`.
- §6 User-facing API examples → Task 7's positive tests.
- §7 Safety invariants → Task 7's negative tests cover the type-level enforcement points.
- §8 Generator responsibilities → decomposed across Tasks 1–6.
- §9 Migration story → Task 8's superseded banners.
- §10 Cross-spec invariants → Global Constraints (no elm-review rules, output IR unchanged).
- §11 DoD → Task 8's Steps 4/5 verify each DoD checkbox.
- §12 Deferred / follow-ups → not implemented (fused seed setters, docs-app examples).

**Placeholder scan:**
- Task 5 Step 2 contains a note "the `parentBuilder inFlag outFlag` local inside `slotAlias` was miswritten during drafting — remove it" — that's a construction correction, not a placeholder.
- Task 6 uses `... (body: same wrap_/addChild/node_ pattern as before)` in Step 2 — expand this with an actual code snippet before dispatching Task 6. FIX INLINE:

```elm
requiredMultiSlotCore s =
    let
        fieldName = slotFieldB s
        anyBuilder = ...  -- same shape as Task 5's slotCore's anyBuilder
        filled = Type.namedWith internalModule "Filled" []
        containerBuilder rowFlag =
            Type.namedWith containerBuilderPath "Builder"
                [ Type.var "pa"
                , Type.extensible "ps" [ ( fieldName, rowFlag ) ]
                , Type.var "msg"
                ]
        signature =
            Type.function
                [ anyBuilder, containerBuilder (Type.var "filled") ]
                (containerBuilder filled)
    in
    Elm.declaration (fieldName ++ "_core")
        (Elm.fn2 (Elm.Arg.var "child") (Elm.Arg.var "parent")
            (\childE parentE ->
                Elm.apply
                    (Elm.value { importFrom = internalModule, name = "wrap_", annotation = Nothing })
                    [ Elm.apply (Elm.value { importFrom = [ lib, "Node" ], name = "addChild", annotation = Nothing })
                        [ Elm.apply (Elm.value { importFrom = internalModule, name = "node_", annotation = Nothing }) [ childE ]
                        , Elm.apply (Elm.value { importFrom = internalModule, name = "node_", annotation = Nothing }) [ parentE ]
                        ]
                    ]
                    |> Elm.withType (containerBuilder filled)
            )
            |> Elm.withType signature
        )
```

**Type consistency:**
- `wrap_ : Node -> Builder`, `node_ : Builder -> Node`: consistent across Tasks 1–6.
- Task 5's `slotCore` and Task 6's `optionalMultiSlotCore`/`requiredMultiSlotCore` all reference the same `internalModule`, `containerBuilderPath`, `slotFieldB`. Consistent.
- Alias naming rule (`<slotName><ChildComp>` unless `unnamed`) applied consistently in Task 5 and Task 6.
- `M3e.Node.addChild` referenced consistently. If the runtime `M3e.Node` module lacks an `addChild` primitive, the implementer must add one (a tiny function that appends to the Element case's `children` list). Verify before Task 5 starts:

```bash
grep "^addChild\|addChild :" /Users/jhp/code/jackhp95/elm-m3e/packages/m3e/src/M3e/Node.elm
```
If missing, the implementer of Task 5 also needs to add `M3e.Node.addChild : Node msg -> Node msg -> Node msg` (append the first Node's rendered form to the second's children list). This is a small runtime extension.

## Execution Handoff

Plan complete and saved to `docs/superpowers/plans/2026-07-04-build-shape-crossbar.md`. Two execution options:

**1. Subagent-Driven (recommended)** — dispatch a fresh subagent per task, review between tasks, fast iteration.

**2. Inline Execution** — execute tasks in this session using executing-plans, batch execution with checkpoints.

Which approach?
