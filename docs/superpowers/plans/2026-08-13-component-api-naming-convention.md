# Implementation Plan — Component API naming: `view`→`<name>` / `el`→`required` + elm-review guard

Plan for spec: `elm-m3e/specs/2026-08-13-component-api-naming-convention-design.md`
Date: 2026-08-13

## Goal

Rename the two generated smart-constructors that every `M3e.Component.X` module
exposes:

- `view` → the module's own lowercased base name (`Button` → `button`,
  `Checkbox` → `checkbox`, …)
- `el` → `required`

The rename is a **pure rename** (signatures/bodies unchanged), produced by the
**elm-cem generator**, not a codemod against elm-m3e's `src/M3e/**` (that tree is
codegen output — see Architecture). Then add an **elm-review rule** in
`elm-review-cem` that guards the convention against future drift, registered in
elm-m3e's `review/src/ReviewConfig.elm`.

Success = elm-cem phantom golden gate green with re-blessed goldens; elm-m3e
regenerates, `elm make src/M3e.elm` compiles, `elm-review` reports 0 violations of
the new rule across all 130 component modules; elm-review-cem's `elm-test` green;
docs site still builds and `M3e.Component.Button.button` / `.required` render.

## Architecture

Three repos, sequenced A → A.1 → B. Each repo's mutating work runs in its **own git
worktree** (executor creates the worktree per part; this plan does not).

