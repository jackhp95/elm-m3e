// Deterministic HTML -> typed M3e.* Elm mapper.
//
// Handles:
//   - simple 2-arg M3e components (Button/Icon/Card-style): enum/bool/string
//     attributes, named + default slots, and text.
//   - required-record view form (3-arg): named required fields (e.g.
//     ariaLabel <- aria-label) AND a required single-value default slot folded
//     into the record as a bare `content` field (IconButton/Heading/Chip).
//   - plain (non-m3e) HTML: Native.<tag> for a known tag list, Native.node
//     Html.<tag> otherwise, and <a href> -> Kit.link. v1 drops non-structural
//     attributes (class/id/for) rather than skipping the example.
//
// Anything genuinely unmappable short-circuits the example with { skip: reason }
// (never emit non-compiling Elm; the compile/elm-review gate is the backstop).
//
// Contract:
//   toElm(htmlString, oracle) -> { code: string } | { skip: reason }

import { parseHTML } from "linkedom";
import { camel } from "./naming.mjs";

/** Escape a JS string for embedding inside an Elm string literal ("..."). */
function escapeElmString(s) {
  return s
    .replace(/\\/g, "\\\\")
    .replace(/"/g, '\\"')
    .replace(/\n/g, "\\n")
    .replace(/\r/g, "\\r")
    .replace(/\t/g, "\\t");
}

const isWhitespaceText = (node) =>
  node.nodeType === 3 && node.textContent.trim() === "";

// Universal accessibility attributes: settable on ANY component (independent of
// the phantom rows) via the `Aria` modules. Strict/middle layers use `M3e.Aria`
// (open-row `Attr`); the bottom layer uses `M3e.Cem.Html.Aria` (`Html.Attribute`).
const ARIA_SETTER = {
  "aria-label": "label",
  "aria-labelledby": "labelledby",
  "aria-describedby": "describedby",
  "aria-hidden": "hidden",
};

// Universal HTML attributes: like Aria, these are settable on ANY component
// (independent of the phantom rows) via the `Attributes` modules. Top/middle
// layers use `M3e.Attributes` (open-row `Attr capability msg`); the bottom layer
// uses `M3e.Cem.Html.Attributes` (`Html.Attribute msg`). The setter name equals
// the HTML attr name for all four. Only emitted when a component exposes NO
// typed setter for the name (the typed lookup runs first), so a component that
// DOES map e.g. `for` (m3e-app-bar) keeps its own typed setter.
const UNIVERSAL_ATTR = new Set(["id", "for", "class", "style"]);

/** Parse a raw HTML `style="k: v; k2: v2"` string into an Elm tuple-list source
 * `[ ( "k", "v" ), … ]`. Splits on `;` then the first `:`; trims each side; drops
 * empty declarations. Feeds `M3e.Attributes.style` / `M3e.Cem.Html.Attributes.style`
 * (both take `List ( String, String )`). */
function styleTuples(value) {
  const pairs = [];
  for (const decl of value.split(";")) {
    const i = decl.indexOf(":");
    if (i === -1) continue;
    const k = decl.slice(0, i).trim();
    const v = decl.slice(i + 1).trim();
    if (k === "" || v === "") continue;
    pairs.push(`( "${escapeElmString(k)}", "${escapeElmString(v)}" )`);
  }
  return pairs.length ? `[ ${pairs.join(", ")} ]` : "[]";
}

/** Emit a universal HTML-attribute setter (id/for/class/style) qualified by the
 * layer's `Attributes` module. Mirrors the `ARIA_SETTER` universal path. */
function universalAttrExpr(mod, name, value) {
  if (name === "style") return `${mod}.style ${styleTuples(value)}`;
  return `${mod}.${name} "${escapeElmString(value)}"`;
}

/** Validate + normalize a numeric attribute value to an Elm number literal.
 * Accepts an optional sign, integer, or simple decimal (Elm rejects `.5`/`5.`).
 * A non-numeric value skips (the compile gate would reject it anyway). */
function numberLiteral(value, tag, name) {
  const t = value.trim();
  if (!/^-?\d+(?:\.\d+)?$/.test(t)) {
    skip(`non-numeric value "${value}" for ${name} on ${tag}`);
  }
  return t;
}

// Non-structural attributes that carry no typed setter (presentational /
// identity only). On a doc EXAMPLE these are safely DROPPED with a log rather
// than skipping the whole example. Plain-HTML elements already drop all attrs;
// this is the m3e-element equivalent for the known-safe set. Anything NOT in
// this set (and without an oracle setter) is still conservatively skipped.
const isDroppableAttr = (name) =>
  // NOTE: id/class/style/for are no longer dropped here — they emit universal
  // setters via `UNIVERSAL_ATTR`/`universalAttrExpr` (checked before this).
  // Docs-site TOC marker; no Elm setter -> drop.
  name === "m3e-toc-ignore" ||
  // Global HTML attrs with no universal Elm setter. Only reached when the
  // component itself exposes no typed setter for the attr (the setter path
  // runs first), so a component that DOES map hidden/autofocus is unaffected.
  name === "hidden" ||
  name === "autofocus" ||
  name.startsWith("data-");

// Collected across a single toElm() run for logging/inspection.
let droppedAttrs = [];

/** Is `value` one of an enum attribute's known CEM tokens? An attr with no
 * collected token set (enumValues empty) is treated as unvalidated -> accept. */
function isValidEnumValue(attr, value) {
  const tokens = attr.enumValues ?? [];
  return tokens.length === 0 || tokens.includes(value);
}

/** Record + loudly log an invalid enum value being dropped (degradation). The
 * bad token would otherwise emit a non-existent `M3e.Value.<x>` and null the
 * surface; dropping it degrades the one attribute instead. */
function recordInvalidEnum(tag, name, value, attr) {
  const reason = `invalid enum value "${value}" for ${name} on ${tag} (expected one of ${(attr.enumValues ?? []).join("|")})`;
  droppedAttrs.push({ tag, name, value, reason });
  console.error(`to-elm: dropped ${reason}`);
}

// Void (empty) elements whose `Native.<tag>` is a 0-arg value, not a function.
const VOID_NATIVE_TAGS = new Set(["br", "hr"]);

// Plain HTML tags that have a dedicated `Native.<tag>` constructor.
const NATIVE_TAGS = new Set([
  "div",
  "span",
  "section",
  "nav",
  "p",
  "header",
  "footer",
  "strong",
  "em",
  "small",
  "ul",
  "ol",
  "li",
  "img",
  "br",
  "hr",
]);

/**
 * Sentinel thrown internally to short-circuit on the FIRST unmappable thing.
 * Carries the human-readable skip reason.
 */
class SkipError extends Error {
  constructor(reason) {
    super(reason);
    this.reason = reason;
  }
}

const skip = (reason) => {
  throw new SkipError(reason);
};

/** Map a single node (element or text) to an Elm expression string. */
function nodeToElm(node, oracle) {
  // Text node.
  if (node.nodeType === 3) {
    const trimmed = node.textContent.trim();
    if (trimmed === "") {
      // Whitespace-only text is not renderable content; caller filters these.
      skip("internal: whitespace text should be filtered");
    }
    return `Kit.text "${escapeElmString(trimmed)}"`;
  }

  // Element node.
  if (node.nodeType === 1) {
    return elementToElm(node, oracle);
  }

  skip(`unsupported node type ${node.nodeType}`);
}

/**
 * Map the non-whitespace child nodes of an element to a list of Elm exprs.
 * Used for plain-HTML containers, whose children carry no slot semantics.
 */
function childNodesToElm(node, oracle) {
  const out = [];
  for (const child of node.childNodes) {
    if (isWhitespaceText(child)) continue;
    if (child.nodeType === 1 || child.nodeType === 3) {
      out.push(nodeToElm(child, oracle));
    }
    // Comments and other node types are ignored.
  }
  return out;
}

/**
 * Render the child of a required NAMED slot whose accepted `kinds` are
 * text/link (e.g. NavMenuItem/TreeItem `label`). The codegen types this field
 * as `Element { text, link }`, so a generic `Native.<tag>` wrapper (which
 * carries an `html` row) would NOT unify. We therefore unwrap:
 *   - <a href> child            -> Kit.link "href" [ ...text... ]
 *   - text-only wrapper/bare    -> Kit.text "..."   (span/div wrappers folded)
 * Anything richer than text/link genuinely can't be sourced honestly -> skip.
 */
function textLinkSlotChild(node, tag, field, oracle) {
  // Bare text node.
  if (node.nodeType === 3) {
    return `Kit.text "${escapeElmString(node.textContent.trim())}"`;
  }
  if (node.nodeType !== 1) {
    skip(`unsupported ${field} slot child on ${tag}`);
  }
  const childTag = node.tagName.toLowerCase();

  // <a href> -> Kit.link (a link-kinded label).
  if (childTag === "a") {
    return plainElementToElm(node, oracle);
  }

  // A plain wrapper (span/div/etc.) or the m3e element's own text: fold to the
  // inner text if it is text-only; otherwise it isn't a text/link label.
  const nonWhitespace = [...node.childNodes].filter((c) => !isWhitespaceText(c));
  const allText = nonWhitespace.every((c) => c.nodeType === 3);
  if (allText) {
    const text = nonWhitespace.map((c) => c.textContent.trim()).join(" ");
    return `Kit.text "${escapeElmString(text)}"`;
  }

  skip(`unmappable ${field} slot child <${childTag}> on ${tag}`);
}

/**
 * Raw HTML attributes on a Native element, as `Native.attribute "n" "v"` exprs.
 * `Native.attribute` is the sanctioned `Seam.asAttribute (Html.Attributes.
 * attribute name value)` wrapper (the kit `Native.elm`) carrying a fully-open
 * capability row, so it composes onto any Native element (`div`/`input`/`img`/…)
 * regardless of that element's constrained attr row. This carries functional
 * attrs (`value`/`placeholder`/`type`/`src`/…) that were previously DROPPED,
 * so an `<input value="…">` round-trips. `slot` is excluded — a plain child of
 * an m3e container carries its slot structurally via the parent's slot helper,
 * not as an attribute here. `href` is excluded for the caller that already
 * emits it (`<a>` -> Kit.link).
 */
function nativeAttrExprs(node, { excludeHref = false } = {}) {
  const out = [];
  for (const attr of node.attributes) {
    const name = attr.name;
    if (name === "slot") continue;
    if (excludeHref && name === "href") continue;
    out.push(`Native.attribute "${escapeElmString(name)}" "${escapeElmString(attr.value)}"`);
  }
  return out;
}

/** Map a plain (non-m3e) HTML element to Elm. */
function plainElementToElm(node, oracle) {
  const tag = node.tagName.toLowerCase();

  // <a href="URL"> -> Kit.link "URL" [ children ]. Kit.link has no attribute
  // parameter, so its other attributes cannot be carried here.
  if (tag === "a") {
    const href = node.getAttribute("href");
    if (href == null) {
      skip("plain <a> without href");
    }
    const children = childNodesToElm(node, oracle);
    const list = children.length === 0 ? "[]" : `[ ${children.join(", ")} ]`;
    return `Kit.link "${escapeElmString(href)}" ${list}`;
  }

  // Void elements (`Native.br`/`Native.hr`) are 0-arg VALUES, not functions —
  // they take neither attributes nor children, so their attrs cannot be carried.
  if (VOID_NATIVE_TAGS.has(tag)) {
    return `Native.${tag}`;
  }

  const attrs = nativeAttrExprs(node);
  const attrList = attrs.length === 0 ? "[]" : `[ ${attrs.join(", ")} ]`;

  // `Native.img` takes ONLY attributes (no children): `img : List Attr -> ...`.
  if (tag === "img") {
    return `Native.img ${attrList}`;
  }

  const children = childNodesToElm(node, oracle);
  const list = children.length === 0 ? "[]" : `[ ${children.join(", ")} ]`;

  if (NATIVE_TAGS.has(tag)) {
    return `Native.${tag} ${attrList} ${list}`;
  }

  // Any other tag (label, input, etc.) -> Native.node Html.<tag>. Emitted code
  // references `Html.<tag>`, so the example module needs an `Html` import
  // (handled by the orchestrator when assembling the module). `main` clashes
  // with the app entrypoint, so elm/html exposes it as `main_`.
  const htmlFn = tag === "main" ? "main_" : tag;
  return `Native.node Html.${htmlFn} ${attrList} ${list}`;
}

function elementToElm(node, oracle) {
  const tag = node.tagName.toLowerCase();

  // Non-m3e elements are plain HTML.
  if (!tag.startsWith("m3e-")) {
    return plainElementToElm(node, oracle);
  }

  const entry = oracle[tag];
  if (!entry) {
    skip(`unknown m3e tag ${tag}`);
  }

  // Variant-group members fold into the group's TOP module with a per-variant
  // constructor (`M3e.Progress.linear`); everything else is `M3e.<Module>.view`.
  // Setters + content helpers all live on the target module.
  const mod = entry.group ? entry.group.module : entry.module;
  const ctor = entry.group ? entry.group.variant : "view";

  const attrPairs = [...node.attributes].map((a) => [a.name, a.value]);

  // --- Required-record named fields sourced from ATTRIBUTES. ---
  // (e.g. ariaLabel <- aria-label.) These source attributes are consumed here
  // and are NOT emitted as setters.
  const requiredFields = entry.requiredFields ?? [];
  const requiredHtmlNames = new Set(requiredFields.map((f) => f.htmlName));
  const recordFields = [];
  for (const { field, htmlName } of requiredFields) {
    const pair = attrPairs.find(([name]) => name === htmlName);
    if (!pair) {
      skip(`missing required ${field} on ${tag}`);
    }
    recordFields.push(`${field} = "${escapeElmString(pair[1])}"`);
  }

  // --- Required text/link NAMED slots sourced from a `slot="X"` child. ---
  // (e.g. NavMenuItem/TreeItem `label` <- `slot="label"` child.) In the current
  // library these are ordinary Content slot HELPERS (`M3e.TreeItem.label`, a
  // 2-arg `view : List Attr -> List Content`), NOT a folded required-record
  // field — required-ness is enforced by elm-review. We still consume the
  // matching child here (so it is not double-routed by the children loop) and
  // still require its presence, then emit the slot helper into `slottedExprs`.
  const requiredSlots = entry.requiredSlots ?? [];
  const consumedRequiredSlotNames = new Set();
  // Validate presence/uniqueness of each required named slot here, but keep the
  // rendered expr in a by-name MAP so the children loop can emit it in its
  // ORIGINAL DOM position (rather than hoisting all required slots first). The
  // content is a flat `List Element` and required-ness is an elm-review concern,
  // so source order is honest and improves round-trip fidelity.
  const requiredSlotExprByName = new Map();
  for (const { field, rawName, kinds } of requiredSlots) {
    const matches = [...node.childNodes].filter(
      (c) => c.nodeType === 1 && c.getAttribute("slot") === rawName,
    );
    if (matches.length === 0) {
      skip(`missing required ${field} (slot="${rawName}") on ${tag}`);
    }
    if (matches.length > 1) {
      skip(`multiple children for required ${field} slot on ${tag}`);
    }
    // A text/link-kinded slot (e.g. `label`) types as `Element { text, link }`.
    // Render it through the text/link unwrapper so a `<span>`/`<div>` wrapper
    // folds to `Kit.text` rather than an incompatible `Native.<tag>`.
    const onlyTextLink =
      kinds &&
      kinds.length > 0 &&
      kinds.every((k) => k === "text" || k === "link");
    const expr = onlyTextLink
      ? textLinkSlotChild(matches[0], tag, field, oracle)
      : nodeToElm(matches[0], oracle);
    const slotEntry = entry.slots.find((s) => s.rawName === rawName);
    const helper = slotEntry ? slotEntry.helper : camel(rawName);
    requiredSlotExprByName.set(rawName, `M3e.${mod}.${helper} (${expr})`);
    consumedRequiredSlotNames.add(rawName);
  }

  // --- Attributes (skip the `slot` attribute; it is structural). ---
  const attrExprs = [];
  for (const [name, value] of attrPairs) {
    if (name === "slot") continue;
    // Required-record fields were consumed above; they are not setters.
    if (requiredHtmlNames.has(name)) continue;

    // Universal aria-* setters (settable on any component via M3e.Aria).
    if (ARIA_SETTER[name]) {
      attrExprs.push(`M3e.Aria.${ARIA_SETTER[name]} "${escapeElmString(value)}"`);
      continue;
    }

    const attr = entry.attributes.find((a) => a.htmlName === name);
    if (!attr) {
      // Universal HTML-attribute setters (id/for/class/style): settable on ANY
      // component via `M3e.Attributes` (open-row `Attr`), mirroring the Aria
      // path. Reached only when the component exposes no typed setter for the
      // name (the typed lookup above ran first), so a component that DOES map
      // `for` (e.g. m3e-app-bar) keeps its own typed setter.
      if (UNIVERSAL_ATTR.has(name)) {
        attrExprs.push(universalAttrExpr("M3e.Attributes", name, value));
        continue;
      }
      // Other non-structural attrs (data-*, hidden, autofocus, toc marker) have
      // no typed setter: drop them (with a log) rather than skipping the whole
      // example. Anything else genuinely unmappable still skips.
      if (isDroppableAttr(name)) {
        droppedAttrs.push({ tag, name, value });
        continue;
      }
      skip(`unmapped attr ${name} on ${tag}`);
    }

    // Array/function/object-typed attrs have no generated setter -> drop.
    if (attr.kind === "skip") {
      droppedAttrs.push({ tag, name, value });
      continue;
    }

    // An enum attribute whose HTML value is NOT one of the CEM's known tokens
    // (e.g. NavBar mode="extended" — the real set is auto|compact|expanded) has
    // no backing `M3e.Value.<x>` token, so emitting it would fail to compile and
    // null the whole surface. Validate against the collected token set and DROP
    // the attribute (recording a reason + a loud log) so a bad value degrades
    // gracefully instead of silently poisoning the example.
    if (attr.kind === "enum" && !isValidEnumValue(attr, value)) {
      recordInvalidEnum(tag, name, value, attr);
      continue;
    }

    const setterRef = `M3e.${mod}.${attr.setter}`;
    if (attr.kind === "enum") {
      attrExprs.push(`${setterRef} M3e.Value.${camel(value)}`);
    } else if (attr.kind === "bool") {
      // Presence of a boolean attribute means "true".
      attrExprs.push(`${setterRef} True`);
    } else if (attr.kind === "number") {
      // Numeric setter takes a Float; emit the raw value as a number literal.
      attrExprs.push(`${setterRef} ${numberLiteral(value, tag, name)}`);
    } else if (attr.kind === "string") {
      attrExprs.push(`${setterRef} "${escapeElmString(value)}"`);
    } else {
      skip(`unknown attr kind ${attr.kind} for ${name} on ${tag}`);
    }
  }

  // --- Children: emit in ORIGINAL DOM ORDER. ---
  // Each child becomes one ordered item: a "slotted" item is a fully-rendered
  // named-slot / required-slot / Fix-C setter call; a "default" item defers its
  // render so the idWiring single-control wrap can be applied below. Building a
  // single ordered list (instead of separate slotted/default buckets that were
  // concatenated) keeps `tab,tab,panel,panel` as `tab,tab,panel,panel` on the
  // round trip instead of hoisting every slotted child ahead of the defaults.
  const orderedItems = [];
  // id↔control wiring (FormField): the default-slot control's `id=` feeds the
  // `control` helper's leading String argument so `<label for=…>` associates
  // with it (ADR 0010 R6). Captured from the single default-slot element child.
  const idWiring = entry.idWiring;
  let controlId = null;

  for (const child of node.childNodes) {
    if (isWhitespaceText(child)) continue;

    if (child.nodeType === 1) {
      const slotName = child.getAttribute("slot");
      // A required named slot: emit its (already-validated) expr IN POSITION.
      if (slotName != null && consumedRequiredSlotNames.has(slotName)) {
        orderedItems.push({
          kind: "slotted",
          expr: requiredSlotExprByName.get(slotName),
        });
        continue;
      }
      // idWiring label slot (FormField `label`): the helper takes a leading
      // `for`-derived String id, then the label element.
      if (idWiring && slotName != null && slotName === idWiring.label) {
        const forId = child.getAttribute("for") ?? "";
        orderedItems.push({
          kind: "slotted",
          expr: `M3e.${mod}.${camel(slotName)} "${escapeElmString(forId)}" (${nodeToElm(child, oracle)})`,
        });
        continue;
      }
      if (slotName != null && slotName !== "") {
        const slotEntry = entry.slots.find((s) => s.rawName === slotName);
        if (!slotEntry) {
          skip(`unknown slot "${slotName}" on ${tag}`);
        }
        orderedItems.push({
          kind: "slotted",
          expr: `M3e.${mod}.${slotEntry.helper} (${nodeToElm(child, oracle)})`,
        });
        continue;
      }
      // Fix C: a no-`slot=` default child distinguished only by TAG routes to
      // the NAMED slot helper whose accepted kind matches the child's produced
      // kind (e.g. <m3e-tab-panel> -> M3e.Tabs.panel, <m3e-step> ->
      // M3e.Stepper.step, <m3e-step-panel> -> M3e.Stepper.panel). Without this a
      // composite's heterogeneous default children collapse into one
      // `M3e.<mod>.children [ ... ]` whose List is not homogeneous and fails to
      // typecheck. The map excludes the container's default-union kinds, so
      // union-row composites (Menu/NavMenu/FabMenu) are unaffected.
      const childTag = child.tagName.toLowerCase();
      if (childTag.startsWith("m3e-")) {
        const childKind = oracle[childTag]?.kind;
        const helper = childKind ? entry.childSlotByKind?.[childKind] : null;
        if (helper) {
          orderedItems.push({
            kind: "slotted",
            expr: `M3e.${mod}.${helper} (${nodeToElm(child, oracle)})`,
          });
          continue;
        }
      }
      // Default-slot element: for an idWiring control, remember its `id=`.
      if (idWiring && idWiring.control && controlId == null) {
        controlId = child.getAttribute("id") ?? "";
      }
      orderedItems.push({ kind: "default", node: child });
      continue;
    }

    if (child.nodeType === 3) {
      // Non-whitespace text -> default-slot content.
      orderedItems.push({ kind: "default", node: child });
      continue;
    }

    // Comments and other node types are ignored.
  }

  // Content is a single flat `List Element`. The retarget dropped the
  // `child`/`children` wrappers: the top-layer `view : List Attr -> List Element`
  // takes RAW default-child elements, and every named-slot setter now returns a
  // free `Element`. So named-slot setter calls sit in the SAME list as the raw
  // default children — no wrapping, no `++` splicing, and IN SOURCE ORDER.
  // FormField is the one exception: its lone default-slot control keeps id↔`for`
  // wiring via the RENAMED `control` setter (was `child`), taking the control
  // element's `id=` as a leading String so a sibling `<label for=…>` associates
  // with it (ADR 0010 R6). Required-ness of default content is an elm-review
  // concern, not a type.
  const defaultCount = orderedItems.filter((i) => i.kind === "default").length;
  const wrapControl =
    idWiring && idWiring.control && defaultCount === 1;
  const contentExprs = orderedItems.map((item) => {
    if (item.kind === "slotted") return item.expr;
    const expr = nodeToElm(item.node, oracle);
    return wrapControl
      ? `M3e.${mod}.control "${escapeElmString(controlId ?? "")}" (${expr})`
      : expr;
  });
  const contentList =
    contentExprs.length === 0 ? "[]" : `[ ${contentExprs.join(", ")} ]`;

  const attrsList =
    attrExprs.length === 0 ? "[]" : `[ ${attrExprs.join(", ")} ]`;

  // Required record (named fields and/or folded content) -> 3-arg view form.
  const hasRecord = recordFields.length > 0;
  const recordArg = hasRecord ? `{ ${recordFields.join(", ")} } ` : "";

  return `M3e.${mod}.${ctor} ${recordArg}${attrsList} ${contentList}`;
}

// ---------------------------------------------------------------------------
// Phase A1: middle (`M3e.Cem.*`) and bottom (`M3e.Cem.Html.*`) layer emitters.
//
// These layers are strictly MORE permissive supersets of the strict top layer:
// each upper layer only ADDS constraints (required records, typed Content slots,
// enum Value tokens). So any composition that compiles at top is representable
// here by construction. The surface differs though — there are no required
// records and no Content slot helpers; children are raw `Html`, and a field
// that is a required record at top (e.g. `ariaLabel`) is just an untyped
// attribute here. The emitter is therefore a uniform HTML->elm/html transpile:
//   - typed setter where the oracle knows one (enum -> Value token at middle /
//     raw string at bottom; bool -> True; string -> "..."),
//   - the raw-attribute escape otherwise (`M3e.Cem.Attr.attribute` at middle,
//     `Html.Attributes.attribute` at bottom) — lower layers express anything,
//   - non-structural id/class/style/data-* dropped (as top does),
//   - a slotted child carries its slot via `M3e.Cem.Attr.slot` (middle) or
//     `Html.Attributes.attribute "slot"` (bottom).
// ---------------------------------------------------------------------------

const CEM_PREFIX = { middle: "M3e.Cem", bottom: "M3e.Cem.Html" };

// Plain tags that map to a bare `Html.<tag>`; anything else -> `Html.node "tag"`.
const HTML_TAGS = new Set([
  ...NATIVE_TAGS,
  "a",
  "label",
  "h1",
  "h2",
  "h3",
  "h4",
  "h5",
  "h6",
  "table",
  "thead",
  "tbody",
  "tr",
  "td",
  "th",
  "figure",
  "figcaption",
  "code",
  "pre",
  "b",
  "i",
  "u",
]);

/** A component's mid/bottom constructor = its module name, decapitalized
 * (`Button` -> `button`, `IconButton` -> `iconButton`). This is NOT `camel`,
 * which folds an already-PascalCase name to all-lowercase. */
const decapitalize = (s) => s.charAt(0).toLowerCase() + s.slice(1);

/** The slot attribute for a slotted child, per layer. */
function cemSlotAttr(layer, slotName) {
  const s = escapeElmString(slotName);
  return layer === "middle"
    ? `M3e.Cem.Attr.slot "${s}"`
    : `Html.Attributes.attribute "slot" "${s}"`;
}

/** An untyped (raw) attribute name/value, per layer. */
function cemRawAttr(layer, name, value) {
  const n = escapeElmString(name);
  const v = escapeElmString(value);
  return layer === "middle"
    ? `M3e.Cem.Attr.attribute (Html.Attributes.attribute "${n}") "${v}"`
    : `Html.Attributes.attribute "${n}" "${v}"`;
}

/** A typed m3e setter for `name=value`, or null if the oracle has no setter. */
function cemTypedAttr(entry, layer, name, value) {
  const attr = entry.attributes.find((a) => a.htmlName === name);
  if (!attr) return null;
  const setterRef = `${CEM_PREFIX[layer]}.${entry.module}.${attr.setter}`;
  if (attr.kind === "enum") {
    return layer === "middle"
      ? `${setterRef} M3e.Value.${camel(value)}`
      : `${setterRef} "${escapeElmString(value)}"`;
  }
  if (attr.kind === "bool") {
    return `${setterRef} True`;
  }
  if (attr.kind === "number") {
    // Numeric setter takes a Float at every layer -> bare number literal.
    return `${setterRef} ${numberLiteral(value, entry.module, name)}`;
  }
  if (attr.kind === "string") {
    return `${setterRef} "${escapeElmString(value)}"`;
  }
  skip(`unknown attr kind ${attr.kind} for ${name} on ${entry.module}`);
}

/** The `[ ... ]` list literal for a set of expressions ([] when empty). */
const elmList = (exprs) => (exprs.length === 0 ? "[]" : `[ ${exprs.join(", ")} ]`);

/** Render one node to a raw-`Html` Elm expr at the given layer. `slotName` (or
 * null) is injected as the element's slot attribute. */
function cemNodeToElm(node, oracle, layer, slotName) {
  if (node.nodeType === 3) {
    return `Html.text "${escapeElmString(node.textContent.trim())}"`;
  }
  if (node.nodeType !== 1) {
    skip(`unsupported node type ${node.nodeType}`);
  }

  const tag = node.tagName.toLowerCase();
  const attrExprs = [];

  if (!tag.startsWith("m3e-")) {
    // Plain HTML element: its attr list is `List (Html.Attribute msg)`, so a
    // slot is ALWAYS a raw Html attribute — even at the middle layer (where
    // `M3e.Cem.Attr.slot` only fits an m3e element's typed attr list).
    if (slotName) {
      attrExprs.push(
        `Html.Attributes.attribute "slot" "${escapeElmString(slotName)}"`,
      );
    }
    // <a href> keeps its href via the typed helper; carry ALL other raw HTML
    // attributes (`value`/`placeholder`/`type`/`src`/class/id/…) as
    // `Html.Attributes.attribute`, so a plain `<input value="…">` round-trips
    // instead of dropping its functional attributes. `slot` (handled above) and
    // the already-emitted `href` are skipped.
    const isAnchor = tag === "a";
    if (isAnchor) {
      const href = node.getAttribute("href");
      if (href != null) {
        attrExprs.push(`Html.Attributes.href "${escapeElmString(href)}"`);
      }
    }
    for (const attr of node.attributes) {
      const name = attr.name;
      if (name === "slot") continue;
      if (isAnchor && name === "href") continue;
      attrExprs.push(
        `Html.Attributes.attribute "${escapeElmString(name)}" "${escapeElmString(attr.value)}"`,
      );
    }
    const children = cemChildren(node, oracle, layer);
    const fn = HTML_TAGS.has(tag) ? `Html.${tag}` : `Html.node "${tag}"`;
    return `${fn} ${elmList(attrExprs)} ${elmList(children)}`;
  }

  // m3e element: the slot goes in its typed attr list (M3e.Cem.Attr.slot at
  // middle, raw Html attribute at bottom).
  if (slotName) attrExprs.push(cemSlotAttr(layer, slotName));

  const entry = oracle[tag];
  if (!entry) skip(`unknown m3e tag ${tag}`);

  for (const [name, value] of [...node.attributes].map((a) => [a.name, a.value])) {
    if (name === "slot") continue; // carried via slotName on this element
    // Universal aria-* setters (M3e.Aria at middle, M3e.Cem.Html.Aria at bottom).
    if (ARIA_SETTER[name]) {
      const ariaMod = layer === "bottom" ? "M3e.Cem.Html.Aria" : "M3e.Aria";
      attrExprs.push(`${ariaMod}.${ARIA_SETTER[name]} "${escapeElmString(value)}"`);
      continue;
    }
    // Array/function/object-typed attrs have no setter at any layer -> drop.
    const known = entry.attributes.find((a) => a.htmlName === name);
    if (known && known.kind === "skip") {
      droppedAttrs.push({ tag, name, value });
      continue;
    }
    // Invalid enum value: drop consistently with the top layer (the middle
    // layer's `M3e.Value.<x>` token would not exist; the bottom layer would
    // emit a semantically-wrong raw string). Degrade the attribute, not the
    // surface.
    if (known && known.kind === "enum" && !isValidEnumValue(known, value)) {
      recordInvalidEnum(tag, name, value, known);
      continue;
    }
    const typed = cemTypedAttr(entry, layer, name, value);
    if (typed != null) {
      attrExprs.push(typed);
      continue;
    }
    // Universal HTML-attribute setters (id/for/class/style): `M3e.Attributes` at
    // the middle layer (open-row `Attr`), `M3e.Cem.Html.Attributes` at the bottom
    // (raw `Html.Attribute`). Mirrors the Aria universal path; reached only when
    // the component has no typed setter for the name.
    if (UNIVERSAL_ATTR.has(name)) {
      const attrMod =
        layer === "bottom" ? "M3e.Cem.Html.Attributes" : "M3e.Attributes";
      attrExprs.push(universalAttrExpr(attrMod, name, value));
      continue;
    }
    if (isDroppableAttr(name)) {
      droppedAttrs.push({ tag, name, value });
      continue;
    }
    // Untyped but semantic (e.g. aria-label): raw-attribute escape. No skip —
    // the bottom layer expresses any attribute; middle via Attr.attribute.
    attrExprs.push(cemRawAttr(layer, name, value));
  }

  const children = cemChildren(node, oracle, layer);
  return `${CEM_PREFIX[layer]}.${entry.module}.${decapitalize(
    entry.module,
  )} ${elmList(attrExprs)} ${elmList(children)}`;
}

/** Non-whitespace child nodes -> raw-`Html` exprs (each carrying its own slot). */
function cemChildren(node, oracle, layer) {
  const out = [];
  for (const child of node.childNodes) {
    if (isWhitespaceText(child)) continue;
    if (child.nodeType === 1 || child.nodeType === 3) {
      const slotName =
        child.nodeType === 1 ? child.getAttribute("slot") || null : null;
      out.push(cemNodeToElm(child, oracle, layer, slotName));
    }
  }
  return out;
}

/**
 * Convert an HTML string to the middle (`M3e.Cem.*`) or bottom
 * (`M3e.Cem.Html.*`) Elm layer.
 * @param {"middle"|"bottom"} layer
 * @returns {{ code: string } | { skip: string }}
 */
export function toElmCem(htmlString, oracle, layer) {
  droppedAttrs = [];
  let document;
  try {
    ({ document } = parseHTML(`<html><body>${htmlString}</body></html>`));
  } catch (err) {
    return { skip: `parse error: ${err.message}` };
  }

  const roots = [...document.body.childNodes].filter(
    (n) => !isWhitespaceText(n) && (n.nodeType === 1 || n.nodeType === 3),
  );
  if (roots.length === 0) {
    return { skip: "empty example" };
  }

  try {
    const codes = roots.map((n) => {
      const slotName =
        n.nodeType === 1 ? n.getAttribute("slot") || null : null;
      return cemNodeToElm(n, oracle, layer, slotName);
    });
    return { code: codes.join("\n") };
  } catch (err) {
    if (err instanceof SkipError) {
      return { skip: err.reason };
    }
    throw err;
  }
}

/**
 * Convert an HTML string to typed M3e.* Elm.
 * @returns {{ code: string } | { skip: string }}
 */
export function toElm(htmlString, oracle) {
  droppedAttrs = [];
  let document;
  try {
    ({ document } = parseHTML(`<html><body>${htmlString}</body></html>`));
  } catch (err) {
    return { skip: `parse error: ${err.message}` };
  }

  // Top-level renderable nodes (ignore whitespace-only text).
  const roots = [...document.body.childNodes].filter(
    (n) => !isWhitespaceText(n) && (n.nodeType === 1 || n.nodeType === 3),
  );

  if (roots.length === 0) {
    return { skip: "empty example" };
  }

  try {
    const codes = roots.map((n) => nodeToElm(n, oracle));
    // Single-root examples are the focus of this task; multi-root just joins.
    return { code: codes.join("\n") };
  } catch (err) {
    if (err instanceof SkipError) {
      return { skip: err.reason };
    }
    throw err;
  }
}
