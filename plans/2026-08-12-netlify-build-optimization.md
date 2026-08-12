# Netlify build-time optimization for the elm-m3e docs site

**Date:** 2026-08-12
**Status:** Recommendation + implemented low-impact win (option i). One high-impact option (iii) deferred to Jack.
**Related:** PR #224 (`feat/prepush-commit-generated-docs`) — this doc corrects and reconciles with it.

## TL;DR

- **The premise behind #224's original motivation was wrong.** Committing `docs/.elm-pages/` does **not** save Netlify build time. `elm-pages build` regenerates `.elm-pages/` from scratch on every build and never reads the committed copies, and the served `dist/` is gitignored. #224 still has value — but it is **repo hygiene** (keeping the tracked generated tree in sync; `main` is permanently dirty today), not build speed.
- **The real cost of a Netlify build here is the two `lamdera make` Elm compiles** that `elm-pages build` runs (client app + server/CLI app). Route pre-render and `pnpm install` are not the bottleneck.
- **The dependency-artifact cache is already in place and correct**: `ELM_HOME="$NETLIFY_BUILD_BASE/cache/elm"` (= `/opt/buildhome/cache/elm`) sits inside Netlify's persisted cache tree, so Elm's compiled *dependency* artifacts persist across builds. This is the biggest single saver and needs no change.
- **The remaining unclaimed, low-impact win (implemented): persist the project's own compiled artifacts** by caching `docs/elm-stuff` via `netlify-plugin-cache`. This makes the project-module recompile incremental across builds. Done in `docs/netlify.toml`.
- **The max-savings option (iii) — commit + serve `dist/`** — is **NOT** implemented: it trades all remaining build time for large, churny, semi-binary diffs on every content change. Recommendation and mechanics are documented below for Jack to ratify or reject; it is not committed unilaterally.

## Investigation (what is actually true)

Facts below are grounded in the installed `elm-pages` 3.5.1 source (`docs/node_modules/elm-pages/generator/src/`) and the Netlify build-image source (`netlify/build-image@focal` `run-build-functions.sh`). See "Sources".

### The build pipeline

- Netlify base directory = `docs/` (the `netlify.toml` lives at `docs/netlify.toml` and `publish = "dist/"` is relative → `docs/dist`).
- Build command:
  ```
  export ELM_HOME="$NETLIFY_BUILD_BASE/cache/elm" && corepack enable && pnpm install --frozen-lockfile && pnpm run build:ci
  ```
- `build:ci` = `gen:reference` (`elm make --docs`) → `check:nav` → `build:site` (`elm-pages build` + search-index gen).

### Where time goes

`elm-pages build` (`generator/src/build.js`) runs, in order:

1. **Codegen** — synthesizes `Pages.elm`, `Route/*`, `Main.elm`, `Fetcher/*` in-memory from `app/Route/*.elm`, plus an `elm-review` codemod pass for dead-code elimination. Fast-to-moderate.
2. **`lamdera make` of the client app** → optimize-level-2 → terser. **Heavy.**
3. **`lamdera make` of the server/CLI app**; `esbuild` bundles `compiled/render.mjs`. **Heavy.**
4. **Vite asset bundling.** Moderate.
5. **Pre-render of every route** across `os.cpus().length - 1` worker threads. Cheap and parallel; scales fine with route count.

For a docs site whose routes are all `single`/`preRender`, **steps 2–3 (the two Elm compiles) dominate.** The lever is Elm compile caching, not route count.

### Does committing `.elm-pages/` help? — No.

`build.js` calls `codegen.generate()` unconditionally at the start of every build. It **synthesizes** the `.elm-pages/` modules from the route files and only writes them via `writeFileIfChanged` (a no-op disk write when identical). `compiled/render.mjs` is rebuilt by `esbuild` every run. **The committed `.elm-pages/` copies are never read as input.** On Netlify the checkout sets fresh mtimes and the Elm compile happens in a *different* directory (below) anyway.

→ **Committing `docs/.elm-pages/` is pure repo hygiene. It saves zero Netlify build time.** This is the false premise in #224's original description, now corrected in the hook header and here.

### Where Elm caches compiled artifacts

- **Dependency artifacts** live in `ELM_HOME`: `$ELM_HOME/0.19.1/packages/<author>/<pkg>/<ver>/artifacts.dat`. Expensive to rebuild. **Already persisted** via `ELM_HOME="$NETLIFY_BUILD_BASE/cache/elm"`.
- **Project-module artifacts** live in `elm-stuff/0.19.1/` relative to the compiled `elm.json`. elm-pages does **not** compile in `docs/elm-stuff/0.19.1/` — it compiles in nested dirs: `docs/elm-stuff/elm-pages/client/` and `docs/elm-stuff/elm-pages/server/` (each with its own `elm-stuff/0.19.1/`). Caching **`docs/elm-stuff`** (the whole tree) covers both. Not gitignore-committable and not auto-cached by Netlify → needs a cache plugin.

Caveat: elm-pages force-copies `app/` into the client/server dirs with `{ overwrite: true }` every build (to defeat stale mtimes after the codemod), so *app* modules recompile regardless. The persisted `elm-stuff` mainly saves recompiling unchanged framework/generated modules and re-linking. Real but smaller than the ELM_HOME (dependency) saving that is already in place.

### Netlify cache mechanics

