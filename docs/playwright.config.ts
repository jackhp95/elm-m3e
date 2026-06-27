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
 * Run: `npm run test:browser` (reuses a dev server on :1239 if one is up,
 * otherwise starts one). Override the target with `BASE_URL=...`.
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
    command: "npm start -- --port 1239",
    url: baseURL,
    // Locally, reuse a dev server already on :1239 (instant). In CI, always
    // start fresh and allow for a cold elm compile.
    reuseExistingServer: !process.env.CI,
    timeout: 300_000,
  },
});
