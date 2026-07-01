#!/usr/bin/env node
// PARKED (2026-07-01): superseded by ornith-agent.mjs (tool-using + elmq-surgical +
// signature-lock). Kept for reference only; prefer ornith-agent.mjs, which perturbs
// untouched declarations far less. See docs/ORNITH_MIGRATION_PLAN.md.
//
// Ornith migration harness: migrate ONE docs file old->new M3e API via ollama, with
// a compile-feedback loop. Usage: node ornith-migrate.mjs <path-relative-to-docs>
import fs from "node:fs";
import { execSync } from "node:child_process";
import path from "node:path";

const REPO = "/Users/jack/Documents/code/elm-m3e";
const DOCS = path.join(REPO, "docs");
const ELM = path.join(REPO, "node_modules/.bin/elm");
const PKG = path.join(REPO, "packages/m3e/src/M3e");
const OLLAMA = process.env.OLLAMA_URL || "http://localhost:11434"; // e.g. http://gpu.internal:11434
const MODEL = process.env.ORNITH_MODEL || "ornith-9b";
const MAX_ITERS = 5;

const rel = process.argv[2];
if (!rel) { console.error("usage: node ornith-migrate.mjs <docs-relative-file>"); process.exit(1); }
const abs = path.join(DOCS, rel);
const original = fs.readFileSync(abs, "utf8");

// --- gather the exposing lines of the M3e modules this file imports -------------
const usedM3e = [...original.matchAll(/import\s+(M3e\.[A-Za-z]+)/g)].map((m) => m[1]);
const exposings = [...new Set(usedM3e)].map((mod) => {
  const p = path.join(PKG, mod.replace("M3e.", "") + ".elm");
  if (!fs.existsSync(p)) return `-- ${mod}: NOT FOUND (renamed? see migration spec)`;
  const first = fs.readFileSync(p, "utf8").split("\n").find((l) => l.startsWith("module")) || "";
  return `${mod} exposes: ${(first.match(/exposing \((.*)\)/) || [, "?"])[1]}`;
}).join("\n");

const SYSTEM = `You are an expert Elm engineer. Migrate an Elm file from the OLD (deleted) M3e API to the NEW generated M3e API. Output ONLY the complete migrated file in one \`\`\`elm code block — no prose.

ELM RULES: pure, strongly typed, no null/exceptions. Function application is \`f a b\` (spaces, no commas/parens). Pipe: \`x |> f\`. Records \`{ field = v }\`, access \`.field\`. Lists \`[ a, b ]\`. Keep imports correct; keep the module's exposing list working. Do not invent functions.

AVAILABLE MODULES — import EXACTLY these top-level modules. NEVER invent submodules (no \`Native.Html\`, no \`Native.M3e\`):
  import M3e.<Component> as <Component>   -- e.g. import M3e.Button as Button
  import M3e.Node as Node                 -- Node, map, raw, text, toHtml
  import M3e.Element as Element           -- Element, fromNode, toNode, withSlot, text, map
  import Kit                              -- text, link
  import Native                           -- div span p a strong em small ul ol li img br hr node
  import EscapeHatch                      -- fromHtml, asElement, asAttribute
  import Seam                             -- asElement, asAttribute, fromHtml
  import Html          -- standard elm/html (Html.node, Html.text, …)
  import Html.Attributes -- standard elm/html attributes

NEW M3e API — the DOUBLE LIST. Each component is its lowercase name taking up to three args: an optional required record, an attributes list, and a content list:
  Comp.comp { required } [ attrs ] [ content ]      -- e.g. Button.button, Icon.icon
  - No required fields  -> Comp.comp [ attrs ] [ content ]   (e.g. Divider.divider [] [])
  - attrs come from attr setters:  Comp.attrName value
  - content comes from slot setters: Comp.slotName element ; Comp.child el / Comp.children [els] for the default slot
  - the required record holds required-singular slots (field 'content' for the default) and aria: { ariaLabel = "..." }
Render at the root with: M3e.Element.toNode el |> M3e.Node.toHtml   (or Element.map / Node.map to change msg type).

THE USERLAND KIT (import what you use):
  Kit.text : String -> Element {text}            -- text content
  Kit.link : String -> List Element -> Element {link}
  Native.div/span/p/a/strong/em/ul/ol/li/img/... : List Attr -> List Element -> Element {html}   -- native HTML
  Native.node htmlCtor attrs kids                 -- any other tag, htmlCtor e.g. (Html.node "section")
  EscapeHatch.fromHtml : Html msg -> Element      -- wrap raw Html
  EscapeHatch.asElement : Element a -> Element b  -- coerce kind (break-glass)
  EscapeHatch.asAttribute : Html.Attribute msg -> Attr

MIGRATION MAPPINGS:
  X.view { rec } opts        -> X.x { required } [attrs] [content]   (split rec fields + opts into the two lists)
  a glyph name "add" (Icon)  -> Icon.icon [ Icon.name "add" ] []
  label = "s"                -> content Kit.text "s"
  ariaLabel = "s"            -> required { ariaLabel = "s" }
  variant/size/level/grade   -> attr X.variant v (tokens from M3e.Value, unchanged)
  Node.raw h                 -> EscapeHatch.fromHtml h   (Node.raw still exists for Node-level)
  Node.rawAttr a             -> EscapeHatch.asAttribute a
  Node.element tag attrs k   -> Native.node (Html.node tag) attrs k
  Element.element tag a k     -> Native.node (Html.node tag) a k
  Node.attribute name val    -> EscapeHatch.asAttribute (Html.Attributes.attribute name val)
  Element.html h             -> EscapeHatch.fromHtml h
  Node.map / Element.map      -> KEEP (they exist)
  Node.findProperty/findAttribute/childrenOf/tagOf -> DELETE (introspection is gone)
RENAMES: NavigationDrawer->DrawerContainer, RadioButton->Radio, NavigationBar->NavBar, NavigationRail->NavRail, DatePicker->Datepicker, ExtendedFab->Fab (+ Fab.extended attr), Text/Label -> Kit.text.

Keep behavior faithful. Prefer the most specific setter (see the exposing lines given). If a composition is genuinely impossible, use EscapeHatch and leave a -- TODO(escape) comment.`;

