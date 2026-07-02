# elm-cem Generic Doc Capabilities — Implementation Plan (Plan 1 of 3)

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Give the standalone `elm-cem` code generator two *generic, manifest-agnostic* capabilities — ingesting per-component **usage examples** and opaque **doc metadata** from config and emitting them into generated module doc comments — so any Custom Elements Manifest consumer (not just m3e) can enrich its generated Elm docs.

**Architecture:** `elm-cem`'s per-component config (`_config`, already injected by `bin/elm-cem.js` and decoded by `Generate.decodeConfig`) gains two optional fields: `examples` (list of `{title, code, section?}`) and `docMeta` (key/value pairs). Two new pure `Docs.elm` functions render them into the top component module's doc comment as **machine-readable markers + fenced ```elm blocks** (invisible/inert in rendered Markdown and to `elm make --docs`, but recoverable by a downstream extractor built in Plan 3). elm-cem never interprets the values — m3e-specific content is supplied entirely by config in Plan 2.

**Tech Stack:** Elm 0.19.1, `mdgriffith/elm-codegen` 6.0.3, `elm-test-rs` (local at `elm-cem/node_modules/.bin/elm-test-rs`), the `elm` compiler at `docs/node_modules/.bin/elm`, `elm-format` at `docs/node_modules/.bin/elm-format`.

**Scope note — this is Plan 1 of a 3-plan sequence** (from `docs/superpowers/specs/2026-07-02-docs-matraic-alignment-design.md`):
- **Plan 1 (this doc):** generic elm-cem example-ingestion + docMeta capabilities. Ships working, tested, and independently useful.
- **Plan 2 (later):** m3e Layer-2 HTML→Elm converter + section deriver + `config/slots.json` example/docMeta/category population.
- **Plan 3 (later):** docs-site renderer-extractor (doc-comment → renderable view modules), inline theme-inheriting previews, categorized nav, matraic-style Usage pages.

**Conventions pinned here (referenced by Plans 2 & 3):**
- **Example marker:** an HTML comment on its own line immediately preceding a fenced ```elm block:
  `<!-- elm-cem:example title="..." -->` then `` ```elm `` … `` ``` ``. Grouped under `### <Section>` headers, all beneath one `## Examples` header.
- **docMeta marker:** a single HTML comment: `<!-- elm-cem:docmeta key=value; key2=value2 -->`.
- Both markers are invisible in rendered Markdown (so the published registry docs stay clean) and inert to `elm make --docs` (fenced blocks are not executed — verification of examples happens in Plan 3 by *compiling* the extracted modules, not here).

---

## File Structure

| File | Responsibility | Change |
| --- | --- | --- |
| `elm-cem/tests/elm.json` | test project deps | Modify: bump `mdgriffith/elm-codegen` `3.0.0` → `6.0.3` |
| `elm-cem/tests/src/GoldenTest.elm` | existing golden test | Modify: fix stale `generateFromManifest` call to current 3-arg signature |
| `elm-cem/codegen/Generate.elm` | config type + decoder + top-module wiring | Modify: `Config` record, `decodeConfig`, `topFile` `docs =` |
| `elm-cem/codegen/Docs.elm` | doc-comment string builders | Modify: add `examplesSection`, `docMetaMarker` (+ expose) |
| `elm-cem/tests/src/ExampleDocsTest.elm` | new unit + integration tests | Create |

**Test command (used in every task):**
```bash
cd /Users/jack/Documents/code/elm-m3e/elm-cem && \
  node_modules/.bin/elm-test-rs --compiler ../docs/node_modules/.bin/elm --project tests tests/src/*.elm
```
Run a single new file by replacing the glob with `tests/src/ExampleDocsTest.elm` (its dependencies still compile transitively).

---

## Task 0: Green baseline — make the existing test suite compile & pass

The suite currently fails to compile for two independent reasons; TDD is blocked until it's green.

**Files:**
- Modify: `elm-cem/tests/elm.json`
- Modify: `elm-cem/tests/src/GoldenTest.elm:92` (and possibly the path assertion at `:149`)

- [ ] **Step 1: Reproduce the failure**

