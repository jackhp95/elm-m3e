import { defineConfig, devices } from "@playwright/test";

/**
 * Runtime contract harness for the M3e.* library.
 *
 * Why this exists: the elm-test suite renders the *virtual DOM* (the emitted
 * markup string) via `Test.Html`. But m3e components are custom elements whose
 * truth lives in **DOM properties** and **shadow DOM** — neither of which
 * `Test.Html` can observe. The icon-invisible bug (friction F1) passed the
 * compiler *and* the unit suite and only a real browser caught it. These tests
 * mount the real components (via the docs component pages, which render the
 * actual `Ui.*` modules) in Chromium and assert the runtime contract.
 *
 * Run: `npm run test:browser`. A `pretest:browser` hook kills anything
 * already listening on :1239 first, so this always rebuilds and serves
 * fresh rather than risking a pass against stale content — load-bearing for
 * the pre-push gate, since Netlify deploys from whatever `main` says passed.
 * Override the target with `BASE_URL=...` (skips the local server and the
 * port-kill hook has nothing to affect).
 */
const baseURL = process.env.BASE_URL ?? "http://localhost:1239";

export default defineConfig({
  testDir: "./tests-browser",
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: 0,
  reporter: [["list"]],
  use: {
    baseURL,
    trace: "retain-on-failure",
  },
  projects: [
    { name: "chromium", use: { ...devices["Desktop Chrome"] } },
  ],
  webServer: {
    // In CI: build the site once and serve the pre-rendered production output
    // statically. `elm-pages dev` cold-compiles all 125 routes on first request
    // (too slow for the boot timeout on a 2-core runner) and holds a `/stream`
    // SSE connection open (breaking `networkidle`); the static build serves
    // instantly, is deterministic, and is the artifact we actually ship — the
    // right target for a runtime-contract harness. Its stdout is piped so a
    // boot failure is visible in the CI log instead of a bare timeout.
    // Locally: reuse a dev server already on :1239 for fast iteration, else
    // start `elm-pages dev`.
    // Build once, serve statically — in CI AND locally. `elm-pages dev`
    // cold-compiles all routes on first request and holds a `/stream` SSE
    // connection open, so it blows the boot timeout and breaks `networkidle`.
    // Measured: the dev-server path times out at 480s locally. The static build
    // is deterministic, serves instantly, and is the artifact we actually ship.
    // `reuseExistingServer` still lets you point at a hand-started server.
    command: "npm run build:site && PORT=1239 npm run serve",
    url: baseURL,
    reuseExistingServer: !process.env.CI,
    stdout: "pipe",
    stderr: "pipe",
    // Cold `elm-pages build` on a slow runner can take a few minutes; give it
    // generous headroom (serving itself is instant once built).
    timeout: 480_000,
  },
});
