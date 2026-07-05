# `config/slots.json` schema

The single declarative config the generator reads (via `bin/elm-cem.js
--config-from`). A JSON object keyed by **PascalCase component name**. Every key is
optional; a component absent from the config gets safe defaults (free child row, no
required, no groups). **Hand-authored → may be wrong; loose types + elm-review absorb
that** (see COMPONENT_AGNOSTIC_API §4-6). ~100 entries today (~28 evidence-based, rest
at defaults). `slots.evidence.json` = the per-slot citations from the investigation;
`slots.findings.txt` = review notes (CEM gaps, dedups).

```jsonc
{
  "TreeItem": {
    // per named slot ("default" = the unnamed slot). Absent slot entry = not exposed.
    "slots": {
      "label":   { "kinds": ["text", "link"], "multi": false, "required": true },
      "icon":    { "kinds": ["icon"],         "multi": false, "required": false },
      "default": { "kinds": ["treeItem"],     "multi": true,  "required": false }
    },
    // non-slot required fields (go in the required record). kind is "ariaLabel"
    // (→ a required String emitted as aria-label) or "action:click,link" (→ an Action field).
    "required": { "ariaLabel": "ariaLabel" },
    // variant-split grouping: fold member tags into one module (e.g. Progress).
    "group": { "linear": "m3e-linear-progress-indicator", "circular": "m3e-circular-progress-indicator" }
  },
  "Tabs": {
    // R12 typed-arg overrides: force the Elm type of an attribute the CEM types
    // wrongly or leaves under-specified. Keyed by the attribute's MANIFEST name
    // (kebab, as in requiredAttrs). Three value shapes:
    "attrTypes": {
      "some-count":    "int",                            //  scalar: "int" | "float" | "bool" | "string"
      "some-align":    ["start", "end"],                 //  enum, token == emitted value
      "disable-pagination": ["true", "false", "auto"]    //  tri-state enum (closes #96)
      // token → value map form (token name differs from the emitted string):
      // "some-attr": { "always": "on", "never": "off" }
    }
  }
}
```

Field reference:
- **`slots`** — object keyed by slot name. `kinds`: accepted-kind union (camelCase
  component names, or the specials `text`/`link`/`any`; `element` is the implicit escape,
  never listed; `any` = accepts anything, encoded as an open row). `multi`: true if the
  slot holds >1 element (drives advisory cardinality). `required`: true if the component
  is non-functional without it (required-singular → the record; required-multi → the
  content list + advisory).
- **`required`** — object of `field → kind` for NON-slot required record fields:
  `"ariaLabel"` (String → `aria-label`) or `"action:click,link"` (an `Action` field;
  suppresses the overlapping `href`/`onClick`).
- **`group`** — object of `memberName → tag` for variant-split folding.
- **`attrTypes`** (R12) — object keyed by an attribute's **manifest name** (kebab, e.g.
  `disable-pagination`; matches the `requiredAttrs` convention). Declaratively OVERRIDES
  the Elm type the generator would otherwise derive from the CEM `type.text`, for
  attributes the manifest types wrongly or leaves untyped. Three value shapes:
  - **scalar** — one of `"int"`, `"float"`, `"bool"`, `"string"`. Forces the matching
    scalar setter (an unknown string is a LOUD build error, never a silent `String`).
  - **list** — `["a", "b", …]`. Forces a typed `Value` enum where each token's name
    equals its emitted attribute string.
  - **map** — `{ "token": "value", … }`. Forces a typed `Value` enum where the Elm-facing
    token name may DIFFER from the emitted string (e.g. `{ "always": "on" }` exposes
    `M3e.Value.always` but writes `on`).

  The generator mints one shared `M3e.Value` token per token name across the whole
  manifest, so a **map** whose token reuses a name already minted with a different string
  (e.g. `always` already renders `"always"` for `hide-subscript`/`float-label`) is a
  COLLISION — the generator reports it as a build warning (`valueTokenConflicts`). Pick a
  distinct token name, or map it to the same string. (This is why #96's tri-state uses the
  collision-free list `["true","false","auto"]` rather than `never`/`always` tokens.)

**Not yet in the schema but referenced in design docs** (COMPONENT_AGNOSTIC_API §4-6):
`skip` (surface curation) and per-slot type-suffix / most-common-kind overrides. These are
unbuilt — add them when the corresponding generator features land. (The `typedArgs`
concept from those docs is now shipped as **`attrTypes`** above.)
