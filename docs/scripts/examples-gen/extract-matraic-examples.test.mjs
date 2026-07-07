import { test } from "node:test";
import assert from "node:assert/strict";
import { extractPageFromHtml, dedent } from "./extract-matraic-examples.mjs";

// A heading section with a .showcase (complete markup) followed by a trimmed
// .example (the brevity oracle). Mirrors the matraic app-bar "Sizes" shape.
const SHOWCASE_SECTION = `
<m3e-heading level="1">App Bar</m3e-heading>
<m3e-heading level="3">Sizes</m3e-heading>
<p>Use the size attribute.</p>
<m3e-card class="showcase"><div slot="content">
  <m3e-app-bar size="medium">
    <span slot="title">Trails</span>
  </m3e-app-bar>
</div></m3e-card>
<m3e-card class="example"><pre slot="content">
&lt;m3e-app-bar size="medium"&gt;
  &lt;!-- Content omitted for brevity --&gt;
&lt;/m3e-app-bar&gt;</pre></m3e-card>
`;

test("showcase section sources COMPLETE markup, not the trimmed pre", () => {
  const { examples } = extractPageFromHtml("appbar", SHOWCASE_SECTION);
  assert.equal(examples.length, 1);
  const ex = examples[0];
  assert.equal(ex.title, "Sizes");
  // Complete: the title span survived; nothing was "omitted for brevity".
  assert.match(ex.code, /<span slot="title">Trails<\/span>/);
  assert.doesNotMatch(ex.code, /omitted for brevity/);
  // The trimmed pre is captured as the brevity oracle for B2.
  assert.match(ex.brevitySource, /omitted for brevity/);
});

// A pure-code section: an .example with NO preceding .showcase (install/native).
const PURE_CODE_SECTION = `
<m3e-heading level="3">Native module support</m3e-heading>
<m3e-card class="example"><pre slot="content">
&lt;m3e-app-bar&gt;&lt;/m3e-app-bar&gt;
&lt;script type="module"&gt;&lt;/script&gt;</pre></m3e-card>
`;

test("example-only section falls back to the pre source", () => {
  const { examples } = extractPageFromHtml("appbar", PURE_CODE_SECTION);
  assert.equal(examples.length, 1);
  assert.match(examples[0].code, /<m3e-app-bar><\/m3e-app-bar>/);
  assert.equal(examples[0].brevitySource, undefined);
});

test("dedent strips common leading indentation and blank edges", () => {
  assert.equal(dedent("\n    <a>\n      <b/>\n    </a>\n"), "<a>\n  <b/>\n</a>");
});