- `NETLIFY_BUILD_BASE = /opt/buildhome`; the persisted cache dir is `$NETLIFY_BUILD_BASE/cache` (= `$NETLIFY_CACHE_DIR`). Netlify archives this tree after a successful build and restores it next build. `ELM_HOME=/opt/buildhome/cache/elm` is inside it → persists. *(High-confidence from the build-image structure; the exact "whole tree is archived" sentence is not quoted verbatim in public docs — see "Sources".)*
- **Auto-cached (no plugin):** `node_modules`, the **pnpm content-addressable store** (`~/.pnpm-store`), corepack, language toolchains. So `pnpm install --frozen-lockfile` is already fast.
- **Not auto-cached:** `elm-stuff`, `ELM_HOME`, `.elm-pages` — Elm is unknown to Netlify's build image. `ELM_HOME` is handled by the env trick; `elm-stuff` needs a plugin.

## Options considered

| Option | What | Build-time win | Repo impact | Verdict |
|---|---|---|---|---|
| (i) Cache `elm-stuff` via plugin | persist `docs/elm-stuff` across builds | Real (incremental project recompile). ELM_HOME already covers deps. | ~13 lines in `netlify.toml`. None to git history. | **IMPLEMENTED** |
| (ii) Reuse committed `.elm-pages` | wire build to skip codegen if present | **None — not supported.** elm-pages always regenerates and never reads committed copies. | n/a | **Rejected (impossible)** |
| (iii) Commit + serve `dist/` | un-gitignore built output, `publish=dist`, no-op build | **Max** (skip the whole Elm build on Netlify) | **HIGH** — large, churny, semi-binary diffs on every content change; bloats history permanently | **Deferred to Jack (not committed)** |

## Recommendation

**Ship option (i) now** (done). It is the genuine, low-impact incremental win left on the table after the already-correct `ELM_HOME` cache. Combined effect: dependency artifacts (ELM_HOME) + project artifacts (`elm-stuff`) both persist → warm rebuilds recompile only what changed instead of the whole graph from scratch.

**Do not adopt option (iii) without Jack's explicit sign-off.** It would give the largest wall-clock win but permanently bloats the repo with large, frequently-changing build output. If Jack decides the build-time savings are worth it, the mechanics are:
- Remove `dist/` from `docs/.gitignore` (and root if it shadows).
- Set the Netlify build command to a no-op (or a minimal search-index-only step) and keep `publish = "dist/"`.
- Extend the pre-push hook's `GEN_PATHS` allowlist to include `docs/dist` so the gate's freshly-built output is what gets committed and served — at which point the committed artifact becomes *load-bearing* (Netlify serves it directly), unlike today's `.elm-pages`.
- Accept: every content change produces a large diff; `git` history grows fast; review noise increases.

## Reconciliation with PR #224

- #224's hook is **sound and retained**. Its value is re-scoped from "saves Netlify build time" (false) to "repo hygiene: the tracked generated tree stays in sync with the build output; `main` is currently permanently dirty." The hook header comment is corrected to say exactly this and to point here.
- **Option (i) does not change what is committed on push**, so no hook logic change is required for it — only the corrected comment + this doc. The two changes are coherent and can live in the same PR.
- **Only option (iii) would make committed artifacts load-bearing** and require the hook to handle `docs/dist`. That path is deferred; if taken, adjust `GEN_PATHS` as noted above.

Bundled into #224 in the same PR (Part A nit-fixes below shipped alongside).

## Also fixed in #224 (Part A nits)

1. **Pathspec-scoped commit.** The docs auto-commit now runs `git commit … -- $GEN_PATHS`, so only the generated allowlist is committed even if the developer had unrelated changes pre-staged at push time. (Staging was already allowlist-scoped; the pathspec is the belt-and-braces guarantee against a pre-existing staged index.)
2. **Non-interactive / CI exit code.** The docs commit uses a self-push that necessarily exits non-zero (the git ref-snapshot wrinkle). A scripted `git push` reads that as failure. Because the docs commit has **zero** Netlify value (this doc), a non-interactive push (no TTY on stdout, or `$CI` set) now **skips** the commit+self-push, leaves the regenerated docs uncommitted, and **exits 0** cleanly; a later interactive push re-syncs the tracked files at no cost. Force the old behavior with `PREPUSH_FORCE_DOCS_COMMIT=1`.

## Verification

- **Hook behavior** (fast rig: temp repo + bare remote + fake gate that regenerates a tracked `.elm-pages` file + the real hook): all four cases pass — (A) pre-staged unrelated file is **not** swept into the docs commit and stays staged; (B) non-interactive/`CI=1` leaves docs uncommitted and exits 0; (C) no-doc-change push makes no commit. `sh -n` clean.
- **`netlify.toml`** parses (tomllib) with the plugin block intact.
- **Netlify build-time reduction** for option (i) is best verified on Netlify directly: trigger two consecutive deploys of the same commit and compare the "build" phase duration in the deploy log — the second should be materially shorter as the restored `docs/elm-stuff` makes the Elm compile incremental (watch for the plugin's `Restored cache for elm-stuff` / `Saved cache for elm-stuff` log lines). A local proxy is `time pnpm run build:ci` with `docs/elm-stuff` present vs. removed. Empirical Netlify timing was not run from here (no deploy access); the expected-win reasoning is grounded in the compile-phase analysis above.

## Sources

- Installed `elm-pages` 3.5.1: `docs/node_modules/elm-pages/generator/src/{build.js,codegen.js,file-helpers.js}`.
- Netlify build image (env vars / cache paths): `netlify/build-image@focal` `run-build-functions.sh`; https://docs.netlify.com/build/configure-builds/manage-dependencies/
- `netlify-plugin-cache`: https://github.com/jakejarvis/netlify-plugin-cache · https://www.npmjs.com/package/netlify-plugin-cache
- `@netlify/cache-utils`: https://www.npmjs.com/package/@netlify/cache-utils
