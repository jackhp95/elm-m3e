// Layer 1: statically scan a converted-Elm string for escape hatches.
//   Seam.*   — the sanctioned type-hole.
//   Native.* — raw-HTML fallback.

/**
 * Read one balanced (...) or [...] group starting exactly at an open-bracket
 * index. Returns the inner text, its length, and the index just past the
 * closing bracket. This is the single primitive all balanced-scanning here
 * is built from.
 */
function readBalancedGroup(code, openIndex) {
  const open = code[openIndex];
  const close = open === "(" ? ")" : "]";
  let depth = 0;
  const start = openIndex + 1;
  let i = openIndex;
  for (; i < code.length; i++) {
    if (code[i] === open) depth++;
    else if (code[i] === close) {
      depth--;
      if (depth === 0) return { inner: code.slice(start, i), len: i - start, end: i + 1 };
    }
  }
  return { inner: code.slice(start), len: code.length - start, end: code.length };
}

/**
 * Elm calls look like `Prefix.fn arg1 arg2 ...` where each arg is its own
 * bracket/paren group (e.g. `Native.div [] [ ... ]` has an attrs list AND a
 * children list). Walk consecutive whitespace-separated groups immediately
 * after the identifier and concatenate them, so structure hiding in later
 * args (like a Native children list) isn't missed.
 */
function collectArgsAfter(code, fromIndex) {
  let i = fromIndex;
  let inner = "";
  let charsInside = 0;
  while (i < code.length) {
    while (i < code.length && /\s/.test(code[i])) i++;
    if (i >= code.length || (code[i] !== "(" && code[i] !== "[")) break;
    const group = readBalancedGroup(code, i);
    inner += group.inner;
    charsInside += group.len;
    i = group.end;
  }
  return { inner, charsInside };
}

function scanMechanism(code, prefix) {
  const re = new RegExp("\\b" + prefix + "\\.[A-Za-z][A-Za-z0-9_]*", "g");
  let m,
    count = 0,
    charsInside = 0;
  const inners = [];
  while ((m = re.exec(code)) !== null) {
    count++;
    const { inner, charsInside: len } = collectArgsAfter(code, m.index + m[0].length);
    charsInside += len;
    inners.push(inner);
  }
  return { count, charsInside, inners };
}

export function scanEscapes(code) {
  if (typeof code !== "string" || code.length === 0) {
    return { converted: false, seam: { count: 0, charsInside: 0 }, native: { count: 0, charsInside: 0 }, charsInside: 0, benign: true };
  }
  const seam = scanMechanism(code, "Seam");
  const native = scanMechanism(code, "Native");
  const nativeBenign = native.inners.every((inner) => !/M3e\.|Native\.|Html\./.test(inner));
  const benign = seam.count === 0 && nativeBenign;
  return {
    converted: true,
    seam: { count: seam.count, charsInside: seam.charsInside },
    native: { count: native.count, charsInside: native.charsInside },
    charsInside: seam.charsInside + native.charsInside,
    benign,
  };
}
