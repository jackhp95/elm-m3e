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
 * navigates to the page the heading lives on when clicked.
 *
 * This does NOT exercise a real `#anchor` -- every entry the real crawled
 * `/search-index.json` currently produces has `anchor: null` site-wide
 * (verified: `curl .../search-index.json | jq '[.[] | select(.anchor !=
 * null)] | length'` -> 0). Root cause, confirmed against the rendered
 * output: `build-search-index.mjs`'s `HEADING_SELECTOR` only matches native
 * `h1`-`h6` tags inside `#main-content`, but `Doc.sectionHeadingWithId`
 * (used by every Components page, e.g. `#api` on `/components/button` --
 * see `Route/Components/Name_.elm`) renders a `<m3e-heading id="..."
 * level="...">` CUSTOM element, not a native heading tag, so the crawler's
 * selector never matches it and no anchor ever survives into the index.
 * That's a pre-existing gap in Task 1's crawler (`docs/scripts/search-index-gen/build-search-index.mjs`),
 * out of this task's file scope to fix -- once `HEADING_SELECTOR` is
 * extended to also match `m3e-heading[id]`, this test should gain a
 * `href`/anchor assertion mirroring the brief's original intent.
 */
test("clicking a heading result navigates to the page it lives on", async ({ page }) => {
  await page.goto("/");
  await page.getByRole("button", { name: "Search", exact: true }).click();

  const view = page.locator("m3e-search-view");
  await view.locator("input").fill("renders nothing");

  // Not `exact` here: the link's one accessible name is the concatenation of
  // BOTH its lines (the accessible-name algorithm flattens all descendant
  // text), so it is "A class renders nothing" + the secondary title line,
  // not "A class renders nothing" alone.
  const result = view.getByRole("link", { name: "A class renders nothing" });
  await expect(result).toBeVisible();
  await expect(result).toHaveAttribute("href", "/guide/troubleshooting");
  // The secondary line is the page's own title, not the heading text.
  await expect(result.getByText("Troubleshooting · elm-m3e")).toBeVisible();

  await result.click();
  await expect(page).toHaveURL(/\/guide\/troubleshooting$/);
  await expect(page.locator("m3e-search-view")).toHaveCount(0);
});