Run:
```bash
cd /Users/jack/Documents/code/elm-m3e/elm-cem && \
  node_modules/.bin/elm-test-rs --compiler ../docs/node_modules/.bin/elm --project tests tests/src/*.elm
```
Expected: FAIL — `MODULE NOT FOUND ... import Elm.Arg` (elm-codegen 3.0.0 pinned in `tests/elm.json` lacks `Elm.Arg`, which the generator's 6.x source imports).

- [ ] **Step 2: Bump the test project's elm-codegen to match the generator**

In `elm-cem/tests/elm.json`, change the dependency (`6.0.3` is already present in `~/.elm/0.19.1/packages/mdgriffith/elm-codegen/`, and `elm-cem/codegen/elm.json` uses it):
```json
"mdgriffith/elm-codegen": "6.0.3"
```
(was `"3.0.0"`).

- [ ] **Step 3: Re-run — expect a *different*, later failure**

Run the test command from Step 1.
Expected: compiles further, now FAILS in `GoldenTest.elm` with a type/arity error — `generateFromManifest` is called with 1 argument but wants 3 (`Config -> List RuntimeFile -> Cem.Manifest -> List Elm.File`, `Generate.elm:252`).

- [ ] **Step 4: Fix the stale call**

In `elm-cem/tests/src/GoldenTest.elm:90-92`, change:
```elm
emitted : List Elm.File
emitted =
    Generate.generateFromManifest fixture
```
to:
```elm
emitted : List Elm.File
emitted =
    Generate.generateFromManifest Dict.empty [] fixture
```
Add the import near the other imports (`GoldenTest.elm:13-17`):
```elm
import Dict
```

- [ ] **Step 5: Run and reconcile the emitted-paths assertion**

Run the test command.
If `GoldenTest.elm:144-149` ("emits exactly the Common and one component module") now fails because the *current* generator emits more/different module paths (e.g. a top `X/Button.elm` in addition to `Cem/X/Button.elm`), print the truth and update the expected list to match observed output:
```bash
cd /Users/jack/Documents/code/elm-m3e/elm-cem && node -e '0' # placeholder
```
Inspect by temporarily failing a test to dump `emitted |> List.map .path |> List.sort` — or read the failure message, which prints actual vs expected. Set the expected list in `GoldenTest.elm:149` to exactly the observed sorted paths. Do **not** change any other assertion.

- [ ] **Step 6: Confirm green**

Run the test command.
Expected: PASS (all suites, including GoldenTest).

- [ ] **Step 7: Commit**

```bash
cd /Users/jack/Documents/code/elm-m3e
git add elm-cem/tests/elm.json elm-cem/tests/src/GoldenTest.elm
git commit -m "test(elm-cem): restore green baseline (elm-codegen 6.0.3, fix GoldenTest arity)"
```

---

## Task 1: Add `examplesSection` to `Docs.elm`

Pure function: render example records into a `## Examples` doc-comment section, grouped by section, with markers + fenced blocks. Manifest-agnostic (sees only the records).

**Files:**
- Modify: `elm-cem/codegen/Docs.elm` (exposing list `:1-5`; add function + helper)
- Test: `elm-cem/tests/src/ExampleDocsTest.elm` (create)

- [ ] **Step 1: Write the failing test**

Create `elm-cem/tests/src/ExampleDocsTest.elm`:
```elm
module ExampleDocsTest exposing (suite)

{-| Unit + integration tests for elm-cem's generic example-ingestion and
doc-metadata capabilities (Plan 1). These assert on raw doc-comment strings, so
they are independent of any specific manifest.
-}

import Cem
import Dict
import Docs
import Elm
import Expect
import Generate
import Test exposing (Test, describe, test)


contains : String -> String -> Expect.Expectation
contains needle haystack =
    if String.contains needle haystack then
        Expect.pass

    else
        Expect.fail ("expected to find:\n  " ++ needle ++ "\n\nin:\n" ++ haystack)


missing : String -> String -> Expect.Expectation
missing needle haystack =
    if String.contains needle haystack then
        Expect.fail ("expected NOT to find:\n  " ++ needle ++ "\n\nin:\n" ++ haystack)

    else
        Expect.pass


suite : Test
suite =
    describe "elm-cem generic doc capabilities"
        [ describe "Docs.examplesSection"
            [ test "empty list renders nothing" <|
                \_ -> Docs.examplesSection [] |> Expect.equal ""
            , test "emits the Examples header when present" <|
                \_ ->
                    Docs.examplesSection
                        [ { title = "Basic", code = "view [] []", section = Nothing } ]
                        |> contains "## Examples"
            , test "emits a fenced elm block with the code" <|
                \_ ->
                    Docs.examplesSection
                        [ { title = "Basic", code = "view [] []", section = Nothing } ]
                        |> Expect.all [ contains "```elm", contains "view [] []" ]
            , test "emits a machine-readable example marker with the title" <|
                \_ ->
                    Docs.examplesSection
                        [ { title = "Basic", code = "view [] []", section = Nothing } ]
                        |> contains "<!-- elm-cem:example title=\"Basic\" -->"
            , test "groups examples under their section headers" <|
                \_ ->
                    Docs.examplesSection
                        [ { title = "Filled", code = "a", section = Just "Variants" }
                        , { title = "Small", code = "b", section = Just "Sizes" }
                        ]
                        |> Expect.all [ contains "### Variants", contains "### Sizes" ]
            , test "unsectioned examples fall under a default Examples group" <|
                \_ ->
                    Docs.examplesSection
                        [ { title = "Basic", code = "a", section = Nothing } ]
                        |> contains "### Examples"
            , test "a double-quote in a title cannot break the marker" <|
                \_ ->
                    Docs.examplesSection
                        [ { title = "He said \"hi\"", code = "a", section = Nothing } ]
                        |> missing "\"hi\" -->"
            ]
        ]
