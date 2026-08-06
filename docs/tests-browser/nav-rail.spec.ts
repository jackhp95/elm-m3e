import { expect, test } from "@playwright/test";

/**
 * The 5-item nav rail (desktop) / nav bar (mobile) that replaces top-level
 * hamburger-drawer navigation. `selected` reflects which of the 5 sections
 * the current route belongs to, matched by first path segment — NOT by
 * exact path, so e.g. /components/button and /components/tooltip both
 * select "Components".
 *
 * Locators below use `getByRole("button", ...)` for `m3e-nav-item`, NOT
 * "link" — confirmed against @m3e/web's compiled source
 * (`node_modules/@m3e/web/dist/nav-bar.js`): `M3eNavItemElement` extends
 * `Role(LitElement, "button")`, so its ARIA role is "button" even with
 * `href` set (it synthesizes a temporary real `<a>` to perform actual
 * navigation on click, but the accessible role of the component itself
 * never changes).
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
    const item = rail.getByRole("button", { name: label, exact: true });
    await expect(item).toHaveAttribute("href", href);
  }
});

test("rail highlights the section matching the current route", async ({ page }) => {
  await page.goto("/components/button");
  const rail = page.locator("m3e-nav-rail");
  await expect(rail.getByRole("button", { name: "Components", exact: true })).toHaveAttribute(
    "selected",
    "",
  );
  await expect(rail.getByRole("button", { name: "The Guide", exact: true })).not.toHaveAttribute(
    "selected",
    "",
  );
});

test("no section is selected on a route outside all 5", async ({ page }) => {
  await page.goto("/");
  const rail = page.locator("m3e-nav-rail");
  await expect(rail).toHaveCount(1);
  for (const { label } of SECTIONS) {
    await expect(rail.getByRole("button", { name: label, exact: true })).not.toHaveAttribute(
      "selected",
      "",
    );
  }
});

test("mobile viewport shows the nav bar instead of the rail", async ({ page }) => {
  await page.setViewportSize({ width: 411, height: 761 });
  await page.goto("/guide");
  await expect(page.locator("m3e-nav-rail")).toBeHidden();
  const bar = page.locator("m3e-nav-bar");
  await expect(bar).toBeVisible();
  await expect(bar.getByRole("button", { name: "The Guide", exact: true })).toHaveAttribute(
    "selected",
    "",
  );
});
