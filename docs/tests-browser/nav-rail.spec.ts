import { expect, test } from "@playwright/test";

/**
 * The 5-item nav rail (desktop) / nav bar (mobile) that replaces top-level
 * hamburger-drawer navigation. `selected` reflects which of the 5 sections
 * the current route belongs to, matched by first path segment — NOT by
 * exact path, so e.g. /components/button and /components/tooltip both
 * select "Components".
 *
 * Locators below use `getByRole("link", ...)` for `m3e-nav-item`. While
 * `M3eNavItemElement` declares `Role(LitElement, "button")` at the class level,
 * a `LinkButton` mixin in @m3e/web runtime (dist/all.js) upgrades the role
 * to "link" in `connectedCallback` when `href` is set:
 * `if (this.hasAttribute("href") && this.role === "button") { this.role = "link" }`
 * Every nav item in this app has `href` set (they're real routes), so all are
 * upgraded to `role="link"` by design.
 */
const SECTIONS: { label: string; href: string }[] = [
  { label: "Getting Started", href: "/getting-started/installation" },
  { label: "The Guide", href: "/guide" },
  { label: "Styles", href: "/styles/color" },
  { label: "Examples", href: "/examples" },
  { label: "Components", href: "/components/button" },
];

test("rail renders all 5 sections with correct hrefs", async ({ page }) => {
  await page.goto("/guide");
  const rail = page.locator("m3e-nav-rail");
  await expect(rail).toHaveCount(1);
  for (const { label, href } of SECTIONS) {
    const item = rail.getByRole("link", { name: label, exact: true });
    await expect(item).toHaveAttribute("href", href);
  }
});

test("rail highlights the section matching the current route", async ({ page }) => {
  await page.goto("/components/button");
  const rail = page.locator("m3e-nav-rail");
  await expect(rail.getByRole("link", { name: "Components", exact: true })).toHaveAttribute(
    "selected",
    "",
  );
  await expect(rail.getByRole("link", { name: "The Guide", exact: true })).not.toHaveAttribute(
    "selected",
  );
});

test("no section is selected on a route outside all 5", async ({ page }) => {
  await page.goto("/");
  const rail = page.locator("m3e-nav-rail");
  await expect(rail).toHaveCount(1);
  for (const { label } of SECTIONS) {
    await expect(rail.getByRole("link", { name: label, exact: true })).not.toHaveAttribute(
      "selected",
    );
  }
});

test("mobile viewport shows the nav bar instead of the rail", async ({ page }) => {
  await page.setViewportSize({ width: 411, height: 761 });
  await page.goto("/guide");
  await expect(page.locator("m3e-nav-rail")).toBeHidden();
  const bar = page.locator("m3e-nav-bar");
  await expect(bar).toBeVisible();
  await expect(bar.getByRole("link", { name: "The Guide", exact: true })).toHaveAttribute(
    "selected",
    "",
  );
});

test("rail sits beside the app bar, not above it", async ({ page }) => {
  await page.goto("/guide");
  const rail = page.locator("m3e-nav-rail");
  const appBar = page.locator("#docs-app-bar");
  const railBox = await rail.boundingBox();
  const appBarBox = await appBar.boundingBox();
  if (!railBox || !appBarBox) throw new Error("rail or app bar has no box");

  // The rail spans (close to) the full viewport height...
  const viewportHeight = page.viewportSize()?.height ?? 0;
  expect(railBox.height).toBeGreaterThan(viewportHeight - 5);
  // ...while the app bar starts to the right of the rail, not above it.
  expect(appBarBox.x).toBeGreaterThanOrEqual(railBox.x + railBox.width - 1);
  expect(appBarBox.y).toBeLessThanOrEqual(railBox.y + 1);
});

test("tree panel is open (pinned) by default on desktop, closed by default on mobile", async ({
  page,
}) => {
  await page.goto("/guide");
  await expect(page.locator("#docs-drawer")).toHaveAttribute("start", "");

  await page.setViewportSize({ width: 411, height: 761 });
  await page.goto("/guide");
  await expect(page.locator("#docs-drawer")).not.toHaveAttribute("start", "");
});
