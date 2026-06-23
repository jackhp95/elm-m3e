// Extract a component reference from the Ui.* library source: each module's
// overview doc-comment plus every exposed member's type signature and doc.
// Output: docs/data/reference.json (consumed by Route.Reference via BackendTask).
// Accurate by construction — pulled straight from the compiled source.
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const here = path.dirname(fileURLToPath(import.meta.url));
const SRC = path.resolve(here, "../../src/Ui");
const OUT = path.resolve(here, "../data/reference.json");

function firstDocComment(src, fromIndex) {
  const start = src.indexOf("{-|", fromIndex);
  if (start === -1) return "";
  const end = src.indexOf("-}", start);
  if (end === -1) return "";
  return tidy(src.slice(start + 3, end));
}

// Strip @docs lines and collapse whitespace into readable prose.
function tidy(s) {
  return s
    .split("\n")
    .map((l) => l.trim())
    .filter((l) => !l.startsWith("@docs") && !l.startsWith("@figma-code-connect") && l !== "#" && !/^#\s/.test(l))
    .join("\n")
    .replace(/\n{3,}/g, "\n\n")
    .trim();
}

function parseExposing(src) {
  const m = src.match(/^module\s+[\w.]+\s+exposing\s*\(([\s\S]*?)\)\s*$/m);
  if (!m) return [];
  return m[1]
    .split(",")
    .map((s) => (s.match(/[A-Za-z0-9_]+/) || [""])[0])
    .filter(Boolean);
}

function memberDoc(lines, annIdx) {
  let k = annIdx - 1;
  while (k >= 0 && lines[k].trim() === "") k--;
  if (k < 0 || !lines[k].includes("-}")) return "";
  let s = k;
  while (s >= 0 && !lines[s].includes("{-|")) s--;
  if (s < 0) return "";
  return tidy(lines.slice(s, k + 1).join("\n").replace("{-|", "").replace("-}", ""));
}

const components = [];
for (const file of fs.readdirSync(SRC).filter((f) => f.endsWith(".elm")).sort()) {
  const name = file.replace(/\.elm$/, "");
  const src = fs.readFileSync(path.join(SRC, file), "utf8");
  const lines = src.split("\n");
  const moduleAt = src.indexOf("module");
  const overview = firstDocComment(src, moduleAt);

  const members = [];
  for (const nm of parseExposing(src)) {
    if (!/^[a-z]/.test(nm)) {
      // a type (possibly with constructors)
      const idx = lines.findIndex((l) => new RegExp("^type\\s+(alias\\s+)?" + nm + "\\b").test(l));
      members.push({ name: nm, kind: "type", signature: "", doc: idx === -1 ? "" : memberDoc(lines, idx) });
      continue;
    }
    const idx = lines.findIndex((l) => new RegExp("^" + nm.replace(/[.*+?^${}()|[\]\\]/g, "\\$&") + "\\s*:").test(l));
    let signature = "";
    let doc = "";
    if (idx !== -1) {
      const sig = [lines[idx]];
      for (let j = idx + 1; j < lines.length; j++) {
        if (/^\S/.test(lines[j])) break;
        sig.push(lines[j]);
      }
      signature = sig.join(" ").replace(/\s+/g, " ").replace(new RegExp("^" + nm + "\\s*:\\s*"), "").trim();
      doc = memberDoc(lines, idx);
    }
    members.push({ name: nm, kind: "value", signature, doc });
  }
  components.push({ name, slug: name.toLowerCase(), overview, members });
}

fs.mkdirSync(path.dirname(OUT), { recursive: true });
fs.writeFileSync(OUT, JSON.stringify(components));
console.log(`reference: ${components.length} components, ${components.reduce((n, c) => n + c.members.length, 0)} members -> data/reference.json`);
