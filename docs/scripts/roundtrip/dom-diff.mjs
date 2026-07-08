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

function rootOf(html) {
  // linkedom drops unknown/custom elements out of <body> when parsed at the
  // top level, so wrap in a known container and read its first element child.
  const { document } = parseHTML(`<div id="__rt_root__">${html}</div>`);
  const wrapper = document.getElementById("__rt_root__");
  // Reads only firstElementChild: cells are single-root by contract, so any
  // extra top-level siblings in a multi-root fragment are silently ignored
  // (A6 relies on this single-root contract).
  const el = wrapper ? wrapper.firstElementChild : null;
  return el ? toTree(el) : null;
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

/** @returns {{ matches: boolean, deviations: Array<object> }} */
export function diffHtml(expectedRawHtml, actualRenderedHtml) {
  const a = rootOf(expectedRawHtml), b = rootOf(actualRenderedHtml);
  const deviations = [];
  diffNode(a, b, "", deviations);
  return { matches: deviations.length === 0, deviations };
}