function callOrnith(messages) {
  const body = JSON.stringify({ model: MODEL, messages, stream: false, options: { num_ctx: 8192, temperature: 0.1 } });
  const out = execSync(`curl -s ${OLLAMA}/api/chat -d @-`, { input: body, maxBuffer: 1 << 26 });
  const j = JSON.parse(out.toString());
  if (!j.message) throw new Error("ollama: " + (j.error || "no message"));
  return j.message.content;
}
function extractElm(text) {
  const m = text.match(/```(?:elm)?\s*([\s\S]*?)```/);
  return (m ? m[1] : text).trim();
}
function renderMsg(message) {
  if (typeof message === "string") return message;
  return (message || []).map((p) => (typeof p === "string" ? p : p.string || "")).join("");
}
// Priority: unambiguous missing-name / import errors first (they usually cascade),
// then everything else. Feed only the top FEW so a 9B isn't overwhelmed.
function priority(title = "") {
  const t = title.toUpperCase();
  if (/NAMING|IMPORT|MODULE|NOT FOUND|UNKNOWN/.test(t)) return 0;
  return 1;
}
function compile() {
  try {
    execSync(`${ELM} make ${rel} --report=json --output=/dev/null`, { cwd: DOCS, stdio: "pipe" });
    return { ok: true, problems: [] };
  } catch (e) {
    const raw = e.stderr?.toString() || e.stdout?.toString() || "";
    let problems = [];
    try {
      const j = JSON.parse(raw);
      if (j.type === "compile-errors") {
        for (const err of j.errors)
          for (const p of err.problems)
            problems.push({ path: err.path, title: p.title, line: p.region?.start?.line || 0, msg: renderMsg(p.message).trim() });
      } else if (j.type === "error") {
        problems.push({ path: j.path || rel, title: j.title || "ERROR", line: 0, msg: renderMsg(j.message).trim() });
      }
    } catch {
      problems.push({ path: rel, title: "COMPILE ERROR", line: 0, msg: raw.slice(0, 600) });
    }
    problems.sort((a, b) => priority(a.title) - priority(b.title) || a.line - b.line);
    return { ok: false, problems };
  }
}
function fmtProblems(problems, n = 2) {
  const total = problems.length;
  const top = problems.slice(0, n);
  const body = top
    .map((p) => `-- ${p.title} (${p.path}:${p.line})\n${p.msg.split("\n").slice(0, 8).join("\n")}`)
    .join("\n\n");
  return total > n ? `${body}\n\n(+${total - n} more error(s) — fix these first, then recompile.)` : body;
}

// --- the loop -------------------------------------------------------------------
console.log(`migrating ${rel}  (M3e modules: ${[...new Set(usedM3e)].join(", ") || "none"})`);
const initialUser = `Available NEW-API setters for the components this file uses:\n${exposings}\n\nMigrate this file:\n\`\`\`elm\n${original}\n\`\`\``;
// KEEP-BEST: a 9B oscillates (a fix regresses to more errors). So each retry
// anchors on the fewest-errors candidate so far, not the last (possibly worse) one.
let best = { code: null, n: Infinity, problems: [] };
let ok = false;
for (let i = 1; i <= MAX_ITERS; i++) {
  process.stdout.write(`  iter ${i}: generating… `);
  const t0 = Date.now();
  const msgs = i === 1 || !best.code
    ? [{ role: "system", content: SYSTEM }, { role: "user", content: initialUser }]
    : [
        { role: "system", content: SYSTEM },
        { role: "user", content: initialUser },
        { role: "assistant", content: "```elm\n" + best.code + "\n```" },
        { role: "user", content: `\`elm make\` reports these on your file. Fix ONLY these and re-output the COMPLETE file:\n\n${fmtProblems(best.problems, 2)}` },
      ];
  const reply = callOrnith(msgs);
  const code = extractElm(reply);
  fs.writeFileSync(abs, code + "\n");
  const result = compile();
  const n = result.ok ? 0 : result.problems.length;
  const tag = result.ok ? "✅ COMPILES" : n < best.n ? `${n} err (new best) [${result.problems[0]?.title}]` : `${n} err (best stays ${best.n})`;
  console.log(`${((Date.now() - t0) / 1000).toFixed(0)}s -> ${tag}`);
  if (result.ok) { ok = true; best = { code, n: 0, problems: [] }; break; }
  if (n < best.n) best = { code, n, problems: result.problems };
  else fs.writeFileSync(abs, best.code + "\n"); // regressed — restore the best candidate
}
if (!ok) {
  console.log(`--- best reached ${best.n} error(s); reverting file to original ---`);
  fs.writeFileSync(abs, original);
  console.log(fmtProblems(best.problems, 3));
  process.exit(2);
}
console.log("done — file migrated and compiles.");
