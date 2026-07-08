// verify-roundtrip.mjs — round-trip verification harness.
// Layer 1 (default): join the config JSONs, scan each converted cell for escape
// hatches, and write docs/data/roundtrip-report.json.
// Layer 2 (--render): additionally SSR-render + DOM-diff each cell (added later).

import { readFileSync, writeFileSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { buildMatrix, SURFACES } from "./roundtrip/join.mjs";
import { scanEscapes } from "./roundtrip/escape-scan.mjs";

const HERE = dirname(fileURLToPath(import.meta.url));
const REPO = resolve(HERE, "..", "..");
const CONFIG = resolve(REPO, "config");
const OUT = resolve(REPO, "docs", "data", "roundtrip-report.json");

const readJson = (p) => JSON.parse(readFileSync(p, "utf8"));

function main() {
  const rich = readJson(resolve(CONFIG, "examples.rich.json"));
  const surfaces = readJson(resolve(CONFIG, "examples.surfaces.json"));
  const barrel = readJson(resolve(CONFIG, "examples.barrel.json"));

  const cells = buildMatrix({ rich, surfaces, barrel }).map((cell) => {
    const escape = scanEscapes(cell.elm);
    return {
      id: `${cell.module}/${cell.index}/${cell.surface}`,
      module: cell.module,
      index: cell.index,
      surface: cell.surface,
      title: cell.title,
      converted: cell.converted,
      escapeHatch: {
        seam: escape.seam,
        native: escape.native,
        charsInside: escape.charsInside,
        benign: escape.benign,
      },
      roundtrip: null, // filled by Layer 2 (--render)
    };
  });

  const perSurface = {};
  for (const s of SURFACES) {
    const scoped = cells.filter((c) => c.surface === s);
    const converted = scoped.filter((c) => c.converted);
    perSurface[s] = {
      total: scoped.length,
      converted: converted.length,
      clean: converted.filter((c) => c.escapeHatch.charsInside === 0).length,
      usedEscapeHatch: converted.filter((c) => c.escapeHatch.charsInside > 0).length,
    };
  }

  const report = {
    generatedAtNote: "stamp externally; Date.now() intentionally not embedded",
    layer2: false,
    perSurface,
    cells,
  };
  writeFileSync(OUT, JSON.stringify(report, null, 2) + "\n");
  const totalConverted = cells.filter((c) => c.converted).length;
  console.log(`roundtrip Layer 1: ${cells.length} cells, ${totalConverted} converted -> ${OUT}`);
}

main();
