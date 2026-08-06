import { expect, test } from "@playwright/test";

/**
 * A page that opts into `View.toc` gets a jump-link list rendered into the
 * drawer's `end` slot; a page that doesn't (the vast majority today) gets no
 * TOC panel content at all — `View.toc` defaults to `[]`.
 */
test("a component page's TOC jump-link scrolls to its matching heading", async ({ page }) => {
  await page.goto("/components/button");
  const tocLink = page.locator("#docs-drawer [slot='end']").getByRole("link", { name: "API" });
  await expect(tocLink).toBeVisible();

  const heading = page.locator("#api");
  await expect(heading).not.toBeInViewport();
  await tocLink.click();
  await expect(heading).toBeInViewport();
});

test("on mobile, the TOC toggle button opens the panel", async ({ page }) => {
  await page.setViewportSize({ width: 411, height: 761 });
  await page.goto("/components/button");

  const tocPanel = page.locator("#docs-drawer [slot='end']");
  await expect(tocPanel).toBeHidden();

  await page.getByRole("button", { name: "On this page" }).click();
  await expect(tocPanel).toBeVisible();
  await expect(tocPanel.getByRole("link", { name: "API" })).toBeVisible();
});

test("a page with no toc entries shows no TOC toggle button", async ({ page }) => {
  await page.goto("/guide");
  await expect(page.getByRole("button", { name: "On this page" })).toHaveCount(0);
});
