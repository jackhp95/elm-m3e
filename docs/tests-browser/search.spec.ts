import { test, expect } from "@playwright/test";

/**
 * The search FAB (top of the rail on desktop, top of the bottom bar on
 * mobile) opens `m3e-search-view`, lazily fetching `/search-index.json` on
 * the first `query` event (fired when the view opens, term = ""). Results
 * are a plain case-insensitive substring match against title/heading,
 * capped at 20 -- see specs/2026-08-07-nav-rail-search-design.md.
 */
test("the FAB opens search, typing filters results, and clicking a result navigates and closes it", async ({
  page,
}) => {
  await page.goto("/");
  await page.getByRole("button", { name: "Search", exact: true }).click();

  const view = page.locator("m3e-search-view");
  await expect(view).toHaveAttribute("open", "");

  const input = view.locator("input");
  await input.fill("button");

  // A page-level entry (`heading = null`) renders its real `<title>`, which
  // is never the bare component name -- see `searchResultLink`'s doc comment
  // on why that distinction matters for the accessible tree.
  const result = view.getByRole("link", { name: "Button · elm-m3e", exact: true });
  await expect(result).toBeVisible();

  await result.click();
  await expect(page).toHaveURL(/\/components\/button$/);
  await expect(page.locator("m3e-search-view")).toHaveCount(0);
});

/**
 * A heading-level entry (`heading` non-null) renders the matched heading as
 * its primary text and the page's own title as a secondary line -- and
 * navigates to the page the heading lives on when clicked, with a real
 * `#anchor` in the URL.
 *
 * `Doc.sectionHeadingWithId` (used by every Components page, e.g. `#api` on
 * `/components/button` -- see `Route/Components/Name_.elm`) renders a
 * `<m3e-heading id="..." level="...">` CUSTOM element. `build-search-index.mjs`'s
 * `HEADING_SELECTOR` now matches `m3e-heading` in addition to native
 * `h1`-`h6` (fixed in 1488c602), so the crawled index carries a real
 * `heading: "API", anchor: "api"` entry for that page.
 *
 * Every Components page has its own "API" heading, so the query alone
 * returns 20 same-named results (`filterSearchEntries` caps at 20) -- pin
 * the Button one by `href` rather than by accessible name/text, which is
 * ambiguous here on purpose (it's the realistic case this feature has to
 * handle well, not a contrived one).
 */
test("clicking a heading result navigates to the page and its anchor", async ({ page }) => {
  await page.goto("/");
  await page.getByRole("button", { name: "Search", exact: true }).click();

  const view = page.locator("m3e-search-view");
  await view.locator("input").fill("API");

  const result = view.locator('a[href="/components/button#api"]');
  await expect(result).toBeVisible();
  // The secondary line is the page's own title, not the heading text.
  await expect(result.getByText("Button · elm-m3e")).toBeVisible();

  await result.click();
  await expect(page).toHaveURL(/\/components\/button#api$/);
  await expect(page.locator("m3e-search-view")).toHaveCount(0);
});

/**
 * A heading match with no anchor is a real, still-valid case elsewhere in
 * the index (not every heading the crawler visits renders as `m3e-heading`
 * with an id) -- this keeps that shape covered alongside the anchor case
 * above.
 */
test("clicking a heading result with no anchor navigates to the page it lives on", async ({ page }) => {
  await page.goto("/");
  await page.getByRole("button", { name: "Search", exact: true }).click();

  const view = page.locator("m3e-search-view");
  await view.locator("input").fill("renders nothing");

  const result = view.getByRole("link", { name: "A class renders nothing" });
  await expect(result).toBeVisible();
  await expect(result).toHaveAttribute("href", "/guide/troubleshooting");
  // The secondary line is the page's own title, not the heading text.
  await expect(result.getByText("Troubleshooting · elm-m3e")).toBeVisible();

  await result.click();
  await expect(page).toHaveURL(/\/guide\/troubleshooting$/);
  await expect(page.locator("m3e-search-view")).toHaveCount(0);
});

test("Cmd/Ctrl+K opens search from an arbitrary route", async ({ page }) => {
  await page.goto("/guide");
  await page.keyboard.press("ControlOrMeta+k");
  await expect(page.locator("m3e-search-view")).toHaveAttribute("open", "");
});

test("a failed index fetch shows an unavailable message, not a silently empty panel", async ({
  page,
}) => {
  await page.route("**/search-index.json", (route) => route.abort());
  await page.goto("/");
  await page.getByRole("button", { name: "Search", exact: true }).click();
  await page.locator("m3e-search-view input").fill("button");
  await expect(page.getByText("Search unavailable")).toBeVisible();
});
