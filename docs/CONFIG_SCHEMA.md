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

**Not yet in the schema but referenced in design docs** (COMPONENT_AGNOSTIC_API §4-6):
`typedArgs` (typed-arg overrides like Icon `weight`), `skip` (surface curation),
per-slot type-suffix / most-common-kind overrides. These are unbuilt — add them when
the corresponding generator features land.
