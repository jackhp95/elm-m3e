// Code-generate a transient elm-pages route that SSR-renders every converted
// cell wrapped in <div data-rt="Module/index/surface">. NOT committed (gitignored)
// and NOT deployed (Netlify uses build:ci which never runs this).

import { writeFileSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { referencedModules } from "../examples-gen/verify-examples.mjs";

const HERE = dirname(fileURLToPath(import.meta.url));
const REPO = resolve(HERE, "..", "..", "..");
const ROUTE = resolve(REPO, "docs", "app", "Route", "RoundtripHarness.elm");

const STDLIB = new Set(["Html", "Json", "VirtualDom", "Basics", "Dict", "Set", "List", "Maybe", "Result", "String", "Char", "Tuple", "Array"]);

const ADAPTER = { top: "elementToHtml", record: "elementToHtml", build: "elementToHtml", barrel: "elementToHtml", mid: "identity", bottom: "identity" };

function bindingName(module, index, surface) {
  return `cell_${module.replace(/\./g, "_")}_${index}_${surface}`;
}

/**
 * @param {Array<{module,index,surface,elm,converted}>} cells
 * @param {(mod:string)=>boolean} resolves  reuse verify-examples' moduleResolves
 */
export function generateHarness(cells, resolves) {
  const converted = cells.filter((c) => c.converted);
  const imports = new Set(["M3e.Element", "M3e.Node", "Html", "Html.Attributes"]);
  for (const c of converted) {
    for (const mod of referencedModules(c.elm)) {
      if (!STDLIB.has(mod.split(".")[0]) && resolves(mod)) imports.add(mod);
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
  L.push("elementToHtml : M3e.Element.Element any msg -> Html.Html msg");
  L.push("elementToHtml el = M3e.Node.toHtml (M3e.Element.toNode el)");
  L.push("");
  L.push("identity : a -> a");
  L.push("identity x = x");
  L.push("");
  for (const c of converted) {
    const adapter = ADAPTER[c.surface];
    const name = bindingName(c.module, c.index, c.surface);
    L.push(`${name} : Html.Html msg`);
    L.push(`${name} =`);
    L.push(`    ${adapter}`);
    const body = c.elm.split("\n").map((l) => "        " + l).join("\n");
    L.push(`        (${c.elm.includes("\n") ? "\n" + body + "\n        " : c.elm})`);
    L.push("");
  }
  L.push("view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)");
  L.push("view _ _ =");
  L.push('    { title = "roundtrip-harness"');
  L.push("    , body =");
  L.push("        [ Html.map (\\_ -> PagesMsg.fromMsg ()) (Html.div []");
  L.push("            [");
  const wrapped = converted.map((c) => {
    const id = `${c.module}/${c.index}/${c.surface}`;
    return `            Html.div [ Html.Attributes.attribute "data-rt" "${id}" ] [ ${bindingName(c.module, c.index, c.surface)} ]`;
  });
  L.push(wrapped.join("\n            ,\n"));
  L.push("            ])");
  L.push("        ]");
  L.push("    }");
  L.push("");
  return L.join("\n");
}

export function writeHarness(cells, resolves) {
  writeFileSync(ROUTE, generateHarness(cells, resolves) + "\n");
  return ROUTE;
}
