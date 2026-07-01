# Ornith migration plan — autonomous UI refactor onto M3e

> The harness and process for migrating consumers to the new Vocab API with a
> local model (ornith) supervised by opus. Converged 2026-07-01 (grill-with-docs).
> The rules architecture it leans on is [ADR 12](adr/0012-codegen-aware-elm-review.md);
> the per-call transform is `MIGRATION_OLD_TO_NEW.md`. This is a roadmap — expect it
> to change as the first files teach us.

## Goal

Send an autonomous agent at a codebase and have it refactor the UI onto the M3e
modules — eventually multi-file, and eventually even *from a foreign design
system*. The docs app (~1073 call sites) is the proving ground. Ornith is a local
9B model (ollama) driven by `scratchpad/ornith-agent.mjs`; **opus** is the
reviewer that keeps it honest and turns its mistakes into rules and prompt edits.

## The near-term invariant

Ornith is **single-file and signature-preserving**: it may rewrite a module's
internals but must **not change any exposed function's signature** (callers must
keep compiling). Anything that requires a signature or `Model`/`update`/`type`
change is a cross-module edit → the **opus lane**. Multi-file autonomy is the
*trusted future*, not the starting point.

## Two lanes (triage first)

A cheap pre-pass reads each file and assigns a lane:

- **Ornith lane** — mechanical, view-only, single-file: import renames, `X.view`
  rewrites, `Kit.text` for labels. (`Route/Styles/*`, small Getting-Started
  routes, `Reference`.)
- **Opus lane** — any file touching `type` / `Model` / `update`, or a
  fuzzy-semantic module (`Theme`, `Field`/`TextField`, `SideSheet`, `Disclosure`,
  `TimePicker`). Examples: `Shared.elm` (the old `Theme.Light|Dark|Auto` union
  ripples through state; typed-slot aliases like `AppBar.Leading` become
  `Content`), the Studies demos, the 375-site `Name_.elm` showcase.

## Definition of done (per file)

A cheapest-first ladder:

1. **`elm make`** clean — the compiler oracle (already in the loop).
2. **`elm-review`** clean against a curated, mostly **auto-fixable** subset (fed
   into ornith's *inner* loop the same way compile errors are). This is where
   *decidable* component-preference lives ("there is a 1:1 component for this exact
   native pattern → use it"). The ruleset is **discovered empirically**, not
   declared upfront — opus findings tell us which rules to add.
3. **Opus semantic review** — the judgment gate: faithfulness, *fuzzy*
   component-preference, and the fuzzy-semantic cases no rule can adjudicate.

## Enforcing the invariant (harness guards)

The current harness compiles only the target file, so a changed exposed signature
compiles locally while breaking callers unseen. Close that with:

1. **Signature lock** — extract the module's exposed type annotations before/after;
   if any changed, **reject the run and route the file to the opus lane** (this is
   what correctly kicks `Shared.elm` out of ornith's hands).
2. **Whole-project compile** — after signature-lock passes, `elm make` the whole
   docs app so indirect caller breakage surfaces before opus review.

Standardize on the tool-using **`ornith-agent.mjs`** (surgical `elmq` patches
rarely perturb an untouched signature); park `ornith-migrate.mjs` (whole-file
regurgitation). Fix the stale prompt (both harnesses still say `X.x` / `Icon.icon`
— the built constructor is `X.view`) and inject `MIGRATION_OLD_TO_NEW.md` + the
imported modules' `exposing` facts.

## The opus monitor

An opus agent reviews **each completed file** (not a live stream — ornith reverts
anything that won't compile, so the unit is "one file that compiles"). It reads the
`git diff` + the real new component APIs and emits a **structured report** whose
`generalizable` field is the routing signal:

```
file: app/Route/Studies/Rally.elm
faithful: yes | no          # did behaviour survive? — the only hard gate
findings:
  - kind: escape-overused | wrong-slot | invalid-enum | fuzzy-semantic | style
    where: <decl / line>
    detail: "EscapeHatch.fromHtml for a plain row → M3e.Card fits"
    generalizable: rule | prompt | human-decision | one-off
verdict: clean | needs-fix
```

- `rule` → a candidate codegen-aware elm-review rule (build it, add to the loop).
- `prompt` → a line to add to ornith's SYSTEM prompt.
- `human-decision` → the fuzzy queue for the maintainer (e.g. Theme light/dark).
- `one-off` → opus just patches it.

Reports accumulate into a ledger; recurring `rule`/`prompt` findings drive what we
build next. Rules are built **in parallel** while ornith chugs — ornith's failures
*prioritize* the backlog, they don't gate it.

## Autonomy gate

Ornith is released to run the batch after **3 consecutive ornith-lane files** with
`faithful: yes` and **no `human-decision` findings**. Trivial `rule`/`prompt`/
`one-off` findings do **not** block the gate — they are the refinements we expect.
After the gate, opus shifts from every-file to **sampling** but keeps emitting the
same reports.

## Open / next

- Wire the two harness guards (signature-lock, whole-project compile).
- Update the ornith SYSTEM prompt to the Vocab API + inject the spec/facts.
- Stand up the triage pre-pass and the opus-report ledger location.
- Begin the codegen-aware rules per [ADR 12](adr/0012-codegen-aware-elm-review.md),
  seeded by the first files' `rule` findings.
