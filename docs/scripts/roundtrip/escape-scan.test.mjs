import { test } from "node:test";
import assert from "node:assert/strict";
import { scanEscapes } from "./escape-scan.mjs";

test("fully typed conversion scores zero", () => {
  const r = scanEscapes("M3e.AppBar.view [] [ M3e.IconButton.view [] [] ]");
  assert.equal(r.seam.count, 0);
  assert.equal(r.native.count, 0);
  assert.equal(r.charsInside, 0);
  assert.equal(r.benign, true);
});

test("counts Native.* and Seam.* call sites and inner char span", () => {
  const r = scanEscapes('M3e.card [] [ Seam.asElement (Html.div [] [ Html.text "x" ]) ]');
  assert.equal(r.seam.count, 1);
  assert.ok(r.seam.charsInside > 0);
  assert.equal(r.native.count, 0);
});

test("lone Native.span wrapping text is flagged benign", () => {
  const r = scanEscapes('M3e.appBar [] [ Native.span [] [ Kit.text "Title" ] ]');
  assert.equal(r.native.count, 1);
  assert.equal(r.benign, true);
});

test("Native wrapping real structure is NOT benign", () => {
  const r = scanEscapes("M3e.appBar [] [ Native.div [] [ M3e.icon [] [], M3e.icon [] [] ] ]");
  assert.equal(r.benign, false);
});

test("null / non-string input is inert", () => {
  const r = scanEscapes(null);
  assert.equal(r.converted, false);
  assert.equal(r.seam.count, 0);
});
