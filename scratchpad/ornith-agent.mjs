#!/usr/bin/env node
// Tool-using ornith migration agent. Ornith calls elmq + elm make as native tools
// and self-scaffolds the migration. Usage: node ornith-agent.mjs <docs-relative-file>
import fs from "node:fs";
import { execSync } from "node:child_process";
import path from "node:path";

const REPO = "/Users/jack/Documents/code/elm-m3e";
const DOCS = path.join(REPO, "docs");
const ELM = path.join(REPO, "node_modules/.bin/elm");
const ELMQ = path.join(REPO, "scratchpad/bin/elmq");
const OLLAMA = process.env.OLLAMA_URL || "http://localhost:11434";
const MODEL = process.env.ORNITH_MODEL || "ornith-9b";
const MAX_ROUNDS = 40;

const rel = process.argv[2];
if (!rel) { console.error("usage: node ornith-agent.mjs <docs-relative-file>"); process.exit(1); }
const abs = path.join(DOCS, rel);
const original = fs.readFileSync(abs, "utf8");

const sh = (cmd, input) => {
  try { return execSync(cmd, { cwd: DOCS, input, stdio: "pipe", maxBuffer: 1 << 24 }).toString().trim() || "ok"; }
  catch (e) { return "ERROR: " + ((e.stdout?.toString() || "") + (e.stderr?.toString() || "")).trim().slice(0, 1500); }
};
const q = (s) => `'${String(s).replace(/'/g, "'\\''")}'`;
const onlyTarget = (f) => f === rel || path.resolve(DOCS, f) === abs;

function compileJson() {
  try { execSync(`${ELM} make ${rel} --report=json --output=/dev/null`, { cwd: DOCS, stdio: "pipe" }); return { ok: true, text: "NO ERRORS — compiles." }; }
  catch (e) {
    const raw = e.stderr?.toString() || e.stdout?.toString() || "";
    let out = [];
    try {
      const j = JSON.parse(raw);
      const probs = j.type === "compile-errors" ? j.errors.flatMap((x) => x.problems.map((p) => ({ ...p, path: x.path }))) : [{ title: j.title, message: j.message, path: j.path }];
      out = probs.slice(0, 3).map((p) => `-- ${p.title} (${p.path}:${p.region?.start?.line || "?"})\n` + (Array.isArray(p.message) ? p.message.map((z) => (typeof z === "string" ? z : z.string)).join("") : p.message).split("\n").slice(0, 8).join("\n"));
      return { ok: false, text: `${probs.length} error(s):\n\n` + out.join("\n\n") };
    } catch { return { ok: false, text: raw.slice(0, 1500) }; }
  }
}

const TOOLS = [
  { type: "function", function: { name: "list", description: "Show a file's module header, imports, and declarations with line ranges.", parameters: { type: "object", properties: { file: { type: "string" } }, required: ["file"] } } },
  { type: "function", function: { name: "search", description: "Regex-search Elm code; returns matches with their enclosing declaration.", parameters: { type: "object", properties: { pattern: { type: "string" } }, required: ["pattern"] } } },
  { type: "function", function: { name: "get", description: "Read the full source of a declaration by name.", parameters: { type: "object", properties: { file: { type: "string" }, name: { type: "string" } }, required: ["file", "name"] } } },
  { type: "function", function: { name: "patch", description: "Surgical find-and-replace of an exact substring within one declaration of the file being migrated.", parameters: { type: "object", properties: { name: { type: "string", description: "declaration name" }, old: { type: "string" }, new: { type: "string" } }, required: ["name", "old", "new"] } } },
  { type: "function", function: { name: "set_decl", description: "Replace (or add) an entire top-level declaration in the file being migrated. Provide the full new declaration source including its type annotation.", parameters: { type: "object", properties: { name: { type: "string" }, content: { type: "string" } }, required: ["name", "content"] } } },
  { type: "function", function: { name: "add_import", description: "Add an import statement to the file being migrated, e.g. 'import Kit'.", parameters: { type: "object", properties: { statement: { type: "string" } }, required: ["statement"] } } },
  { type: "function", function: { name: "remove_import", description: "Remove the import of a module (e.g. a renamed or deleted OLD module like 'Cem.M3e.Shape' or 'M3e.DatePicker'). Imports are NOT patchable — to rename an import, remove_import the old module then add_import the new one.", parameters: { type: "object", properties: { module: { type: "string", description: "module name, e.g. Cem.M3e.Shape" } }, required: ["module"] } } },
  { type: "function", function: { name: "compile", description: "Compile the file being migrated; returns the top errors, or 'NO ERRORS'.", parameters: { type: "object", properties: {}, required: [] } } },
];

