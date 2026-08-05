import { expect, test } from "@playwright/test";

/**
 * App-shell layout contract — the two branches of `Shared.view` must keep
 * DIFFERENT layout class lists, and the shell element must really generate the
 * box those classes describe.
 *
 * Why computed style, and not markup: `Test.Html` (elm-test) can only see the
 * emitted attribute string, which cannot distinguish "the class list won the
 * cascade" from "something else won and the shell silently reflowed". Two
 * failure modes are in scope here and both are silent — no compile error, no
 * console warning:
 *
 *  1. Branch collapse. If the docs-shell list is ever hoisted onto BOTH
 *     branches, `/examples/*` loses `overflow-y-auto` and gains
 *     `grid-rows-[auto_1fr]`. The document (html/body) is fixed and
 *     non-scrolling for mobile URL-bar stability, so a full-viewport example
 *     that is not its own scroll region CLIPS instead of scrolling.
 *  2. `:host` winning. `@m3e/web` sets `:host { display: contents }` on
 *     `m3e-theme` (`node_modules/@m3e/web/dist/theme.js`). The shell currently
 *     lives on a wrapper INSIDE that host, so it is unaffected — but if the
 *     shell classes are ever hoisted onto the host itself, the layout only
 *     works because normal declarations from the outer tree beat a shadow
 *     tree's `:host` rules. A future `!important` there would stop the host
 *     generating a box and flatten the whole app shell.
 *
 * The `SHELL` selector matches EITHER shape (host or wrapper) on purpose, so
 * these assertions survive the hoist and keep pinning the same contract.
 */
const SHELL = "m3e-theme.h-dvh, m3e-theme > .h-dvh";

// A `/examples/*` route whose content is taller than the viewport, so the
// "owns its scroll region" assertion is meaningful rather than vacuous.
const TALL_EXAMPLE = "/examples/shop";

test("the docs shell is a fixed-height grid, not flow content", async ({ page }) => {
  await page.goto("/");
  await expect(page.locator("#docs-app-bar")).toBeVisible();

  const shell = page.locator(SHELL).first();
  // `grid` + `auto_1fr` is what pins the app bar above the single scrolling
  // content row. If this reads `contents` or `block`, the shell has flattened.
  await expect(shell).toHaveCSS("display", "grid");
  // The shell itself must NOT scroll — the inner content row does.
  await expect(shell).toHaveCSS("overflow-y", "hidden");
});

test("a full-viewport example route owns its own scroll region", async ({ page }) => {
  await page.goto(TALL_EXAMPLE);

  const shell = page.locator(SHELL).first();
  await expect(shell).toBeAttached();
  // NOT the docs-shell grid: examples are authored as plain flow content, and
  // `grid-rows-[auto_1fr]` would lay them into rows they never asked for.
  await expect(shell).not.toHaveCSS("display", "grid");
  // Its own bounded scroll region — the document cannot scroll for it.
  await expect(shell).toHaveCSS("overflow-y", "auto");
});

test("a tall example scrolls instead of clipping", async ({ page }) => {
  await page.goto(TALL_EXAMPLE);

  const shell = page.locator(SHELL).first();
  await expect(shell).toBeAttached();

  const scroll = await shell.evaluate((el) => {
    el.scrollTop = 400;
    return {
      overflow: el.scrollHeight - el.clientHeight,
      moved: el.scrollTop,
    };
  });

  // Taller than its box (so clipping is actually possible here) …
  expect(scroll.overflow).toBeGreaterThan(20);
  // … and reachable, because the shell is the scroller.
  expect(scroll.moved).toBeGreaterThan(0);
});

test("the shell carries the document direction", async ({ page }) => {
  await page.goto("/");
  await expect(page.locator("#docs-app-bar")).toBeVisible();

  const shell = page.locator(SHELL).first();
  // `dir` lives on the shell element, so direction must resolve there and
  // inherit down to the app bar and drawer. A missing `dir` would leave the
  // RTL control in the settings drawer with nothing to flip.
  await expect(shell).toHaveAttribute("dir", /^(ltr|rtl|auto)$/);
  await expect(shell).toHaveCSS("direction", "ltr");
});