**Critical fact (verified, do not violate):** `elm-m3e/src/M3e/**` is elm-cem
codegen output, NOT hand-written source. Confirmed via `elm-m3e/.gitattributes:24`
(`src/** linguist-generated=true`), `CONTRIBUTING.md:10-14` ("Do not hand-edit
them — change the generator … and regenerate"), `docs/ARCHITECTURE-GROUND-TRUTH.md:17-22`.
A codemod against `src/M3e/**` is reverted by the next `npm run gen:src`. **The
rename happens in the generator.**

**Where the literals live** — one file,
`elm-cem/codegen/Generate/Phantom/Emit.elm` (~276 KB, 6744 lines). Three emit
functions, all verified against the golden fixtures:

| Function | Line | Emits | `view`/`el` literals | Auto-follows rename? |
|---|---|---|---|---|
| `compModule` | 2681 | `M3e.Component.X` | `exposeGroups` 2787/2789; `viewDecl` 3025-3033; `elDecl` 3096-3118 (incl. internal `view` calls at 3101/3108) | **NO — edit here (source of truth)** |
| `generalModule` | 4438 | `M3e` barrel | `.view` body+doc at **4455** | **NO — one-line fix at 4455** |
| `buildModule` | ~3480 | `M3e.Build.X` | none (refs `Component.icon`/`.variant`, not `view`/`el`) | **YES — verified via golden Build/Button.elm** |

`@docs view, el` is derived from `exposeGroups` via `docsBlock` (Emit.elm:2827) —
**auto-follows** once `exposeGroups` changes. The collision-guard block in
`guardComponentModule` (Emit.elm:685/753) also lists `"view"`/`"el"`; update it for
consistency (it drives duplicate-name error messages).

**Regen entry point (verified):** elm-m3e `package.json:9` `gen:src` shells out to
`../elm-cem/bin/elm-cem.js … --output=src && npm run format:src`. To point at the
worktree'd generator, set `ELM_CEM_BIN`.

**elm-cem regression backstop (verified — spec's "gap" fear was unfounded):** the
phantom golden harness. `npm run test:phantom` (`tests/phantom/gate.mjs`) verifies
byte-equality against `tests/phantom/expected/**`; `npm run bless`
(`tests/phantom/bless.mjs`) regenerates them. Goldens contain `view`/`el` and the
barrel `Mini.elm` contains `.view` bodies — so the rename **requires re-blessing**,
and the gate then proves the change is exactly what's intended.

**elm-review-cem wiring (verified):** it's on elm-m3e's review source-path via
`review/elm.json:source-directories` `"../../elm-review-cem/src"`. A new rule module
there is import-and-register in `review/src/ReviewConfig.elm`. Exposing-list
extraction has a proven in-repo pattern at
`elm-review-cem/src/NoRedundantAttributeEscape.elm:386-407`.

## Tech Stack

- elm-cem generator: Elm + `elm-codegen`-style string emission (`codegen/`), Node CLI
  (`bin/elm-cem.js`). Golden harness in Node (`tests/phantom/*.mjs`).
- elm-m3e: generated Elm `src/M3e/**`; docs is an elm-pages app (`docs/`); one
  hand-written Node script `docs/scripts/extract-reference.mjs`.
- elm-review-cem: Elm `package` — deps `jfmengels/elm-review 2.16.x`,
  `stil4m/elm-syntax 7.3.x`, `elm/core`; test-dep `elm-explorations/test 2.x`.
  Tests via `elm-test-rs`.

## Non-goals (preserve every one)

- NO `M3e.Component` → `M3e.Components` module-namespace rename (functions only).
- NO new `type Button` (or per-component concrete type).
- NO rename of `build` (`M3e.Build.X` entry point).
- NO behavior change to `view`/`el` — pure rename.
- NO change to elm-cem config / CEM-manifest inputs (emitter-only edit).
- NO autofix on the new rule (v1 is drift-prevention only).

---

# PART A — elm-cem generator fix + re-bless goldens

> Executor: create a worktree of `elm-cem` for all of Part A.
> elm-format after every `.elm` edit: `elm-cem/node_modules/.bin/elm-format --yes <file>`.

## A1 — RED: re-bless goldens is NOT the test; first read the current golden shape

No code yet. Confirm the baseline gate is green before touching anything:

```
cd <elm-cem-worktree> && npm run test:phantom
```

Expect: PASS (goldens match current generator). This is the pre-change green.

Read the golden that will change most, to fix the intended before/after in your head:
`tests/phantom/expected/Mini/Component/Button.elm` (exposing `( view, el, … )`,
`@docs view, el`, `view :` / `view =` / `el required_ …`) and
`tests/phantom/expected/Mini.elm:45-50` (barrel: `button =` then body
`Mini.Component.Button.view`).

## A2 — GREEN: edit `compModule` in `Emit.elm`

File: `elm-cem/codegen/Generate/Phantom/Emit.elm`, function `compModule` (from 2681).

**A2a — compute the base name once.** In the `let` of `compModule` (near the
existing `lib =` at 2684-2685), add:

```elm
        ctorName =
            Naming.camel comp.name
```

(`Naming.camel "Button" == "button"` — verified `codegen/Naming.elm:85-98`. This is
the same lowercasing already used for module member names.)

**A2b — exposing list** (2787-2793): replace the literal `"view"`/`"el"`:

```elm
        exposeGroups =
            [ [ ctorName ]
                ++ (if hasEl then
                        [ "required" ]

                    else
                        []
                   )
```

(`@docs` auto-follows via `docsBlock exposeGroups` at 2827 — no separate edit.)

**A2c — `viewDecl`** (3025-3033): replace `"view"` in the two emitted lines:

```elm
        viewDecl =
            [ doc viewDocText
            , ctorName ++ " :"
            , "    List (Attr Attrs msg)"
            , "    -> " ++ childrenSig
            , "    -> " ++ returnType
            , ctorName ++ " ="
            , "    H." ++ comp.resolvedCtor
            ]
```

**A2d — `elDecl` body** (3096-3118): both branches emit `el required_ …` and call
`view` internally. Replace `el` → `required` and internal `view` → `ctorName`:

- 3096: `[ "el required_ attrs children ="` → `[ "required required_ attrs children ="`
- 3101: `, "    view"` → `, "    " ++ ctorName`
- 3107: `[ "el required_ attrs children ="` → `[ "required required_ attrs children ="`
- 3108: `, "    view "` → `, "    " ++ ctorName ++ " "`

And the type-signature head (3123): `"el :"` → `"required :"`.

**A2e — doc-comment text.** `viewDocText` (3014-3023) says "Standard constructor:";
leave the prose (it's accurate regardless of name). The `elDecl` doc at 3122
("Required-content (and action) constructor …") stays accurate. No change needed
here — but grep the compModule range for any residual literal `` `view` `` /
`` `el` `` in doc strings and update if present:
`grep -n '\`view\`\|\`el\`' codegen/Generate/Phantom/Emit.elm` restricted to 2681-3130.

**A2f — collision guard** `guardComponentModule` (685-687, 753-755): update the
`"view"`/`"el"` literals so duplicate-name diagnostics name the real emitted names.
This function has `comp` in scope; compute the same `Naming.camel comp.name` there:

```elm
                [ [ Naming.camel comp.name ]         -- was [ "view" ]
                , if not (List.isEmpty (comp.slots |> List.filter .required)) || comp.actionCaps /= Nothing then
                    [ "required" ]                    -- was [ "el" ]
```

and the pair-list at 753-755 likewise (`( Naming.camel comp.name, "static decl" )`,
`( "required", "static decl" )`).

`elm-format --yes` the file.

## A3 — GREEN: one-line fix in `generalModule` (barrel)

File same, function `generalModule` (4438), `ctorSig`, line **4455**:

```elm
                        Nothing ->
                            lib ++ ".Component." ++ comp.name ++ "." ++ Naming.camel comp.name
```

(was `… ++ ".view"`). This fixes both the barrel body (`button = M3e.Component.Button.button`)
and its doc (`See \`M3e.Component.Button.button\``). The `Just _` branch (4458) uses
`comp.ctor` (atom-homed constructor, not `view`) — **verify-at-exec** by inspecting
the re-blessed `Hz.elm`/atom goldens that this branch's output is unchanged; expect
no change. `elm-format --yes`.

## A4 — RED→GREEN: re-bless and read the diff

```
cd <elm-cem-worktree>
node bin/elm-cem.js --help >/dev/null    # sanity: generator still loads
npm run bless
git --no-pager diff -- tests/phantom/expected
```

**Verify the diff is ONLY the intended substitutions:** in every
`expected/*/Component/*.elm`: exposing `view`→`<name>`, `el`→`required`, `@docs`
line, `view :`/`view =`→`<name>`, `el required_`→`required required_`, internal
`view`→`<name>`; in every barrel (`Mini.elm`, `Hz.elm`, `Br.elm`): `.view` bodies +
`See ….view` docs → `.<name>`; Build/* goldens **unchanged** (buildModule doesn't
reference these). Any unrelated churn = wider blast radius → stop and investigate.

```
npm run test:phantom        # gate: byte-equality — must PASS
```

## A5 — VERIFY Part A in isolation

```
cd <elm-cem-worktree> && npm run gate    # check + full test suite
```

Expect green. Commit: `git add -A && git commit -m "feat!: rename generated view→<name>, el→required (Emit.elm) + re-bless goldens"`.
Add a `CHANGELOG.md` entry under `## [Unreleased]` (breaking generator-output change).

---

# PART A ROLLOUT — regenerate elm-m3e `src/` + verify + commit

> Executor: worktree of `elm-m3e`. Point regen at the Part-A elm-cem worktree via
> `ELM_CEM_BIN`.

## AR1 — snapshot the pre-change tree, then regenerate

```
cd <elm-m3e-worktree>
git rev-parse HEAD                       # baseline
ELM_CEM_BIN=<elm-cem-worktree>/bin/elm-cem.js npm run gen:src
```

(`gen:src` = `elm-cem.js … --output=src && npm run format:src && format:icons`,
`package.json:9`.)

## AR2 — diff-verify: ONLY intended name substitutions

```
git --no-pager diff --stat -- src
git --no-pager diff -- src/M3e/Component/Button.elm src/M3e.elm
```

Every `src/M3e/Component/*.elm`: `view`→lowercased module name, `el`→`required`,
exposing + `@docs` + decls updated. `src/M3e.elm` barrel: `.view` bodies/docs →
`.<name>`. `src/M3e/Build/*.elm`: **no changes** (expected). No behavior/type churn.
A diff touching unrelated content = generator blast-radius bug → back to Part A.

## AR3 — compile (the real correctness backstop)

```
cd <elm-m3e-worktree> && node_modules/.bin/elm make src/M3e.elm --output=/dev/null
```

Compiles ⇒ every internal call site across all 130 modules + barrel + Build tracked
the rename (the generator, not a grep, is the guarantee). Fix = fix the generator
(Part A), not `src/`.

## AR4 — commit generated output

```
git add src && git commit -m "chore(gen): regenerate src/M3e for view→<name>/el→required rename"
```

Normal generated-output commit (same as any elm-cem bump). Add a `CHANGELOG.md`
entry under `## [Unreleased]` (breaking `src/M3e` public-API rename).

---

# PART A.1 — the one hand-written elm-m3e call site + docs prose

> Same elm-m3e worktree.

## A1a — RED: `extract-reference.mjs` `roleOf` classifier

File `docs/scripts/extract-reference.mjs`. `roleOf(m)` at line 305-313 special-cases
`if (m.name === "view") return "ctor";` (line 308). After regen, no member is named
`view` — every component ctor silently loses its `ctor` role.

`roleOf` doesn't receive the module. The lowercased base name is already computed as
`slug` inside `moduleEntry` (line 324, `name.replace(/^Component\./, "").toLowerCase()`),
and `roleOf` is called at line 348 (`m.role = roleOf(m)`) where `slug` is in scope.

**Fix:** thread `slug` into `roleOf` and compare against it (and keep `required`
implicitly falling through to `other`/attr — `required`'s signature is a constructor,
so it also should be `ctor`). Change signature and callsite:

```js
// line 305
function roleOf(m, ctorName) {
  const sig = m.signature || "";
  if (m.kind === "type") return "type";
  if (m.name === ctorName || m.name === "required") return "ctor";
  ...
}
// line 348
for (const m of members) m.role = roleOf(m, slug);
```

(`slug` for `M3e.Component.Button` is `"button"` — matches the new ctor name.
Adding `required` keeps the required-record constructor grouped with the ctor, which
matches its prior `el`→(fell through to `other`) behavior — **decision point:** if
the reference page previously grouped `el` as `other`, keep parity by NOT adding the
`required` clause. Verify against a rendered reference page during A1d and pick the
grouping that matches pre-change output for `el`.)

## A1b — GREEN: docs prose sweep (guard the false-positive trap)

**TRAP (verified):** a bare `\.view` grep in `docs/` matches hand-written docs-app
helpers — `Theme.view`, `Logo.view`, `Theme.Sections.Color.view` — which are NOT the
generated API and must NOT be renamed. Only rewrite `M3e.Component.<X>.view` /
`M3e.Component.<X>.el`.

Precise find (≈19 lines, 10 files):

```
cd <elm-m3e-worktree>
grep -rEn 'M3e\.Component\.[A-Za-z]+\.(view|el)\b' docs/app docs/src
```

Files: `docs/app/Shared.elm`, `Route/Guide/{Reference,Seams,CheatSheet,Strictness,TheLayers,Roundtrip,ToolingRefactors,HowWeProveIt,Glossary,Motion,Theming}.elm`,
`Route/GettingStarted/Installation.elm`, `docs/src/Guide/Samples.elm`. Rewrite each
`M3e.Component.<X>.view` → `M3e.Component.<X>.<x>` (lowercased) and
`M3e.Component.<X>.el` → `M3e.Component.<X>.required`. Also prose like
"the standard `view` surface" / "the `el` surface" (e.g. `Roundtrip.elm:291-292`,
`Glossary.elm:87`, `TheLayers.elm:117-118`) → update the backticked name.
**Do NOT touch** `Theme.view`, `Logo.view`, `Theme.Sections.*.view`, `M3e.Theme.view`.

> Usage-example strings on component pages are generated from the live modules
> (extract-reference pipeline) and follow automatically — verify in A1d, don't
> hand-edit them.

`elm-format --yes` any `.elm` docs files edited.

## A1c — GREEN: CHANGELOGs

Already added elm-cem (A5) and elm-m3e (AR4) entries. Confirm both under
`## [Unreleased]` name the breaking rename explicitly.

## A1d — VERIFY docs build + spot-check

```
cd <elm-m3e-worktree>
npm run build:site                       # docs elm-pages build (ignore Pages.elm builtAt churn)
```

Then spot-check (per MEMORY: test against PROD build, not the dev server — the dev
server doesn't wire Elm listeners onto SSR nodes):

- Reference page for Button renders `button` and `required` under the constructor
  group (confirms A1a grouping choice is right).
- A rendered Usage example on the Button page shows `M3e.Component.Button.button …`
  (confirms generated example strings auto-followed).

Commit: `git commit -am "docs: update prose + roleOf for view→<name>/el→required rename"`.

---

# PART B — elm-review rule (elm-review-cem) + register in both configs

> Executor: worktree of `elm-review-cem` for B1-B3; the ReviewConfig registration in
> B4 is in the **elm-m3e** worktree (pointing at the elm-review-cem worktree via its
> source-dir — or land B1-B3 first and let elm-m3e's existing `../../elm-review-cem/src`
> path resolve).
> elm-format after every `.elm` edit: `elm-review-cem/node_modules/.bin/elm-format --yes <file>`.

## B1 — RED: write the test first

File `elm-review-cem/tests/NoMissingComponentApiNamesTest.elm`, mirroring
`tests/NoInternalImportOutsideAllowedTest.elm` shape (module `…Test exposing (all)`,
`Review.Test.run (rule)`, `Test`/`describe`/`test`). elm-test-rs discovers `all`.

Deps available (verified `elm-review-cem/elm.json`): `Review.Test`, `Test`,
`Elm.Syntax.*` (7.3.x), `Set`.

```elm
module NoMissingComponentApiNamesTest exposing (all)

import NoMissingComponentApiNames exposing (rule)
import Review.Test
import Test exposing (Test, describe, test)


all : Test
all =
    describe "NoMissingComponentApiNames"
        [ test "M3e.Component.Button exposing button and required — no error" <|
            \() ->
                """module M3e.Component.Button exposing (button, required, variant)

button attrs children =
    something

required r attrs children =
    button attrs children
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        , test "missing the ctor name (has required only) — reports the missing ctor" <|
            \() ->
                """module M3e.Component.Button exposing (required, variant)

required r attrs children =
    something
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "`M3e.Component.Button` does not expose its constructor `button`"
                            , details =
                                [ "Every `M3e.Component.*` module must expose a value named after the module's own lowercased base name — here `button` — as its standard constructor."
                                , "This is normally emitted by the elm-cem generator; a missing name means the module was hand-edited or generated by a stale generator. Regenerate with `npm run gen:src`."
                                ]
                            , under = "M3e.Component.Button"
                            }
                        ]
        , test "missing `required` (has ctor only) — reports missing required" <|
            \() ->
                """module M3e.Component.Button exposing (button, variant)

button attrs children =
    something
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "`M3e.Component.Button` does not expose `required`"
                            , details =
                                [ "Every `M3e.Component.*` module must expose a value named `required` (the required-content constructor)."
                                , "This is normally emitted by the elm-cem generator; a missing name means the module was hand-edited or generated by a stale generator. Regenerate with `npm run gen:src`."
                                ]
                            , under = "M3e.Component.Button"
                            }
                        ]
        , test "missing both — reports both (two errors)" <|
            \() ->
                """module M3e.Component.Widget exposing (variant)

variant v =
    something
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectErrorsForModules
                        [ ( "M3e.Component.Widget", [ {- ctor error -} , {- required error -} ] ) ]
        , test "non-M3e.Component module missing both — out of scope, no error" <|
            \() ->
                """module Docs.Whatever exposing (thing)

thing =
    something
"""
                    |> Review.Test.run rule
                    |> Review.Test.expectNoErrors
        ]
```

> Fill the "missing both" case's two `Review.Test.error` records with the same
> message/details as the single-missing cases (module `Widget`, ctor `widget`).
> `under` = the module-name token (report on the module-definition range).

Run — expect FAIL (rule module doesn't exist):
`cd <elm-review-cem-worktree> && npm run test:elm`

## B2 — GREEN: write the rule

File `elm-review-cem/src/NoMissingComponentApiNames.elm`. Single-visitor design:
the module name AND exposing list are both available in `moduleDefinitionVisitor`,
and these modules use explicit exposing lists (verified — `Button.elm` exposes
`( view, el, … )`, never `exposing (..)`), matching `NoMissingTypeExpose`'s approach.
Reuse the exposing-extraction pattern verbatim from
`NoRedundantAttributeEscape.elm:390-407`.

```elm
module NoMissingComponentApiNames exposing (rule)

{-| Guard the generated component-API naming convention: every `M3e.Component.*`
module must expose its standard constructor under the module's own lowercased base
name (`Button` → `button`) and its required-content constructor as `required`.

The rename ships through elm-cem regeneration; this rule is drift prevention — it
catches a hand-edited exception or a stale-generator regression. No autofix (v1).

@docs rule

-}

import Elm.Syntax.Exposing as Exposing
import Elm.Syntax.Module as Module
import Elm.Syntax.ModuleName exposing (ModuleName)
import Elm.Syntax.Node as Node exposing (Node)
import Review.Rule as Rule exposing (Error, Rule)
import Set exposing (Set)


{-| The drift guard for `M3e.Component.*` API names.
-}
rule : Rule
rule =
    Rule.newModuleRuleSchema "NoMissingComponentApiNames" ()
        |> Rule.withSimpleModuleDefinitionVisitor moduleDefinitionVisitor
        |> Rule.fromModuleRuleSchema


moduleDefinitionVisitor : Node Module.Module -> List (Error {})
moduleDefinitionVisitor node =
    let
        moduleName : ModuleName
        moduleName =
            Module.moduleName (Node.value node)
    in
    if not (isComponentModule moduleName) then
        []

    else
        let
            baseName : String
            baseName =
                moduleName
                    |> List.reverse
                    |> List.head
                    |> Maybe.withDefault ""

            ctorName : String
            ctorName =
                String.toLower baseName

            exposed : Set String
            exposed =
                case Module.exposingList (Node.value node) of
                    Exposing.All _ ->
                        -- exposing (..) exposes everything; treat as satisfying
                        -- both (these modules never use it, but be permissive).
                        Set.fromList [ ctorName, "required" ]

                    Exposing.Explicit list ->
                        Set.fromList (List.filterMap exposedFunctionName list)

            qualified : String
            qualified =
                String.join "." moduleName

            range =
                Node.range node

            ctorError =
                if Set.member ctorName exposed then
                    []

                else
                    [ Rule.error
                        { message = "`" ++ qualified ++ "` does not expose its constructor `" ++ ctorName ++ "`"
                        , details =
                            [ "Every `M3e.Component.*` module must expose a value named after the module's own lowercased base name — here `" ++ ctorName ++ "` — as its standard constructor."
                            , "This is normally emitted by the elm-cem generator; a missing name means the module was hand-edited or generated by a stale generator. Regenerate with `npm run gen:src`."
                            ]
                        }
                        range
                    ]

            requiredError =
                if Set.member "required" exposed then
                    []

                else
                    [ Rule.error
                        { message = "`" ++ qualified ++ "` does not expose `required`"
                        , details =
                            [ "Every `M3e.Component.*` module must expose a value named `required` (the required-content constructor)."
                            , "This is normally emitted by the elm-cem generator; a missing name means the module was hand-edited or generated by a stale generator. Regenerate with `npm run gen:src`."
                            ]
                        }
                        range
                    ]
        in
        ctorError ++ requiredError


{-| Scope gate: only `M3e.Component.*` modules (prefix match, dot-boundary).
-}
isComponentModule : ModuleName -> Bool
isComponentModule moduleName =
    case moduleName of
        "M3e" :: "Component" :: _ :: _ ->
            True

        _ ->
            False


exposedFunctionName : Node Exposing.TopLevelExpose -> Maybe String
exposedFunctionName node =
    case Node.value node of
        Exposing.FunctionExpose name ->
            Just name

        _ ->
            Nothing
```

> DESIGN NOTE (deviation from spec, simpler + matches repo convention): the spec
> sketched `withModuleDefinitionVisitor` + `withDeclarationListVisitor`. Because
> these modules use explicit exposing lists, the exposing list alone is
> authoritative and `withSimpleModuleDefinitionVisitor` suffices (mirrors
> `NoRedundantAttributeEscape`). If a future module needs `exposing (..)` +
> declaration inspection, add `withDeclarationListVisitor` then. `required` is a
> fixed literal (not derived), so no per-module `required` requirement escapes.
>
> VERIFY-AT-EXEC: `Rule.newModuleRuleSchema "…" () |> withSimpleModuleDefinitionVisitor`
> is valid for elm-review 2.16.6 (the non-context schema). If the executor prefers
> the context-creator form (as `NoInternalImportOutsideAllowed` uses), switch to
> `newModuleRuleSchemaUsingContextCreator` + `withModuleDefinitionVisitor` returning
> `( errors, context )` — same logic, threaded through `Context`.

`elm-format --yes` the rule file. Run tests — expect GREEN:
`cd <elm-review-cem-worktree> && npm run test:elm`

## B3 — register in elm-review-cem's own dev config + VERIFY the package

Add to `elm-review-cem/review/src/ReviewConfig.elm` (its own dev suite):

```elm
import NoMissingComponentApiNames
-- in config list:
    , NoMissingComponentApiNames.rule
```

Then:

```
cd <elm-review-cem-worktree> && npm run gate    # check:* (format/review/facts-sync) + test:*
```

Expect green. Commit:
`git commit -am "feat: add NoMissingComponentApiNames rule + tests"`.

## B4 — register in elm-m3e's ReviewConfig + run against regenerated src

In the **elm-m3e worktree** (its `review/elm.json` already source-dirs
`../../elm-review-cem/src`, so once B1-B3 land the module resolves). Edit
`elm-m3e/review/src/ReviewConfig.elm`:

- add `import NoMissingComponentApiNames`
- add `NoMissingComponentApiNames.rule` to the appropriate group (e.g. the existing
  `codegenAware` list alongside `Cem`/`M3e.Review.Facts`).

Run elm-review against the regenerated `src/`:

```
cd <elm-m3e-worktree>/docs
node_modules/.bin/elm-review --config ../review --compiler node_modules/.bin/elm
```

(the canonical invocation per `ReviewConfig.elm`'s own header). Expect **0
violations** of `NoMissingComponentApiNames` across all 130 component modules
(they all now expose `<name>` + `required`). If any fires, the generator missed a
component → back to Part A.

`elm-format --yes review/src/ReviewConfig.elm`. Commit:
`git commit -am "chore(review): register NoMissingComponentApiNames"`.

---

# Testing (per spec's Testing section)

| Repo | Command | Expect |
|---|---|---|
| elm-cem | `npm run test:phantom` after `npm run bless` | byte-equal, PASS (goldens re-blessed with intended diff only) |
| elm-cem | `npm run gate` | full suite green |
| elm-m3e | `ELM_CEM_BIN=… npm run gen:src` then `elm make src/M3e.elm` | regenerates, compiles (rename tracked everywhere) |
| elm-m3e | `git diff src` review | only intended name substitutions; Build/* unchanged |
| elm-m3e | `elm-review --config ../review` (from docs/) | 0 `NoMissingComponentApiNames` violations across 130 modules |
| elm-m3e | `npm run build:site` + PROD spot-check | docs build; Button page renders `.button` / `.required` |
| elm-review-cem | `npm run test:elm` | new rule's 5 cases green |
| elm-review-cem | `npm run gate` | check + test green |

# Sequencing summary

A (elm-cem: edit Emit.elm compModule + barrel 4455 + guard → bless → gate → commit +
CHANGELOG) → A-rollout (elm-m3e: gen:src → diff → elm make → commit generated src +
CHANGELOG) → A.1 (elm-m3e: roleOf fix + docs prose sweep [avoid Theme.view trap] →
build:site + spot-check → commit) → B (elm-review-cem: test → rule → dev config →
gate → commit; then elm-m3e: register in ReviewConfig → elm-review 0 violations →
commit). Each repo in its own worktree.

# Risks / verify-at-exec flags

1. `generalModule` line 4458 `Just _` branch (`comp.ctor`, atom-homed) — expected
   unchanged by the rename; confirm via re-blessed atom goldens (Hz/Or).
2. `roleOf` grouping of `required` (A1a) — match pre-change `el` grouping; verify on
   a rendered reference page.
3. Rule schema form (B2) — `newModuleRuleSchema … |> withSimpleModuleDefinitionVisitor`
   vs the context-creator form; either works, pick what compiles cleanly against
   elm-review 2.16.6.
4. Docs generated Usage strings auto-follow — verify in A1d, do not hand-edit.
