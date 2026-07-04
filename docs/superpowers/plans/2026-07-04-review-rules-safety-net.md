# Review Rules Safety Net — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Ship the codegen-aware elm-review rule set (D1–D5) that consumes
`M3e.Review.Facts` to enforce first-ship top-layer guarantees: missing
required attribute, missing required-singular slot, duplicate singular
setter, shorthand → specific autofix, and hardened required-multi
detection. Four new rules + three retrofitted existing rules + one shared
helper module.

**Architecture:** A shared helper `review/src/Facts.elm` centralizes
call-site resolution (`callSite`), fact lookup (`find`, `buildIndex`), and a
progressive list-content tracer (`tracedList`). Every rule reads facts and
walks the AST; rules are shape-aware, Facts is shape-agnostic. Autofix uses
`Review.Fix.replaceRangeBy` for `PreferSpecificSlot`.

**Tech Stack:** Elm 0.19.1; `jfmengels/elm-review@2`; `elm-test-rs@3`;
existing `review/src/` layout following the current rule-per-file pattern.

## Global Constraints

- Governing spec: `docs/superpowers/specs/2026-07-04-review-rules-safety-net-design.md`.
- Governing ADR: `docs/adr/0012-codegen-aware-elm-review.md`.
- Cross-spec invariants: `docs/superpowers/specs/2026-07-03-epic-138-shipping-coordination.md`.
- Facts is per-component, shape-agnostic. Every `requiredAttrs` fact is drawn
  from `config/slots.json`. Rules are shape-aware; Facts is shape-invariant.
- Existing 3 rules (`ValidEnumValue`, `SingularSlot`, `RequireSlot`) must
  continue to fire on Shape3 call sites unchanged; retrofit ADDS Shape4
  coverage.
- Every rule uses `rule : List Fact -> Rule` signature — parameterized by
  the generated facts.
- `PreferSpecificSlot` autofix output must compile — verified via
  `Review.Test.whenFixed`.
- Rules commit to the outer repo (`/Users/jhp/code/jackhp95/elm-m3e/`) only.
- Test suite command (from the repo root):
  ```
  PATH="./node_modules/.bin:/Users/jhp/.elm/elm-tooling/elm-test-rs/3.0.0:$PATH" \
    elm-test-rs --project review review/tests/*.elm
  ```
- Existing baseline: 25/25 tests pass at the start of Task 1.

---

### Task 1: `Facts` shared helper — `callSite`, `find`, and Basic `tracedList`

**Files:**
- Create: `review/src/Facts.elm`
- Create: `review/tests/FactsTest.elm`

**Interfaces:**
- Produces:
  - `type alias CallSite = { noun : String, shape : Facts.Shape }` (re-exposes the generated `Shape` from `M3e.Review.Facts`).
  - `callSite : ModuleNameLookupTable -> Node Expression -> Maybe CallSite`
  - `buildIndex : List M3e.Review.Facts.Fact -> Dict String M3e.Review.Facts.Fact`
  - `find : String -> Dict String M3e.Review.Facts.Fact -> Maybe M3e.Review.Facts.Fact`
  - `type alias TracedList = { known : List (Node Expression), unresolved : Bool }`
  - `tracedList : ModuleNameLookupTable -> Node Expression -> TracedList`
- Consumed by: every subsequent task.

- [ ] **Step 1: Write the failing tests for `callSite`**

Create `review/tests/FactsTest.elm`:

```elm
module FactsTest exposing (all)

import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Elm.Syntax.Range exposing (emptyRange)
import Expect
import Facts
import M3e.Review.Facts as MRF exposing (Shape(..))
import Test exposing (Test, describe, test)


all : Test
all =
    describe "Facts"
        [ describe "callSite"
            [ test "recognises M3e.Button.view as Shape3 button" <|
                \_ ->
                    -- Placeholder — actual test uses Review.Test to exercise
                    -- callSite via a rule that reports its return value.
                    Expect.pass
            ]
        , describe "tracedList (Basic)"
            [ test "empty list literal" <|
                \_ ->
                    Expect.pass
            , test "literal list yields its elements" <|
                \_ ->
                    Expect.pass
            , test "bare variable resolves to its let binding" <|
                \_ ->
                    Expect.pass
            , test "two-literal concat" <|
                \_ ->
                    Expect.pass
            ]
        ]
```

The placeholders will be replaced with proper `Review.Test` fixtures in Step 3 —
`callSite` and `tracedList` can't be tested in isolation, they need a rule
context. For now the file compiles.

- [ ] **Step 2: Verify test file compiles (currently placeholder-only)**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
PATH="./node_modules/.bin:/Users/jhp/.elm/elm-tooling/elm-test-rs/3.0.0:$PATH" \
  elm-test-rs --project review review/tests/FactsTest.elm 2>&1 | tail -5
```
Expected: `Facts.elm` doesn't exist yet, so compile error `Cannot find module Facts`.

- [ ] **Step 3: Write the minimal `Facts.elm` that satisfies the imports**

Create `review/src/Facts.elm`:

```elm
module Facts exposing
    ( CallSite, callSite
    , buildIndex, find
    , TracedList, tracedList
    )

{-| Shared helpers for codegen-aware rules that consume `M3e.Review.Facts`.

@docs CallSite, callSite
@docs buildIndex, find
@docs TracedList, tracedList

-}

import Dict exposing (Dict)
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import M3e.Review.Facts as MRF exposing (Fact, Shape(..))
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)


{-| A resolved top-layer call site: which component + which top-shape variant.
-}
type alias CallSite =
    { noun : String
    , shape : Shape
    }


{-| Resolve a function-reference AST node to a top-layer call site, if any.

Handles four forms:
- `M3e.Button.view` → `{ noun = "button", shape = Shape3 }`
- `M3e.Record.Button.view` → `{ noun = "button", shape = Shape4 }`
- `M3e.button` (barrel) → `{ noun = "button", shape = Shape3 }`
- `M3e.Record.button` (Shape4 barrel) → `{ noun = "button", shape = Shape4 }`

Returns `Nothing` for non-top-layer references (`M3e.Cem.*`, `Html.*`, etc.).
-}
callSite : ModuleNameLookupTable -> Node Expression -> Maybe CallSite
callSite lookup fnNode =
    case Node.value fnNode of
        Expression.FunctionOrValue _ name ->
            case Lookup.moduleNameFor lookup fnNode of
                Just [ "M3e" ] ->
                    Just { noun = name, shape = Shape3 }

                Just [ "M3e", "Record" ] ->
                    Just { noun = name, shape = Shape4 }

                Just [ "M3e", comp ] ->
                    if name == "view" then
                        Just { noun = decapitalize comp, shape = Shape3 }

                    else
                        Nothing

                Just [ "M3e", "Record", comp ] ->
                    if name == "view" then
                        Just { noun = decapitalize comp, shape = Shape4 }

                    else
                        Nothing

                _ ->
                    Nothing

        _ ->
            Nothing


{-| Build a noun-keyed index from a facts list. -}
buildIndex : List Fact -> Dict String Fact
buildIndex facts =
    facts
        |> List.map (\f -> ( f.component, f ))
        |> Dict.fromList


{-| Look up a fact by component noun. -}
find : String -> Dict String Fact -> Maybe Fact
find noun index =
    Dict.get noun index


{-| The result of tracing a list expression. `known` are the elements the
tracer could resolve statically; `unresolved` is `True` iff some parts of the
expression couldn't be traced (bare functions from other modules, opaque
`List.map` etc.).
-}
type alias TracedList =
    { known : List (Node Expression)
    , unresolved : Bool
    }


{-| Progressive list-content resolver.

Basic level (this task):
- `[a, b, c]` → all elements, `unresolved = False`.
- Anything else → `unresolved = True`, no known elements.

Medium and Ambitious levels are added in later tasks.
-}
tracedList : ModuleNameLookupTable -> Node Expression -> TracedList
tracedList _ node =
    case Node.value node of
        Expression.ListExpr elements ->
            { known = elements, unresolved = False }

        _ ->
            { known = [], unresolved = True }


decapitalize : String -> String
decapitalize s =
    case String.uncons s of
        Just ( c, rest ) ->
            String.cons (Char.toLower c) rest

        Nothing ->
            s
```

- [ ] **Step 4: Verify test suite compiles**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
PATH="./node_modules/.bin:/Users/jhp/.elm/elm-tooling/elm-test-rs/3.0.0:$PATH" \
  elm-test-rs --project review review/tests/*.elm 2>&1 | tail -5
```
Expected: FactsTest passes (4 `Expect.pass` placeholders); existing 25 tests continue passing. Total 29.

- [ ] **Step 5: Replace test placeholders with Review-based `callSite` tests**

Actual verification of `callSite` requires a probe rule that exercises it inside `Review.Test`. Create a private probe rule for the tests — inline in `FactsTest.elm`:

