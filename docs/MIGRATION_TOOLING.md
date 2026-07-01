# Migration tooling & environment

How the old→new consumer migration is actually run: an LLM (**ornith**) driving
AST-surgery (**elmq**) with the compiler as oracle. Written 2026-07-01. Most of this
is otherwise undocumented tribal knowledge.

## The pieces

- **elmq** — a Rust/tree-sitter Elm AST CLI ("jq for Elm", built for LLM agents) by
  Casey Webb. `grep`/`list`/`get` (structured), `set decl`/`patch --old/--new`/
  `add import`/`rename`/`mv`/`refs`. Refuses to write a file that wouldn't parse.
  - **Install (macOS arm64):** `gh release download v0.8.0 -R caseyWebb/elmq -p
    "elmq-v0.8.0-aarch64-apple-darwin.tar.gz"`, untar; binary currently at
    `scratchpad/bin/elmq`. Assets exist for linux-musl + x86 + windows too.
  - `elmq guide` prints an agent-integration playbook (use it instead of `cat`/`grep`
    on `.elm`; files <300 lines → Read+Edit, larger → `get`/`patch`).
- **ornith** — DeepReinforce **Ornith-1.0**, an open-source *agentic coding LLM*
  (MIT, built on Gemma4/Qwen3.5), served via **Ollama**. It self-scaffolds and does
  native tool-calling. NOT a codemod tool — it's the model.
- **The harness** — `scratchpad/ornith-agent.mjs` (the good one): exposes elmq +
  `elm make --report=json` as native Ollama tools and loops (≤40 rounds) until a file
  compiles. `scratchpad/ornith-migrate.mjs` is an older full-file-regen variant.
  **These are in `scratchpad/` (throwaway); promote them to committed tooling when the
  migration is real.**

## The two Ollama endpoints

- **Local (this Mac, M1 Pro 16GB):** `http://localhost:11434`, model `ornith-9b`
  (a bartowski Q4_K_M GGUF, registered via `ollama create`). ~21 tok/s. Fine for
  smoke tests, too slow for the full run.
- **GPU box (preferred):** `http://192.168.1.226:11434`, RTX 5070 12GB, Ollama 0.31.1,
  model `hf.co/deepreinforce-ai/Ornith-1.0-9B-GGUF:Q4_K_M`. ~39 tok/s. **The box's
  hostname `gpu.internal` / static `.69` never applied — it's on DHCP `192.168.1.226`.**
  Point the harness at it: `OLLAMA_URL=http://192.168.1.226:11434
  ORNITH_MODEL="hf.co/deepreinforce-ai/Ornith-1.0-9B-GGUF:Q4_K_M" node
  scratchpad/ornith-agent.mjs <docs-relative-file>`. Reaching the LAN from the sandbox
  needs `dangerouslyDisableSandbox: true` on Bash calls.

## Hard-won gotchas (these cost real time)

1. **HF pulls stall on the box.** `ollama pull hf.co/…` repeatedly stalled at ~0.9GB
   from bartowski's repo (connection drops). Fixes that worked: the **official
   `deepreinforce-ai/Ornith-1.0-9B-GGUF` repo** downloaded cleanly (different CDN path);
   and locally, when a pull errored with `context deadline exceeded` after the blobs
   were cached, **`ollama create <name> -f Modelfile` from the downloaded GGUF blob**
   (`~/.ollama/models/blobs/sha256-…`, `FROM <blob>`) bypassed the manifest step.
2. **The GGUF tool-calling template needs a USER turn after tool results.** A multi-round
   tool loop that only appends `role:"tool"` messages crashes Ollama with a Jinja
   `"No user query found in messages"` error (the stock template is buggy — that's why
   `…-Ollama-fixed-GGUF` reuploads exist). The harness works around it by appending a
   `role:"user"` turn (carrying the live compile error) after each tool round — which
   also keeps the 9B focused on fixing rather than exploring.
3. **The 9B over-explores and oscillates.** Without the focused user-turn it `get`-reads
   every declaration; and a naive retry loop regresses (1 err → 12 → 1). The harness
   uses **keep-best** (anchor each retry on the fewest-errors candidate) and feeds only
   the **top ~2 prioritized** errors (naming/import first — they cascade), from
   `--report=json`, not the whole error dump.
4. **`num_ctx`.** 32k on the M1 Pro thrashes memory (1000s/iter); 8k is the sweet spot
   (~70–280s/iter). The GPU box tolerates more.
5. **Tool precision is shaky at 9B.** It misused `patch`/`set_decl` on *imports* (not
   declarations); expose an explicit remove/add-import tool and constrain the toolset.

## The hybrid (recommended architecture)
Do the **deterministic ~80%** with elmq (module renames, IR-helper→kit remaps, import
fixes — AST-safe) and hand the **judgment ~20%** (the `X.view {rec} opts` → double-list
reshape, fuzzy renames) to ornith. See `MIGRATION_OLD_TO_NEW.md` for the transform rules
(rewrite it to the Vocab API first). `elm-lsp-rust` (lue-bird/elm-language-server-rs) is
a possible richer-diagnostics upgrade to the ornith loop, not required.

## Running a migration (per file)
`OLLAMA_URL=… ORNITH_MODEL=… node scratchpad/ornith-agent.mjs <file-relative-to-docs>`.
It git-safe-reverts on failure. **Dependency order matters** — migrate foundational
modules first (`docs/src/Layout.elm` done; `docs/app/Shared.elm` is a big shared dep the
routes need). A file is "done" when `elm make <file>` is green.
