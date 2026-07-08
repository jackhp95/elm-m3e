import { test } from "node:test";
import assert from "node:assert/strict";
import { diffHtml } from "./dom-diff.mjs";

test("identical markup matches", () => {
  const r = diffHtml("<m3e-button variant='filled'>Go</m3e-button>", "<m3e-button variant='filled'>Go</m3e-button>");
  assert.equal(r.matches, true);
  assert.deepEqual(r.deviations, []);
});

test("attribute order is normalized away", () => {
  const r = diffHtml('<m3e-button a="1" b="2"></m3e-button>', '<m3e-button b="2" a="1"></m3e-button>');
  assert.equal(r.matches, true);
});

test("insignificant whitespace is normalized away", () => {
  const r = diffHtml("<m3e-list>\n  <m3e-list-item></m3e-list-item>\n</m3e-list>", "<m3e-list><m3e-list-item></m3e-list-item></m3e-list>");
  assert.equal(r.matches, true);
});

test("boolean attribute forms are normalized (disabled vs disabled='')", () => {
  const r = diffHtml("<m3e-button disabled></m3e-button>", '<m3e-button disabled=""></m3e-button>');
  assert.equal(r.matches, true);
});

test("a changed attribute value is a structured deviation", () => {
  const r = diffHtml('<m3e-button variant="filled"></m3e-button>', '<m3e-button variant="tonal"></m3e-button>');
  assert.equal(r.matches, false);
  assert.equal(r.deviations[0].kind, "changed-attr");
  assert.equal(r.deviations[0].attr, "variant");
});

test("a missing element is a structured deviation", () => {
  const r = diffHtml("<m3e-app-bar><span slot='title'>T</span></m3e-app-bar>", "<m3e-app-bar></m3e-app-bar>");
  assert.equal(r.matches, false);
  assert.ok(r.deviations.some((d) => d.kind === "removed-element"));
});