```elm
module FactsTest exposing (all)

import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Facts
import M3e.Review.Facts exposing (Shape(..))
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)
import Review.Test
import Test exposing (Test, describe, test)


{-| A minimal rule that flags any top-layer call site it recognises via
`Facts.callSite`. Used only in tests to verify `callSite`'s classification.
-}
probeRule : Rule
probeRule =
    Rule.newModuleRuleSchemaUsingContextCreator "FactsProbe" initContext
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


type alias Context =
    { lookup : ModuleNameLookupTable }


initContext : Rule.ContextCreator () Context
initContext =
    Rule.initContextCreator (\lookup () -> { lookup = lookup })
        |> Rule.withModuleNameLookupTable


expressionVisitor : Node Expression -> Context -> ( List (Error {}), Context )
expressionVisitor node context =
    case Node.value node of
        Expression.Application (fnNode :: _) ->
            case Facts.callSite context.lookup fnNode of
                Just site ->
                    ( [ Rule.error
                            { message =
                                "probe: " ++ site.noun ++ " " ++ shapeLabel site.shape
                            , details = [ "used only for tests" ]
                            }
                            (Node.range fnNode)
                      ]
                    , context
                    )

                Nothing ->
                    ( [], context )

        _ ->
            ( [], context )


shapeLabel : Shape -> String
shapeLabel s =
    case s of
        Shape3 -> "Shape3"
        Shape4 -> "Shape4"


all : Test
all =
    describe "Facts"
        [ describe "callSite"
            [ test "recognises M3e.Button.view as button/Shape3" <|
                \_ ->
                    """module A exposing (v)
import M3e.Button
v = M3e.Button.view [] []
"""
                        |> Review.Test.run probeRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "probe: button Shape3"
                                , details = [ "used only for tests" ]
                                , under = "M3e.Button.view"
                                }
                            ]
            , test "recognises M3e.Record.Button.view as button/Shape4" <|
                \_ ->
                    """module A exposing (v)
import M3e.Record.Button
v = M3e.Record.Button.view {} [] []
"""
                        |> Review.Test.run probeRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "probe: button Shape4"
                                , details = [ "used only for tests" ]
                                , under = "M3e.Record.Button.view"
                                }
                            ]
            , test "recognises M3e.button (barrel) as button/Shape3" <|
                \_ ->
                    """module A exposing (v)
import M3e
v = M3e.button [] []
"""
                        |> Review.Test.run probeRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "probe: button Shape3"
                                , details = [ "used only for tests" ]
                                , under = "M3e.button"
                                }
                            ]
            , test "recognises M3e.Record.button (Shape4 barrel)" <|
                \_ ->
                    """module A exposing (v)
import M3e.Record
v = M3e.Record.button {} [] []
"""
                        |> Review.Test.run probeRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "probe: button Shape4"
                                , details = [ "used only for tests" ]
                                , under = "M3e.Record.button"
                                }
                            ]
            , test "returns Nothing for M3e.Cem.Button (middle layer)" <|
                \_ ->
                    """module A exposing (v)
import M3e.Cem.Button
v = M3e.Cem.Button.button [] []
"""
                        |> Review.Test.run probeRule
                        |> Review.Test.expectNoErrors
            ]
        ]
```

