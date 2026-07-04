# `M3e.Build` codegen spike — design (epic #138, workstream B, phase 0)

Date: 2026-07-03
Status: Proposed (blocking gate for workstream B implementation)
Scope: **the phase-0 spike only** — a bounded, standalone experiment against
`mdgriffith/elm-codegen` 6.x to prove the ⑤ phantom-record shape can actually
be emitted by the generator without silently dropping annotations. This
document does NOT specify the workstream-B generator plan; that spec is
written after the spike returns.

## 1. Purpose

Workstream B ships shape ⑤ (`M3e.Build.*`) via a **unified availability
phantom**: opaque `Builder attrCaps slotCaps msg`, per-component `Caps` type
aliases, consuming-row setters (`{ c | field : Available } → { c | field : Used }`),
and a `build : Builder a s msg -> Element` terminal. See the
[top-shape gradient spec §6–7](2026-07-03-top-shape-gradient-design.md) and
[ADR 0013](../../adr/0013-top-shape-matrix-and-translation.md) for why.

The plan touches three positions elm-codegen 6.x has never been exercised on
in this codebase: multi-parameter opaque `Builder`, extensible-record inputs
with a **state flip** on one field, and type-alias references in return
positions of `withType` annotations. The generator already carries a scar
proving the tool is fragile here — `Generate.elm:2002-2009`:

> `req_`/`attributes`/`content_` are deliberately UNannotated args
> (`Elm.Arg.var`, not `varWith`): the full signature is supplied by
> `Elm.withType viewType` below. Annotating the multi-field required record
> (`requiredType`) here trips an "infinite type inference loop" in
> elm-codegen 6.x (SplitButton/AssistChip — the 2 components with a 2+ field
> required record), which silently DROPS the whole `view` annotation and
> breaks `elm make --docs`. Do not re-add `varWith`.

Failure mode is **silent**: the generator succeeds, output *looks* fine, and
`elm make --docs` breaks downstream with "signature required" errors on decls
that were supposed to be annotated. Diagnosing that across ~3,000 emitted
declarations after we're committed is expensive. Cheap to test up front.

**The spike is a yes/no gate.** If it passes, workstream B proceeds with the
unified-phantom plan. If it fails at a step whose fallback is workable, the
plan proceeds with the fallback noted. If it fails at the composition step,
workstream B retreats to **Option 2** (defaults-record) and this ADR-0013
line item is un-decided again.

## 2. Scope

### In scope
- One hand-written reference file (`M3e/Build/Button.elm`) demonstrating the
  target shape.
- One elm-codegen-driven emission of that same file (or something type-shape
  equivalent), through a small standalone entry point.
- Verification via `elm make --docs` and human inspection of the generated
  `docs.json` for signature preservation.
- A written report at spike end: pass/fail per step + observations.

### Out of scope
- Any change to the production generator (`elm-cem/codegen/Generate.elm`).
- Any change to the shipped library packages.
- Emitting ⑤ for more than one component.
- Barrel/facts/translator integration.
- Ergonomics tuning (naming, `defaults` helpers, docs presentation).
- Deciding whether ⑤ emits for degenerate components.

Everything not in the above `In scope` bullet is deferred to the
post-spike workstream-B spec.

## 3. Target artifact — the reference `M3e.Build.Button`

The hand-written reference file establishes what the codegen output must
match at the type-signature level. It is not shipped — it lives under the
spike directory (§5) and is diffed against codegen output.

```elm
module M3e.Build.Button exposing
    ( Builder, AttrCaps, SlotCaps
    , button, build
    , variant, icon
    -- (spike emits 3 setters to cover the pattern; production emits all)
    )

import M3e.Action
import M3e.Element
import M3e.Value


type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


type alias Fields msg =
    { content : M3e.Element.Element { text : M3e.Value.Supported, icon : M3e.Value.Supported } msg
    , action  : M3e.Action.Action { click : M3e.Value.Supported {- … -} } msg
    , variant : Maybe (M3e.Value.Value { elevated : M3e.Value.Supported {- … -} })
    , icon    : Maybe (M3e.Element.Element { icon : M3e.Value.Supported, loadingIndicator : M3e.Value.Supported } msg)
    -- (rest omitted from spike; production emits all optional-singular fields)
    }


type alias AttrCaps =
    { variant : M3e.Build.Internal.Available
    -- (production emits all optional-singular attrs; spike ships one for pattern coverage)
    }


type alias SlotCaps =
    { icon : M3e.Build.Internal.Available
    -- (production emits all optional-singular slots; spike ships one for pattern coverage)
    }


button :
    { content : M3e.Element.Element { text : M3e.Value.Supported, icon : M3e.Value.Supported } msg
    , action  : M3e.Action.Action { click : M3e.Value.Supported } msg
    }
    -> Builder AttrCaps SlotCaps msg
button req_ =
    Builder
        { content = req_.content
        , action  = req_.action
        , variant = Nothing
        , icon    = Nothing
        }


variant :
    M3e.Value.Value { elevated : M3e.Value.Supported {- … -} }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg
variant v (Builder f) =
    Builder { f | variant = Just v }


icon :
    M3e.Element.Element { icon : M3e.Value.Supported, loadingIndicator : M3e.Value.Supported } msg
    -> Builder a { s | icon : M3e.Build.Internal.Available } msg
    -> Builder a { s | icon : M3e.Build.Internal.Used } msg
icon el (Builder f) =
    Builder { f | icon = Just el }


build : Builder a s msg -> M3e.Element.Element { r | button : M3e.Value.Supported } msg
build (Builder _) =
    Debug.todo "spike only: body reuses M3e.Button.view's assembly; not validated here"
```

