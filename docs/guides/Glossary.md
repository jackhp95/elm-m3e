# Glossary

Terms used across the elm-m3e docs, design notes, and generator config. When a
term appears in code (a module name, config key, or type name), the code form is
noted.

---

**atom**
A small, accessible, cross-library content element from the v1 shared vocabulary:
`text`, `link`, `label`, `icon`. Atoms carry `Markup.Kind.Shared` in a role-specific
kind field and are produced by `Markup.Atoms`. They flow freely into any m3e slot
that opts in with a matching `shared:<atom>` config entry. New atoms are non-breaking
additions. See [`TheLayers — The atom layer`](TheLayers.md#the-atom-layer) and
[`decisions.md CX4`](../decisions.md#cx4--atom-vocabulary-v1-text-link-label-icon).

**brand**
An opaque, nullary phantom type local to one library — `M3e.Kind.Brand`,
`Markup.Kind.Brand`, etc. Each library mints its own brand in its own namespace, so
Elm's nominal type system keeps them distinct at zero runtime cost. A private-tier
component's kind row carries its library's brand; closed slots reject any element
carrying a different brand. See [`decisions.md CX2`](../decisions.md#cx2--brand-kind-rows-per-library).

**coercion**
A config-declared, named, typed brand crossing. Declared in the `_coerce` block of
`config/slots.json`; generated into `<Lib>.Coerce` (e.g., `M3e.Coerce.asButton`).
A coercion makes a semantic claim about the crossing — a Chip *acting as* a button
— and is the preferred mechanism for recurrent, well-reasoned crossings. Contrast
with `recast` (the general loud crossing). See [`Seams`](Seams.md) and
[`decisions.md CX5`](../decisions.md#cx5--seams-are-loud-coercions-are-config-blessed-sugar).

**facet**
One package in a generated library's facet family, corresponding to one point on
the layer/form space: core, raw, html, standard, record, build, review-facts. The
word "facet" replaces "surface" in the post-CX11 vocabulary to avoid ambiguity with
"HTML surface". See [`TheLayers`](TheLayers.md) and
[`decisions.md CX11`](../decisions.md#cx11--facet-family-packaging-one-package-per-facet).

**mirror**
A publish-only GitHub repo (`jackhp95/<pkg>`) that contains a standalone copy of
one facet package (its own `elm.json` + partitioned `src/` + `README` + `LICENSE`),
pushed there by the `elm-cem split` splitter + `mirror-release.mjs` script. Mirrors
carry a "generated — do not edit; issues and source in the dev repo" banner.
Development never happens in mirrors. See
[`decisions.md CX12`](../decisions.md#cx12--copy-only-publish-mirrors).

**recast**
The general loud seam crossing: `Seam.recast` coerces any `Element` to any other
kind row with no semantic claim. Always greppable and review-enforced. Use for
one-off or as-yet-unnamed crossings; promote to a named coercion when the crossing
recurs with consistent intent. See [`Seams`](Seams.md).

**seam**
Any crossing point where a value from outside the typed IR enters it. Two
sanctioned mechanisms exist: `recast` (general) and named coercions
(`M3e.Coerce.*`, config-blessed). Every seam crossing must happen inside a
module declared in `NoSeamOutsideAllowedModules`'s `allowedModules` list.
The seam stampers (`fromNode`, `fromHtml`, `recast`) live only in `*.Internal`
modules not re-exported from the public surface. See
[`Seams`](Seams.md) and [`DESIGN.md §4`](../DESIGN.md).

**shared** (kind)
`Markup.Kind.Shared` — the cross-library atom marker. An `Element` carrying
`Shared` in a kind field is produced by `Markup.Atoms` and admissible in any slot
across any library that declares the corresponding `shared:<atom>` config entry.
The type is defined in `markup-core` and shared by all generated libraries. Distinct
from `M3e.Kind.Brand` (which is m3e-private) and `Markup.Kind.Brand`
(which is markup-private). See
[`decisions.md CX3`](../decisions.md#cx3--two-kind-tiers-private-brand-vs-shared-atom).

**tier**
The per-component config choice of kind segregation strategy. Two tiers:

- **private** (default): the component's kind row carries `<Lib>.Kind.Brand`.
  Slots typed with a private kind reject foreign elements.
- **role** (atom tier): the component's kind row carries `Markup.Kind.Shared`
  with a specific role field name (`text`, `link`, `label`, `icon`). Slots that
  opt in to the matching atom accept this element regardless of origin library.

Config: `"tier": "private"` or `"tier": {"role": "text"}`. The generator
propagates the chosen tier through all five facet emitters. See
[`decisions.md CX3`](../decisions.md#cx3--two-kind-tiers-private-brand-vs-shared-atom).

---

**Terms from earlier docs that changed meaning:**

- **`Supported`** — in the pre-CX2 design this appeared in kind rows. Since CX2,
  kind rows carry only `<Lib>.Kind.Brand` or `Markup.Kind.Shared`. `Supported`
  still appears on value rows (`Token.Supported`) and attribute capability rows,
  but not on kind rows.

- **surface** — older usage for what is now called a **facet**. The word "surface"
  was ambiguous (it could mean the HTML surface, the API surface, or a facet);
  "facet" is unambiguous.

- **runtime** — the modules in `markup-core` that every generated library imports
  (`Markup.Element`, `Markup.Node`, `Markup.Html.Attr`, `Markup.Token.*`). Pre-CX1,
  these were copied per library via string-rewrite; post-CX1 they are the shared
  published package. The word "runtime" refers specifically to these infrastructure
  types, not to JavaScript runtime behavior.