```

- [ ] **Step 2: Run to verify it fails**

Run:
```bash
cd /Users/jack/Documents/code/elm-m3e/elm-cem && \
  node_modules/.bin/elm-test-rs --compiler ../docs/node_modules/.bin/elm --project tests tests/src/ExampleDocsTest.elm
```
Expected: FAIL — `Docs.examplesSection` does not exist (naming/compile error).

- [ ] **Step 3: Implement `examplesSection`**

In `elm-cem/codegen/Docs.elm`, add `examplesSection` to the exposing list (`:1-5`):
```elm
module Docs exposing
    ( docMetaMarker
    , examplesSection
    , findSkippedElementTypes
    , generateStructuredDocs
    , generateViewDocumentation
    )
```
(`docMetaMarker` is added in Task 2 — include it now so the exposing list is final; if elm-format complains about the not-yet-defined name, add both functions' bodies in this task and Task 2's test after. Simplest: define `docMetaMarker` as a stub returning `""` here, then TDD its body in Task 2. To keep tasks honest, add the stub now:)

Add these functions to `Docs.elm` (after `bulletedSection`, around `:45`):
```elm
{-| Escape a value so it cannot terminate or corrupt an HTML-comment marker:
drop double quotes (markers quote titles) and `-->` sequences.
-}
escapeMarker : String -> String
escapeMarker s =
    s
        |> String.replace "\"" "'"
        |> String.replace "-->" "--&gt;"


