// Code-generate a transient elm-pages route that SSR-renders every converted
// cell wrapped in a <div data-rt="Module/index/surface"> element. NOT committed
// (gitignored) and NOT deployed (Netlify uses build:ci which never runs this).
//
// The docs app's View type is `{ title : String, body : List (M3e.Node.Node msg) }`
// — body must be a list of Nodes, NOT Html. M3e.Node is opaque (no public
// Html -> Node), so every cell is turned into an Element and then Element.toNode'd:
//   - top/record/build/barrel surfaces already return Element  -> use the raw expr.
//   - mid/bottom surfaces return `Html msg`                    -> lift via Seam.fromHtml.
// The data-rt wrapper is a Native.div carrying a Seam.asAttribute attribute, so it
// stays an Element the whole way. Per-cell bindings are un-annotated: each surface's
// Element carries a different phantom capability row, so no single concrete
// annotation is possible (this is exactly why verify-examples.mjs leaves bindings
// un-annotated too).

import { writeFileSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { referencedModules } from "../examples-gen/verify-examples.mjs";

const HERE = dirname(fileURLToPath(import.meta.url));
const REPO = resolve(HERE, "..", "..", "..");
const ROUTE = resolve(REPO, "docs", "app", "Route", "RoundtripHarness.elm");

const STDLIB = new Set(["Html", "Json", "VirtualDom", "Basics", "Dict", "Set", "List", "Maybe", "Result", "String", "Char", "Tuple", "Array"]);

// Surfaces whose cell expression is already an `Element` need no lifting; the
// rest return `Html msg` and are lifted into an Element via Seam.fromHtml.
const ELEMENT_SURFACES = new Set(["top", "record", "build", "barrel"]);

// Modules imported under an alias / exposing — never emit them as plain imports
// (a duplicate import is a compile error), and never let the forced-import scan
// re-add them as plain imports either.
const ALIASED = new Set(["M3e.Element", "PagesMsg"]);

function bindingName(module, index, surface) {
  return `cell_${module.replace(/\./g, "_")}_${index}_${surface}`;
}

/**
 * @param {Array<{module,index,surface,elm,converted}>} cells
 * @param {(mod:string)=>boolean} resolves  reuse verify-examples' moduleResolves
 */
export function generateHarness(cells, resolves) {
  const converted = cells.filter((c) => c.converted);

  // Plain imports: the harness's own fixed deps plus every resolvable module the
  // cell expressions reference. Aliased/exposing modules are handled separately.
  const imports = new Set(["Html", "Html.Attributes", "Native", "Seam"]);
  for (const c of converted) {
    for (const mod of referencedModules(c.elm)) {
      if (STDLIB.has(mod.split(".")[0])) continue;
      if (ALIASED.has(mod)) continue;
      if (resolves(mod)) imports.add(mod);
    }
  }

  const L = [];
  L.push("module Route.RoundtripHarness exposing (ActionData, Data, Model, Msg, route)");
  L.push("");
  L.push("-- GENERATED transient harness — do not edit or commit. See scripts/roundtrip/gen-harness-route.mjs.");
  L.push("");
  for (const mod of [...imports].sort()) L.push(`import ${mod}`);
  L.push("import BackendTask exposing (BackendTask)");
  L.push("import FatalError exposing (FatalError)");
  L.push("import Head");
  L.push("import M3e.Element as Element");
  L.push("import PagesMsg exposing (PagesMsg)");
  L.push("import RouteBuilder exposing (App, StatelessRoute)");
  L.push("import Shared");
  L.push("import View exposing (View)");
  L.push("");
  L.push("type alias Model = {}");
  L.push("type alias Msg = ()");
  L.push("type alias RouteParams = {}");
  L.push("type alias Data = {}");
  L.push("type alias ActionData = {}");
  L.push("");
  L.push("route : StatelessRoute RouteParams Data ActionData");
  L.push("route = RouteBuilder.single { head = head, data = data } |> RouteBuilder.buildNoState { view = view }");
  L.push("");
  L.push("data : BackendTask FatalError Data");
  L.push("data = BackendTask.succeed {}");
  L.push("");
  L.push("head : App Data ActionData RouteParams -> List Head.Tag");
  L.push("head _ = []");
  L.push("");
  // Per-cell bindings — NO type annotation (each surface carries a different
  // phantom capability row; inference types each one on its own).
  for (const c of converted) {
    const name = bindingName(c.module, c.index, c.surface);
    const lift = !ELEMENT_SURFACES.has(c.surface); // mid/bottom -> Seam.fromHtml
    const multiline = c.elm.includes("\n");
    const body = c.elm.split("\n").map((l) => "        " + l).join("\n");
    const expr = multiline ? "\n" + body + "\n        " : c.elm;
    L.push(`${name} =`);
    if (lift) {
      L.push("    Seam.fromHtml");
      L.push(`        (${expr})`);
    } else {
      L.push(`    ${multiline ? "(" + expr + ")" : expr}`);
    }
    L.push("");
  }
  L.push("view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)");
  L.push("view _ _ =");
  L.push('    { title = "roundtrip-harness"');
  L.push("    , body =");
  L.push("        [");
  const wrapped = converted.map((c) => {
    const id = `${c.module}/${c.index}/${c.surface}`;
    const name = bindingName(c.module, c.index, c.surface);
    return (
      "        Element.toNode (Element.map PagesMsg.fromMsg " +
      `(Native.div [ Seam.asAttribute (Html.Attributes.attribute "data-rt" "${id}") ] [ ${name} ]))`
    );
  });
  L.push(wrapped.join("\n        ,\n"));
  L.push("        ]");
  L.push("    }");
  L.push("");
  return L.join("\n");
}

export function writeHarness(cells, resolves) {
  writeFileSync(ROUTE, generateHarness(cells, resolves) + "\n");
  return ROUTE;
}
