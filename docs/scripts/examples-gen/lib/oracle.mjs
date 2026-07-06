// Mapping oracle: per-tag lookup derived from the Custom Elements Manifest
// (@m3e/web custom-elements.json) + config/slots.json. Feeds the HTML->Elm
// mapper so it can turn `<m3e-button variant="filled">` into typed M3e.* calls.

import { readFileSync } from "node:fs";
import { fileURLToPath } from "node:url";
import { dirname, resolve } from "node:path";
import { camel, pascal } from "./naming.mjs";

// docs/scripts/examples-gen/lib/oracle.mjs -> elm-m3e root is four levels up.
const HERE = dirname(fileURLToPath(import.meta.url));
const REPO_ROOT = resolve(HERE, "..", "..", "..", "..");

const CEM_PATH = resolve(
  REPO_ROOT,
  "docs/node_modules/@m3e/web/dist/custom-elements.json"
);
const SLOTS_PATH = resolve(REPO_ROOT, "config/slots.json");

function readJson(path) {
  return JSON.parse(readFileSync(path, "utf8"));
}

// Kebab-case a config key: insert "-" before each interior uppercase, lowercase
// the whole thing. Already-kebab keys pass through unchanged.
function kebab(key) {
  return String(key)
    .replace(/([a-z0-9])([A-Z])/g, "$1-$2")
    .toLowerCase();
}

// A TS type the codegen has no simple setter for: arrays (`string[]`),
// functions (`=> `), or object literals (`{`). Mirrors the generator's ASkip.
function isComplexType(typeText) {
  return /\[\]|=>|^\s*\{/.test(typeText);
}

// Extract quoted string-literal values from a TS union type text.
function enumLiterals(typeText) {
  const out = [];
  const re = /'([^']*)'/g;
  let m;
  while ((m = re.exec(typeText)) !== null) out.push(m[1]);
  return out;
}