{-| Render config-supplied usage examples into a `## Examples` doc-comment section,
grouped by each example's optional `section` (unsectioned ⇒ "Examples"). Every example
is a machine-readable HTML-comment marker (invisible in rendered Markdown and in the
package registry) followed by a fenced ```elm block, so a downstream extractor can
recover `(section, title, code)` while the block still reads as ordinary docs. Returns
"" when there are no examples. Manifest-agnostic — it only sees the records.
-}
examplesSection : List { fields | title : String, code : String, section : Maybe String } -> String
examplesSection examples =
    if List.isEmpty examples then
        ""

    else
        let
            sectionOf ex =
                ex.section |> Maybe.withDefault "Examples"

            orderedSections =
                examples |> List.map sectionOf |> deduplicateBy identity

            renderExample ex =
                "\n\n<!-- elm-cem:example title=\""
                    ++ escapeMarker ex.title
                    ++ "\" -->\n```elm\n"
                    ++ String.trim ex.code
                    ++ "\n```"

            renderSection name =
                "\n\n### "
                    ++ name
                    ++ (examples
                            |> List.filter (\ex -> sectionOf ex == name)
                            |> List.map renderExample
                            |> String.join ""
                       )
        in
        "\n\n## Examples"
            ++ (orderedSections |> List.map renderSection |> String.join "")


{-| Placeholder — implemented in Task 2. -}
docMetaMarker : List ( String, String ) -> String
docMetaMarker _ =
    ""
```
Note: `deduplicateBy` is already imported (`Docs.elm:20` — `import Util exposing (deduplicateBy)`). The extensible record (`{ fields | ... }`) lets both plain records and the `Config` example records satisfy the type.

- [ ] **Step 4: Run to verify it passes**

Run the single-file test command from Step 2.
Expected: PASS (the `Docs.examplesSection` group; the `docMetaMarker` stub returns `""` and isn't asserted yet).

- [ ] **Step 5: Run the full suite (no regressions)**

Run the full test command. Expected: PASS.

- [ ] **Step 6: Commit**

```bash
cd /Users/jack/Documents/code/elm-m3e
git add elm-cem/codegen/Docs.elm elm-cem/tests/src/ExampleDocsTest.elm
git commit -m "feat(elm-cem): Docs.examplesSection — generic usage-example doc blocks"
```

---

## Task 2: Implement `docMetaMarker`

Replace the Task-1 stub with the real opaque-metadata marker.

**Files:**
- Modify: `elm-cem/codegen/Docs.elm` (`docMetaMarker` body)
- Modify: `elm-cem/tests/src/ExampleDocsTest.elm` (add a describe block)

- [ ] **Step 1: Write the failing test**

In `ExampleDocsTest.elm`, add a new describe block inside `suite` (after the `Docs.examplesSection` block):
```elm
        , describe "Docs.docMetaMarker"
            [ test "empty list renders nothing" <|
                \_ -> Docs.docMetaMarker [] |> Expect.equal ""
            , test "emits a single docmeta marker with key=value" <|
                \_ ->
                    Docs.docMetaMarker [ ( "category", "Actions" ) ]
                        |> contains "<!-- elm-cem:docmeta category=Actions -->"
            , test "joins multiple pairs with a semicolon" <|
                \_ ->
                    Docs.docMetaMarker [ ( "category", "Actions" ), ( "family", "buttons" ) ]
                        |> contains "category=Actions; family=buttons"
            ]
```

- [ ] **Step 2: Run to verify it fails**

Run the single-file test command.
Expected: FAIL — the stub returns `""`, so `contains "... category=Actions ..."` fails.

- [ ] **Step 3: Implement `docMetaMarker`**

In `Docs.elm`, replace the stub body:
```elm
{-| Render opaque per-component doc metadata (config-supplied key/value pairs, e.g.
`category`) as a single machine-readable HTML-comment marker. Invisible in rendered
Markdown; a downstream tool parses it back out. Returns "" when empty. elm-cem never
interprets the keys — they are pass-through, keeping the generator manifest-agnostic.
-}
docMetaMarker : List ( String, String ) -> String
docMetaMarker pairs =
    if List.isEmpty pairs then
        ""

    else
        "\n\n<!-- elm-cem:docmeta "
            ++ (pairs
                    |> List.map (\( k, v ) -> k ++ "=" ++ escapeMarker v)
                    |> String.join "; "
               )
            ++ " -->"
```

- [ ] **Step 4: Run to verify it passes**

Run the single-file test command. Expected: PASS.

- [ ] **Step 5: Commit**

```bash
cd /Users/jack/Documents/code/elm-m3e
git add elm-cem/codegen/Docs.elm elm-cem/tests/src/ExampleDocsTest.elm
git commit -m "feat(elm-cem): Docs.docMetaMarker — opaque per-component doc metadata"
```

---

## Task 3: Extend `Config` + `decodeConfig` to carry `examples` and `docMeta`

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` (`Config` alias `:43-44`; `decodeConfig` `:85-116`; module exposing)

- [ ] **Step 1: Write the failing test**

In `ExampleDocsTest.elm`, add a describe block for the decoder. This requires `Generate.decodeConfig` and the `Config`/`ExampleRecord` types to be exposed (done in Step 3):
```elm
        , describe "Generate.decodeConfig — examples & docMeta"
            [ test "decodes examples and docMeta for a component" <|
                \_ ->
                    let
                        flags =
                            Encode.object
                                [ ( "_config"
                                  , Encode.object
                                        [ ( "Button"
                                          , Encode.object
                                                [ ( "examples"
                                                  , Encode.list identity
                                                        [ Encode.object
                                                            [ ( "title", Encode.string "Filled" )
                                                            , ( "code", Encode.string "view [] []" )
                                                            , ( "section", Encode.string "Variants" )
                                                            ]
                                                        ]
                                                  )
                                                , ( "docMeta", Encode.object [ ( "category", Encode.string "Actions" ) ] )
                                                ]
                                          )
                                        ]
                                  )
                                ]

                        cfg =
                            Generate.decodeConfig flags |> Dict.get "Button"
                    in
                    case cfg of
                        Just c ->
                            Expect.all
                                [ \x -> List.map .title x.examples |> Expect.equal [ "Filled" ]
                                , \x -> List.map .section x.examples |> Expect.equal [ Just "Variants" ]
                                , \x -> x.docMeta |> Expect.equal [ ( "category", "Actions" ) ]
                                ]
                                c

                        Nothing ->
                            Expect.fail "expected a Button config entry"
            , test "components without examples/docMeta default to empty lists" <|
                \_ ->
                    let
                        flags =
                            Encode.object [ ( "_config", Encode.object [ ( "Card", Encode.object [] ) ] ) ]

                        cfg =
                            Generate.decodeConfig flags |> Dict.get "Card"
                    in
                    case cfg of
                        Just c ->
                            Expect.all
                                [ \x -> x.examples |> Expect.equal []
                                , \x -> x.docMeta |> Expect.equal []
                                ]
                                c

                        Nothing ->
                            Expect.fail "expected a Card config entry"
            ]
```
Add `import Json.Encode as Encode` to the test's imports.

- [ ] **Step 2: Run to verify it fails**

Run the single-file test command.
Expected: FAIL — `Generate.decodeConfig` is not exposed / `.examples` field does not exist.

- [ ] **Step 3: Extend the type, decoder, and exposing**

In `Generate.elm`:

(a) Add an `ExampleRecord` alias near `SlotSpec` (`:39-40`):
```elm
type alias ExampleRecord =
    { title : String, code : String, section : Maybe String }
```

(b) Widen the `Config` record (`:43-44`):
```elm
type alias Config =
    Dict.Dict String
        { slots : List SlotSpec
        , extra : List ( String, String )
        , group : List ( String, String )
        , examples : List ExampleRecord
        , docMeta : List ( String, String )
        }
```

(c) In `decodeConfig` (`:104-116`), add an example decoder and widen the component decoder from `map3` to `map5`:
```elm
        exampleDecoder =
            Json.Decode.map3 (\t c s -> { title = t, code = c, section = s })
                (opt "title" Json.Decode.string "")
                (opt "code" Json.Decode.string "")
                (Json.Decode.maybe (Json.Decode.field "section" Json.Decode.string))
    in
    Json.Decode.decodeValue
        (Json.Decode.field "_config"
            (Json.Decode.dict
                (Json.Decode.map5
                    (\slots extra grp examples docMeta ->
                        { slots = slots, extra = extra, group = grp, examples = examples, docMeta = docMeta }
                    )
                    (opt "slots" slotsDecoder [])
                    (opt "required" (Json.Decode.keyValuePairs Json.Decode.string) [])
                    (opt "group" (Json.Decode.keyValuePairs Json.Decode.string) [])
                    (opt "examples" (Json.Decode.list exampleDecoder) [])
                    (opt "docMeta" (Json.Decode.keyValuePairs Json.Decode.string) [])
                )
            )
        )
        flags
        |> Result.withDefault Dict.empty
```
(The `exampleDecoder` `let`-binding goes alongside `slotsDecoder` inside the existing `let` in `decodeConfig`.)

(d) Expose the new members. Find the module `exposing (...)` at the top of `Generate.elm` and add `Config`, `ExampleRecord`, and `decodeConfig` if not already present. (`generateFromManifest` is already exposed — the tests use it.)

(e) **Fix every other place that constructs this record.** Search for construction sites and add the two new fields to each literal:
```bash
cd /Users/jack/Documents/code/elm-m3e/elm-cem && grep -rn "{ slots =" codegen/
```
For any `Dict.get ... |> Maybe.withDefault { slots = ..., extra = ..., group = ... }` add `, examples = [], docMeta = []`. (Reads like `.slots`/`.extra`/`.group` need no change — only literal constructions do. The compiler will flag any you miss.)

- [ ] **Step 4: Run to verify it passes**

Run the single-file test command, then the full suite.
Expected: PASS. If the compiler flags a missing-field error in `Generate.elm`, add `examples = [], docMeta = []` to that record literal and re-run.

- [ ] **Step 5: Commit**

```bash
cd /Users/jack/Documents/code/elm-m3e
git add elm-cem/codegen/Generate.elm elm-cem/tests/src/ExampleDocsTest.elm
git commit -m "feat(elm-cem): _config carries examples + docMeta (generic passthrough)"
```

---

## Task 4: Wire examples + docMeta into the generated top module docstring

**Files:**
- Modify: `elm-cem/codegen/Generate.elm` (`topFile`, `:1566-1585`)
- Modify: `elm-cem/tests/src/ExampleDocsTest.elm` (integration test via `generateFromManifest`)

- [ ] **Step 1: Write the failing test**

In `ExampleDocsTest.elm`, add a describe block that runs the *real* generator with a Config containing examples/docMeta and asserts they appear in the emitted output. Reuse a minimal non-m3e fixture so this doubles as part of the genericity proof:
```elm
        , describe "generateFromManifest wires examples + docMeta into the top module"
            [ test "the emitted output contains the example marker, fenced block, and docmeta" <|
                \_ ->
                    let
                        cfg =
                            Dict.fromList
                                [ ( "Button"
                                  , { slots = []
                                    , extra = []
                                    , group = []
                                    , examples =
                                        [ { title = "Filled", code = "Widget.Button.view [] []", section = Just "Variants" } ]
                                    , docMeta = [ ( "category", "Actions" ) ]
                                    }
                                  )
                                ]

                        allContents =
                            Generate.generateFromManifest cfg [] fixtureManifest
                                |> List.map .contents
                                |> String.join "\n\n=====\n\n"
                    in
                    Expect.all
                        [ contains "## Examples"
                        , contains "### Variants"
                        , contains "<!-- elm-cem:example title=\"Filled\" -->"
                        , contains "Widget.Button.view [] []"
                        , contains "<!-- elm-cem:docmeta category=Actions -->"
                        ]
                        allContents
            ]
```
Add the fixture at the bottom of the test module (a minimal non-m3e manifest — `wc-*` prefix, module name `Button`):
```elm
fixtureManifest : Cem.Manifest
fixtureManifest =
    { schemaVersion = "1.0.0"
    , modules =
        [ { kind = "javascript-module"
          , path = "wc-button.js"
          , declarations =
                [ { kind = "class"
                  , name = "WcButtonElement"
                  , description = Just "A widget button."
                  , tagName = Just "wc-button"
                  , cssProperties = []
                  , cssParts = []
                  , slots = [ { name = "", description = Just "Label." } ]
                  , members = []
                  , events = []
                  , attributes = [ { name = "variant", description = Nothing, type_ = Just { text = "'filled' | 'text'" }, default = Nothing, fieldName = Nothing } ]
                  , customElement = Just True
                  , summary = Nothing
                  , documentation = Nothing
                  , status = Nothing
                  , since = Nothing
                  , superclass = Nothing
                  , dependencies = []
                  , cssStates = []
                  }
                ]
          , exports = Nothing
          }
        ]
    , package = Nothing
    }
```
> If the `Cem.Declaration`/`Cem.Attribute` record fields differ from the above at compile time, copy the exact field set from `elm-cem/tests/src/GoldenTest.elm:24-73` (the `attr`/`slot`/`buttonDecl` helpers) — that file is the canonical up-to-date fixture shape after Task 0.

- [ ] **Step 2: Run to verify it fails**

Run the single-file test command.
Expected: FAIL — the emitted output does not yet contain `## Examples` / the markers (wiring not done).

- [ ] **Step 3: Wire the doc strings into `topFile`**

In `Generate.elm`, in the `let` that defines `topFile` (`:1566`), add bindings that look up this module's config, and extend the `docs =` field (`:1576`). `config` and `moduleName` are already in scope in this `let` (used by `viewType`/`viewDecl` at `:1515`,`:1525`):
```elm
        cfgFor =
            Dict.get moduleName config

        exampleRecords =
            cfgFor |> Maybe.map .examples |> Maybe.withDefault []

        docMetaPairs =
            cfgFor |> Maybe.map .docMeta |> Maybe.withDefault []

        topFile =
            Elm.fileWith [ lib, moduleName ]
                { docs =
                    Docs.generateViewDocumentation component
                        ++ Docs.docMetaMarker docMetaPairs
                        ++ Docs.examplesSection exampleRecords
                , aliases = []
                }
                (viewDecl
                    :: (List.map setter specs
                            ++ List.map eventAlias events
                            ++ List.map contentSetter contentSlots
                            ++ defaultHelpers
                       )
                )
```
(Only the `docs =` value changed; the declarations list is unchanged. Place `cfgFor`/`exampleRecords`/`docMetaPairs` among the other `let` bindings before `topFile`.)

- [ ] **Step 4: Run to verify it passes**

Run the single-file test command, then the full suite.
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
cd /Users/jack/Documents/code/elm-m3e
git add elm-cem/codegen/Generate.elm elm-cem/tests/src/ExampleDocsTest.elm
git commit -m "feat(elm-cem): emit config examples + docMeta into top module docstring"
```

---

## Task 5: Genericity guard — prove it works for a non-m3e manifest end-to-end

Task 4 already used a `wc-*` (non-m3e) fixture. This task hardens the guarantee: the emitted markers must appear on the **top module for that non-m3e library** and must be **absent when config is empty** (no accidental output), locking in that the feature is opt-in and manifest-agnostic.

**Files:**
- Modify: `elm-cem/tests/src/ExampleDocsTest.elm`

- [ ] **Step 1: Write the failing test**

Add to `ExampleDocsTest.elm`:
```elm
        , describe "genericity guard (non-m3e manifest)"
            [ test "no examples/docMeta markers are emitted when config is empty" <|
                \_ ->
                    Generate.generateFromManifest Dict.empty [] fixtureManifest
                        |> List.map .contents
                        |> String.join "\n"
                        |> Expect.all
                            [ missing "elm-cem:example"
                            , missing "elm-cem:docmeta"
                            , missing "## Examples"
                            ]
            , test "the example lands on the wc-button top module specifically" <|
                \_ ->
                    let
                        cfg =
                            Dict.fromList
                                [ ( "Button"
                                  , { slots = [], extra = [], group = []
                                    , examples = [ { title = "Filled", code = "x", section = Nothing } ]
                                    , docMeta = []
                                    }
                                  )
                                ]

                        topModule =
                            Generate.generateFromManifest cfg [] fixtureManifest
                                |> List.filter (\f -> String.endsWith "Button.elm" f.path && not (String.contains "Cem/" f.path))
                                |> List.map .contents
                                |> String.join ""
                    in
                    topModule |> contains "<!-- elm-cem:example title=\"Filled\" -->"
            ]
```
(`missing` and `contains` helpers already exist from Task 1.)

- [ ] **Step 2: Run to verify it fails, then passes**

Run the single-file test command.
Expected: with Tasks 1–4 done, the first test (empty config ⇒ no markers) should already PASS; the second (top-module targeting) should PASS. If the second fails because the top module path filter is wrong, dump `Generate.generateFromManifest cfg [] fixtureManifest |> List.map .path` (temporarily fail a test to print) and adjust the `List.filter` predicate to select the top `[lib, moduleName]` file (e.g. `Widget/Button.elm`), not the `Cem/Widget/Button.elm` middle/bottom modules.

- [ ] **Step 3: Run the full suite**

Run the full test command. Expected: PASS.

- [ ] **Step 4: Commit**

```bash
cd /Users/jack/Documents/code/elm-m3e
git add elm-cem/tests/src/ExampleDocsTest.elm
git commit -m "test(elm-cem): genericity guard — example/docMeta markers are opt-in & manifest-agnostic"
```

---

## Task 6: Real-manifest smoke — generate against @m3e/web, format, and keep `elm make --docs` green

Prove the markers survive the *actual* generation + `elm-format` + `elm make --docs` pipeline (the two downstream consumers in Plan 3), using a throwaway config entry. This catches formatter/compiler interactions the unit tests can't.

**Files:**
- Create (throwaway): `/tmp/smoke-config.json`
- No committed source changes (verification only) unless a fix is needed.

- [ ] **Step 1: Build a minimal smoke config**

Create `/tmp/smoke-config.json` — one real component, one example, one docMeta pair. `Button`'s TOP-layer API is `M3e.Button.view [attrs] [content]`:
```json
{
  "Button": {
    "docMeta": { "category": "Actions" },
    "examples": [
      {
        "title": "Filled button",
        "section": "Variants",
        "code": "M3e.Button.view [ M3e.Button.variant M3e.Value.filled ] [ M3e.Button.child (M3e.Element.text \"New\") ]"
      }
    ]
  }
}
```

- [ ] **Step 2: Run the real generator into a scratch output**

Run (does not touch the committed `packages/m3e`):
```bash
cd /Users/jack/Documents/code/elm-m3e && \
  node elm-cem/bin/elm-cem.js \
    --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json \
    --config-from=/tmp/smoke-config.json \
    --output=/tmp/m3e-smoke-src
```
Expected: exits 0; `/tmp/m3e-smoke-src/M3e/Button.elm` exists.

- [ ] **Step 3: Assert the markers are present in the generated Button module**

Run:
```bash
grep -c "elm-cem:example\|elm-cem:docmeta\|## Examples" /tmp/m3e-smoke-src/M3e/Button.elm
```
Expected: ≥ 3 (all three markers present in the generated doc comment).

- [ ] **Step 4: Run elm-format and confirm markers survive**

Run:
```bash
../elm-m3e/docs/node_modules/.bin/elm-format --yes /tmp/m3e-smoke-src/M3e/Button.elm 2>&1 || \
  /Users/jack/Documents/code/elm-m3e/docs/node_modules/.bin/elm-format --yes /tmp/m3e-smoke-src/M3e/Button.elm
grep -c "elm-cem:example\|elm-cem:docmeta" /tmp/m3e-smoke-src/M3e/Button.elm
```
Expected: elm-format exits 0; grep still ≥ 2. If elm-format reflows or drops the fenced block/markers, note the exact change — the marker convention may need a tweak (e.g. blank-line padding); fix `Docs.examplesSection`/`docMetaMarker` and re-run Tasks 1–5.

- [ ] **Step 5: Confirm `elm make --docs` still succeeds with examples in the comment**

Point the docs reference generator's scratch flow at the smoke output, or run the compiler directly against a package scratch. Simplest: reuse the docs pipeline against the real (unchanged) tree to confirm no regression in the toolchain, then compile the smoke file's module comment by running the existing extractor unchanged:
```bash
cd /Users/jack/Documents/code/elm-m3e/docs && node scripts/extract-reference.mjs && echo "reference OK"
```
Expected: prints `reference OK` (the committed tree is unchanged, so this must stay green — it proves the extractor/compiler baseline is intact for Plan 3 to build on).

- [ ] **Step 6: Clean up scratch + commit (docs only)**

```bash
rm -rf /tmp/m3e-smoke-src /tmp/smoke-config.json
cd /Users/jack/Documents/code/elm-m3e
git add docs/superpowers/plans/2026-07-02-elm-cem-doc-capabilities.md
git commit -m "docs(plan): elm-cem generic doc-capabilities plan (Plan 1 of 3)"
```

---

## Self-Review

**Spec coverage (§ = design spec sections):**
- §Layer 1 "Example ingestion" → Tasks 1, 3, 4. ✅
- §Layer 1 "Doc metadata passthrough" → Tasks 2, 3, 4. ✅
- §Layer 1 "Section hinting" → **partially**: elm-cem's *mechanism* (grouping emitted examples by their `section` field) is Task 1; the attribute→section *resolution map* is explicitly Plan 2 (the deriver), per the design's Layer-2 "Section deriver." Called out so it isn't mistaken for a gap.
- §"Genericity guard: non-m3e fixture manifest" → Tasks 4 & 5 (wc-button fixture). ✅
- §"Fenced-block marker convention … pinned early with a test" → conventions pinned in the header; Task 6 Step 4 tests survival through elm-format. ✅
- §"Development approach — TDD at every step" → every task is failing-test-first. ✅
- §Risk "elm-format may reflow doc comments" → Task 6 Step 4 explicitly checks. ✅

**Placeholder scan:** The only intentional placeholder is the `docMetaMarker` stub in Task 1 Step 3, which is *replaced* in Task 2 Step 3 — flagged inline, not a gap. No "TBD"/"handle edge cases"/"similar to Task N" left.

**Type consistency:** `examplesSection`/`docMetaMarker` signatures match between `Docs.elm` and every test call. `ExampleRecord = { title, code, section }` is identical in the `Config` record (Task 3), the decoder output (Task 3), and the integration fixture (Task 4). `Config` record field order (`slots, extra, group, examples, docMeta`) matches the `decodeConfig` `map5` constructor and the `Dict.fromList` literals in Tasks 4–5.

**Known reconciliation points (honest, compiler-enforced):** (1) the exact emitted top-module path for the fixture (Tasks 4–5 filter for it; Step 2 instructions dump the truth if the filter misses); (2) the exact `Cem.Declaration`/`Cem.Attribute` field set for the fixture (Task 4 references `GoldenTest.elm:24-73` as the canonical shape); (3) `GoldenTest.elm:149`'s path assertion after the generator moved on (Task 0 Step 5). All three are caught by the compiler or a printed failure — none are silent.
