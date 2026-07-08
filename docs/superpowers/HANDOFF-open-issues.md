# Open-Issues Handoff (2026-07-07)

You are picking up the **open GitHub issue backlog** of `jackhp95/elm-m3e` (7 open issues) and
driving each to resolution — autonomously, as an orchestrator, subagent-driven. This doc is the
source of truth: what each issue needs, what's already done, the product decisions the user has
already made (do NOT relitigate), where to stop, and how to run.

> **Prereq context:** two large bodies of work just shipped and are on `main`: the **docs-overhaul
> queue** (`docs/superpowers/HANDOFF.md`, streams A→D) and the **ADR-15 unwrap-default-slot refactor**
> (memory `adr-0015-unwrap-default-slot`, ADR `docs/adr/0015-*`, plan
> `docs/superpowers/plans/2026-07-07-unwrap-m3e-default-slot.md`). Read the ADR-15 memory first — the
> M3e top layer no longer has the `child`/`children` `Content` wrapper; several issues below reference
> the pre-ADR-15 API, so verify current reality before acting on any finding.

---

## Operating mode (the user chose this)

- **Full autonomy.** Per issue: branch off `main` → spawn subagents (investigate → implement →
  spec-review → code-quality-review) → fix loops → verify → **merge to `main` `--no-ff` and push
  yourself**. Don't wait for the user between issues. Same pattern that shipped the ADR-15 refactor.
- **Comment-and-close.** When an issue is **fully** resolved, post a resolution comment (what changed,
  commit SHAs) and **close it** (`gh issue close`). When partially resolved, post a **status comment**
  and tick the specific checkboxes you completed — leave it open.
- **ONE mandatory stop-and-discuss point:** issue **#174's type-safety hole** — investigate and
  **report findings to the user; do NOT auto-fix.** (See Group D.) Everything else runs to completion.
- Only surface other decisions if you hit a genuinely irreversible fork with no reasonable default.
  Standing preference: pre-release, embrace breaking changes, uniformity > per-component ergonomics.

## Decisions already made (do NOT re-ask)

1. **Publishing is NOT a near-term goal — stay pre-release/private.** DEFER every publish blocker:
   the packages/m3e repo split-or-root-restructure, git tags / `1.0.0`, making the repo public,
   secret-scanning / branch-protection, and public-only community files (CODE_OF_CONDUCT, issue/PR
   templates, a standalone package landing README). The ONE publish-prep item to do now is
   **reconcile the license** (below). Focus the real effort on **code/docs quality** and the
   **generation pipeline**.