export function buildOracle() {
  const cem = readJson(CEM_PATH);
  const slots = readJson(SLOTS_PATH);

  // Variant groups: a `group` config folds several tags into ONE top module
  // with a constructor per variant (e.g. Progress.group = { linear:
  // "m3e-linear-progress-indicator", ... } -> `M3e.Progress.linear`). Build a
  // tag -> { module, variant } map so the TOP mapper targets the group module.
  // (Middle/bottom layers keep the per-tag modules, which exist as-is.)
  const groupByTag = {};
  for (const [module, cfg] of Object.entries(slots)) {
    if (cfg && cfg.group && typeof cfg.group === "object") {
      for (const [variant, tag] of Object.entries(cfg.group)) {
        groupByTag[tag] = { module, variant };
      }
    }
  }

  const oracle = {};

  for (const mod of cem.modules ?? []) {
    for (const d of mod.declarations ?? []) {
      const tag = d.tagName;
      if (!tag) continue;

      // module: strip library prefix (up to and incl. first "-"), then pascal.
      const rest = tag.slice(tag.indexOf("-") + 1);
      const module = pascal(rest);
      const moduleConfig = slots[module] ?? {};

      // attributes
      const attributes = [];
      const setterNames = new Set();
      for (const attr of d.attributes ?? []) {
        const htmlName = attr.name;
        // Attribute setters use the PLAIN camelCase name — the generator does
        // NOT reserved-bump them (Attr.elm: `elmName = camel attribute.name`),
        // so `min`/`max`/etc. stay as-is. (`setterNames` is still tracked for
        // the slot-helper collision bump below.)
        const setter = camel(htmlName);
        setterNames.add(setter);

        const typeText = attr.type?.text ?? "";
        const enumSource = attr.parsedType?.text ?? attr.type?.text ?? "";
        // Strip nullable union members (`| null` / `| undefined`) the way the
        // generator does, so `number | null` still classifies as a number.
        const bare = typeText
          .replace(/\s*\|\s*(null|undefined)\b/g, "")
          .trim();
        let kind;
        let enumValues = [];
        if (bare === "boolean") {
          kind = "bool";
        } else if (bare === "number") {
          // Numeric attributes map to a `Float` setter at every layer, so the
          // value is emitted as a bare Elm number literal (no quotes).
          kind = "number";
        } else if (isComplexType(bare)) {
          // Array/function/object-typed attributes (e.g. `detents: string[]`,
          // `valueFormatter`) have NO generated setter (the codegen skips them),
          // so the mapper drops them like id/class rather than emitting a
          // non-existent setter.
          kind = "skip";
        } else {
          const lits = enumLiterals(enumSource);
          if (lits.length >= 2) {
            kind = "enum";
            enumValues = lits;
          } else {
            kind = "string";
          }
        }
        attributes.push({ htmlName, setter, kind, enumValues });
      }

      // requiredFields from slots.json[module].required (field -> kind object)
      const requiredFields = [];
      const requiredConfig = moduleConfig.required;
      if (requiredConfig && typeof requiredConfig === "object") {
        for (const key of Object.keys(requiredConfig)) {
          // An `action:`-kinded required field (Button/IconButton/Fab/... take a
          // required `action` on the ④ Record view) is NOT a required record
          // field at the strict TOP (Standard `M3e.*`) layer: the Standard view
          // has no required record and realizes the action through ordinary
          // `href`/`onClick` Attr setters. Skip it here so an action-bearing
          // element sources its action from `href` (-> `M3e.<mod>.href "…"`)
          // like any other attribute. The ④/⑤ translator rules then lift that
          // `href` into `action = M3e.Action.link { href = … }`.
          if (
            typeof requiredConfig[key] === "string" &&
            requiredConfig[key].startsWith("action:")
          ) {
            continue;
          }
          // Keys may be camelCase (e.g. "ariaLabel"). camel() collapses a
          // separator-free word to lowercase, so kebab first to recover the
          // word boundaries: camel(kebab("ariaLabel")) === "ariaLabel".
          const htmlName = kebab(key);
          requiredFields.push({ field: camel(htmlName), htmlName });
        }
      }

      // slots
      const slotEntries = [];
      const slotConfig = moduleConfig.slots ?? {};
      // Required NAMED slots (e.g. NavMenuItem/TreeItem `label`) are folded by
      // the codegen into the view's required record as a field (NOT a slot
      // helper). Collect them so the mapper can source that field from the
      // matching `slot="X"` child instead of emitting a non-existent helper.
      const requiredSlots = [];
      for (const slot of d.slots ?? []) {
        const rawName = slot.name;
        let helper;
        if (rawName === "") {
          helper = "child";
        } else {
          const base = camel(rawName);
          helper = setterNames.has(base) ? base + "Slot" : base;
        }
        const cfgKey = rawName === "" ? "default" : rawName;
        const cfg = slotConfig[cfgKey] ?? {};
        // `kinds` was loosened in slots.json: it is now EITHER a list of accepted
        // element rows (`["text","link"]`) OR a scalar string (`"arbitrary"` /
        // `"any"`) for slots that take anything. Normalize to a list so callers
        // can always `.length`/`.every` without a string leaking through (a bare
        // `"arbitrary"[0]` used to silently become the char `"a"`).
        const kinds = Array.isArray(cfg.kinds)
          ? cfg.kinds
          : cfg.kinds != null
            ? [cfg.kinds]
            : [];
        const kind = kinds[0] ?? "any";
        // A required, single-value default slot is folded by the codegen into
        // the view's required record as a `content` field (not a `child`
        // helper). The mapper needs required/multi to reproduce that.
        const required = cfg.required === true;
        const multi = cfg.multi === true;
        slotEntries.push({ rawName, helper, kind, required, multi });

        // A required, single-value NAMED slot -> required record field named
        // after the slot (camelCased), sourced from the `slot="X"` child.
        // `kinds` records what element rows the field accepts (e.g.
        // ["text","link"]) so the mapper can unwrap a text-only wrapper into a
        // compatible `Kit.text` / `Kit.link` rather than an incompatible
        // `Native.<tag>` (which carries an `html` row).
        // The generated view folds a required single NAMED slot into its
        // required record ONLY when the slot's accepted kinds are text/link
        // (e.g. NavMenuItem/TreeItem `label`). Required slots with element
        // kinds (e.g. SplitButton `leading-button`, SearchBar `input`) stay
        // ordinary slot HELPERS in the library — required-ness is enforced by
        // elm-review, not the record. Mirror that here so the mapper emits a
        // helper (not a phantom record field) for non-text/link required slots.
        const foldsToRecord =
          kinds.length > 0 && kinds.every((k) => k === "text" || k === "link");
        if (rawName !== "" && required && !multi && foldsToRecord) {
          requiredSlots.push({
            field: camel(rawName),
            rawName,
            kinds,
          });
        }
      }

      // Config-only slots: slots declared in config/slots.json that the CEM does
      // NOT list (e.g. FormField `label`, StepPanel `actions`, SearchBar
      // `clear-icon`). The GENERATOR emits real helpers for these (from the same
      // config), so the oracle must know them or the TOP mapper skips the whole
      // example with "unknown slot". Merge any config key not already covered by
      // a CEM slot. ("unnamed"/"default" both denote the anonymous default slot.)
      const seenRaw = new Set(slotEntries.map((s) => s.rawName));
      for (const cfgKey of Object.keys(slotConfig)) {
        const rawName =
          cfgKey === "unnamed" || cfgKey === "default" ? "" : cfgKey;
        if (seenRaw.has(rawName)) continue;
        const cfg = slotConfig[cfgKey] ?? {};
        const base = camel(rawName);
        const helper =
          rawName === ""
            ? "child"
            : setterNames.has(base)
              ? base + "Slot"
              : base;
        const kinds = Array.isArray(cfg.kinds)
          ? cfg.kinds
          : cfg.kinds != null
            ? [cfg.kinds]
            : [];
        const kind = kinds[0] ?? "any";
        const required = cfg.required === true;
        const multi = cfg.multi === true;
        slotEntries.push({ rawName, helper, kind, required, multi });
        seenRaw.add(rawName);
        const foldsToRecord =
          kinds.length > 0 && kinds.every((k) => k === "text" || k === "link");
        if (rawName !== "" && required && !multi && foldsToRecord) {
          requiredSlots.push({ field: camel(rawName), rawName, kinds });
        }
      }

      oracle[tag] = {
        tag,
        module,
        attributes,
        requiredFields,
        requiredSlots,
        slots: slotEntries,
        // id↔control wiring (FormField): a `label`/`control` slot whose helper
        // takes a leading `id`/`for` String argument (ADR 0010 R6). null unless
        // config/slots.json declares `idWiring` for this module.
        idWiring: moduleConfig.idWiring ?? null,
        // Present only for variant-group members; the TOP mapper folds them
        // into `M3e.<group.module>.<group.variant>`.
        group: groupByTag[tag] ?? null,
      };
    }
  }

  return oracle;
}
