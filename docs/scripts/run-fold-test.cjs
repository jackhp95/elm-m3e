// Minimal node runner for tests/FoldTest.elm (compiled Platform.worker).
// Usage: node scripts/run-fold-test.cjs <compiled-elm.js>
const { Elm } = require(require("path").resolve(process.argv[2]));
const app = Elm.FoldTest.init();
app.ports.emit.subscribe((out) => {
  console.log(out);
  // Exit code keys off the harness's structured `RESULT ok=<passed>/<total>`
  // line — never a substring match on human-readable PASS/FAIL text (a case
  // *named* with "FAIL" must not false-positive the run).
  const m = out.match(/^RESULT ok=(\d+)\/(\d+)$/m);
  if (!m) {
    console.error("run-fold-test: missing structured RESULT line");
    process.exit(2);
  }
  process.exit(Number(m[1]) === Number(m[2]) ? 0 : 1);
});
