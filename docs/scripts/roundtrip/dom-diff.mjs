// Semantic DOM-tree diff for round-trip verification.
// Parses both sides with linkedom, canonicalizes (sort attrs, collapse
// insignificant whitespace, normalize boolean-attr form), then compares
// structurally into { matches, deviations: [...] }.

import { parseHTML } from "linkedom";

function canonAttrs(el) {
  const out = {};
  for (const { name, value } of [...el.attributes]) out[name] = value == null ? "" : String(value);
  return out;
}

function toTree(el) {
  const children = [];
  for (const child of el.childNodes) {
    if (child.nodeType === 1) children.push(toTree(child));
    else if (child.nodeType === 3) {
      const t = child.textContent.replace(/\s+/g, " ").trim();
      if (t) children.push({ type: "text", text: t });
    }
  }
  return { type: "el", tag: el.tagName.toLowerCase(), attrs: canonAttrs(el), children };
}

function rootsOf(html) {
  // linkedom drops unknown/custom elements out of <body> when parsed at the
  // top level, so wrap in a known container and collect ALL its top-level
  // children. ~42% of corpus cells are multi-root (a bare list of sibling
  // elements); comparing only the first root would hide any deviation in the
  // 2nd+ siblings. We fold every top-level child into a synthetic "#roots"
  // node so the existing positional diffNode compares every root.
  const { document } = parseHTML(`<div id="__rt_root__">${html}</div>`);
  const wrapper = document.querySelector("#__rt_root__");
  const children = [];
  if (wrapper) {
    for (const child of wrapper.childNodes) {
      if (child.nodeType === 1) children.push(toTree(child));
      else if (child.nodeType === 3) {
        const t = child.textContent.replace(/\s+/g, " ").trim();
        if (t) children.push({ type: "text", text: t });
      }
    }
  }
  return { type: "el", tag: "#roots", attrs: {}, children };
}

// Attribute values that reference an element id (whitespace-separated id lists
// for headers/aria-*; single ids elsewhere). Any `aria-*` attribute is treated
// as a potential id reference. `id`/`class`/`style` are NOT references.
function isRefAttr(name) {
  return (
    name === "for" ||
    name === "headers" ||
    name === "list" ||
    name === "form" ||
    name === "popovertarget" ||
    name.startsWith("aria-")
  );
}

// Walk a parsed tree collecting every id string referenced by another element's
// reference-type attribute (for/aria-*/headers/list/form/popovertarget).
function collectReferencedIds(tree, into) {
  if (!tree || tree.type !== "el") return into;
  for (const [name, value] of Object.entries(tree.attrs || {})) {
    if (isRefAttr(name) && value) {
      for (const tok of value.split(/\s+/)) if (tok) into.add(tok);
    }
  }
  for (const child of tree.children) collectReferencedIds(child, into);
  return into;
}

// Classify a deviation as cosmetic (demo scaffolding / normalization) vs
// functional (a real fidelity gap). Mutates the deviation with `cosmetic`.
function classify(dev, referencedIds) {
  const attr = dev.attr;
  // class/style differences are always cosmetic, on any element.
  if (attr === "class" || attr === "style") return true;
  // An added role/slot is the typed layer making an implied ARIA role / slot
  // placement explicit — a normalize case, not a bug.
  if (dev.kind === "added-attr" && (attr === "role" || attr === "slot")) return true;
  // id differences are cosmetic UNLESS the id value is referenced elsewhere.
  if (attr === "id") {
    const vals = [dev.value, dev.from, dev.to].filter((v) => v != null);
    const referenced = vals.some((v) => referencedIds.has(v));
    return !referenced;
  }
  // Everything else (component enum/bool attrs, for/value/type/src/placeholder,
  // all structural element/node/text changes) is functional.
  return false;
}

function diffNode(a, b, path, out) {
  if (!a || !b) {
    out.push({ kind: !a ? "added-element" : "removed-element", path, tag: (a || b).tag });
    return;
  }
  if (a.type !== b.type) {
    out.push({ kind: "changed-node", path, from: a.type, to: b.type });
    return;
  }
  if (a.type === "text") {
    if (a.text !== b.text) out.push({ kind: "changed-text", path, from: a.text, to: b.text });
    return;
  }
  if (a.tag !== b.tag) {
    out.push({ kind: "changed-element", path, from: a.tag, to: b.tag });
    return;
  }
  const keys = new Set([...Object.keys(a.attrs), ...Object.keys(b.attrs)]);
  for (const k of keys) {
    const av = a.attrs[k], bv = b.attrs[k];
    if (av === undefined) out.push({ kind: "added-attr", path, attr: k, value: bv });
    else if (bv === undefined) out.push({ kind: "removed-attr", path, attr: k, value: av });
    else if (av !== bv) out.push({ kind: "changed-attr", path, attr: k, from: av, to: bv });
  }
  const n = Math.max(a.children.length, b.children.length);
  for (let i = 0; i < n; i++) diffNode(a.children[i], b.children[i], `${path}/${a.tag}[${i}]`, out);
}

/** @returns {{ matches: boolean, functionalMatches: boolean, deviations: Array<object> }} */
export function diffHtml(expectedRawHtml, actualRenderedHtml) {
  const a = rootsOf(expectedRawHtml), b = rootsOf(actualRenderedHtml);
  const deviations = [];
  diffNode(a, b, "", deviations);
  // Collect referenced ids from BOTH sides so an id present on one side and
  // referenced on the other still counts as functional.
  const referencedIds = new Set();
  collectReferencedIds(a, referencedIds);
  collectReferencedIds(b, referencedIds);
  for (const dev of deviations) dev.cosmetic = classify(dev, referencedIds);
  const functionalMatches = deviations.every((d) => d.cosmetic === true);
  return { matches: deviations.length === 0, functionalMatches, deviations };
}