function runTool(name, a) {
  switch (name) {
    case "list": return sh(`${ELMQ} list ${q(a.file || rel)}`);
    case "search": return sh(`${ELMQ} grep ${q(a.pattern)}`);
    case "get": return sh(`${ELMQ} get -f ${q(a.file || rel)} ${q(a.name)}`);
    case "patch": return sh(`${ELMQ} patch --old ${q(a.old)} --new ${q(a.new)} ${q(rel)} ${q(a.name)}`);
    case "set_decl": return sh(`${ELMQ} set decl ${q(rel)} ${q(a.name)} --content ${q(a.content)}`);
    case "add_import": return sh(`${ELMQ} add import ${q(rel)} ${q(a.statement)}`);
    case "remove_import": return sh(`${ELMQ} rm import ${q(rel)} ${q(a.module)}`);
    case "compile": return compileJson().text;
    default: return "ERROR: unknown tool " + name;
  }
}

const SYSTEM = `You migrate an Elm file from the OLD (deleted) M3e API to the NEW generated M3e API, using tools. You may ONLY edit the file "${rel}" (patch/set_decl/add_import act on it). Read with list/get/search; check with compile. Loop: compile -> fix an error with elmq -> compile -> repeat until compile says NO ERRORS. Make minimal, faithful edits.

NEW API essentials (the built Vocab API):
- The constructor is ALWAYS \`view\` in the component's module: Comp.view [attrs] [content], or Comp.view { required } [attrs] [content] when there are required slots/aria/action. Drop the record when there are none: Icon.view [ Icon.name "add" ] []. NEVER call Comp.comp / Icon.icon — that name is gone.
- Setters live in the component module (strict, e.g. Button.variant, Icon.name, Card.header) OR via the barrel (import M3e exposing (..) gives loose disabled/variant/onClick + every constructor as its noun: M3e.button = Button.view). Prefer the component-module setters when the module is already imported. Read the module's exposing line (list tool) for exact setter names — do NOT invent setters. Enum inputs are M3e.Value tokens (Value.filled, Value.small).
- HARD CONSTRAINT: do not change any EXPOSED function's type signature (callers must keep compiling). If a faithful migration would require changing an exposed signature or a Model/custom type, STOP — that is a cross-module change for a human, not this single-file run.
- Node-level code (returns Node, old Node.element/Node.rawAttr) -> rebuild with the kit's Native.* (Element-level), never Node.raw(Html.*) (opaque HTML is banned).
- Userland kit modules (add_import as needed): Kit (text, link), Native (div, section, nav, span, p, a, ul, li, ... — native HTML as Element), EscapeHatch (fromHtml, asElement, asAttribute), Seam (asAttribute for a class on a Native element).
- Mappings: Node.raw h -> EscapeHatch.fromHtml h ; Node.rawAttr a / class -> Seam.asAttribute a ; Element.html -> EscapeHatch.fromHtml ; X.view {rec} opts -> X.view {req} [attrs] [content] ; a glyph label -> Kit.text ; renames (do each as remove_import OLD then add_import NEW — NEVER patch an import line): NavigationDrawer->DrawerContainer, RadioButton->Radio, NavigationBar->NavBar, NavigationRail->NavRail, DatePicker->Datepicker. Old \`Cem.M3e.*\` modules are gone — remove_import them and use the M3e.Value tokens / the matching M3e.* component instead.
Start by calling compile, then IMMEDIATELY fix the first error with add_import (renamed/missing module) or patch/set_decl. Do NOT call get/list/search unless an error names something you genuinely must inspect — exploration wastes the context window and stalls the migration.`;

const NUM_CTX = Number(process.env.ORNITH_NUM_CTX || 32768);

// Keep the conversation bounded: system + the migrate instruction + the most recent
// exchanges. The harness re-injects the current file state (via the model's own
// edits) and the current compile error every round, so old tool output is dead
// weight that otherwise overflows the context window (the failure on large files).
function windowed(messages, keep = 12) {
  if (messages.length <= keep + 2) return messages;
  return [messages[0], messages[1], ...messages.slice(-keep)];
}

async function chat(messages) {
  // Retry transient fetch failures (a flaky LAN link to a remote ollama box drops
  // mid-run otherwise — see the qwen3:14b run that died at round 7 on "fetch failed").
  let lastErr;
  for (let attempt = 1; attempt <= 4; attempt++) {
    try {
      const res = await fetch(`${OLLAMA}/api/chat`, { method: "POST", body: JSON.stringify({ model: MODEL, messages: windowed(messages), tools: TOOLS, stream: false, options: { num_ctx: NUM_CTX, temperature: 0.1 } }) });
      const j = await res.json();
      if (j.error && /context/i.test(String(j.error.message || j.error))) throw new Error("ollama: " + JSON.stringify(j.error)); // don't retry a real context error
      if (!j.message) throw new Error("ollama: " + (j.error?.message || j.error || "no message"));
      return j.message;
    } catch (e) {
      lastErr = e;
      if (/context/i.test(String(e.message))) throw e;
      console.log(`  (chat attempt ${attempt} failed: ${String(e.message).slice(0, 60)} — retrying)`);
      await new Promise((r) => setTimeout(r, 1500 * attempt));
    }
  }
  throw lastErr;
}