Companion internal module (also hand-written for the spike):

```elm
module M3e.Build.Internal exposing (Available, Used)

type Available = Available
type Used = Used
```

**What the reference file establishes:** the exact type signatures the
codegen output must produce, verbatim, in `docs.json`. Every signature above
is a distinct elm-codegen expression pattern (see §4).

## 4. The four inference patterns being tested

Each pattern maps to one signature above. Steps run sequentially; a step's
failure stops the spike and triggers the fallback for that pattern.

### Step 1 — type-alias preservation
Emit `type alias AttrCaps = { variant : Available }` and reference it as
`Type.namedWith [ "M3e", "Build", "Button" ] "AttrCaps" []` in a downstream
signature. Confirm `docs.json` shows `Builder AttrCaps SlotCaps msg` in the
`button` seed's signature — **not** the inlined record `Builder { variant :
Available } { icon : Available } msg`.

**Success:** alias name preserved in `docs.json` type field for `button`.
**Failure mode:** alias inlined → signature width explodes → seed likely
triggers the inference loop → annotation silently dropped.
**Fallback if failed:** emit `AttrCaps`/`SlotCaps` from a hand-written
`M3e.Build.Aliases.elm` the generator imports rather than emits. Ugly but
bounded; workstream B still viable.

### Step 2 — consuming-row setter with polymorphic tail
Emit `variant` with signature
`Value {...} -> Builder { a | variant : Available } s msg -> Builder { a | variant : Used } s msg`
using `Type.extensible "a" [ ( "variant", Available ) ]`. Verify `docs.json`
shows the exact extensible-record + polymorphic-tail form and that both
`a` and `s` are polymorphic type variables in the output.

**Success:** signature emitted verbatim, tail vars preserved.
**Failure mode:** elm-codegen either drops the annotation or reifies the
extensible record (`{ variant : Available }` closed, no tail var).
**Fallback if failed:** apply the `Elm.Arg.var` + `Elm.withType`-covers-all
workaround from Generate.elm:2002-2009. This is the exact scar that already
works for shape ④'s `view`, and it should generalize to setters.

### Step 3 — seed with multi-field caps in return position
Emit `button` with the full return type `Builder AttrCaps SlotCaps msg`,
where both aliases are multi-field records. This is the pattern closest to
the known-broken position — a multi-field record in an annotation on a
function that carries `withType`.

**Success:** seed's full signature preserved in `docs.json`; `elm make --docs`
succeeds.
**Failure mode:** the inference loop trips despite the alias wrapper; annotation
silently dropped; `elm make --docs` errors "signature required for `button`".
**Fallback if failed:** collapse the two-axis phantom into a single `Caps`
alias (union of attr + slot fields), halving the type-parameter count.
Costs the attr/slot separation but keeps dup-impossibility. If *this*
also fails, drop the alias entirely and rely on Step 2's `Elm.Arg.var` +
`withType` workaround at the seed. If *that* fails, the plan is dead.

### Step 4 — composition in one file, `elm make --docs` clean
Emit `Fields`, `AttrCaps`, `SlotCaps`, `button`, `variant`, `icon`, `build`
into a single `M3e/Build/Button.elm` via one codegen invocation. Run
`elm make --docs=/tmp/docs.json` against the whole package (in a temp elm
project the spike scaffolds). Any missing signature, any Elm compile error,
any `docs.json` divergence from the reference file's signatures is a fail.

**Success:** `elm make --docs` exits 0 with all signatures preserved;
`docs.json` diff against the reference file is empty at the signature level.
**Failure mode:** any of the above in a composition that steps 1–3 didn't
surface (interaction bugs).
**Fallback if failed:** at this point the individual patterns work but their
composition breaks. Diagnose which decl loses its signature; if the issue is
localized to one pattern's composition (e.g. setters break the seed's
inference), retreat to the corresponding step's fallback. If composition
failure is unresolvable, **workstream B abandons the unified phantom and
adopts Option 2 (defaults-record)**.

## 5. Test harness (files the spike creates)

Everything lives under `elm-cem/spikes/build-shape/` (a new directory).
Nothing outside this directory is modified.

```
elm-cem/spikes/build-shape/
├── README.md                    # what this is, how to run it
├── reference/
│   ├── elm.json                 # standalone Elm project
│   └── src/
│       ├── M3e/Build/Button.elm     # the reference from §3
│       └── M3e/Build/Internal.elm   # Available/Used markers
├── codegen/
│   ├── elm.json                 # elm-codegen entrypoint project
│   └── src/
│       └── Spike.elm            # emits Button.elm via elm-codegen
└── run.sh                       # runs codegen, then `elm make --docs`, then diffs
```

`run.sh` executes (from the spike directory, with `elm-cem/node_modules/.bin`
prefixed to PATH so `elm` resolves — see the auto-memory note "elm-cem
generator needs `elm` on PATH + wipes output first"):

1. `cd codegen && pnpm exec elm-codegen run` — emits `M3e/Build/Button.elm`
   + `M3e/Build/Internal.elm` into `codegen/generated/`.
2. Copy `codegen/generated/*` into a temp Elm project alongside a minimal
   `elm.json` (elm/core, elm/html, and the local `M3e.Element`/`M3e.Value`/
   `M3e.Action` modules the reference depends on — sourced by relative path
   into `packages/m3e/src/`).
3. In that temp project: `elm make --docs=generated-docs.json --output=/dev/null`.
4. Same treatment for the `reference/` project: `elm make
   --docs=reference-docs.json --output=/dev/null`.
5. `jq` diff of the two `docs.json` files' function/type-alias signatures
   (union of member names, compare `type` fields for signatures and `args`
   + `type` for aliases).
6. Exit 0 on empty diff, non-zero otherwise. Print any diverging signature
   plus the specific step (1–4 from §4) it maps to.

Note: this differs from production elm-cem invocation (which goes through
`bin/elm-cem.js`) — the spike is intentionally *not* using the production
entry point, since it needs to isolate a minimal `Spike.elm` codegen without
the CEM-rewriting / temp-file / output-wiping machinery around it. This
means the spike answers "does elm-codegen 6.x itself emit these signatures
cleanly" rather than "does the elm-cem CLI wire them through end-to-end."
The latter is a workstream-B implementation concern, not a codegen-feasibility
concern.

## 6. Deliverables

At spike end, one of two outcomes commits:

### Pass
- `elm-cem/spikes/build-shape/RESULT.md` — a short report noting all four
  steps passed, any observations worth carrying into workstream B (e.g.
  "aliases work but only when `Type.namedWith` is used, not `Type.alias`").
- Green light to write the workstream-B implementation spec.

### Partial pass with workable fallback
- `RESULT.md` documenting which step needed a fallback and which fallback
  was validated by re-running the spike with the workaround applied.
- Green light to write the workstream-B implementation spec, with the
  fallback baked into it as a constraint.

### Fail
- `RESULT.md` documenting where the composition broke and why the fallbacks
  did not rescue it.
- Workstream B retreats to Option 2 (defaults-record); ADR 0013 is
  amended to record the retreat and the reasoning.

## 7. Time box

**4 hours of focused work** from start to `RESULT.md`. If the spike is not
converging by the 4-hour mark, treat that as evidence the pattern is fragile
even when it doesn't outright fail and consider Option 2 anyway.

## 8. Definition of done

- [ ] The four artifact directories exist under `elm-cem/spikes/build-shape/`.
- [ ] `run.sh` exits 0 (or exits non-zero with a clearly-diagnosed step
      failure and a validated fallback re-run).
- [ ] `RESULT.md` written, committed, and its verdict maps to §6's three
      outcomes unambiguously.
- [ ] Workstream B's next action is committed on the basis of the verdict
      (proceed with plan / proceed with fallback / retreat to Option 2).

## 9. Open questions

None gating the spike. All open ergonomic/naming/coverage questions for ⑤
belong to the post-spike workstream-B spec, not this document.