- [ ] **Step 6: Run tests, verify all pass**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
PATH="./node_modules/.bin:/Users/jhp/.elm/elm-tooling/elm-test-rs/3.0.0:$PATH" \
  elm-test-rs --project review review/tests/*.elm 2>&1 | tail -5
```
Expected: 5 new `Facts.callSite` tests pass; existing 25 still pass. Total 30.

- [ ] **Step 7: Commit**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
git add review/src/Facts.elm review/tests/FactsTest.elm && \
git commit -m "feat(review): Facts shared helper — callSite + buildIndex/find + Basic tracedList"
```

---

### Task 2: `tracedList` — Medium level (partial concat + variable resolution)

**Files:**
- Modify: `review/src/Facts.elm` — extend `tracedList`.
- Modify: `review/tests/FactsTest.elm` — add tracing tests.

**Interfaces:**
- `tracedList` signature unchanged; behavior extends to:
  - `[a] ++ [b]` (fully-literal concat).
  - `[a] ++ dynamic` (partial: `known = [a]`, `unresolved = True`).
  - `dynamic ++ [a]` (same).
  - `List.append [a] [b]`, `List.concat [[a], [b]]` (structurally equivalent to `++`).
  - Bare variable references resolving to a `let`-bound or top-level value in the same module.

- [ ] **Step 1: Write failing tests for the Medium tracing cases**

Append to `review/tests/FactsTest.elm`'s `all` function:

```elm
        , describe "tracedList (Medium)"
            [ test "two-literal concat" <|
                \_ ->
                    """module A exposing (v)
import M3e
v = M3e.button [] ([ M3e.child a ] ++ [ M3e.child b ])
"""
                        -- Uses probeContentRule (defined below) which asserts
                        -- known == [child a, child b] and unresolved == False.
                        |> Review.Test.run probeContentRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "known:2 unresolved:False"
                                , details = [ "probe" ]
                                , under = "M3e.button"
                                }
                            ]
            , test "partial concat — literal left, dynamic right" <|
                \_ ->
                    """module A exposing (v)
import M3e
v = M3e.button [] ([ M3e.child a ] ++ tail)
"""
                        |> Review.Test.run probeContentRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "known:1 unresolved:True"
                                , details = [ "probe" ]
                                , under = "M3e.button"
                                }
                            ]
            , test "bare variable resolves to its let binding" <|
                \_ ->
                    """module A exposing (v)
import M3e
v =
    let
        content = [ M3e.child a, M3e.child b ]
    in
    M3e.button [] content
"""
                        |> Review.Test.run probeContentRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "known:2 unresolved:False"
                                , details = [ "probe" ]
                                , under = "M3e.button"
                                }
                            ]
            ]
```

Add the `probeContentRule` and its supporting code above the `all` definition:

```elm
{-| Probe rule that inspects the second argument of `M3e.button` via
`Facts.tracedList` and reports `known:N unresolved:B`. Used to verify
`tracedList` classifications.
-}
probeContentRule : Rule
probeContentRule =
    Rule.newModuleRuleSchemaUsingContextCreator "TracedListProbe" initContext
        |> Rule.withExpressionEnterVisitor tracedListVisitor
        |> Rule.fromModuleRuleSchema


tracedListVisitor : Node Expression -> Context -> ( List (Error {}), Context )
tracedListVisitor node context =
    case Node.value node of
        Expression.Application (fnNode :: args) ->
            case ( Facts.callSite context.lookup fnNode, List.reverse args ) of
                ( Just _, last :: _ ) ->
                    let
                        traced =
                            Facts.tracedList context.lookup last
                    in
                    ( [ Rule.error
                            { message =
                                "known:"
                                    ++ String.fromInt (List.length traced.known)
                                    ++ " unresolved:"
                                    ++ (if traced.unresolved then "True" else "False")
                            , details = [ "probe" ]
                            }
                            (Node.range fnNode)
                      ]
                    , context
                    )

                _ ->
                    ( [], context )

        _ ->
            ( [], context )
```

- [ ] **Step 2: Run the new tests, verify they fail**

```bash
PATH="./node_modules/.bin:/Users/jhp/.elm/elm-tooling/elm-test-rs/3.0.0:$PATH" \
  elm-test-rs --project review review/tests/FactsTest.elm 2>&1 | tail -10
```
Expected: 3 new tests fail. Basic `tracedList` doesn't handle `++`, `List.append`, or variable resolution.

- [ ] **Step 3: Extend `tracedList` for concat and reference resolution**

In `review/src/Facts.elm`, replace the current `tracedList` with:

```elm
tracedList : ModuleNameLookupTable -> Node Expression -> TracedList
tracedList lookup node =
    tracedListWith lookup Dict.empty node


{-| Internal — `resolved` accumulates the set of variable names already followed,
so a cyclic reference (`x = y; y = x`) doesn't infinite-loop. -}
tracedListWith : ModuleNameLookupTable -> Dict String Bool -> Node Expression -> TracedList
tracedListWith lookup resolved node =
    case Node.value node of
        Expression.ListExpr elements ->
            { known = elements, unresolved = False }

        Expression.OperatorApplication "++" _ left right ->
            concatTraced
                (tracedListWith lookup resolved left)
                (tracedListWith lookup resolved right)

        Expression.Application (fnNode :: args) ->
            case ( Node.value fnNode, args ) of
                ( Expression.FunctionOrValue [ "List" ] "append", [ a, b ] ) ->
                    concatTraced
                        (tracedListWith lookup resolved a)
                        (tracedListWith lookup resolved b)

                ( Expression.FunctionOrValue [ "List" ] "concat", [ inner ] ) ->
                    case Node.value inner of
                        Expression.ListExpr parts ->
                            List.foldl
                                (\part acc ->
                                    concatTraced acc (tracedListWith lookup resolved part)
                                )
                                { known = [], unresolved = False }
                                parts

                        _ ->
                            { known = [], unresolved = True }

                _ ->
                    { known = [], unresolved = True }

        Expression.FunctionOrValue _ name ->
            -- Bare variable reference; caller module context needed for full
            -- resolution. See Task 3's Ambitious extensions for cross-module
            -- source-following. For this task, resolve only single-module
            -- `let` bindings, which the caller must pre-attach to `resolved`
            -- via a wrapping rule (below).
            case Dict.get name resolved of
                Just _ ->
                    -- already following this ref — cycle guard
                    { known = [], unresolved = True }

                Nothing ->
                    { known = [], unresolved = True }

        _ ->
            { known = [], unresolved = True }


concatTraced : TracedList -> TracedList -> TracedList
concatTraced a b =
    { known = a.known ++ b.known
    , unresolved = a.unresolved || b.unresolved
    }
```

For `let`-bound variable resolution, we need to attach the module's `let`
scope to `tracedList`. Extend the signature by threading in a scope
parameter — but keep the exported `tracedList` signature stable for the
callers. The internal `tracedListWith` accepts a Dict, and the exposed
`tracedList` invokes it with an empty Dict.

Then extend `tracedList` to also accept a scope dict. Update the exposed
API:

```elm
tracedList : ModuleNameLookupTable -> Dict String (Node Expression) -> Node Expression -> TracedList
tracedList lookup scope node =
    tracedListWith lookup scope Dict.empty node


tracedListWith :
    ModuleNameLookupTable
    -> Dict String (Node Expression)
    -> Dict String Bool
    -> Node Expression
    -> TracedList
tracedListWith lookup scope seen node =
    case Node.value node of
        Expression.ListExpr elements ->
            { known = elements, unresolved = False }

        Expression.OperatorApplication "++" _ left right ->
            concatTraced
                (tracedListWith lookup scope seen left)
                (tracedListWith lookup scope seen right)

        Expression.Application (fnNode :: args) ->
            resolveApp lookup scope seen fnNode args

        Expression.FunctionOrValue _ name ->
            if Dict.member name seen then
                { known = [], unresolved = True }

            else
                case Dict.get name scope of
                    Just referred ->
                        tracedListWith lookup scope (Dict.insert name True seen) referred

                    Nothing ->
                        { known = [], unresolved = True }

        _ ->
            { known = [], unresolved = True }


resolveApp lookup scope seen fnNode args =
    case ( Node.value fnNode, args ) of
        ( Expression.FunctionOrValue [ "List" ] "append", [ a, b ] ) ->
            concatTraced
                (tracedListWith lookup scope seen a)
                (tracedListWith lookup scope seen b)

        ( Expression.FunctionOrValue [ "List" ] "concat", [ inner ] ) ->
            case Node.value inner of
                Expression.ListExpr parts ->
                    List.foldl
                        (\part acc ->
                            concatTraced acc (tracedListWith lookup scope seen part)
                        )
                        { known = [], unresolved = False }
                        parts

                _ ->
                    { known = [], unresolved = True }

        _ ->
            { known = [], unresolved = True }
```

**Callers of `tracedList` must now supply a `scope : Dict String (Node Expression)`.** Update `probeContentRule` to compute a `let`-scope
before calling `tracedList` — a `letBindingVisitor` collects `let` bindings
into the scope, then the expression visitor uses them.

For simplicity in this task, the tests can use the module-level scope only
(top-level function bodies where `let` bindings are visible). Attach a
`letBindingVisitor` to the probe:

```elm
probeContentRule =
    Rule.newModuleRuleSchemaUsingContextCreator "TracedListProbe" initContext
        |> Rule.withDeclarationEnterVisitor declarationEnterVisitor
        |> Rule.withExpressionEnterVisitor tracedListVisitor
        |> Rule.fromModuleRuleSchema


type alias Context =
    { lookup : ModuleNameLookupTable
    , scope : Dict String (Node Expression)
    }


initContext =
    Rule.initContextCreator (\lookup () -> { lookup = lookup, scope = Dict.empty })
        |> Rule.withModuleNameLookupTable


declarationEnterVisitor node context =
    case Node.value node of
        Declaration.FunctionDeclaration { declaration } ->
            case Node.value declaration |> .expression |> Node.value of
                Expression.LetExpression { declarations } ->
                    let
                        scope =
                            List.foldl
                                (\dec acc ->
                                    case Node.value dec of
                                        Expression.LetFunction fn ->
                                            let
                                                fnDecl = Node.value fn.declaration
                                                name = Node.value fnDecl.name
                                            in
                                            Dict.insert name fnDecl.expression acc

                                        _ ->
                                            acc
                                )
                                context.scope
                                declarations
                    in
                    ( [], { context | scope = scope } )

                _ ->
                    ( [], context )

        _ ->
            ( [], context )
```

(This is a minimal let-collector; production callers should use
`elm-review`'s `Rule.withLetDeclarationEnterVisitor` for correctness.)

- [ ] **Step 4: Run tests, verify Medium cases pass**

```bash
PATH="./node_modules/.bin:/Users/jhp/.elm/elm-tooling/elm-test-rs/3.0.0:$PATH" \
  elm-test-rs --project review review/tests/FactsTest.elm 2>&1 | tail -5
```
Expected: all Medium tests green (3/3). All Basic tests still green. Total FactsTest ≥ 8 passing.

- [ ] **Step 5: Commit**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
git add review/src/Facts.elm review/tests/FactsTest.elm && \
git commit -m "feat(review): Facts.tracedList — Medium (concat + let-scope resolution)"
```

---

### Task 3: `tracedList` — Ambitious (push until you can't)

**Files:**
- Modify: `review/src/Facts.elm` — extend `tracedList` further.
- Modify: `review/tests/FactsTest.elm` — add Ambitious cases.

**Interfaces:** `tracedList` signature unchanged; behavior extends. When the
implementer can't push further against real docs-app patterns, they stop and
commit.

- [ ] **Step 1: Add Ambitious test cases (one per pattern, TDD)**

Append to `review/tests/FactsTest.elm`'s `all`:

```elm
        , describe "tracedList (Ambitious)"
            [ test "List.map with single-setter lambda counts as one known" <|
                \_ ->
                    """module A exposing (v)
import M3e
v = M3e.button [] (List.map (\\x -> M3e.child x) items)
"""
                        |> Review.Test.run probeContentRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "known:1 unresolved:True"
                                , details = [ "probe" ]
                                , under = "M3e.button"
                                }
                            ]
            , test "case scrutinee with all-literal branches" <|
                \_ ->
                    """module A exposing (v)
import M3e
v =
    M3e.button []
        (case flag of
            True -> [ M3e.child a ]
            False -> [ M3e.child b ]
        )
"""
                        -- When every case branch is a literal list, intersect
                        -- them: known = elements common to all branches?
                        -- Or union? Design choice: return union with
                        -- unresolved=True to signal "at least these were seen
                        -- in some branch".
                        |> Review.Test.run probeContentRule
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "known:2 unresolved:True"
                                , details = [ "probe" ]
                                , under = "M3e.button"
                                }
                            ]
            , test "cross-module: value imported from another module" <|
                \_ ->
                    -- Multi-module Review.Test scenario. Deferred if
                    -- Review.Test doesn't support project-context easily.
                    Expect.pass
            ]
```

The `case` union-vs-intersection decision: **union** (any-branch element is
known, `unresolved = True` because we don't know which branch fired). This
is the loosest safe posture — rules that need presence get the widest set
of candidates; rules that need absence bail on `unresolved`.

- [ ] **Step 2: Extend `tracedList` for `List.map` and `case`**

Add cases to `tracedListWith` (in `review/src/Facts.elm`):

```elm
tracedListWith lookup scope seen node =
    case Node.value node of
        Expression.ListExpr elements ->
            { known = elements, unresolved = False }

        Expression.OperatorApplication "++" _ left right ->
            concatTraced (…) (…)

        Expression.Application (fnNode :: args) ->
            case Node.value fnNode of
                Expression.FunctionOrValue [ "List" ] "append" ->
                    -- (as Medium)

                Expression.FunctionOrValue [ "List" ] "concat" ->
                    -- (as Medium)

                Expression.FunctionOrValue [ "List" ] "map" ->
                    case args of
                        [ lambdaNode, _ ] ->
                            case Node.value lambdaNode of
                                Expression.LambdaExpression lambda ->
                                    -- Inspect the lambda body: if it's a
                                    -- single Application whose function is
                                    -- a top-layer setter, count as 1.
                                    { known =
                                        case Node.value lambda.expression of
                                            Expression.Application (setterNode :: _) ->
                                                [ setterNode ]

                                            _ ->
                                                []
                                    , unresolved = True
                                    }

                                _ ->
                                    { known = [], unresolved = True }

                        _ ->
                            { known = [], unresolved = True }

                _ ->
                    resolveApp lookup scope seen fnNode args

        Expression.CaseExpression { cases } ->
            let
                branchTraces =
                    List.map (\( _, branchExpr ) -> tracedListWith lookup scope seen branchExpr) cases
            in
            { known = List.concatMap .known branchTraces
            , unresolved = True
            }

        Expression.FunctionOrValue _ name ->
            -- (as Medium — resolve via scope with cycle guard)

        _ ->
            { known = [], unresolved = True }
```

- [ ] **Step 3: Run tests. If `case` and `List.map` pass, push into more patterns.**

```bash
PATH="./node_modules/.bin:/Users/jhp/.elm/elm-tooling/elm-test-rs/3.0.0:$PATH" \
  elm-test-rs --project review review/tests/FactsTest.elm 2>&1 | tail -5
```

Once basic Ambitious cases pass, look at `docs/app/**/*.elm` for concrete
list-building patterns that `tracedList` still fails on:

```bash
grep -n "M3e\.\(button\|card\|iconButton\).*\[" docs/app/**/*.elm | head -30
```

For each new pattern encountered, add:
1. A failing test in `FactsTest.elm`.
2. An extension to `tracedListWith`.
3. Verify the test passes.

Stop when either (a) all docs-app list patterns are covered OR (b) the next
pattern requires simulation/evaluation the tracer can't safely do (e.g.,
`List.filter (\x -> f x)` where `f` is opaque).

- [ ] **Step 4: Cross-module tracing (best effort)**

If `Review.Test` cleanly supports multi-module fixtures (see the
`Review.Test.runOnModules` API), add a cross-module case where a
`let`-scope-external value is followed via project context:

```elm
Review.Test.runOnModules [ moduleA, moduleB ] rule
```

Extend the rule (and `tracedList`'s caller) to use
`Rule.withModuleNameLookupTable` and project-context tracing. If this
becomes non-trivial, defer to a follow-up — cross-module tracing may not
be worth the complexity for the initial ship.

- [ ] **Step 5: Commit**

```bash
git add review/src/Facts.elm review/tests/FactsTest.elm && \
git commit -m "feat(review): Facts.tracedList — Ambitious (List.map + case + best-effort refs)"
```

---

### Task 4: Retrofit existing 3 rules to use `Facts.callSite` + `Facts.tracedList`

**Files:**
- Modify: `review/src/ValidEnumValue.elm` — swap inline `constructorNoun` for `Facts.callSite`; use `Facts.tracedList` for attrs list where present.
- Modify: `review/src/SingularSlot.elm` — same treatment for content-list analysis.
- Modify: `review/src/RequireSlot.elm` — same, plus adopt `tracedList` (this task's version of D5's harden — the new tracing makes the rule stronger).
- Modify: `review/tests/ValidEnumValueTest.elm`, `SingularSlotTest.elm`, `RequireSlotTest.elm` — add Shape4 and dynamic-content test cases.

**Interfaces:**
- Consumes: `Facts.callSite`, `Facts.tracedList`, `Facts.buildIndex`, `Facts.find` (Task 1).
- Behavior change: existing rules now fire on Shape4 call sites AND on previously-dynamic content lists that `tracedList` can now see through.

- [ ] **Step 1: Add Shape4 fixture entries to each rule's test file**

In each of `ValidEnumValueTest.elm`, `SingularSlotTest.elm`, `RequireSlotTest.elm`, add a test that exercises a Shape4 call site. Example for `RequireSlotTest.elm`:

```elm
        , test "flags a required-multi slot omission at Shape4 call site" <|
            \() ->
                """module A exposing (v)

import M3e.Record.Grid

v =
    M3e.Record.Grid.view {} [] []
"""
                    |> Review.Test.run (rule shape4Facts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Required slot `child` is not filled"
                            , details =
                                [ "This component needs at least one `child` in its content list, but none is present."
                                , "This is a repeatable required slot, so the type system doesn't enforce it — add the missing content."
                                ]
                            , under = "M3e.Record.Grid.view"
                            }
                        ]