// --- signature lock -----------------------------------------------------------
// The near-term ornith invariant is single-file + signature-preserving: it may
// rewrite a module's internals but must NOT change any EXPOSED function's type
// signature, or callers break (which the single-file compile below can't see).
// We snapshot the exposed annotations before the run and reject drift after.
function exposedSignatures(src) {
  const exp = (src.match(/module\s+[\w.]+\s+exposing\s*\(([^)]*)\)/s) || [, ""])[1];
  const names = new Set(
    exp.split(",").map((s) => s.trim().replace(/\(\.\.\)$/, "").trim()).filter((n) => /^[a-z]\w*$/.test(n))
  );
  const sigs = {};
  const lines = src.split("\n");
  for (let i = 0; i < lines.length; i++) {
    const mm = lines[i].match(/^([a-z]\w*)\s*:/);
    if (mm && names.has(mm[1])) {
      const ann = [lines[i]];
      for (let j = i + 1; j < lines.length; j++) {
        if (new RegExp("^" + mm[1] + "\\b").test(lines[j])) break;
        ann.push(lines[j]);
      }
      sigs[mm[1]] = ann.join(" ").replace(/\s+/g, " ").trim();
    }
  }
  return sigs;
}
const originalSigs = exposedSignatures(original);

const messages = [{ role: "system", content: SYSTEM }, { role: "user", content: `Migrate ${rel}.` }];
let done = false;
for (let round = 1; round <= MAX_ROUNDS; round++) {
  let m;
  try {
    m = await chat(messages);
  } catch (e) {
    console.log(`  [${round}] chat error (${String(e.message).slice(0, 120)}) — stopping`);
    break;
  }
  messages.push(m);
  if (m.tool_calls?.length) {
    for (const tc of m.tool_calls) {
      const out = runTool(tc.function.name, tc.function.arguments || {});
      const short = String(out).slice(0, 2500);
      console.log(`  [${round}] ${tc.function.name}(${JSON.stringify(tc.function.arguments).slice(0, 80)}) -> ${short.split("\n")[0].slice(0, 70)}`);
      messages.push({ role: "tool", content: short });
    }
    // the GGUF tool template requires a user turn after tool results — and it keeps
    // the model focused on fixing rather than endlessly exploring.
    const c = compileJson();
    messages.push({ role: "user", content: c.ok ? "compile: NO ERRORS. You are done." : `Now fix the FIRST error below with elmq (add_import for a renamed/missing module, patch/set_decl for code). Do not read declarations you are not editing.\n\n${c.text}` });
  } else {
    console.log(`  [${round}] (no tool call) ${String(m.content || "").slice(0, 80)}`);
    messages.push({ role: "user", content: "Keep going — call compile; if there are errors, fix them with elmq; stop only when compile says NO ERRORS." });
  }
  if (compileJson().ok) { done = true; console.log(`✅ ${rel} compiles (round ${round})`); break; }
}
if (!done) { console.log(`✗ not compiling after ${MAX_ROUNDS} rounds — reverting`); fs.writeFileSync(abs, original); process.exit(2); }

// signature lock: reject exposed-signature drift and route the file to the opus lane.
const newSigs = exposedSignatures(fs.readFileSync(abs, "utf8"));
const drift = [
  ...Object.keys(originalSigs).filter((n) => originalSigs[n] !== (newSigs[n] ?? "«removed»")),
  ...Object.keys(newSigs).filter((n) => !(n in originalSigs)),
];
if (drift.length) {
  console.log(`✗ exposed signature changed (${drift.join(", ")}) — reverting; this file needs the OPUS lane (cross-module change).`);
  fs.writeFileSync(abs, original);
  process.exit(3); // 3 = signature drift → opus lane
}

// whole-project gate: the per-file compile can't see caller breakage. Compile the
// declared entry points too (ORNITH_ENTRYPOINTS="app/Route/Index.elm,..."), if any.
const entrypoints = (process.env.ORNITH_ENTRYPOINTS || "").split(",").map((s) => s.trim()).filter(Boolean);
if (entrypoints.length) {
  const res = sh(`${ELM} make ${entrypoints.map(q).join(" ")} --output=/dev/null`);
  if (res.startsWith("ERROR")) {
    console.log(`✗ whole-project compile broke a caller — reverting; opus lane.\n${res.slice(0, 800)}`);
    fs.writeFileSync(abs, original);
    process.exit(3);
  }
}
console.log(`✅ ${rel} migrated; exposed signatures preserved.`);