2. **#174 slot-safety hole → investigate + report, do NOT fix** without the user. (Group D.)
3. **Build (⑤) layer → keep as-is.** No `M3e.Build` barrel (**#148 = won't-do**). Do NOT try to shrink
   the ~110k-line `Build/*/Slots.elm` output (#174's B-item) — accepted footprint.
4. **Full autonomy; comment-and-close.**

## OPEN DECISION the user still owes you (ask at the start, one question)

- **Which SPDX license id?** It's declared two ways today — root `package.json` says `BSD-3-Clause`,
  `packages/m3e/elm.json` says `MIT`, and there is **no `LICENSE` file**. The user must pick ONE. Ask
  this single question before doing the license reconciliation (Group B); if unanswered, default to
  the id the user names in memory or leave the reconciliation as the last, un-merged step.

---

## The issue queue

7 open issues. Grouped by kind; run the groups in this order (cheap wins → quality → pipeline →
investigation → enhancement).

### Group A — quick closes (do first, ~1 subagent or inline)

- **#148 `[low]` Build barrel — CLOSE as won't-do.** Decision made: keep Build as-is, no barrel. Post a
  comment with the rationale (pre-release; the ⑤ layer is the strict pipeline shape and a barrel adds
  surface without demand; revisit if a concrete need appears) and `gh issue close 148`.
- **Branch cleanup (part of #176) — already done** this session (stale `docs/*` branches deleted; all
  three repos on `main`). Note it when you touch #176.

### Group B — code/docs quality (the "stay-private" focus)

Covers **#136 (release-readiness)**, **#176 (repo-health)**, and **#174's doc-drift findings** (MEDIUM
`M2` "five surfaces" claim; the config-schema drift `M1`; LOW/NIT doc items). Do the QUALITY items;
DEFER the publish/public items with a status comment on each issue explaining the deferral.

**DO now:**
- **License reconciliation** (the one prep item; #136 + #176 both list it). Pick the id the user chose
  (OPEN DECISION above), set it consistently in root `package.json` + `packages/m3e/elm.json`, and add
  a matching top-level `LICENSE` file. This is the ONLY publish-prep item in scope.
- **README + prose accuracy.** This session already fixed the removed-`child` examples
  (commit `c14189f`). Remaining drift to fix: #174 `M2` — the README "five addressable surfaces" table
  is inaccurate (it omits Build and overstates the required-record claim for ~80% of components);
  #174 `M1` — `CONFIG_SCHEMA.md` drift vs the real Decl surface (`unnamed`/`arbitrary`/`_native`/
  `idWiring`); the README "coverage lives in the type system" framing now needs the ADR-15 nuance
  (named-slot inputs + kind-restricted default lists are compile errors; `any` defaults are guidance +
  elm-review). Verify each claim against the CURRENT generated `packages/m3e` before editing. Grep the
  README/CONTEXT/THREE_LAYER_PATTERN/COMPONENT_AGNOSTIC_API/CONFIG_SCHEMA for `child`/`children`/
  `Content` and any pre-ADR-15 shapes (Phase 6 of the refactor already reconciled the concept pages +
  three of those prose docs — re-verify they're clean).
- **CHANGELOG.md** — a light `Keep a Changelog` stub with an "Unreleased" section noting the docs
  overhaul + the ADR-15 unwrap is cheap and useful even pre-publish. (Optional; do if low-cost.)

**DEFER (status-comment, don't do):** the nested-package repo split, git tags, going public,
CONTRIBUTING/SECURITY/CODE_OF_CONDUCT/issue+PR templates, the standalone package README, branch
protection / secret scanning, `.gitattributes export-ignore`. On **#136** and **#176**, post a comment:
"pre-release; publish/public items deferred until a publish decision — see HANDOFF-open-issues.md,"
tick the boxes you did (license, branch cleanup, README fixes), and leave both **open**.

### Group C — the generation pipeline (#71 epic + #76)

- **#71 `[epic]` consume the elm-cem retarget — AUDIT + triage.** The body is a checklist across the
  generator (elm-cem#2–11) and this repo (#72–76). Reality: the library IS 100%-generated + consumed +
  regenerated (this session regenerated all of `packages/m3e` from the elm-cem generator, ADR-15).
  A subagent should audit each checkbox against current state, tick the done ones in the issue body,
  and report what genuinely remains. If everything but #76 is done, say so and scope the epic down to
  #76. Do NOT close the epic unless every child is verifiably done (it likely isn't — #76 remains).
- **#76 Test harness + regenerate-on-release pipeline; "delete elm-cem clone" — UPDATE to reality +
  do the real remainder.** Important: the "delete the `./elm-cem` clone" framing is **stale** —
  `elm-cem` is now a real, pushed repo (`jackhp95/elm-cem`, on `main`), nested-and-gitignored inside
  elm-m3e as the canonical generator source. So "push upstream" is DONE. Rewrite the issue's remaining
  scope to: (a) **wire regenerate-on-@m3e/web-release** (a CI job or documented `build:assets` flow
  that re-runs the regen when `@m3e/web` bumps — see the exact regen command in Conventions); (b)
  confirm the IR-introspection / type-matrix / Playwright contract harness is in place (golden tests +
  `docs/tests-browser/*.spec.ts` exist; note the ~7 known-stale contract tests); and (c) **publish
  `elm-review-cem`** — see the CRITICAL note below. Decide whether the `./elm-cem` nested clone stays
  gitignored (recommended, pre-release) or is externalized; default: keep as-is, just correct the
  issue text.

  > **CRITICAL — elm-review-cem is unpublished.** The ADR-15 refactor's guarantee layer (the `slotKinds`
  > Fact + `Cem.ValidSlotKind` rule) is merged to `elm-review-cem`'s **local** `main` but **could not be
  > pushed** — `github.com/jackhp95/elm-review-cem` does not exist yet (`git push` 404s). The `review/`
  > config sources it from the sibling worktree `../../elm-review-cem/src`, so everything works locally,
  > but CI and any fresh clone won't have the new rules. **Create that GitHub repo and push** as part of
  > #76 (or flag it to the user if repo-creation needs their account). This is the highest-value pipeline
  > item.

### Group D — INVESTIGATE ONLY, then STOP (#174 type-safety hole)

**#174's top HIGH finding:** "native container elements slip into closed slots" — the finding
(`#174` body, ~line 51–71) is that native container elements carry `Element { k | html : Supported }`
and can land in a closed slot they shouldn't. **The user wants to discuss this before any fix.**

- Spawn an investigation subagent to determine whether ADR-15 **already changed this**: ADR-15 made
  default-slot child lists kind-constrained (closed rows) and added the `Cem.ValidSlotKind` elm-review
  rule + restored kind-constrained named-slot *inputs*. Does a native container element (`Element {…,
  html}`) still slip into a closed slot at compile time? Construct the actual failing/passing case
  against the CURRENT generated library and report: is the hole open, narrowed, or closed? If open,
  what's the minimal generator fix and its blast radius?
- **STOP and surface the report to the user. Do NOT implement a fix.** Post the investigation as a
  comment on #174, tick any doc-drift boxes you resolved in Group B, and leave #174 open pending the
  user's call on the hole (and on whether to touch the generator again so soon after ADR-15).

### Group E — docs-app enhancement (#111, lowest priority)

- **#111 Adopt type-safe Tailwind classes (`elm-tailwind-classes`) in the docs app.** A real quality
  improvement to `docs/app`/`docs/src` (typed Tailwind instead of raw class strings). It's tagged
  `enhancement,question` — do it LAST, and if it turns out large or the named library doesn't fit the
  current Tailwind setup (check `docs/style.css`, the vendored `docs/vendor/tailwind-m3e-web/`, and the
  `[--var:val]` arbitrary-class pattern the docs rely on — memory `docs-mobile-polish-and-surfaces`),
  scope it down or report back rather than forcing it. Mind: this touches `Shared.elm` and every route;
  verify with `build:ci` + Playwright at both viewports.

---

## Conventions & the non-negotiable verification bar

**Repos (three, all on `main`):** `elm-m3e` (this repo; pushed), `elm-cem/` (nested, own repo,
`jackhp95/elm-cem`, pushed), `../elm-review-cem` (sibling, own repo, **local-only — unpublished**).
Branch per issue off each repo's `main` as `issue/<n>-<slug>`; never force-push / reset --hard / clean
a tracked dir.

**Toolchains (these bit us — use exactly):**
- Library regen (from elm-m3e root): `node elm-cem/bin/elm-cem.js
  --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json --config-from=config/slots.json
  --config-from=config/native-mdn.json --config-from=config/examples.generated.json
  --output=packages/m3e/src`. It is **deterministic** — a no-op regen must leave `packages/m3e` clean;
  if it doesn't, sync + commit the (doc-comment) drift first.
- `elm-cem` tests: `cd elm-cem && npm test` (elm-test-rs + compile-gate; ~253). NOT `npx elm-test`.
- `elm-review-cem` tests: `npx -y elm-test@0.19.1-revision12 --compiler
  /Users/jack/Documents/code/elm-m3e/docs/node_modules/.bin/elm` (the repo pins Elm 0.19.2 which is
  NOT installed; this 0.19.1-pinned runner + explicit compiler is the workaround; ~113).
- `packages/m3e` compile: `cd packages/m3e && ../../docs/node_modules/.bin/elm make src/M3e.elm
  --output=/dev/null`.

**Verification bar (every issue, before merge):**
- `cd docs && npm run build:ci` → **exit 0** (`check-nav: OK`, `Success - Adapter script complete`) —
  exactly what Netlify runs.
- `docs/node_modules/.bin/elm-format --validate app src` → `[]` after any `.elm` edit.
- If the generator changed: regen, `packages/m3e` compiles, `build:reference`, **and elm-review-cem +
  elm-cem test suites green** (a Fact-shape change is a breaking cross-repo contract — regenerate
  `Review.Facts` and re-green `review/` together, the ADR-15 lesson).
- **Playwright for every visual claim** (the user insists). Build `dist` (`npm run build`), serve
  (`node scripts/serve-dist.mjs dist 1239 &`, `pkill -f serve-dist.mjs` first), import chromium from
  `/Users/jack/Documents/code/elm-m3e/docs/node_modules/.pnpm/@playwright+test@1.61.1/node_modules/@playwright/test/index.js`,
  wait ~1600ms after networkidle for custom elements. Scratch scripts/screenshots in the session
  scratchpad, not the repo.
- Then merge `--no-ff` + push; comment-and-close (or status-comment) the issue.

**Commit trailer (every commit):**
```
Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>
Claude-Session: https://claude.ai/code/session_01Ap4D1B7LnEde7MVfd5uuCy
```

## Gotchas / state (read before touching code)

- **`config/` is at the REPO ROOT**, not under `docs/` (`slots.json`, `examples.*.json`, `categories.json`).
- Untracked `m3e-docs/` at the elm-m3e root is a **separate, unrelated project** — do not touch or
  conflate it.
- ~7 **pre-existing stale browser contract tests** (`docs/tests-browser/*.spec.ts`) fail independently
  of any change here — verify they fail identically at your base before blaming your work.
- The **hardened** `verify-examples.mjs` (fatal on unattributable compile errors) and `gen-barrel.mjs`
  (fatal on all-null) will now fail loudly instead of silent-passing — that's intended; if they fire,
  something upstream (usually the kit or library) doesn't compile.
- Example surfaces: honest top-compile is ~267/329 (62 graceful-degrade; B1.5a invariant = never drop
  an example). Record 91 / Build 67 / barrel 202 surfaces converted. Don't "fix" the degraded ones
  without checking they weren't degrading pre-ADR-15 too (they were).
- **Sources of the current issue set** (verify with `gh issue list` — state may have moved):
  #71 (epic: consume elm-cem retarget), #76 (pipeline), #111 (Tailwind), #136 (release-readiness),
  #148 (Build barrel — closing), #174 (thermonuclear findings), #176 (repo-health).

## Reference index
- ADR-15 memory `adr-0015-unwrap-default-slot`; ADR `docs/adr/0015-*`; refactor plan
  `docs/superpowers/plans/2026-07-07-unwrap-m3e-default-slot.md`.
- Docs-overhaul handoff `docs/superpowers/HANDOFF.md` (streams A→D, shipped).
- Memories: `issue-backlog-sequence`, `barrel-and-rules-architecture`, `elm-cem-retarget-design`,
  `docs-reference-and-review-pipeline`, `feedback-prerelease-perfection`,
  `feedback-clarify-both-process-and-substance`, `worktree-base-gotcha`, `elm-format-after-edits`.
