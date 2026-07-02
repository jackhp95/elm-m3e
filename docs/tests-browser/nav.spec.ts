import { test, expect } from "@playwright/test";
test("drawer groups components by category", async ({ page }) => {
  await page.goto("/components/button");
  await page.waitForLoadState("networkidle");
  // All 7 category groups render as nav items.
  for (const c of ["Actions","Communication","Containment","Navigation","Selection","Text inputs","Layout & style"]) {
    await expect(page.getByText(c, { exact: true }).first()).toBeVisible();
  }
});