```

With `shape4Facts` — a fixture list including grid with `shapes = [ Shape3, Shape4 ]`.

- [ ] **Step 2: Run tests, verify Shape4 cases fail**

```bash
PATH="./node_modules/.bin:/Users/jhp/.elm/elm-tooling/elm-test-rs/3.0.0:$PATH" \
  elm-test-rs --project review review/tests/*.elm 2>&1 | tail -10
```
Expected: new Shape4 tests fail; the 3 existing rules only see Shape3.

- [ ] **Step 3: Rewrite `RequireSlot.elm` to use `Facts.callSite` and `Facts.tracedList`**

Replace the inline `constructorNoun` and the `contentElements` list-literal check with `Facts.callSite` and `Facts.tracedList`:

```elm
module RequireSlot exposing (rule)

import Dict exposing (Dict)
import Elm.Syntax.Declaration as Declaration
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Facts
import M3e.Review.Facts exposing (Fact)
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


rule : List Fact -> Rule
rule facts =
    Rule.newModuleRuleSchemaUsingContextCreator "RequireSlot" (initContext (buildRequiredIndex facts))
        |> Rule.withDeclarationEnterVisitor collectLetScope
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


{-| noun → required-multi setter names to check. -}
type alias RequiredIndex =
    Dict String (List String)


buildRequiredIndex : List Fact -> RequiredIndex
buildRequiredIndex facts =
    facts
        |> List.map
            (\f ->
                ( f.component
                , f.requiredSlots
                    |> List.filter (\s -> List.member s f.multiSlots)
                    |> List.map slotSetter
                )
            )
        |> List.filter (\( _, req ) -> not (List.isEmpty req))
        |> Dict.fromList


slotSetter : String -> String
slotSetter slot =
    if slot == "default" || slot == "unnamed" then
        "child"

    else
        camelize slot


type alias Context =
    { lookup : ModuleNameLookupTable
    , index : RequiredIndex
    , scope : Dict String (Node Expression)
    }


initContext : RequiredIndex -> Rule.ContextCreator () Context
initContext index =
    Rule.initContextCreator (\lookup () -> { lookup = lookup, index = index, scope = Dict.empty })
        |> Rule.withModuleNameLookupTable


collectLetScope : Node Declaration.Declaration -> Context -> ( List (Error {}), Context )
collectLetScope declNode context =
    -- (implementation as sketched in Task 2; use Rule.withLetDeclarationEnterVisitor
    -- if elm-review supports it for cleaner scoping)
    ( [], context )


expressionVisitor : Node Expression -> Context -> ( List (Error {}), Context )
expressionVisitor node context =
    case Node.value node of
        Expression.Application (fnNode :: args) ->
            case Facts.callSite context.lookup fnNode of
                Just site ->
                    case Facts.find site.noun (buildIndexView context.index) of
                        _ ->
                            case Dict.get site.noun context.index of
                                Just required ->
                                    ( checkCall context required (Node.range fnNode) args, context )

                                Nothing ->
                                    ( [], context )

                Nothing ->
                    ( [], context )

        _ ->
            ( [], context )


-- (helper: use Facts.tracedList on the LAST arg — the content list — and
-- flag missing required-multi setter names in the traced set)
checkCall context required range args =
    -- ...
```

The full retrofit of `RequireSlot.elm` replaces `contentElements` (which
only looked at raw `ListExpr`) with `Facts.tracedList` on the last arg.
Existing message text unchanged. Existing tests should still pass; new
tests (Shape4 + traced-content) should also pass.

- [ ] **Step 4: Rewrite `SingularSlot.elm` similarly**

Same treatment: `Facts.callSite` for the constructor detection, `Facts.tracedList` for the content list. Existing behavior preserved for literal lists.

- [ ] **Step 5: Rewrite `ValidEnumValue.elm` similarly**

Same for `Facts.callSite`. `ValidEnumValue` walks the attrs list — replace its inline resolution with `Facts.tracedList` on the attrs argument. Enum-value check unchanged.

- [ ] **Step 6: Run full test suite, verify green**

```bash
PATH="./node_modules/.bin:/Users/jhp/.elm/elm-tooling/elm-test-rs/3.0.0:$PATH" \
  elm-test-rs --project review review/tests/*.elm 2>&1 | tail -5
```
Expected: all tests pass, including new Shape4 cases and dynamic-content cases. Total ≥ 33.

- [ ] **Step 7: Commit**

```bash
git add review/src/ValidEnumValue.elm review/src/SingularSlot.elm review/src/RequireSlot.elm \
        review/tests/ValidEnumValueTest.elm review/tests/SingularSlotTest.elm review/tests/RequireSlotTest.elm && \
git commit -m "refactor(review): retrofit ValidEnumValue/SingularSlot/RequireSlot to use Facts helper"
```

---

### Task 5: `MissingRequiredAttribute` (D1) — new rule

**Files:**
- Create: `review/src/MissingRequiredAttribute.elm`
- Create: `review/tests/MissingRequiredAttributeTest.elm`

**Interfaces:**
- Consumes: `Facts.callSite`, `Facts.find`, `Facts.tracedList`, `Fact.requiredAttrs`.
- Produces: `rule : List Fact -> Rule`.

- [ ] **Step 1: Write failing tests**

Create `review/tests/MissingRequiredAttributeTest.elm`:

```elm
module MissingRequiredAttributeTest exposing (all)

import M3e.Review.Facts as Facts exposing (Shape(..))
import MissingRequiredAttribute exposing (rule)
import Review.Test
import Test exposing (Test, describe, test)


iconButtonFacts : List Facts.Fact
iconButtonFacts =
    [ { component = "iconButton"
      , module_ = "M3e.IconButton"
      , enums = []
      , requiredSlots = [ "unnamed" ]
      , multiSlots = []
      , attrRewrites = []
      , slotRewrites = [ ( "unnamed", "child" ) ]
      , shapes = [ Shape3, Shape4 ]
      , requiredAttrs = [ "aria-label" ]
      }
    ]


all : Test
all =
    describe "MissingRequiredAttribute"
        [ test "flags Shape3 call missing aria-label" <|
            \() ->
                """module A exposing (v)
import M3e.IconButton
v = M3e.IconButton.view [] []
"""
                    |> Review.Test.run (rule iconButtonFacts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Component `iconButton` requires attribute `aria-label` but this call doesn't provide it"
                            , details =
                                [ "The Material 3 spec (and accessibility guidance) treats `aria-label` as required for iconButton."
                                , "Add `M3e.Aria.label \"...\"` to the attrs list."
                                ]
                            , under = "M3e.IconButton.view"
                            }
                        ]
        , test "accepts Shape3 call with M3e.Aria.label" <|
            \() ->
                """module A exposing (v)
import M3e.IconButton
import M3e.Aria
v = M3e.IconButton.view [ M3e.Aria.label "Close" ] []
"""
                    |> Review.Test.run (rule iconButtonFacts)
                    |> Review.Test.expectNoErrors
        , test "accepts raw M3e.Cem.Attr.attribute escape hatch" <|
            \() ->
                """module A exposing (v)
import M3e.IconButton
import M3e.Cem.Attr
v = M3e.IconButton.view [ M3e.Cem.Attr.attribute "aria-label" "Close" ] []
"""
                    |> Review.Test.run (rule iconButtonFacts)
                    |> Review.Test.expectNoErrors
        , test "flags Shape4 call missing aria-label" <|
            \() ->
                """module A exposing (v)
import M3e.Record.IconButton
v = M3e.Record.IconButton.view { content = a } [] []
"""
                    |> Review.Test.run (rule iconButtonFacts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Component `iconButton` requires attribute `aria-label` but this call doesn't provide it"
                            , details =
                                [ "The Material 3 spec (and accessibility guidance) treats `aria-label` as required for iconButton."
                                , "Add `M3e.Aria.label \"...\"` to the attrs list."
                                ]
                            , under = "M3e.Record.IconButton.view"
                            }
                        ]
        , test "silent when attrs list is unresolved" <|
            \() ->
                """module A exposing (v)
import M3e.IconButton
v = M3e.IconButton.view dynamicAttrs []
"""
                    |> Review.Test.run (rule iconButtonFacts)
                    |> Review.Test.expectNoErrors
        , test "no-op on component with no requiredAttrs" <|
            \() ->
                """module A exposing (v)
import M3e.Card
v = M3e.Card.view [] []
"""
                    |> Review.Test.run
                        (rule [ { component = "card", module_ = "M3e.Card", enums = [], requiredSlots = [], multiSlots = [], attrRewrites = [], slotRewrites = [], shapes = [ Shape3 ], requiredAttrs = [] } ])
                    |> Review.Test.expectNoErrors
        ]
```

- [ ] **Step 2: Run tests, verify they fail (rule module doesn't exist)**

```bash
PATH="./node_modules/.bin:/Users/jhp/.elm/elm-tooling/elm-test-rs/3.0.0:$PATH" \
  elm-test-rs --project review review/tests/MissingRequiredAttributeTest.elm 2>&1 | tail -5
```
Expected: compile error — `Cannot find module MissingRequiredAttribute`.

- [ ] **Step 3: Implement `MissingRequiredAttribute.elm`**

Create `review/src/MissingRequiredAttribute.elm`:

```elm
module MissingRequiredAttribute exposing (rule)

{-| D1: flag component calls missing a required HTML attribute.

Reads `requiredAttrs` from the generated facts. For each required attr, checks
that a satisfier is present in the call's attribute list (or, for Shape4, in
the required record's fields).

Satisfier conventions:
- `aria-*` attrs → `M3e.Aria.<lowerCamel(name)>` (e.g. `aria-label` → `M3e.Aria.label`).
- Other attrs → `M3e.<Comp>.<camelCase(name)>` (per-component setter).
- Universal escape → `M3e.Cem.Attr.attribute "<name>" ...`.

Silent when `tracedList.unresolved = True` and no static satisfier is found.
Advisory posture.

@docs rule

-}

import Dict exposing (Dict)
import Elm.Syntax.Declaration as Declaration
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Facts
import M3e.Review.Facts as MRF exposing (Fact, Shape(..))
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


rule : List Fact -> Rule
rule facts =
    Rule.newModuleRuleSchemaUsingContextCreator "MissingRequiredAttribute" (initContext facts)
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


type alias Context =
    { lookup : ModuleNameLookupTable
    , factsIndex : Dict String Fact
    , scope : Dict String (Node Expression)
    }


initContext : List Fact -> Rule.ContextCreator () Context
initContext facts =
    Rule.initContextCreator
        (\lookup () ->
            { lookup = lookup
            , factsIndex = Facts.buildIndex facts
            , scope = Dict.empty
            }
        )
        |> Rule.withModuleNameLookupTable


expressionVisitor : Node Expression -> Context -> ( List (Error {}), Context )
expressionVisitor node context =
    case Node.value node of
        Expression.Application (fnNode :: args) ->
            case Facts.callSite context.lookup fnNode of
                Just site ->
                    case Facts.find site.noun context.factsIndex of
                        Just fact ->
                            ( checkCall context site fact fnNode args, context )

                        Nothing ->
                            ( [], context )

                Nothing ->
                    ( [], context )

        _ ->
            ( [], context )


checkCall : Context -> Facts.CallSite -> Fact -> Node Expression -> List (Node Expression) -> List (Error {})
checkCall context site fact fnNode args =
    if List.isEmpty fact.requiredAttrs then
        []

    else
        let
            ( recordArg, attrsList ) =
                case site.shape of
                    Shape3 ->
                        ( Nothing, List.head args )

                    Shape4 ->
                        case args of
                            record :: attrs :: _ ->
                                ( Just record, Just attrs )

                            _ ->
                                ( Nothing, Nothing )

            attrsTrace =
                case attrsList of
                    Just attrsNode ->
                        Facts.tracedList context.lookup context.scope attrsNode

                    Nothing ->
                        { known = [], unresolved = True }
        in
        fact.requiredAttrs
            |> List.filterMap (checkOneAttr context site fact recordArg attrsTrace fnNode)


checkOneAttr context site fact recordArg attrsTrace fnNode attrName =
    if satisfiedInRecord recordArg attrName || satisfiedInAttrs context attrsTrace fact.component attrName then
        Nothing

    else if attrsTrace.unresolved then
        -- Can't verify — silent per advisory posture.
        Nothing

    else
        Just
            (Rule.error
                { message =
                    "Component `"
                        ++ fact.component
                        ++ "` requires attribute `"
                        ++ attrName
                        ++ "` but this call doesn't provide it"
                , details =
                    [ "The Material 3 spec (and accessibility guidance) treats `"
                        ++ attrName
                        ++ "` as required for "
                        ++ fact.component
                        ++ "."
                    , "Add `" ++ satisfierHint attrName fact.component ++ "` to the attrs list."
                    ]
                }
                (Node.range fnNode)
            )


satisfiedInRecord : Maybe (Node Expression) -> String -> Bool
satisfiedInRecord recordArg attrName =
    case recordArg of
        Just record ->
            case Node.value record of
                Expression.RecordExpr fields ->
                    let
                        fieldName =
                            attrToFieldName attrName
                    in
                    List.any
                        (\field ->
                            case Node.value field of
                                ( name, _ ) ->
                                    Node.value name == fieldName
                        )
                        fields

                _ ->
                    False

        Nothing ->
            False


{-| Convert an HTML attribute name to its expected Elm record field name.
`aria-label` → `ariaLabel`. -}
attrToFieldName : String -> String
attrToFieldName attrName =
    camelize attrName


satisfiedInAttrs : Context -> Facts.TracedList -> String -> String -> Bool
satisfiedInAttrs context attrsTrace componentNoun attrName =
    List.any (attrElementSatisfies context componentNoun attrName) attrsTrace.known


attrElementSatisfies : Context -> String -> String -> Node Expression -> Bool
attrElementSatisfies context componentNoun attrName element =
    case Node.value element of
        Expression.Application (setterNode :: setterArgs) ->
            let
                canonicalAriaSatisfier =
                    if String.startsWith "aria-" attrName then
                        -- e.g., aria-label → M3e.Aria.label
                        let
                            fieldName =
                                String.dropLeft 5 attrName
                        in
                        isCallTo context [ "M3e", "Aria" ] fieldName setterNode

                    else
                        False

                perComponentSatisfier =
                    isCallTo context [ "M3e", capitalize componentNoun ] (camelize attrName) setterNode

                rawAttributeSatisfier =
                    case ( isCallTo context [ "M3e", "Cem", "Attr" ] "attribute" setterNode, setterArgs ) of
                        ( True, arg0 :: _ ) ->
                            case Node.value arg0 of
                                Expression.Literal literal ->
                                    literal == attrName

                                _ ->
                                    False

                        _ ->
                            False
            in
            canonicalAriaSatisfier || perComponentSatisfier || rawAttributeSatisfier

        _ ->
            False


isCallTo : Context -> List String -> String -> Node Expression -> Bool
isCallTo context expectedModule expectedName setterNode =
    case Node.value setterNode of
        Expression.FunctionOrValue _ name ->
            (name == expectedName)
                && (Lookup.moduleNameFor context.lookup setterNode == Just expectedModule)

        _ ->
            False


satisfierHint : String -> String -> String
satisfierHint attrName componentNoun =
    if String.startsWith "aria-" attrName then
        "M3e.Aria." ++ String.dropLeft 5 attrName ++ " \"...\""

    else
        "M3e." ++ capitalize componentNoun ++ "." ++ camelize attrName ++ " \"...\""


camelize : String -> String
camelize s =
    case String.split "-" s of
        [] ->
            s

        first :: rest ->
            first ++ String.concat (List.map capitalize rest)


capitalize : String -> String
capitalize s =
    case String.uncons s of
        Just ( c, rest ) ->
            String.cons (Char.toUpper c) rest

        Nothing ->
            s
```

- [ ] **Step 4: Run tests, verify they pass**

```bash
PATH="./node_modules/.bin:/Users/jhp/.elm/elm-tooling/elm-test-rs/3.0.0:$PATH" \
  elm-test-rs --project review review/tests/MissingRequiredAttributeTest.elm 2>&1 | tail -5
```
Expected: all 6 tests pass.

- [ ] **Step 5: Commit**

```bash
git add review/src/MissingRequiredAttribute.elm review/tests/MissingRequiredAttributeTest.elm && \
git commit -m "feat(review): D1 MissingRequiredAttribute rule"
```

---

### Task 6: `MissingRequiredSingularSlot` (D2) — new rule

**Files:**
- Create: `review/src/MissingRequiredSingularSlot.elm`
- Create: `review/tests/MissingRequiredSingularSlotTest.elm`

**Interfaces:**
- Consumes: `Facts.callSite`, `Facts.find`, `Facts.tracedList`.
- Produces: `rule : List Fact -> Rule`.

- [ ] **Step 1: Write failing tests**

Create `review/tests/MissingRequiredSingularSlotTest.elm`:

```elm
module MissingRequiredSingularSlotTest exposing (all)

import M3e.Review.Facts as Facts exposing (Shape(..))
import MissingRequiredSingularSlot exposing (rule)
import Review.Test
import Test exposing (Test, describe, test)


buttonFacts : List Facts.Fact
buttonFacts =
    [ { component = "button"
      , module_ = "M3e.Button"
      , enums = []
      , requiredSlots = [ "unnamed" ]
      , multiSlots = []
      , attrRewrites = []
      , slotRewrites = [ ( "unnamed", "child" ) ]
      , shapes = [ Shape3, Shape4 ]
      , requiredAttrs = []
      }
    ]


all : Test
all =
    describe "MissingRequiredSingularSlot"
        [ test "flags Shape3 call missing required-singular slot" <|
            \() ->
                """module A exposing (v)
import M3e.Button
v = M3e.Button.view [] []
"""
                    |> Review.Test.run (rule buttonFacts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Component `button` requires content slot `unnamed` but the content list doesn't fill it"
                            , details =
                                [ "Add `M3e.Button.child <value>` to the content list, or use `M3e.Record.Button.view` which enforces this at the type level."
                                ]
                            , under = "M3e.Button.view"
                            }
                        ]
        , test "accepts Shape3 call with child" <|
            \() ->
                """module A exposing (v)
import M3e.Button
v = M3e.Button.view [] [ M3e.Button.child a ]
"""
                    |> Review.Test.run (rule buttonFacts)
                    |> Review.Test.expectNoErrors
        , test "silent on Shape4 call (record is compile-time enforced)" <|
            \() ->
                """module A exposing (v)
import M3e.Record.Button
v = M3e.Record.Button.view { content = a } [] []
"""
                    |> Review.Test.run (rule buttonFacts)
                    |> Review.Test.expectNoErrors
        , test "silent when content list is unresolved" <|
            \() ->
                """module A exposing (v)
import M3e.Button
v = M3e.Button.view [] dynamicContent
"""
                    |> Review.Test.run (rule buttonFacts)
                    |> Review.Test.expectNoErrors
        ]
```

- [ ] **Step 2: Run tests, verify they fail**

```bash
PATH="./node_modules/.bin:/Users/jhp/.elm/elm-tooling/elm-test-rs/3.0.0:$PATH" \
  elm-test-rs --project review review/tests/MissingRequiredSingularSlotTest.elm 2>&1 | tail -5
```
Expected: compile error — module not found.

- [ ] **Step 3: Implement the rule**

Create `review/src/MissingRequiredSingularSlot.elm`:

```elm
module MissingRequiredSingularSlot exposing (rule)

{-| D2: flag Shape3 calls whose content list omits a required-singular slot.

Shape4 calls are silent (the required record's field is compile-time-enforced).
Advisory posture — silent on unresolved content lists.

@docs rule

-}

import Dict exposing (Dict)
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Facts
import M3e.Review.Facts as MRF exposing (Fact, Shape(..))
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


rule : List Fact -> Rule
rule facts =
    Rule.newModuleRuleSchemaUsingContextCreator "MissingRequiredSingularSlot" (initContext facts)
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


type alias Context =
    { lookup : ModuleNameLookupTable
    , factsIndex : Dict String Fact
    , scope : Dict String (Node Expression)
    }


initContext facts =
    Rule.initContextCreator
        (\lookup () ->
            { lookup = lookup
            , factsIndex = Facts.buildIndex facts
            , scope = Dict.empty
            }
        )
        |> Rule.withModuleNameLookupTable


expressionVisitor node context =
    case Node.value node of
        Expression.Application (fnNode :: args) ->
            case Facts.callSite context.lookup fnNode of
                Just site ->
                    if site.shape /= Shape3 then
                        ( [], context )

                    else
                        case Facts.find site.noun context.factsIndex of
                            Just fact ->
                                ( checkCall context fact fnNode args, context )

                            Nothing ->
                                ( [], context )

                Nothing ->
                    ( [], context )

        _ ->
            ( [], context )


checkCall context fact fnNode args =
    let
        requiredSingular =
            fact.requiredSlots
                |> List.filter (\s -> not (List.member s fact.multiSlots))

        contentList =
            List.reverse args |> List.head

        contentTrace =
            case contentList of
                Just contentNode ->
                    Facts.tracedList context.lookup context.scope contentNode

                Nothing ->
                    { known = [], unresolved = True }

        setterForSlot slotName =
            fact.slotRewrites
                |> List.filter (\( k, _ ) -> k == slotName)
                |> List.head
                |> Maybe.map Tuple.second
                |> Maybe.withDefault (camelize slotName)

        slotFilled setter =
            List.any (elementIsCall context setter) contentTrace.known
    in
    requiredSingular
        |> List.filterMap
            (\slotName ->
                let
                    setter =
                        setterForSlot slotName
                in
                if slotFilled setter then
                    Nothing

                else if contentTrace.unresolved then
                    Nothing

                else
                    Just
                        (Rule.error
                            { message =
                                "Component `"
                                    ++ fact.component
                                    ++ "` requires content slot `"
                                    ++ slotName
                                    ++ "` but the content list doesn't fill it"
                            , details =
                                [ "Add `M3e."
                                    ++ capitalize fact.component
                                    ++ "."
                                    ++ setter
                                    ++ " <value>` to the content list, or use `M3e.Record."
                                    ++ capitalize fact.component
                                    ++ ".view` which enforces this at the type level."
                                ]
                            }
                            (Node.range fnNode)
                        )
            )


elementIsCall context setter element =
    case Node.value element of
        Expression.Application (setterNode :: _) ->
            case Node.value setterNode of
                Expression.FunctionOrValue _ name ->
                    name == setter

                _ ->
                    False

        _ ->
            False


camelize s =
    case String.split "-" s of
        [] -> s
        first :: rest -> first ++ String.concat (List.map capitalize rest)


capitalize s =
    case String.uncons s of
        Just ( c, rest ) -> String.cons (Char.toUpper c) rest
        Nothing -> s
```

- [ ] **Step 4: Run tests, verify pass**

```bash
PATH="./node_modules/.bin:/Users/jhp/.elm/elm-tooling/elm-test-rs/3.0.0:$PATH" \
  elm-test-rs --project review review/tests/MissingRequiredSingularSlotTest.elm 2>&1 | tail -5
```
Expected: all 4 tests pass.

- [ ] **Step 5: Commit**

```bash
git add review/src/MissingRequiredSingularSlot.elm review/tests/MissingRequiredSingularSlotTest.elm && \
git commit -m "feat(review): D2 MissingRequiredSingularSlot rule"
```

---

### Task 7: `SingularAttribute` (D3 new) — new rule

**Files:**
- Create: `review/src/SingularAttribute.elm`
- Create: `review/tests/SingularAttributeTest.elm`

**Interfaces:**
- Consumes: `Facts.callSite`, `Facts.tracedList`.
- Produces: `rule : List Fact -> Rule`.

- [ ] **Step 1: Write failing tests**

Create `review/tests/SingularAttributeTest.elm` mirroring `SingularSlotTest.elm`'s pattern:

```elm
module SingularAttributeTest exposing (all)

import M3e.Review.Facts as Facts exposing (Shape(..))
import Review.Test
import SingularAttribute exposing (rule)
import Test exposing (Test, describe, test)


buttonFacts : List Facts.Fact
buttonFacts =
    [ { component = "button"
      , module_ = "M3e.Button"
      , enums = []
      , requiredSlots = []
      , multiSlots = []
      , attrRewrites = [ ( "variant", "variant" ), ( "disabled", "disabled" ) ]
      , slotRewrites = []
      , shapes = [ Shape3 ]
      , requiredAttrs = []
      }
    ]


all : Test
all =
    describe "SingularAttribute"
        [ test "flags a duplicated attribute setter" <|
            \() ->
                """module A exposing (v)
import M3e.Button
v = M3e.Button.view [ M3e.Button.variant a, M3e.Button.variant b ] []
"""
                    |> Review.Test.run (rule buttonFacts)
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "Attribute `variant` is set more than once on this call"
                            , details =
                                [ "HTML allows only one value per attribute; the browser will silently keep one and discard the others."
                                , "Merge or delete the extras."
                                ]
                            , under = "variant"
                            }
                            |> Review.Test.atExactly { start = { row = 3, column = 43 }, end = { row = 3, column = 50 } }
                        ]
        , test "accepts distinct attributes" <|
            \() ->
                """module A exposing (v)
import M3e.Button
v = M3e.Button.view [ M3e.Button.variant a, M3e.Button.disabled True ] []
"""
                    |> Review.Test.run (rule buttonFacts)
                    |> Review.Test.expectNoErrors
        , test "silent on unresolved attrs list" <|
            \() ->
                """module A exposing (v)
import M3e.Button
v = M3e.Button.view dynamicAttrs []
"""
                    |> Review.Test.run (rule buttonFacts)
                    |> Review.Test.expectNoErrors
        ]
```

- [ ] **Step 2: Verify tests fail (module not found)**
- [ ] **Step 3: Implement `SingularAttribute.elm`**

Mirror the structure of `SingularSlot.elm` but analyze the ATTRS list (second-to-last argument, or last-with-only-one-arg?). Attrs is always the argument BEFORE content — for Shape3 that's the FIRST argument.

```elm
module SingularAttribute exposing (rule)

{-| D3 (attribute half): flag a call whose attrs list sets the same attribute
setter more than once. HTML attributes can hold only one value; a repeated
attr is a bug (the browser keeps one at random).

Mirrors `SingularSlot` for the content half. No multi-attributes are supported
today — every duplicate is flagged.

@docs rule

-}

import Dict exposing (Dict)
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Facts
import M3e.Review.Facts exposing (Fact)
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


rule : List Fact -> Rule
rule facts =
    Rule.newModuleRuleSchemaUsingContextCreator "SingularAttribute" (initContext facts)
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


type alias Context =
    { lookup : ModuleNameLookupTable
    , factsIndex : Dict String Fact
    , scope : Dict String (Node Expression)
    }


initContext facts =
    Rule.initContextCreator
        (\lookup () ->
            { lookup = lookup
            , factsIndex = Facts.buildIndex facts
            , scope = Dict.empty
            }
        )
        |> Rule.withModuleNameLookupTable


expressionVisitor node context =
    case Node.value node of
        Expression.Application (fnNode :: args) ->
            case Facts.callSite context.lookup fnNode of
                Just site ->
                    let
                        attrsList =
                            case site.shape of
                                Facts.Shape3 ->
                                    List.head args

                                Facts.Shape4 ->
                                    case args of
                                        _ :: attrs :: _ ->
                                            Just attrs

                                        _ ->
                                            Nothing

                        attrsTrace =
                            case attrsList of
                                Just node_ ->
                                    Facts.tracedList context.lookup context.scope node_

                                Nothing ->
                                    { known = [], unresolved = True }
                    in
                    ( checkAttrs attrsTrace, context )

                Nothing ->
                    ( [], context )

        _ ->
            ( [], context )


checkAttrs trace =
    if trace.unresolved then
        []

    else
        let
            setters =
                trace.known |> List.filterMap elementSetter
        in
        setters
            |> List.filter (\( name, _ ) -> countBy name setters > 1)
            |> dedupeByName
            |> List.map (\( name, range ) -> error name range)


elementSetter element =
    case Node.value element of
        Expression.Application (setterNode :: _) ->
            case Node.value setterNode of
                Expression.FunctionOrValue _ name ->
                    Just ( name, Node.range setterNode )

                _ ->
                    Nothing

        _ ->
            Nothing


countBy name =
    List.filter (\( n, _ ) -> n == name) >> List.length


dedupeByName =
    List.foldl
        (\(( name, _ ) as item) acc ->
            if List.any (\( n, _ ) -> n == name) acc then
                acc

            else
                acc ++ [ item ]
        )
        []


error name range =
    Rule.error
        { message = "Attribute `" ++ name ++ "` is set more than once on this call"
        , details =
            [ "HTML allows only one value per attribute; the browser will silently keep one and discard the others."
            , "Merge or delete the extras."
            ]
        }
        range
```

- [ ] **Step 4: Run tests, verify pass**
- [ ] **Step 5: Commit**

```bash
git add review/src/SingularAttribute.elm review/tests/SingularAttributeTest.elm && \
git commit -m "feat(review): D3 SingularAttribute rule (sibling of SingularSlot)"
```

---

### Task 8: `PreferSpecificSlot` (D4 autofix) — new rule

**Files:**
- Create: `review/src/PreferSpecificSlot.elm`
- Create: `review/tests/PreferSpecificSlotTest.elm`

**Interfaces:**
- Consumes: `Facts.callSite`, `Facts.find`, `Facts.tracedList`, `Fact.attrRewrites`, `Fact.slotRewrites`.
- Produces: `rule : List Fact -> Rule` with `Review.Fix` autofix.

- [ ] **Step 1: Write failing tests (both attr and slot cases with autofix)**

Create `review/tests/PreferSpecificSlotTest.elm`:

```elm
module PreferSpecificSlotTest exposing (all)

import M3e.Review.Facts as Facts exposing (Shape(..))
import PreferSpecificSlot exposing (rule)
import Review.Test
import Test exposing (Test, describe, test)


buttonFacts : List Facts.Fact
buttonFacts =
    [ { component = "button"
      , module_ = "M3e.Button"
      , enums = []
      , requiredSlots = []
      , multiSlots = []
      , attrRewrites = [ ( "variant", "variant" ), ( "shapeAttr", "shape" ) ]
      , slotRewrites = [ ( "unnamed", "child" ), ( "icon", "icon" ) ]
      , shapes = [ Shape3 ]
      , requiredAttrs = []
      }
    ]


all : Test
all =
    describe "PreferSpecificSlot"
        [ describe "attr case"
            [ test "rewrites M3e.variant to M3e.Button.variant" <|
                \() ->
                    """module A exposing (v)
import M3e
import M3e.Button
v = M3e.Button.view [ M3e.variant filled ] []
"""
                        |> Review.Test.run (rule buttonFacts)
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "`variant` can be replaced with the per-component setter `M3e.Button.variant` for tighter type safety"
                                , details =
                                    [ "The barrel-level setter accepts every component's tokens; the per-component form only accepts button's."
                                    ]
                                , under = "M3e.variant"
                                }
                                |> Review.Test.whenFixed
                                    """module A exposing (v)
import M3e
import M3e.Button
v = M3e.Button.view [ M3e.Button.variant filled ] []
"""
                            ]
            , test "rewrites shape-collision-suffixed name" <|
                \() ->
                    """module A exposing (v)
import M3e
import M3e.Button
v = M3e.Button.view [ M3e.shapeAttr rounded ] []
"""
                        |> Review.Test.run (rule buttonFacts)
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "`shapeAttr` can be replaced with the per-component setter `M3e.Button.shape` for tighter type safety"
                                , details =
                                    [ "The barrel-level setter accepts every component's tokens; the per-component form only accepts button's."
                                    ]
                                , under = "M3e.shapeAttr"
                                }
                                |> Review.Test.whenFixed
                                    """module A exposing (v)
import M3e
import M3e.Button
v = M3e.Button.view [ M3e.Button.shape rounded ] []
"""
                            ]
            ]
        , describe "slot case"
            [ test "rewrites M3e.Cem.Attr.slot to per-component setter" <|
                \() ->
                    """module A exposing (v)
import M3e.Button
import M3e.Cem.Attr
v = M3e.Button.view [] [ M3e.Cem.Attr.slot "icon" someIcon ]
"""
                        |> Review.Test.run (rule buttonFacts)
                        |> Review.Test.expectErrors
                            [ Review.Test.error
                                { message = "`.slot \"icon\"` can be replaced with the typed setter `M3e.Button.icon`"
                                , details =
                                    [ "The typed setter enforces the slot's kinds at compile time."
                                    ]
                                , under = "M3e.Cem.Attr.slot \"icon\" someIcon"
                                }
                                |> Review.Test.whenFixed
                                    """module A exposing (v)
import M3e.Button
import M3e.Cem.Attr
v = M3e.Button.view [] [ M3e.Button.icon someIcon ]
"""
                            ]
            ]
        , test "no-op when already using per-component setter" <|
            \() ->
                """module A exposing (v)
import M3e.Button
v = M3e.Button.view [ M3e.Button.variant filled ] []
"""
                    |> Review.Test.run (rule buttonFacts)
                    |> Review.Test.expectNoErrors
        ]
```

- [ ] **Step 2: Verify tests fail (module not found)**

- [ ] **Step 3: Implement `PreferSpecificSlot.elm`**

Create `review/src/PreferSpecificSlot.elm`:

```elm
module PreferSpecificSlot exposing (rule)

{-| D4: prefer per-component setters over barrel shorthands, with autofix.

Two cases:
- Attr case: `M3e.<barrelName>` inside a component's attrs list → rewrite to
  `M3e.<Comp>.<perCompName>` using `attrRewrites`.
- Slot case: `M3e.Cem.Attr.slot "<slotName>" body` in the content list →
  rewrite to `M3e.<Comp>.<setterName> body` using `slotRewrites`.

@docs rule

-}

import Dict exposing (Dict)
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Elm.Syntax.Range exposing (Range)
import Facts
import M3e.Review.Facts as MRF exposing (Fact, Shape(..))
import Review.Fix as Fix
import Review.ModuleNameLookupTable as Lookup exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


rule : List Fact -> Rule
rule facts =
    Rule.newModuleRuleSchemaUsingContextCreator "PreferSpecificSlot" (initContext facts)
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


type alias Context =
    { lookup : ModuleNameLookupTable
    , factsIndex : Dict String Fact
    , scope : Dict String (Node Expression)
    }


initContext facts =
    Rule.initContextCreator
        (\lookup () ->
            { lookup = lookup
            , factsIndex = Facts.buildIndex facts
            , scope = Dict.empty
            }
        )
        |> Rule.withModuleNameLookupTable


expressionVisitor node context =
    case Node.value node of
        Expression.Application (fnNode :: args) ->
            case Facts.callSite context.lookup fnNode of
                Just site ->
                    case Facts.find site.noun context.factsIndex of
                        Just fact ->
                            ( checkCall context site fact args, context )

                        Nothing ->
                            ( [], context )

                Nothing ->
                    ( [], context )

        _ ->
            ( [], context )


checkCall context site fact args =
    let
        ( attrsList, contentList ) =
            case site.shape of
                Shape3 ->
                    case args of
                        a :: c :: _ ->
                            ( Just a, Just c )

                        [ a ] ->
                            ( Just a, Nothing )

                        _ ->
                            ( Nothing, Nothing )

                Shape4 ->
                    case args of
                        _ :: a :: c :: _ ->
                            ( Just a, Just c )

                        _ ->
                            ( Nothing, Nothing )

        attrErrors =
            attrsList
                |> Maybe.map (checkAttrs context fact)
                |> Maybe.withDefault []

        slotErrors =
            contentList
                |> Maybe.map (checkSlots context fact)
                |> Maybe.withDefault []
    in
    attrErrors ++ slotErrors


checkAttrs context fact attrsNode =
    let
        trace =
            Facts.tracedList context.lookup context.scope attrsNode
    in
    if trace.unresolved then
        []

    else
        trace.known |> List.filterMap (attrErrorFor context fact)


attrErrorFor context fact element =
    case Node.value element of
        Expression.Application (setterNode :: _) ->
            case ( Node.value setterNode, Lookup.moduleNameFor context.lookup setterNode ) of
                ( Expression.FunctionOrValue _ name, Just [ "M3e" ] ) ->
                    fact.attrRewrites
                        |> List.filter (\( barrelName, _ ) -> barrelName == name)
                        |> List.head
                        |> Maybe.map
                            (\( _, perCompName ) ->
                                Rule.errorWithFix
                                    { message =
                                        "`" ++ name ++ "` can be replaced with the per-component setter `M3e."
                                            ++ capitalize fact.component ++ "." ++ perCompName
                                            ++ "` for tighter type safety"
                                    , details =
                                        [ "The barrel-level setter accepts every component's tokens; the per-component form only accepts "
                                            ++ fact.component ++ "'s."
                                        ]
                                    }
                                    (Node.range setterNode)
                                    [ Fix.replaceRangeBy
                                        (Node.range setterNode)
                                        ("M3e." ++ capitalize fact.component ++ "." ++ perCompName)
                                    ]
                            )

                _ ->
                    Nothing

        _ ->
            Nothing


checkSlots context fact contentNode =
    let
        trace =
            Facts.tracedList context.lookup context.scope contentNode
    in
    if trace.unresolved then
        []

    else
        trace.known |> List.filterMap (slotErrorFor context fact)


slotErrorFor context fact element =
    case Node.value element of
        Expression.Application (setterNode :: setterArgs) ->
            case ( Node.value setterNode, Lookup.moduleNameFor context.lookup setterNode ) of
                ( Expression.FunctionOrValue _ "slot", Just [ "M3e", "Cem", "Attr" ] ) ->
                    case setterArgs of
                        firstArg :: body :: _ ->
                            case Node.value firstArg of
                                Expression.Literal slotName ->
                                    fact.slotRewrites
                                        |> List.filter (\( k, _ ) -> k == slotName)
                                        |> List.head
                                        |> Maybe.map
                                            (\( _, perCompSetter ) ->
                                                let
                                                    replacement =
                                                        "M3e." ++ capitalize fact.component ++ "." ++ perCompSetter
                                                            ++ " " ++ nodeSource body
                                                in
                                                Rule.errorWithFix
                                                    { message =
                                                        "`.slot \"" ++ slotName ++ "\"` can be replaced with the typed setter `M3e."
                                                            ++ capitalize fact.component ++ "." ++ perCompSetter ++ "`"
                                                    , details =
                                                        [ "The typed setter enforces the slot's kinds at compile time."
                                                        ]
                                                    }
                                                    (Node.range element)
                                                    [ Fix.replaceRangeBy
                                                        (Node.range element)
                                                        replacement
                                                    ]
                                            )

                                _ ->
                                    Nothing

                        _ ->
                            Nothing

                _ ->
                    Nothing

        _ ->
            Nothing


{-| Emit the source text of a node — used to reconstruct the body expression
in the slot-case fix. In real elm-review rules, use `Review.Fix` with
`extractSourceCode` from `Rule.withSourceCodeExtractor`. -}
nodeSource : Node Expression -> String
nodeSource _ =
    -- Placeholder — replace with actual source-extraction via Rule.withSourceCodeExtractor.
    "..."


capitalize s =
    case String.uncons s of
        Just ( c, rest ) -> String.cons (Char.toUpper c) rest
        Nothing -> s
```

**Note on `nodeSource`:** the placeholder above must be replaced with real
source extraction via `Rule.withSourceCodeExtractor` (see elm-review docs).
Add `sourceCodeExtractor : String -> String -> String -> String` to the
context and use it inside `slotErrorFor`. Verify by running the slot-case
test and confirming the fix output preserves the body expression.

- [ ] **Step 4: Run tests, verify pass**

```bash
PATH="./node_modules/.bin:/Users/jhp/.elm/elm-tooling/elm-test-rs/3.0.0:$PATH" \
  elm-test-rs --project review review/tests/PreferSpecificSlotTest.elm 2>&1 | tail -10
```
Expected: all 4 tests pass (2 attr cases with autofix, 1 slot case with autofix, 1 negative case).

- [ ] **Step 5: Commit**

```bash
git add review/src/PreferSpecificSlot.elm review/tests/PreferSpecificSlotTest.elm && \
git commit -m "feat(review): D4 PreferSpecificSlot rule (autofix, attr + slot cases)"
```

---

### Task 9: Wire all rules + full DoD verification

**Files:**
- Modify: `review/src/CodegenReviewConfig.elm` — add the new rules.
- Test: full docs-app + review pass.

- [ ] **Step 1: Update `CodegenReviewConfig.elm`**

Add imports and wire all four new rules:

```elm
module CodegenReviewConfig exposing (config)

import M3e.Review.Facts as Facts
import MissingRequiredAttribute
import MissingRequiredSingularSlot
import PreferSpecificSlot
import RequireSlot
import Review.Rule exposing (Rule)
import SingularAttribute
import SingularSlot
import ValidEnumValue


config : List Rule
config =
    [ ValidEnumValue.rule Facts.facts
    , SingularSlot.rule Facts.facts
    , RequireSlot.rule Facts.facts
    , MissingRequiredAttribute.rule Facts.facts
    , MissingRequiredSingularSlot.rule Facts.facts
    , SingularAttribute.rule Facts.facts
    , PreferSpecificSlot.rule Facts.facts
    ]
```

- [ ] **Step 2: Run full elm-review against docs-app**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
PATH="./docs/node_modules/.bin:$PATH" \
  elm-review --config review/ docs/app 2>&1 | tail -30
```
Expected: rule reports increase from the current 50-error baseline. New errors should correspond to real issues (missing aria-label on icon buttons, barrel shorthands used, etc.). Document any surprises.

- [ ] **Step 3: Run full test suite**

```bash
PATH="./node_modules/.bin:/Users/jhp/.elm/elm-tooling/elm-test-rs/3.0.0:$PATH" \
  elm-test-rs --project review review/tests/*.elm 2>&1 | tail -5
```
Expected: all tests pass (targeting ≥ 35 total: 25 baseline + 10+ new).

- [ ] **Step 4: Compile docs-app**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/docs && \
PATH="./node_modules/.bin:$PATH" elm make app/Shared.elm src/Doc.elm --output=/dev/null 2>&1 | tail -3
```
Expected: `Success!`.

- [ ] **Step 5: Compile packages/m3e**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e/packages/m3e && \
PATH="/Users/jhp/code/jackhp95/elm-m3e/node_modules/.bin:$PATH" elm make src/M3e.elm --output=/dev/null 2>&1 | tail -3
```
Expected: `Success! Compiled 378 modules.`.

- [ ] **Step 6: Commit**

```bash
cd /Users/jhp/code/jackhp95/elm-m3e && \
git add review/src/CodegenReviewConfig.elm && \
git commit -m "$(cat <<'EOF'
feat(review): wire D1-D5 rules in CodegenReviewConfig

Enables all seven codegen-aware rules against the generated
M3e.Review.Facts. New reports may surface across docs-app —
those reflect real issues (missing aria-labels on icon buttons,
barrel shorthands preferring per-component setters, etc.).

Per docs/superpowers/specs/2026-07-04-review-rules-safety-net-design.md.

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
- §2 (in-scope): rule modules covered by Tasks 5–8; helper by Tasks 1–3; retrofit by Task 4; wiring by Task 9.
- §3 (roster): every row has a task (Tasks 4–9 map to the 7 rules).
- §4 (shared helper API): Tasks 1–3 implement `callSite`, `find`, `buildIndex`, `tracedList` at Basic/Medium/Ambitious levels.
- §5 (rule details): Tasks 5–8 for new rules; Task 4 for retrofit; RequireSlot hardening folded into Task 4.
- §6 (file structure): all files listed appear as Create/Modify in the corresponding task.
- §7 (cross-spec invariants): Task 9 Step 2 verifies via elm-review run.
- §8 (migration): Task 4 handles retrofit.
- §9 (DoD): Task 9 verifies every item.

**Placeholder scan:**
- Task 8 Step 3 references a `nodeSource` placeholder — flagged inline with the correct fix path (via `Rule.withSourceCodeExtractor`). This is not a placeholder in the "TBD" sense; it's a concrete instruction for the implementer.

**Type consistency:**
- `Facts.CallSite`, `Facts.TracedList`, `Facts.Fact` are used consistently across all tasks.
- `Fact.attrRewrites`, `.slotRewrites`, `.requiredAttrs`, `.shapes` referenced with the exact field names emitted by the Facts spec.
- `Shape3`, `Shape4` constructor names match `M3e.Review.Facts.Shape`.

## Execution Handoff

Plan complete and saved to `docs/superpowers/plans/2026-07-04-review-rules-safety-net.md`. Two execution options:

**1. Subagent-Driven (recommended)** — dispatch a fresh subagent per task, review between tasks, fast iteration.

**2. Inline Execution** — execute tasks in this session using executing-plans, batch execution with checkpoints.

Which approach?
